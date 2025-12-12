import gleam/dict.{type Dict}
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  input
  |> tokenize(dict.new(), fn(curr, text) {
    case dict.get(curr, text) {
      Ok(count) -> dict.insert(curr, text, count + 1)
      Error(_) -> dict.insert(curr, text, 1)
    }
  })
}

fn tokenize(input: String, initial: a, consume: fn(a, String) -> a) -> a {
  input
  |> string.lowercase()
  |> string.to_graphemes()
  |> tokenize_loop("", initial, consume)
}

fn tokenize_loop(
  graphemes: List(String),
  curr: String,
  acc: a,
  consume: fn(a, String) -> a,
) -> a {
  let next = fn() {
    case remove_quotes(curr) {
      "" -> acc
      curr -> consume(acc, curr)
    }
  }
  case graphemes {
    [] -> next()
    [head, ..tail] -> {
      case head == "'" || is_lower(head) || is_digit(head) {
        True -> tokenize_loop(tail, curr <> head, acc, consume)
        False -> tokenize_loop(tail, "", next(), consume)
      }
    }
  }
}

const lowers = "abcdefghijklmnopqrstuvwxyz"
const digits = "0123456789"

fn is_lower(char: String) -> Bool {
  string.contains(lowers, char)
}

fn is_digit(char: String) -> Bool {
  string.contains(digits, char)
}

fn remove_quotes(text: String) -> String {
  case string.starts_with(text, "'"), string.ends_with(text, "'") {
    True, True -> remove_quotes(text |> string.drop_start(1) |> string.drop_end(1))
    True, _ -> remove_quotes(text |> string.drop_start(1))
    _, True -> remove_quotes(text |> string.drop_end(1))
    _, _ -> text
  }
}

