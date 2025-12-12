import gleam/dict
import gleam/list
import gleam/set
import gleam/string

type Point {
  Point(y: Int, x: Int)
}

type Segment {
  Segment(a: Point, b: Point)
}

pub fn rectangles(input: String) -> Int {
  input
  |> collect_segments()
  |> count_rectangles()
}

fn count_rectangles(segments: #(List(Segment), List(Segment))) -> Int {
  let #(horizontal, vertical) = segments
  let segments = set.union(set.from_list(horizontal), set.from_list(vertical))
  let vertical = list.group(vertical, fn(s) { s.a })

  list.fold(horizontal, 0, fn(count, row) {
    let Segment(a, b) = row
    case dict.get(vertical, a) {
      Ok(cs) ->
        list.fold(cs, count, fn(count, column) {
          let Segment(_, c) = column
          let d = Point(c.y, b.x)
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
      dict.insert(curr, Point(y, x), token)
    })
  let points =
    dict.fold(map, [], fn(curr, p, token) {
      case token {
        "+" -> [p, ..curr]
        _ -> curr
      }
    })
  let is_valid = fn(p, token) {
    case dict.get(map, p) {
      Ok("+") -> True
      Ok(other) -> token == other
      Error(_) -> False
    }
  }
  let horizontal =
    list.group(points, fn(c) { c.y })
    |> dict.fold([], fn(result, _, points) {
      fold_pairs(points, result, fn(result, a, b) {
        let s = segment_new(a, b, fn(c) { c.x })
        case
          list.range(s.a.x, s.b.x)
          |> list.all(fn(x) { is_valid(Point(a.y, x), "-") })
        {
          True -> [s, ..result]
          False -> result
        }
      })
    })
  let vertical =
    list.group(points, fn(c) { c.x })
    |> dict.fold([], fn(result, _, points) {
      fold_pairs(points, result, fn(result, a, b) {
        let s = segment_new(a, b, fn(c) { c.y })
        case
          list.range(s.a.y, s.b.y)
          |> list.all(fn(y) { is_valid(Point(y, a.x), "|") })
        {
          True -> [s, ..result]
          False -> result
        }
      })
    })
  #(horizontal, vertical)
}

// NOTE: replaces `list.combination_pairs(...) |> list.fold(...)`
fn fold_pairs(xs: List(a), initial: b, next: fn(b, a, a) -> b) -> b {
  case xs {
    [] -> initial
    [_] -> initial
    [fst, ..tail] -> {
      list.fold(tail, initial, fn(curr, snd) { next(curr, fst, snd) })
      |> fold_pairs(tail, _, next)
    }
  }
}

fn segment_new(a: Point, b: Point, key: fn(Point) -> Int) -> Segment {
  case key(a) > key(b) {
    True -> Segment(b, a)
    False -> Segment(a, b)
  }
}

fn tokenize(input, initial: a, next: fn(a, Int, Int, String) -> a) -> a {
  let #(result, _, _) =
    input
    |> string.to_graphemes()
    |> list.fold(#(initial, 0, 0), fn(state, token) {
      let #(curr, y, x) = state
      case token {
        "\n" -> #(curr, y + 1, 0)
        "+" -> #(next(curr, y, x, token), y, x + 1)
        "-" -> #(next(curr, y, x, token), y, x + 1)
        "|" -> #(next(curr, y, x, token), y, x + 1)
        _ -> #(curr, y, x + 1)
      }
    })
  result
}
