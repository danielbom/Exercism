import gleam/int
import gleam/list

pub type Command {
  Wink
  DoubleBlink
  CloseYourEyes
  Jump
}

pub fn commands(encoded_message: Int) -> List(Command) {
  [
    #(int.bitwise_shift_left(1, 0), list.append(_, [Wink])),
    #(int.bitwise_shift_left(1, 1), list.append(_, [DoubleBlink])),
    #(int.bitwise_shift_left(1, 2), list.append(_, [CloseYourEyes])),
    #(int.bitwise_shift_left(1, 3), list.append(_, [Jump])),
    #(int.bitwise_shift_left(1, 4), list.reverse),
  ]
  |> list.fold([], fn(acc, code_command) {
    let #(code, command) = code_command
    case int.bitwise_and(encoded_message, code) {
      0 -> acc
      _ -> command(acc)
    }
  })
}
