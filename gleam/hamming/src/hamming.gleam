import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  distance_loop(string.to_graphemes(strand1), string.to_graphemes(strand2), 0)
}

fn distance_loop(
  strand1: List(String),
  strand2: List(String),
  acc: Int,
) -> Result(Int, Nil) {
  case strand1, strand2 {
    [], [] -> Ok(acc)
    [cell1, ..rest1], [cell2, ..rest2] ->
      case cell1 == cell2 {
        True -> distance_loop(rest1, rest2, acc)
        False -> distance_loop(rest1, rest2, acc + 1)
      }
    _, _ -> Error(Nil)
  }
}
