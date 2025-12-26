import gleam/list

pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

pub fn sublist(compare xs: List(a), to ys: List(a)) -> Comparison {
  case list.length(xs), list.length(ys) {
    xslen, yslen if xslen < yslen ->
      case is_sublist(ys, yslen, xs, xslen) {
        True -> Sublist
        False -> Unequal
      }
    xslen, yslen if xslen > yslen ->
      case is_sublist(xs, xslen, ys, yslen) {
        True -> Superlist
        False -> Unequal
      }
    _, _ ->
      case xs == ys {
        True -> Equal
        False -> Unequal
      }
  }
}

fn is_sublist(xs: List(a), xslen: Int, ys: List(a), yslen: Int) -> Bool {
  case xs, xslen >= yslen {
    [_, ..tail], True ->
      starts_with(xs, ys) || is_sublist(tail, xslen - 1, ys, yslen)
    _, _ -> False
  }
}

fn starts_with(xs: List(a), ys: List(a)) -> Bool {
  case xs, ys {
    [x, ..xs], [y, ..ys] if x == y -> starts_with(xs, ys)
    _, [] -> True
    _, _ -> False
  }
}
