import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  path_current_to(tree, from)
  |> result.map(fn(path) { list.drop(path, 1) })
  |> result.map(fn(path) {
    list.fold(path, #(tree, []), fn(acc, label) {
      let #(acc_tree, acc_list) = acc
      let assert #(children, [focus]) =
        acc_tree.children |> list.partition(fn(child) { child.label != label })
      #(focus, [Tree(acc_tree.label, children), ..acc_list])
    })
  })
  |> result.map(fn(it) {
    let #(root, tree_list) = it
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
  })
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  from_pov(tree, from)
  |> result.then(fn(tree) { path_current_to(tree, to) })
}

pub fn path_current_to(tree tree: Tree(a), to to: a) -> Result(List(a), Nil) {
  path_current_to_loop([tree], to, [])
}

fn path_current_to_loop(
  trees: List(Tree(a)),
  to: a,
  result: List(a),
) -> Result(List(a), Nil) {
  case trees {
    [] -> Error(Nil)
    [head, ..tail] -> {
      case head.label == to {
        True -> Ok([head.label, ..result] |> list.reverse())
        False ->
          path_current_to_loop(head.children, to, [head.label, ..result])
          |> result.lazy_or(fn() { path_current_to_loop(tail, to, result) })
      }
    }
  }
}
