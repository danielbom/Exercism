pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn add(tree: Tree, val: Int) -> Tree {
  Zipper(tree, Top)
  |> zipper_add(val)
  |> zipper_to_tree()
}

pub fn to_tree(data: List(Int)) -> Tree {
  tree_from_list(data)
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> zipper_from_list()
  |> zipper_to_list()
}

fn tree_from_list(data: List(Int)) -> Tree {
  data
  |> zipper_from_list()
  |> zipper_to_tree()
}

fn zipper_to_list(zipper: Zipper) -> List(Int) {
  zipper_to_list_loop([zipper_max(zipper_top(zipper))], [])
}

fn zipper_to_list_loop(zippers: List(Zipper), result: List(Int)) -> List(Int) {
  case zippers {
    [] -> result
    [zipper, ..rest] ->
      case zipper.focus {
        Nil -> zipper_to_list_loop(rest, result)
        Node(val, left_node, _) -> {
          let left = zipper_max(Zipper(left_node, Top))
          let up = zipper_up(zipper)
          zipper_to_list_loop([left, up, ..rest], [val, ..result])
        }
      }
  }
}

fn zipper_max(z: Zipper) -> Zipper {
  case z.focus {
    Nil -> zipper_up(z)
    Node(val, left, right) ->
      zipper_max(Zipper(right, Left(val, left, z.trail)))
  }
}

fn zipper_up(z: Zipper) -> Zipper {
  case z.trail {
    Top -> Zipper(Nil, Top)
    Left(val, left, trail) -> Zipper(Node(val, left, z.focus), trail)
    Right(val, right, trail) -> Zipper(Node(val, z.focus, right), trail)
  }
}

type Trail {
  Top
  Left(val: Int, right: Tree, trail: Trail)
  Right(val: Int, left: Tree, trail: Trail)
}

type Zipper {
  Zipper(focus: Tree, trail: Trail)
}

fn zipper_at(zipper: Zipper, val: Int) -> Zipper {
  let Zipper(focus, trail) = zipper
  case focus {
    Nil -> zipper
    Node(x, left, right) ->
      case val <= x {
        True -> zipper_at(Zipper(left, Left(x, right, trail)), val)
        False -> zipper_at(Zipper(right, Right(x, left, trail)), val)
      }
  }
}

fn zipper_top(zipper: Zipper) -> Zipper {
  case zipper.trail {
    Top -> zipper
    Left(val, right, trail) ->
      zipper_top(Zipper(Node(val, zipper.focus, right), trail))
    Right(val, left, trail) ->
      zipper_top(Zipper(Node(val, left, zipper.focus), trail))
  }
}

fn zipper_add(zipper: Zipper, val: Int) -> Zipper {
  let top = zipper_top(zipper)
  let trail = zipper_at(top, val)
  Zipper(Node(val, Nil, Nil), trail.trail)
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
