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
      let assert #(li, [_, ..ri]) = list.split_while(inorder, fn(y) { y != x })
      let #(lp, rp) = list.split(preorder, list.length(li))
      Node(x, reconstruct(li, lp), reconstruct(ri, rp))
    }
  }
}

