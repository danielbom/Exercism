import gleam/bit_array
import gleam/list
import gleam/result
import gleam/string

pub fn encode(phrase: String) -> String {
  phrase
  |> bit_array.from_string()
  |> substitute()
  |> bit_array.to_string()
  |> result.unwrap("")
  |> string.to_graphemes()
  |> list.sized_chunk(5)
  |> list.map(string.concat)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> bit_array.from_string()
  |> substitute()
  |> bit_array.to_string()
  |> result.unwrap("")
}

fn substitute(codes: BitArray) -> BitArray {
  case codes {
    // [0..9]
    <<code, rest:bits>> if 48 <= code && code <= 58 -> <<
      code,
      substitute(rest):bits,
    >>
    // [a..z]
    <<code, rest:bits>> if 97 <= code && code <= 122 -> {
      let code = { code - 122 } * -1 + 97
      <<<<code>>:bits, substitute(rest):bits>>
    }
    // [A..Z]
    <<code, rest:bits>> if 65 <= code && code <= 90 -> {
      let code = { code - 90 } * -1 + 97
      <<<<code>>:bits, substitute(rest):bits>>
    }
    // remove
    <<_, rest:bits>> -> substitute(rest)
    _ -> codes
  }
}
