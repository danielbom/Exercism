pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  accumulate_loop([], list, fun)
}

fn accumulate_loop(acc: List(b), list: List(a), fun: fn(a) -> b) -> List(b) {
  case list {
    [] -> reverse_loop([], acc)
    [head, ..tail] -> {
      let next = fun(head)
      accumulate_loop([next, ..acc], tail, fun)
    }
  }
}

fn reverse_loop(acc: List(a), list: List(a)) -> List(a) {
  case list {
    [] -> acc
    [head, ..tail] -> reverse_loop([head, ..acc], tail)
  }
}
