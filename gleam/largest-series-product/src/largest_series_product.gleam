import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn largest_product(digits: String, span: Int) -> Result(Int, Nil) {
  use <- bool.guard(0 > span, Error(Nil))
  use <- bool.guard(span > string.length(digits), Error(Nil))
  use <- bool.guard(span == 0, Ok(1))
  digits
  |> string.to_graphemes()
  |> list.try_map(int.parse)
  |> result.map(fn(digits) {
    digits
    |> list.window(span)
    |> list.fold(0, fn(acc, window) { int.max(acc, int.product(window)) })
  })
}
