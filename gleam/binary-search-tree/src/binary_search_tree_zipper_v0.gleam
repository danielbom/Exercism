pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  to_tree_loop(Nil, data)
}

fn to_tree_loop(tree: Tree, data: List(Int)) -> Tree {
  case data {
    [] -> tree
    [x, ..xs] -> to_tree_loop(add(tree, x), xs)
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  to_list(to_tree(data))
}

fn to_list(tree: Tree) -> List(Int) {
  to_list_loop([], [tree], [])
}

fn to_list_loop(
  lefts: List(Tree),
  rights: List(Tree),
  result: List(Int),
) -> List(Int) {
  case lefts, rights {
    _, [current, ..rest] -> {
      case current {
        Nil -> to_list_loop(lefts, rest, result)
        Node(_, _, right) ->
          to_list_loop([current, ..lefts], [right, ..rest], result)
      }
    }
    [current, ..rest], _ -> {
      case current {
        Nil -> to_list_loop(rest, rights, result)
        Node(value, left, _) ->
          to_list_loop(rest, [left, ..rights], [value, ..result])
      }
    }
    _, _ -> result
  }
}

pub fn add(tree: Tree, value: Int) -> Tree {
  let zipper = zipper_at(value, Zipper(tree, Top))
  zipper_to_tree(Zipper(Node(value, Nil, Nil), zipper.trail))
}

type Trail {
  Top
  LeftCrumb(value: Int, right: Tree, trail: Trail)
  RightCrumb(value: Int, left: Tree, trail: Trail)
}

type Zipper {
  Zipper(focus: Tree, trail: Trail)
}

fn zipper_at(value: Int, zipper: Zipper) -> Zipper {
  let Zipper(focus, trail) = zipper
  case focus {
    Nil -> zipper
    Node(x, left, right) ->
      case value <= x {
        True -> zipper_at(value, Zipper(left, LeftCrumb(x, right, trail)))
        False -> zipper_at(value, Zipper(right, RightCrumb(x, left, trail)))
      }
  }
}

fn zipper_top(zipper: Zipper) -> Zipper {
  case zipper.trail {
    Top -> zipper
    LeftCrumb(value, right, trail) ->
      zipper_top(Zipper(Node(value, zipper.focus, right), trail))
    RightCrumb(value, left, trail) ->
      zipper_top(Zipper(Node(value, left, zipper.focus), trail))
  }
}

fn zipper_to_tree(zipper: Zipper) -> Tree {
  zipper_top(zipper).focus
}
