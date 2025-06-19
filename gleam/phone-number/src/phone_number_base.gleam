import gleam/bool
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  clean_base(input)
  |> result.then(fn(output) {
    let a = string.slice(output, 0, 1)
    let b = string.slice(output, 3, 1)
    case a, b {
      "0", _ -> Error("area code cannot start with zero")
      "1", _ -> Error("area code cannot start with one")
      _, "0" -> Error("exchange code cannot start with zero")
      _, "1" -> Error("exchange code cannot start with one")
      _, _ -> Ok(output)
    }
  })
}

pub fn clean_base(input: String) -> Result(String, String) {
  let letters = regexp_extract("[a-zA-Z]", input)
  use <- bool.guard(letters != "", Error("letters not permitted"))
  let symbols = regexp_extract("[^0-9 ()-.]", input)
  use <- bool.guard(symbols != "", Error("punctuations not permitted"))

  let digits = regexp_extract("\\d", input)
  case string.length(digits) {
    n if n < 10 -> Error("must not be fewer than 10 digits")
    n if n > 11 -> Error("must not be greater than 11 digits")
    11 -> {
      case string.starts_with(digits, "1") {
        True -> Ok(string.slice(digits, 1, 11))
        False -> Error("11 digits must start with 1")
      }
    }
    _ -> Ok(digits)
  }
}

fn regexp_extract(regex: String, value: String) -> String {
  let assert Ok(re) = regexp.from_string(regex)
  regexp.scan(re, value)
  |> list.map(fn(match) { match.content })
  |> string.join("")
}
