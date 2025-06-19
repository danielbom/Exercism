import gleam/list
import gleam/set
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  "abcdefghijklmnopqrstuvwxyz"
  |> string.to_graphemes()
  |> list.all({
    let chars =
      sentence |> string.lowercase() |> string.to_graphemes() |> set.from_list()
    set.contains(chars, _)
  })
}
