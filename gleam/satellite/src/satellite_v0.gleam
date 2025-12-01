import gleam/bool
import gleam/list
import gleam/set

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  use <- bool.guard(
    list.length(inorder) != list.length(preorder),
    Error(DifferentLengths),
  )
  use <- bool.guard(
    set.from_list(inorder) != set.from_list(preorder),
    Error(DifferentItems),
  )
  use <- bool.guard(
    set.size(set.from_list(inorder)) != list.length(preorder),
    Error(NonUniqueItems),
  )
  Ok(reconstruct(inorder, preorder))
}

fn reconstruct(inorder: List(a), preorder: List(a)) -> Tree(a) {
  case preorder {
    [] -> Nil
    [x, ..preorder] -> {
      let #(li, ri) = split(inorder, x)
      let l = reconstruct(li, list.filter(preorder, list.contains(li, _)))
      let r = reconstruct(ri, list.filter(preorder, list.contains(ri, _)))
      Node(x, l, r)
    }
  }
}

fn split(xs: List(a), x: a) -> #(List(a), List(a)) {
  split_loop(xs, x, [])
}

fn split_loop(xs: List(a), x: a, left: List(a)) -> #(List(a), List(a)) {
  case xs {
    [] -> #(left, [])
    [y, ..rest] ->
      case x == y {
        True -> #(left, rest)
        False -> split_loop(rest, x, [y, ..left])
      }
  }
}
