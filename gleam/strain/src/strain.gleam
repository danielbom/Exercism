pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_loop([], list, predicate)
}

fn keep_loop(acc: List(t), list: List(t), func: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> reverse_loop([], acc)
    [head, ..tail] -> {
      let acc = case func(head) {
        True -> [head, ..acc]
        False -> acc
      }
      keep_loop(acc, tail, func)
    }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  discard_loop([], list, predicate)
}

fn discard_loop(acc: List(t), list: List(t), func: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> reverse_loop([], acc)
    [head, ..tail] -> {
      let acc = case func(head) {
        True -> acc
        False -> [head, ..acc]
      }
      discard_loop(acc, tail, func)
    }
  }
}

fn reverse_loop(acc: List(t), list: List(t)) -> List(t) {
  case list {
    [] -> acc
    [head, ..tail] -> reverse_loop([head, ..acc], tail)
  }
}
