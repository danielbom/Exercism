import gleam/dict.{type Dict}
import gleam/list

pub opaque type Set(t) {
  Set(values: Dict(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  list.fold(members, Set(dict.new()), add)
}

pub fn is_empty(set: Set(t)) -> Bool {
  dict.is_empty(set.values)
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  dict.has_key(set.values, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  is_empty(second)
  && is_empty(first)
  || all(first, fn(elem) { contains(second, elem) })
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  all(first, fn(elem) { !contains(second, elem) })
}

fn all(set: Set(t), pred: fn(t) -> Bool) -> Bool {
  set.values |> dict.keys() |> list.all(pred)
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  first.values == second.values
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  Set(dict.insert(set.values, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  combine(first, Set(dict.new()), fn(elem) { contains(second, elem) })
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  combine(first, Set(dict.new()), fn(elem) { !contains(second, elem) })
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  combine(first, second, fn(_) { True })
}

fn combine(first: Set(t), second: Set(t), pred: fn(t) -> Bool) -> Set(t) {
  first.values
  |> dict.keys()
  |> list.fold(second, fn(set, elem) {
    case pred(elem) {
      True -> add(set, elem)
      False -> set
    }
  })
}
