import gleam/list
import gleam/string

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let norm_word = normalize(word)
  candidates
  |> list.filter(fn(it) { string.lowercase(it) != string.lowercase(word) })
  |> list.filter(fn(it) { normalize(it) == norm_word })
}

fn normalize(word) {
  string.lowercase(word) |> string.to_graphemes() |> list.sort(string.compare)
}
