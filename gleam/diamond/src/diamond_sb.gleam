import gleam/list
import gleam/string
import gleam/string_tree as sb

pub fn build(letter: String) -> String {
  let #(ix, letters) =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> string.to_graphemes()
    |> take_index(letter, 0, [])
  build_loop(letters, ix * 2 - 1, 0, sb.new())
}

fn build_loop(letters, middle, side, result) {
  case letters {
    [] -> result |> sb.to_string()
    [head, ..tail] -> {
      let line =
        sb.from_string(head)
        |> repeat(middle, fn(it) { sb.append(it, " ") })
        |> cond(middle > 0, fn(it) { sb.append(it, head) })
        |> repeat(side, fn(it) { sb.append(it, " ") })
        |> repeat(side, fn(it) { sb.prepend(it, " ") })
      let bottom =
        line |> cond(!list.is_empty(tail), fn(it) { sb.append(it, "\n") })
      let result = case side > 0 {
        True ->
          result
          |> sb.append_tree(bottom)
          |> sb.prepend_tree(line |> sb.append("\n"))
        False -> bottom
      }
      build_loop(tail, middle - 2, side + 1, result)
    }
  }
}

fn take_index(letters, ch, ix, acc) {
  case letters {
    [] -> #(ix, acc)
    [head, ..tail] -> {
      let next = [head, ..acc]
      case head == ch {
        True -> #(ix, next)
        False -> take_index(tail, ch, ix + 1, next)
      }
    }
  }
}

fn repeat(acc: a, count: Int, func: fn(a) -> a) -> a {
  cond(acc, count > 0, fn(it) { repeat(func(it), count - 1, func) })
}

fn cond(acc: a, cond: Bool, func: fn(a) -> a) -> a {
  case cond {
    True -> func(acc)
    False -> acc
  }
}
