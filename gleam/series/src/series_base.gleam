import gleam/bool
import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  use <- bool.guard(input == "", Error(EmptySeries))
  use <- bool.guard(size == 0, Error(SliceLengthZero))
  use <- bool.guard(size < 0, Error(SliceLengthNegative))
  case
    input
    |> string.to_graphemes()
    |> collect([], _, size)
    |> list.map(string.join(_, ""))
  {
    [] -> Error(SliceLengthTooLarge)
    result -> Ok(result)
  }
}

fn collect(acc, digits: List(String), size: Int) {
  case digits {
    [] -> list.reverse(acc)
    [_, ..tail] -> {
      case collect_one_loop([], digits, size) {
        Ok(sequence) -> collect([sequence, ..acc], tail, size)
        Error(_) -> list.reverse(acc)
      }
    }
  }
}

fn collect_one_loop(acc, digits: List(String), size: Int) {
  use <- bool.lazy_guard(size == 0, fn() { Ok(list.reverse(acc)) })
  case digits {
    [] -> Error(Nil)
    [head, ..tail] -> collect_one_loop([head, ..acc], tail, size - 1)
  }
}

pub type Error {
  EmptySeries
  SliceLengthZero
  SliceLengthNegative
  SliceLengthTooLarge
}
