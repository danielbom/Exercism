import gleam/dict
import gleam/list
import gleam/set
import gleam/string

type Coord {
  Coord(y: Int, x: Int)
}

type Segment {
  Segment(a: Coord, b: Coord)
}

pub fn rectangles(input: String) -> Int {
  input
  |> collect_segments()
  |> count_rectangles()
}

fn count_rectangles(segments: #(List(Segment), List(Segment))) -> Int {
  let #(sy, sx) = segments
  let segments = set.union(set.from_list(sy), set.from_list(sx))
  let sx = list.group(sx, fn(s) { s.a })

  list.fold(sy, 0, fn(count, sa) {
    let Segment(a, b) = sa
    case dict.get(sx, a) {
      Ok(cs) ->
        list.fold(cs, count, fn(count, sb) {
          let Segment(_, c) = sb
          let d = Coord(c.y, b.x)
          case
            c.y > a.y
            && set.contains(segments, Segment(c, d))
            && set.contains(segments, Segment(b, d))
          {
            True -> count + 1
            False -> count
          }
        })
      Error(_) -> count
    }
  })
}

fn collect_segments(input: String) -> #(List(Segment), List(Segment)) {
  let map =
    tokenize(input, dict.new(), fn(curr, y, x, token) {
      dict.insert(curr, Coord(y, x), token)
    })
  let coords =
    tokenize(input, [], fn(curr, y, x, token) {
      case token {
        "+" -> [Coord(y, x), ..curr]
        _ -> curr
      }
    })
  let is_valid = fn(coord, token) {
    case dict.get(map, coord) {
      Ok("+") -> True
      Ok(other) -> token == other
      Error(_) -> False
    }
  }
  let sy =
    list.group(coords, fn(c) { c.y })
    |> dict.fold([], fn(result, _, coords) {
      fold_pairs(coords, result, fn(result, a, b) {
        let s = segment_new(a, b, fn(c) { c.x })
        case
          list.range(s.a.x, s.b.x)
          |> list.all(fn(x) { is_valid(Coord(a.y, x), "-") })
        {
          True -> [s, ..result]
          False -> result
        }
      })
    })
  let sx =
    list.group(coords, fn(c) { c.x })
    |> dict.fold([], fn(result, _, coords) {
      fold_pairs(coords, result, fn(result, a, b) {
        let s = segment_new(a, b, fn(c) { c.y })
        case
          list.range(s.a.y, s.b.y)
          |> list.all(fn(y) { is_valid(Coord(y, a.x), "|") })
        {
          True -> [s, ..result]
          False -> result
        }
      })
    })
  #(sy, sx)
}

// NOTE: replaces `list.combination_pairs(...) |> list.fold(...)`
fn fold_pairs(xs: List(a), initial: b, consume: fn(b, a, a) -> b) -> b {
  case xs {
    [] -> initial
    [_] -> initial
    [fst, ..tail] -> {
      list.fold(tail, initial, fn(curr, snd) { consume(curr, fst, snd) })
      |> fold_pairs(tail, _, consume)
    }
  }
}

fn segment_new(a: Coord, b: Coord, key: fn(Coord) -> Int) -> Segment {
  case key(a) > key(b) {
    True -> Segment(b, a)
    False -> Segment(a, b)
  }
}

fn tokenize(
  input: String,
  initial: a,
  consume: fn(a, Int, Int, String) -> a,
) -> a {
  let #(result, _, _) =
    input
    |> string.to_graphemes()
    |> list.fold(#(initial, 0, 0), fn(state, token) {
      let #(curr, y, x) = state
      case token {
        "\n" -> #(curr, y + 1, 0)
        "+" -> #(consume(curr, y, x, token), y, x + 1)
        "-" -> #(consume(curr, y, x, token), y, x + 1)
        "|" -> #(consume(curr, y, x, token), y, x + 1)
        _ -> #(curr, y, x + 1)
      }
    })
  result
}
