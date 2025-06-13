import gleam/string
import gleam/list
import gleam/int
import gleam/bool

fn build_line(line: Int, size: Int) {
  let rank = line - int.max(line - size, 0) * 2
  let outer = string.repeat(" ", size - rank)
  use <- bool.guard(rank == 0, outer <> "A" <> outer)

  let assert Ok(code) = string.utf_codepoint(rank + 65)
  let letter = string.from_utf_codepoints([code])
  let inner = string.repeat(" ", rank * 2 - 1)
  outer <> letter <> inner <> letter <> outer
}

pub fn build(letter: String) -> String {
  let assert [code] = string.to_utf_codepoints(letter)
  let size = string.utf_codepoint_to_int(code) - 65

  list.range(0, size * 2)
  |> list.map(fn(line) { build_line(line, size) })
  |> string.join("\n")
}