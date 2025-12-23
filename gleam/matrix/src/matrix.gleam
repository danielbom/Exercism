import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Matrix =
  List(List(Int))

pub fn row(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(parse(content))
  at(matrix, index - 1)
}

pub fn column(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(parse(content))
  list.try_map(matrix, at(_, index - 1))
}

fn parse(content: String) -> Result(Matrix, Nil) {
  content
  |> string.split("\n")
  |> list.try_map(fn(line) {
    line |> string.split(" ") |> list.try_map(int.parse)
  })
}

fn at(xs: List(a), index: Int) -> Result(a, Nil) {
  case index > 0, xs {
    True, [_, ..rest] -> at(rest, index - 1)
    False, [x, ..] -> Ok(x)
    _, _ -> Error(Nil)
  }
}
