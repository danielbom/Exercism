import gleam/list
import gleam/string

pub fn translate(phrase: String) -> String {
  string.split(phrase, " ")
  |> list.map(single)
  |> string.join(" ")
}

fn single(word: String) -> String {
  case word {
    "sch" <> tail -> tail <> "schay"
    "squ" <> tail -> tail <> "squay"
    "thr" <> tail -> tail <> "thray"
    "ch" <> tail -> tail <> "chay"
    "th" <> tail -> tail <> "thay"
    "qu" <> tail -> tail <> "quay"
    "rh" <> tail -> tail <> "rhay"
    "xr" <> _ -> word <> "ay"
    "yt" <> _ -> word <> "ay"
    "a" <> _ -> word <> "ay"
    "e" <> _ -> word <> "ay"
    "i" <> _ -> word <> "ay"
    "o" <> _ -> word <> "ay"
    "u" <> _ -> word <> "ay"
    "" -> ""
    _ -> {
      let assert [head, ..tail] = string.to_graphemes(word)
      string.concat(tail) <> head <> "ay"
    }
  }
}
