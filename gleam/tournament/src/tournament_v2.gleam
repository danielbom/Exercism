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
  |> write_cols("Team", "MP", "W", "D", "L", "P")
  |> fn(header) {
    dict.values(stats)
    |> list.sort(stat_compare)
    |> list.fold(header, fn(st, stat) {
      sb.append(st, "\n")
      |> write_cols(
        stat.name,
        int.to_string(stat.played),
        int.to_string(stat.won),
        int.to_string(stat.drawn),
        int.to_string(stat.lost),
        int.to_string(stat.points),
      )
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

fn write_cols(
  st: sb.StringTree,
  team: String,
  played: String,
  won: String,
  drawn: String,
  lost: String,
  points: String,
) -> sb.StringTree {
  st
  |> write_col(team, 30, Begin)
  |> sb.append(" |")
  |> write_col(played, 3, End)
  |> sb.append(" |")
  |> write_col(won, 3, End)
  |> sb.append(" |")
  |> write_col(drawn, 3, End)
  |> sb.append(" |")
  |> write_col(lost, 3, End)
  |> sb.append(" |")
  |> write_col(points, 3, End)
}

fn write_col(
  st: sb.StringTree,
  text: String,
  length: Int,
  align: Align,
) -> sb.StringTree {
  let pad = int.max(0, length - string.length(text))
  let #(pad_start, pad_end) = case align {
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
  |> sb.append(text)
  |> sb.append(string.repeat(" ", pad_end))
}
