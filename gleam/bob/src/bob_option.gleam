import gleam/option.{type Option, None, Some}
import gleam/regexp
import gleam/string

pub fn hey(remark: String) -> String {
  let assert Ok(re_letters) = regexp.from_string("[a-zA-Z]")
  let assert Ok(re_chill) = regexp.from_string("[a-z]")
  let remark = string.trim(remark)
  let letters = regexp.check(re_letters, remark)
  let yelling = !regexp.check(re_chill, remark)
  let question = string.ends_with(remark, "?")
  let silence = string.is_empty(remark)
  check(None, silence, "Fine. Be that way!")
  |> check(letters && yelling && question, "Calm down, I know what I'm doing!")
  |> check(letters && yelling, "Whoa, chill out!")
  |> check(question, "Sure.")
  |> option.unwrap("Whatever.")
}

fn check(out: Option(String), cond: Bool, result: String) -> Option(String) {
  option.lazy_or(out, fn() {
    case cond {
      True -> Some(result)
      False -> out
    }
  })
}
