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
  case silence, letters, yelling, question {
    True, _, _, _ -> "Fine. Be that way!"
    _, True, True, True -> "Calm down, I know what I'm doing!"
    _, True, True, False -> "Whoa, chill out!"
    _, _, _, True -> "Sure."
    _, _, _, _ -> "Whatever."
  }
}
