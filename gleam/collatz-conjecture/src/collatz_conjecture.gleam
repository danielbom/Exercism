pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number > 0 {
    True -> Ok(steps_loop(number, 0))
    False -> Error(NonPositiveNumber)
  }
}

pub fn steps_loop(number: Int, count: Int) -> Int {
  case number, number % 2 == 0 {
    1, _ -> count
    _, True -> steps_loop(number / 2, count + 1)
    _, False -> steps_loop(number * 3 + 1, count + 1)
  }
}
