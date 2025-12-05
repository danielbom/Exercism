import gleam/dict
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/order
import gleam/string
import gleam/string_tree as sb

pub fn tally(input: String) -> String {
  cols_new("Team", "MP", "W", "D", "L", "P")
  |> write_row()
  |> write_rows(stats_new(input))
  |> sb.to_string()
}

type Stat {
  Stat(name: String, played: Int, won: Int, drawn: Int, lost: Int, points: Int)
}

type Stats =
  dict.Dict(String, Stat)

fn stat_new(name: String, result: String) -> Stat {
  case result {
    "win" -> Stat(name, 1, 1, 0, 0, 3)
    "draw" -> Stat(name, 1, 0, 1, 0, 1)
    "loss" -> Stat(name, 1, 0, 0, 1, 0)
    _ -> panic as result
  }
}

fn stat_compare(a: Stat, b: Stat) -> order.Order {
  int.compare(a.points, b.points)
  |> order.negate()
  |> order.lazy_break_tie(fn() { string.compare(a.name, b.name) })
}

fn stats_add(stats: Stats, team: String, result: String) -> Stats {
  let item = stat_new(team, result)
  dict.upsert(stats, team, fn(entry) {
    case entry {
      Some(prev) ->
        Stat(
          prev.name,
          prev.played + item.played,
          prev.won + item.won,
          prev.drawn + item.drawn,
          prev.lost + item.lost,
          prev.points + item.points,
        )
      None -> item
    }
  })
}

fn stats_new(input: String) -> Stats {
  input
  |> string.split("\n")
  |> list.fold(dict.new(), fn(stats, line) {
    case string.split(line, ";") {
      [team_a, team_b, result] -> {
        stats
        |> stats_add(team_a, result)
        |> stats_add(team_b, result_invert(result))
      }
      _ -> stats
    }
  })
}

fn result_invert(result: String) -> String {
  case result {
    "win" -> "loss"
    "draw" -> "draw"
    "loss" -> "win"
    _ -> panic
  }
}

type Align {
  Begin
  Middle
  End
}

type Col {
  Col(text: String, length: Int, align: Align)
}

fn write_rows(st: sb.StringTree, stats: Stats) -> sb.StringTree {
  dict.values(stats)
  |> list.sort(stat_compare)
  |> list.map(fn(item) {
    cols_new(
      item.name,
      int.to_string(item.played),
      int.to_string(item.won),
      int.to_string(item.drawn),
      int.to_string(item.lost),
      int.to_string(item.points),
    )
    |> write_row()
    |> sb.prepend("\n")
  })
  |> sb.concat()
  |> sb.prepend_tree(st)
}

fn write_row(cols: List(Col)) -> sb.StringTree {
  write_row_loop(sb.new(), cols)
}

fn write_row_loop(st: sb.StringTree, cols: List(Col)) -> sb.StringTree {
  case cols {
    [] -> st
    [head] -> sb.append_tree(st, write_col(head))
    [head, ..tail] ->
      st
      |> sb.append_tree(write_col(head))
      |> sb.append(" |")
      |> write_row_loop(tail)
  }
}

fn write_col(col: Col) -> sb.StringTree {
  let pad = int.max(0, col.length - string.length(col.text))
  let #(pad_start, pad_end) = case col.align {
    Begin -> #(0, pad)
    Middle -> {
      let pad_end = pad / 2
      let pad_start = pad - pad_end
      #(pad_start, pad_end)
    }
    End -> #(pad, 0)
  }
  col.text
  |> sb.from_string()
  |> sb.prepend(string.repeat(" ", pad_start))
  |> sb.append(string.repeat(" ", pad_end))
}

fn cols_new(
  team: String,
  played: String,
  won: String,
  drawn: String,
  lost: String,
  points: String,
) {
  [
    Col(team, 30, Begin),
    Col(played, 3, End),
    Col(won, 3, End),
    Col(drawn, 3, End),
    Col(lost, 3, End),
    Col(points, 3, End),
  ]
}
