import gleam/dict.{type Dict}
import gleam/list

pub opaque type Set(t) {
  Set(values: Dict(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  members
  |> list.fold(Set(dict.new()), add)
}

pub fn is_empty(set: Set(t)) -> Bool {
  dict.is_empty(set.values)
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  dict.has_key(set.values, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  case is_empty(second) {
    True -> is_empty(first)
    False ->
      first.values
      |> dict.keys()
      |> list.all(fn(elem) { contains(second, elem) })
  }
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  first.values
  |> dict.keys()
  |> list.all(fn(elem) { !contains(second, elem) })
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  first.values == second.values
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  Set(dict.insert(set.values, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.values
  |> dict.keys()
  |> list.filter(fn(elem) { contains(second, elem) })
  |> new()
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  first.values
  |> dict.keys()
  |> list.filter(fn(elem) { !contains(second, elem) })
  |> new()
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.values
  |> dict.keys()
  |> list.fold(second, add)
}
