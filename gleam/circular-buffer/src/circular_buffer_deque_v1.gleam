import gleam/bool
import gleam/deque.{type Deque}
import gleam/result

pub opaque type CircularBuffer(t) {
  CircularBuffer(queue: Deque(t), free: Int)
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(deque.new(), capacity)
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  use #(elem, queue) <- result.map(deque.pop_back(buffer.queue))
  #(elem, CircularBuffer(queue, buffer.free + 1))
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  use <- bool.guard(buffer.free == 0, Error(Nil))
  let queue = deque.push_front(buffer.queue, item)
  Ok(CircularBuffer(queue, buffer.free - 1))
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  use <- result.lazy_unwrap(write(buffer, item))
  let assert Ok(#(_, buffer)) = read(buffer)
  let assert Ok(buffer) = write(buffer, item)
  buffer
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  CircularBuffer(deque.new(), deque.length(buffer.queue) + buffer.free)
}
