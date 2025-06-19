import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  use path <- result.map(path_current_to(tree, from))
  let path = list.drop(path, 1)
  let #(root, tree_list) =
    list.fold(path, #(tree, []), fn(acc, label) {
      let #(acc_tree, acc_list) = acc
      let assert #(children, [focus]) =
        acc_tree.children |> list.partition(fn(child) { child.label != label })
      #(focus, [Tree(acc_tree.label, children), ..acc_list])
    })
  case tree_list |> list.reverse() {
    [] -> root
    [head, ..tail] -> {
      let child =
        list.fold(tail, head, fn(acc, it) {
          Tree(it.label, [acc, ..it.children])
        })
      Tree(root.label, [child, ..root.children])
    }
  }
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  from_pov(tree, from)
  |> result.then(path_current_to(_, to))
}

pub fn path_current_to(tree tree: Tree(a), to to: a) -> Result(List(a), Nil) {
  path_current_to_loop(tree, to, [])
}

fn path_current_to_loop(
  tree: Tree(a),
  to: a,
  result: List(a),
) -> Result(List(a), Nil) {
  case tree.label == to {
    True -> Ok([tree.label, ..result] |> list.reverse())
    False ->
      tree.children
      |> list.find_map(path_current_to_loop(_, to, [tree.label, ..result]))
  }
}
