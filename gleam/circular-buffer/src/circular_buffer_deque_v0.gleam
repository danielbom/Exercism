import gleam/deque

pub opaque type CircularBuffer(t) {
  CircularBuffer(capacity: Int, queue: deque.Deque(t))
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(capacity, deque.from_list([]))
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case deque.pop_back(buffer.queue) {
    Error(_) -> Error(Nil)
    Ok(#(item, rest)) ->
      Ok(#(item, CircularBuffer(capacity: buffer.capacity, queue: rest)))
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case deque.length(buffer.queue) == buffer.capacity {
    True -> Error(Nil)
    False ->
      Ok(CircularBuffer(..buffer, queue: deque.push_front(buffer.queue, item)))
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case deque.length(buffer.queue) == buffer.capacity {
    True ->
      case deque.pop_back(buffer.queue) {
        Error(_) ->
          CircularBuffer(..buffer, queue: deque.push_front(buffer.queue, item))
        Ok(#(_, rest)) ->
          CircularBuffer(..buffer, queue: deque.push_front(rest, item))
      }
    False ->
      CircularBuffer(..buffer, queue: deque.push_front(buffer.queue, item))
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  new(buffer.capacity)
}
