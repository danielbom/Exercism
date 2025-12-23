import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  let reverse = int.bitwise_shift_left(1, 4)
  let reversed_sequence =
    [
      #(int.bitwise_shift_left(1, 0), Wink),
      #(int.bitwise_shift_left(1, 1), DoubleBlink),
      #(int.bitwise_shift_left(1, 2), CloseYourEyes),
      #(int.bitwise_shift_left(1, 3), Jump),
    ]
    |> list.fold([], fn(acc, code_message) {
      let #(code, message) = code_message
      case int.bitwise_and(encoded_message, code) {
        0 -> acc
        _ -> [message, ..acc]
      }
    })
  case int.bitwise_and(encoded_message, reverse) {
    0 -> list.reverse(reversed_sequence)
    _ -> reversed_sequence
  }
}
