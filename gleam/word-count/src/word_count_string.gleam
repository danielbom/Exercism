import gleam/string
import gleam/dict.{type Dict}
import gleam/list
import gleam/regexp

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(re_words) = regexp.from_string("[\\w|\\d]+('?[\\w|\\d]+)?")
  input
  |> string.lowercase
  |> regexp.scan(re_words, _)
  |> list.group(fn(m) { m.content})
  |> dict.map_values(fn(_, value) { value |> list.length })
}
