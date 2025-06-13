import gleam/list
import gleam/regexp
import gleam/set
import gleam/string

pub fn is_isogram(phrase phrase: String) -> Bool {
  let assert Ok(re_letters) = regexp.from_string("[a-z]")
  let letters =
    phrase
    |> string.lowercase()
    |> string.to_graphemes()
    |> list.filter(fn(it) { regexp.check(re_letters, it) })
  let uniq = set.from_list(letters)
  set.size(uniq) == list.length(letters)
}
