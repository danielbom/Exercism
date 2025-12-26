import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn encode(phrase: String) -> String {
  let map = cipher_map()
  phrase
  |> string.to_graphemes()
  |> list.filter_map(dict.get(map, _))
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  let map = cipher_map()
  phrase
  |> string.to_graphemes()
  |> list.filter_map(dict.get(map, _))
  |> string.concat()
}

fn cipher_map() -> Dict(String, String) {
  let digits = "1234567890" |> string.to_graphemes()
  let letters = "abcdefghijklmnopqrstuvwxyz"
  let upper = letters |> string.uppercase() |> string.to_graphemes()
  let lower = letters |> string.to_graphemes()
  let lower_reversed = lower |> list.reverse()
  [
    dict.from_list(list.zip(lower, lower_reversed)),
    dict.from_list(list.zip(upper, lower_reversed)),
    dict.from_list(list.zip(digits, digits)),
  ]
  |> list.fold(dict.new(), dict.merge)
}
