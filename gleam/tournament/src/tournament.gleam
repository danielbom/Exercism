import gleam/dict
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/order
import gleam/string
import gleam/string_tree as sb

type Stat {
  Stat(name: String, played: Int, won: Int, drawn: Int, lost: Int, points: Int)
}

type Stats =
  dict.Dict(String, Stat)

pub fn tally(input: String) -> String {
  input
  |> stats_parse()
  |> stats_write()
}

fn stats_parse(input: String) -> Stats {
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

fn stats_write(stats: Stats) -> String {
  sb.new()
  |> write_cols(cols_new("Team", "MP", "W", "D", "L", "P"))
  |> fn(header) {
    dict.values(stats)
    |> list.sort(stat_compare)
    |> list.fold(header, fn(st, stat) {
      sb.append(st, "\n")
      |> write_cols(stat_to_cols(stat))
    })
  }
  |> sb.to_string()
}

fn stats_add(stats: Stats, team: String, result: String) -> Stats {
  let stat = case result {
    "win" -> Stat(team, 1, 1, 0, 0, 3)
    "draw" -> Stat(team, 1, 0, 1, 0, 1)
    "loss" -> Stat(team, 1, 0, 0, 1, 0)
    _ -> panic as result
  }
  dict.upsert(stats, team, fn(entry) {
    case entry {
      Some(prev) -> stat_append(prev, stat)
      None -> stat
    }
  })
}

fn stat_to_cols(stat: Stat) -> List(Col) {
  cols_new(
    stat.name,
    int.to_string(stat.played),
    int.to_string(stat.won),
    int.to_string(stat.drawn),
    int.to_string(stat.lost),
    int.to_string(stat.points),
  )
}

fn stat_compare(a: Stat, b: Stat) -> order.Order {
  int.compare(a.points, b.points)
  |> order.negate()
  |> order.lazy_break_tie(fn() { string.compare(a.name, b.name) })
}

fn stat_append(a: Stat, b: Stat) -> Stat {
  Stat(
    a.name,
    a.played + b.played,
    a.won + b.won,
    a.drawn + b.drawn,
    a.lost + b.lost,
    a.points + b.points,
  )
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

fn write_cols(st: sb.StringTree, cols: List(Col)) -> sb.StringTree {
  case cols {
    [] -> st
    [head, ..tail] ->
      list.fold(tail, write_col(st, head), fn(st, col) {
        sb.append(st, " |")
        |> write_col(col)
      })
  }
}

fn write_col(st: sb.StringTree, col: Col) -> sb.StringTree {
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
  st
  |> sb.append(string.repeat(" ", pad_start))
  |> sb.append(col.text)
  |> sb.append(string.repeat(" ", pad_end))
}
