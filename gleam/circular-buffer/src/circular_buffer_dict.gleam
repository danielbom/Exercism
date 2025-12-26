import gleam/dict.{type Dict}

pub opaque type CircularBuffer(t) {
  CircularBuffer(items: Dict(Int, t), begin: Int, end: Int, capacity: Int)
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(dict.new(), 0, 0, capacity)
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case buffer.end > buffer.begin {
    True -> {
      let assert Ok(value) = dict.get(buffer.items, buffer.begin)
      let items = dict.delete(buffer.items, buffer.begin)
      Ok(#(
        value,
        CircularBuffer(items, buffer.begin + 1, buffer.end, buffer.capacity),
      ))
    }
    False -> Error(Nil)
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  let count = buffer.end - buffer.begin
  case count < buffer.capacity {
    True ->
      Ok(CircularBuffer(
        dict.insert(buffer.items, buffer.end, item),
        buffer.begin,
        buffer.end + 1,
        buffer.capacity,
      ))
    False -> Error(Nil)
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  let count = buffer.end - buffer.begin
  case count == buffer.capacity {
    True ->
      CircularBuffer(
        buffer.items
          |> dict.delete(buffer.begin)
          |> dict.insert(buffer.end, item),
        buffer.begin + 1,
        buffer.end + 1,
        buffer.capacity,
      )
    False ->
      CircularBuffer(
        dict.insert(buffer.items, buffer.end, item),
        buffer.begin,
        buffer.end + 1,
        buffer.capacity,
      )
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  new(buffer.capacity)
}
