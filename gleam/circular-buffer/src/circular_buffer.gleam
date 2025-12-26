// For Shree DR.MDD

import gleam/list.{reverse}

pub opaque type CircularBuffer(t) {
  CircularBuffer(
    capacity: Int,
    size: Int,
    push_stack: List(t),
    pop_stack: List(t),
  )
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(capacity, 0, [], [])
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case buffer.size > 0 {
    True -> Ok(read_from_nonempty(buffer))
    False -> Error(Nil)
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  element: t,
) -> Result(CircularBuffer(t), Nil) {
  case buffer.size < buffer.capacity {
    True -> Ok(write_to_buffer(buffer, element))
    False -> Error(Nil)
  }
}

pub fn overwrite(buffer: CircularBuffer(t), element: t) -> CircularBuffer(t) {
  case buffer.size < buffer.capacity {
    True -> write_to_buffer(buffer, element)
    False -> {
      let #(_, buffer) = read_from_nonempty(buffer)
      write_to_buffer(buffer, element)
    }
  }
}

pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  new(buffer.capacity)
}

fn read_from_nonempty(buffer: CircularBuffer(t)) -> #(t, CircularBuffer(t)) {
  case buffer.pop_stack, buffer.push_stack {
    [head, ..tail], _ -> #(
      head,
      CircularBuffer(..buffer, pop_stack: tail, size: buffer.size - 1),
    )
    [], _ -> {
      let buffer =
        CircularBuffer(
          ..buffer,
          pop_stack: reverse(buffer.push_stack),
          push_stack: [],
        )
      read_from_nonempty(buffer)
    }
  }
}

fn write_to_buffer(buffer: CircularBuffer(t), element: t) {
  CircularBuffer(
    capacity: buffer.capacity,
    size: buffer.size + 1,
    push_stack: [element, ..buffer.push_stack],
    pop_stack: buffer.pop_stack,
  )
}
