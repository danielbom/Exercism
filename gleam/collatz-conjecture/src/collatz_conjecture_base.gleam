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
  case number == 1 {
    True -> count
    False -> {
      let number = case number % 2 == 0 {
        True -> number / 2
        False -> number * 3 + 1
      }
      steps_loop(number, count + 1)
    }
  }
}
