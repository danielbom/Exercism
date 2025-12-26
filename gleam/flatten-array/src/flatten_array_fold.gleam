import gleam/list

pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  flatten_loop([], nested_list)
  |> list.reverse()
}

fn flatten_loop(result: List(a), nested_list: NestedList(a)) -> List(a) {
  case nested_list {
    Null -> result
    Value(value) -> [value, ..result]
    List(values) -> list.fold(values, result, flatten_loop)
  }
}
