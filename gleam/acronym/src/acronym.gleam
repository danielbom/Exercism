import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  abbreviate_loop(string.to_graphemes(phrase), True, "")
}

fn abbreviate_loop(phrase: List(String), pick: Bool, result: String) -> String {
  case pick, phrase {
    _, ["_", ..rest] -> abbreviate_loop(rest, True, result)
    _, ["-", ..rest] -> abbreviate_loop(rest, True, result)
    _, [" ", ..rest] -> abbreviate_loop(rest, True, result)
    False, [_, ..rest] -> abbreviate_loop(rest, False, result)
    True, [ch, ..rest] -> abbreviate_loop(rest, False, result <> string.uppercase(ch))
    _, _ -> result
  }
}
