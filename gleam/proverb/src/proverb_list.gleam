import gleam/list
import gleam/string_tree as sb

pub fn recite(inputs: List(String)) -> String {
  case inputs {
    [head, ..] -> {
      inputs
      |> list.window(2)
      |> list.fold(sb.new(), fn(st, pair) {
        let assert [fst, snd] = pair
        st
        |> sb.append("For want of a ")
        |> sb.append(fst)
        |> sb.append(" the ")
        |> sb.append(snd)
        |> sb.append(" was lost.\n")
      })
      |> sb.append("And all for the want of a ")
      |> sb.append(head)
      |> sb.append(".")
      |> sb.to_string()
    }
    _ -> ""
  }
}
