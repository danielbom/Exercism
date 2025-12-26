import gleam/list

pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  flatten_loop([nested_list], [])
  |> list.reverse()
}

fn flatten_loop(nested_list: List(NestedList(a)), result: List(a)) -> List(a) {
  case nested_list {
    [] -> result
    [Null, ..rest] -> flatten_loop(rest, result)
    [Value(value), ..rest] -> flatten_loop(rest, [value, ..result])
    [List(values), ..rest] -> flatten_loop(rest, flatten_loop(values, result))
  }
}
