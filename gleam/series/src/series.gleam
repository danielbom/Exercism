import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let length = string.length(input)
  case size {
    _ if length == 0 -> Error(EmptySeries)
    n if n > length -> Error(SliceLengthTooLarge)
    n if n == 0 -> Error(SliceLengthZero)
    n if n < 0 -> Error(SliceLengthNegative)
    _ ->
      input
      |> string.to_graphemes()
      |> list.window(size)
      |> list.map(string.concat)
      |> Ok()
  }
}

pub type Error {
  EmptySeries
  SliceLengthZero
  SliceLengthNegative
  SliceLengthTooLarge
}
