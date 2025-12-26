import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn encode(phrase: String) -> String {
  phrase
  |> string.to_graphemes()
  |> substitute()
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> string.to_graphemes()
  |> substitute()
  |> string.concat()
}

fn substitute(chars: List(String)) -> List(String) {
  let map = cipher_map()
  list.flat_map(chars, fn(ch) {
    case dict.get(map, ch) {
      Ok(ch) -> [ch]
      Error(_) -> []
    }
  })
}

fn cipher_map() -> Dict(String, String) {
  let digits = "1234567890" |> string.to_graphemes()
  let letters = "abcdefghijklmnopqrstuvwxyz"
  let upper = string.uppercase(letters) |> string.to_graphemes()
  let lower = letters |> string.to_graphemes()
  let lower_reversed = lower |> list.reverse()
  [
    dict.from_list(list.zip(lower, lower_reversed)),
    dict.from_list(list.zip(upper, lower_reversed)),
    dict.from_list(list.zip(digits, digits)),
  ]
  |> list.fold(dict.new(), dict.merge)
}
