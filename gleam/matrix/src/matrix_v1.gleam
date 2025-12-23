import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn row(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(matrix(content))
  list_at(matrix, index - 1)
}

pub fn column(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(matrix(content))
  list.try_map(matrix, list_at(_, index - 1))
}

fn matrix(content: String) -> Result(List(List(Int)), Nil) {
  content
  |> string.split("\n")
  |> list.try_map(fn(line) {
    line |> string.split(" ") |> list.try_map(int.parse)
  })
}

fn list_at(xs: List(a), index: Int) -> Result(a, Nil) {
  case index > 0, xs {
    True, [_, ..rest] -> list_at(rest, index - 1)
    False, [x, ..] -> Ok(x)
    _, _ -> Error(Nil)
  }
}
