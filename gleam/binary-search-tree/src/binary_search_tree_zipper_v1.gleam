pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn add(tree: Tree, value: Int) -> Tree {
  Zipper(tree, Top)
  |> zipper_add(value)
  |> zipper_to_tree()
}

pub fn to_tree(data: List(Int)) -> Tree {
  tree_from_list(data)
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> tree_from_list()
  |> tree_to_list()
}

fn tree_from_list(data: List(Int)) -> Tree {
  data
  |> zipper_from_list()
  |> zipper_to_tree()
}

fn tree_to_list(tree: Tree) -> List(Int) {
  tree_to_list_loop([], [tree], [])
}

fn tree_to_list_loop(
  lefts: List(Tree),
  rights: List(Tree),
  result: List(Int),
) -> List(Int) {
  case lefts, rights {
    _, [current, ..rest] -> {
      case current {
        Nil -> tree_to_list_loop(lefts, rest, result)
        Node(_, _, right) ->
          tree_to_list_loop([current, ..lefts], [right, ..rest], result)
      }
    }
    [current, ..rest], _ -> {
      case current {
        Nil -> tree_to_list_loop(rest, rights, result)
        Node(value, left, _) ->
          tree_to_list_loop(rest, [left, ..rights], [value, ..result])
      }
    }
    _, _ -> result
  }
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

fn zipper_add(zipper: Zipper, value: Int) -> Zipper {
  let top = zipper_top(zipper)
  let trail = zipper_at(value, top)
  Zipper(Node(value, Nil, Nil), trail.trail)
}

fn zipper_to_tree(zipper: Zipper) -> Tree {
  zipper_top(zipper).focus
}

fn zipper_from_list(data: List(Int)) -> Zipper {
  zipper_from_list_loop(Zipper(Nil, Top), data)
}

fn zipper_from_list_loop(zipper: Zipper, data: List(Int)) -> Zipper {
  case data {
    [] -> zipper
    [x, ..xs] -> zipper_from_list_loop(zipper_add(zipper, x), xs)
  }
}
