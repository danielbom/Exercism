pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  case input_base, output_base {
    base, _ if base <= 1 -> Error(InvalidBase(base))
    _, base if base <= 1 -> Error(InvalidBase(base))
    _, _ ->
      case digits_to_int(digits, input_base) {
        Ok(value) -> Ok(int_to_digits(value, output_base))
        Error(digit) -> Error(InvalidDigit(digit))
      }
  }
}

fn int_to_digits(value: Int, base: Int) -> List(Int) {
  int_to_digits_loop(value, base, [])
}

fn int_to_digits_loop(value: Int, base: Int, result: List(Int)) -> List(Int) {
  case value > 0, result {
    True, _ -> int_to_digits_loop(value / base, base, [value % base, ..result])
    False, [] -> [0]
    False, _ -> result
  }
}

fn digits_to_int(digits: List(Int), base: Int) -> Result(Int, Int) {
  digits_to_int_loop(digits, base, 0, multiple(digits, base, 1))
}

fn digits_to_int_loop(
  digits: List(Int),
  base: Int,
  result: Int,
  mult: Int,
) -> Result(Int, Int) {
  case digits {
    [] -> Ok(result)
    [digit, ..rest] if base > digit && digit >= 0 ->
      digits_to_int_loop(rest, base, result + digit * mult, mult / base)
    [digit, ..] -> Error(digit)
  }
}

fn multiple(digits: List(int), base: Int, result: Int) -> Int {
  case digits {
    [] | [_] -> result
    [_, ..tail] -> multiple(tail, base, base * result)
  }
}
