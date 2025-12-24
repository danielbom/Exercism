import gleam/bool
import gleam/int
import gleam/list
import gleam/result

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

fn validate_digit_base(digit: Int, base: Int) -> Result(Int, Error) {
  case digit >= 0 && digit < base {
    True -> Ok(digit)
    False -> Error(InvalidDigit(digit))
  }
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  use <- bool.guard(input_base < 2, Error(InvalidBase(input_base)))
  use <- bool.guard(output_base < 2, Error(InvalidBase(output_base)))
  list.map(digits, validate_digit_base(_, input_base))
  |> result.all
  |> result.try(fn(digits) {
    int.undigits(digits, input_base) |> result.replace_error(InvalidDigit(0))
  })
  |> result.try(fn(digit) {
    int.digits(digit, output_base) |> result.replace_error(InvalidDigit(digit))
  })
}
