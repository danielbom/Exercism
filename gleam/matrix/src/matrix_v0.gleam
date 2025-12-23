import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn row(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(matrix(content))
  matrix |> list_at(index - 1)
}

pub fn column(index: Int, content: String) -> Result(List(Int), Nil) {
  use matrix <- result.try(matrix(content))
  matrix |> list.map(fn(row) { list_at(row, index - 1) }) |> result.all()
}

fn matrix(content: String) -> Result(List(List(Int)), Nil) {
  content
  |> string.split("\n")
  |> list.map(fn(line) {
    line |> string.split(" ") |> list.map(int.parse) |> result.all()
  })
  |> result.all()
}

fn list_at(xs: List(a), index: Int) -> Result(a, Nil) {
  case index > 0, xs {
    True, [_, ..rest] -> list_at(rest, index - 1)
    False, [x, ..] -> Ok(x)
    _, _ -> Error(Nil)
  }
}
