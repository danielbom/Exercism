pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number <= 0, factors_sum(number) {
    True, _ -> Error(NonPositiveInt)
    _, sum if sum > number -> Ok(Abundant)
    _, sum if sum < number -> Ok(Deficient)
    _, _ -> Ok(Perfect)
  }
}

fn factors_sum(number: Int) -> Int {
  factors_fold(number, 0, fn(acc, x) { acc + x })
}

fn factors_fold(number: Int, initial: a, with fun: fn(a, Int) -> a) -> a {
  factors_fold_loop(number, 1, number, initial, fun)
}

fn factors_fold_loop(
  number: Int,
  left: Int,
  right: Int,
  current: a,
  fun: fn(a, Int) -> a,
) -> a {
  case left < right {
    True -> {
      let #(next_right, next_current) = case number % left == 0, number / left {
        True, value if left < value && value < right -> {
          #(value, fun(fun(current, left), value))
        }
        True, _ -> {
          #(right, fun(current, left))
        }
        _, _ -> {
          #(right, current)
        }
      }
      factors_fold_loop(number, left + 1, next_right, next_current, fun)
    }
    False -> current
  }
}

