import gleam/list
import gleam/result

pub type Tree(a) {
  Tree(label: a, children: List(Tree(a)))
}

pub fn from_pov(tree: Tree(a), from: a) -> Result(Tree(a), Nil) {
  from_pov_loop([tree], [], from)
  |> result.then(fn(it) {
    case it.0 {
      [] -> Error(Nil)
      [head, ..tail] ->
        tail
        |> list.fold(head, fn(tree, node) {
          Tree(node.label, [tree, ..node.children])
        })
        |> Ok()
    }
  })
}

pub fn from_pov_loop(
  left: List(Tree(a)),
  right: List(Tree(a)),
  from: a,
) -> Result(#(List(Tree(a)), List(Tree(a))), Nil) {
  case left {
    [] -> Error(Nil)
    [head, ..tail] -> {
      case head.label == from {
        True -> Ok(#([head], list.append(tail, right)))
        False -> {
          from_pov_loop(head.children, [], from)
          |> result.map(fn(result) {
            let #(stack, children) = result
            #([Tree(head.label, children), ..stack], list.append(tail, right))
          })
          |> result.lazy_or(fn() { from_pov_loop(tail, [head, ..right], from) })
        }
      }
    }
  }
}

pub fn path_to(
  tree tree: Tree(a),
  from from: a,
  to to: a,
) -> Result(List(a), Nil) {
  from_pov(tree, from)
  |> result.then(fn(it) { from_pov_loop([it], [], to) })
  |> result.then(fn(it) {
    case list.reverse(it.0) {
      [] -> Error(Nil)
      [head, ..tail] ->
        tail
        |> list.fold([head.label], fn(acc, node) { [node.label, ..acc] })
        |> Ok()
    }
  })
}
