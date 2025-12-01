import gleam/list
import gleam/string

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  list.range(start_bottles, start_bottles - take_down + 1)
  |> list.map(fn(i) {
    let start = n2s(i)
    let start_b = n2b(i)
    let end = n2s(i - 1) |> string.lowercase()
    let end_b = n2b(i - 1)
    {
      start
      <> " green "
      <> start_b
      <> " hanging on the wall,\n"
      <> start
      <> " green "
      <> start_b
      <> " hanging on the wall,\n"
      <> "And if one green bottle should accidentally fall,\n"
      <> "There'll be "
      <> end
      <> " green "
      <> end_b
      <> " hanging on the wall."
    }
  })
  |> string.join("\n\n")
}

const numbers = [
  "No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
  "Ten",
]

fn n2s(x: Int) -> String {
  case list.drop(numbers, x) {
    [number, ..] -> number
    _ -> ""
  }
}

fn n2b(x: Int) -> String {
  case x == 1 {
    True -> "bottle"
    False -> "bottles"
  }
}
