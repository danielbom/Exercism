import gleam/string_tree as sb

pub fn recite(inputs: List(String)) -> String {
  case inputs {
    [head, ..] -> recite_loop(sb.new(), inputs, head)
    _ -> ""
  }
}

fn recite_loop(st: sb.StringTree, inputs: List(String), head: String) -> String {
  case inputs {
    [fst, snd, ..tail] -> {
      st
      |> sb.append("For want of a ")
      |> sb.append(fst)
      |> sb.append(" the ")
      |> sb.append(snd)
      |> sb.append(" was lost.\n")
      |> recite_loop([snd, ..tail], head)
    }
    _ -> {
      st
      |> sb.append("And all for the want of a ")
      |> sb.append(head)
      |> sb.append(".")
      |> sb.to_string()
    }
  }
}
