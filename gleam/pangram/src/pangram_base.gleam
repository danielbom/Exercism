import gleam/set
import gleam/string

pub fn is_pangram(sentence: String) -> Bool {
  let letters = "abcdefghijklmnopqrstuvwxyz"
  let count =
    sentence
    |> string.lowercase()
    |> string.to_graphemes()
    |> set.from_list()
    |> set.intersection(letters |> string.to_graphemes() |> set.from_list())
    |> set.size()
  count == string.length(letters)
}
