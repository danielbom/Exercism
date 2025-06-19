import gleam/bool
import gleam/list
import gleam/regexp.{check}
import gleam/result
import gleam/string

pub fn clean(input: String) -> Result(String, String) {
  use output <- result.then(clean_digits(input))
  let a = string.slice(output, 0, 1)
  let b = string.slice(output, 3, 1)
  case a, b {
    "0", _ -> Error("area code cannot start with zero")
    "1", _ -> Error("area code cannot start with one")
    _, "0" -> Error("exchange code cannot start with zero")
    _, "1" -> Error("exchange code cannot start with one")
    _, _ -> Ok(output)
  }
}

fn clean_digits(input: String) -> Result(String, String) {
  let assert Ok(re) = regexp.from_string("[a-zA-Z]")
  use <- bool.guard(check(re, input), Error("letters not permitted"))
  
  let assert Ok(re) = regexp.from_string("[^0-9 ()-.]")
  use <- bool.guard(check(re, input), Error("punctuations not permitted"))

  let assert Ok(re) = regexp.from_string("\\d")
  let digits =
    regexp.scan(re, input)
    |> list.map(fn(match) { match.content })
    |> string.join("")

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
