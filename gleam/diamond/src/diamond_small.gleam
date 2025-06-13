import gleam/list
import gleam/string

pub fn build(letter: String) -> String {
  let letters_list = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> string.to_graphemes

  let assert [codepoint] = letter |> string.to_utf_codepoints
  let index = string.utf_codepoint_to_int(codepoint) - 65

  letters_list
  |> list.take(index + 1)
  |> list.index_map(fn(x, i) {
    let padding = string.repeat(" ", index - i)
    let middle_space = string.repeat(" ", 2 * i - 1)
    case i {
      0 -> padding <> x <> padding
      _ -> padding <> x <> middle_space <> x <> padding
    }
  })
  |> fn(l) { list.append(l, l |> list.reverse |> list.drop(1)) }
  |> string.join("\n")
}