import gleam/dict.{type Dict}
import gleam/list
import gleam/string

const scores = [
  #("AEIOULNRST", 1),
  #("DG", 2),
  #("BCMP", 3),
  #("FHVWY", 4),
  #("K", 5),
  #("JX", 8),
  #("QZ", 10),
]

pub fn score(word: String) -> Int {
  word
  |> string.uppercase()
  |> string.to_graphemes()
  |> score_word(score_table(), _)
}

fn score_word(scores: Dict(String, Int), graphemes: List(String)) -> Int {
  list.fold(graphemes, 0, fn(result, char) {
    case dict.get(scores, char) {
      Ok(value) -> result + value
      Error(_) -> result
    }
  })
}

fn score_table() -> Dict(String, Int) {
  let update = fn(scores, letters, points) {
    list.fold(string.to_graphemes(letters), scores, fn(scores, letter) {
      dict.insert(scores, letter, points)
    })
  }
  list.fold(scores, dict.new(), fn(scores, pair) {
    let #(letters, points) = pair
    scores
    |> update(letters, points)
    |> update(string.lowercase(letters), points)
  })
}
