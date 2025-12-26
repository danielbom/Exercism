import gleam/list
import gleam/string

pub fn encode(phrase: String) -> String {
  phrase
  |> string.to_graphemes()
  |> list.filter_map(substitute)
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> string.to_graphemes()
  |> list.filter_map(substitute)
  |> string.concat()
}

fn substitute(ch: String) -> Result(String, Nil) {
  case <<ch:utf8>> {
    // [0..9]
    <<code>> if 48 <= code && code <= 58 -> chr(code)
    // [a..z]
    <<code>> if 97 <= code && code <= 122 -> chr({ code - 122 } * -1 + 97)
    // [A..Z]
    <<code>> if 65 <= code && code <= 90 -> chr({ code - 90 } * -1 + 97)
    _ -> Error(Nil)
  }
}

fn chr(code: Int) -> Result(String, Nil) {
  case string.utf_codepoint(code) {
    Ok(codepoint) -> Ok(string.from_utf_codepoints([codepoint]))
    Error(_) -> Error(Nil)
  }
}
