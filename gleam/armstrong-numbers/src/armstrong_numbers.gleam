import gleam/int
import gleam/list
import gleam/result

pub fn is_armstrong_number(number: Int) -> Bool {
  let digits =
    number
    |> int.digits(10)
    |> result.unwrap([])
  let count = list.length(digits)
  let transformed = list.fold(digits, 0, fn(acc, it) { acc + power(it, count) })
  transformed == number
}

fn power(x: Int, count: Int) {
  case x == 1 || count <= 1 {
    True -> x
    False -> power_loop(1, x, count)
  }
}

fn power_loop(acc: Int, x: Int, count: Int) {
  case count > 0 {
    True -> power_loop(acc * x, x, count - 1)
    False -> acc
  }
}
