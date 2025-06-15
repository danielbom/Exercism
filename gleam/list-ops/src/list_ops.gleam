pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  concat([first, second])
}

pub fn concat(lists: List(List(a))) -> List(a) {
  foldl(lists, [], fn(acc, it) { foldl(it, acc, fn(acc, it) { [it, ..acc] }) })
  |> reverse()
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  foldl(list, [], fn(acc, it) {
    case function(it) {
      True -> [it, ..acc]
      False -> acc
    }
  })
  |> reverse()
}

pub fn length(list: List(a)) -> Int {
  foldl(list, 0, fn(acc, _) { acc + 1 })
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  foldl(list, [], fn(acc, it) { [function(it), ..acc] })
  |> reverse()
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [head, ..tail] -> foldl(tail, function(initial, head), function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  reverse(list) |> foldl(initial, function)
}

pub fn reverse(list: List(a)) -> List(a) {
  foldl(list, [], fn(acc, it) { [it, ..acc] })
}
