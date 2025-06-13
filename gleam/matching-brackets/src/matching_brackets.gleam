import gleam/list
import gleam/string

pub fn is_paired(value: String) -> Bool {
  is_paired_loop(string.to_graphemes(value), [])
}

fn is_paired_loop(chars: List(String), stack: List(String)) -> Bool {
  case chars {
    [] -> list.is_empty(stack)
    [ch, ..chs] ->
      case ch {
        "(" -> is_paired_loop(chs, [")", ..stack])
        "[" -> is_paired_loop(chs, ["]", ..stack])
        "{" -> is_paired_loop(chs, ["}", ..stack])
        ")" | "]" | "}" ->
          case stack {
            [top, ..tail] if top == ch -> is_paired_loop(chs, tail)
            _ -> False
          }
        _ -> is_paired_loop(chs, stack)
      }
  }
}
