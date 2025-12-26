import gleam/list

pub opaque type CircularBuffer(t) {
  CircularBuffer(items: List(t), count: Int, capacity: Int)
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer([], 0, capacity)
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case buffer.items {
    [head, ..tail] ->
      Ok(#(head, CircularBuffer(tail, buffer.count - 1, buffer.capacity)))
    _ -> Error(Nil)
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case buffer.count < buffer.capacity {
    True ->
      Ok(CircularBuffer(
        buffer.items |> list.append([item]),
        buffer.count + 1,
        buffer.capacity,
      ))
    False -> Error(Nil)
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case buffer.count == 0, buffer.count == buffer.capacity {
    True, _ -> CircularBuffer([item], buffer.count + 1, buffer.capacity)
    _, True ->
      CircularBuffer(
        list.drop(buffer.items, 1) |> list.append([item]),
        buffer.count,
        buffer.capacity,
      )
    _, _ ->
      CircularBuffer(
        buffer.items |> list.append([item]),
        buffer.count,
        buffer.capacity,
      )
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  new(buffer.capacity)
}
