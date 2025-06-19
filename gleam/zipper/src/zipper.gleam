pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

type TreeWalk(a) {
  Left(a, Tree(a))
  Right(a, Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(steps: List(TreeWalk(a)), focus: Tree(a))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper([], tree)
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case up(zipper) {
    Ok(up) -> to_tree(up)
    Error(_) -> zipper.focus
  }
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper.focus {
    Leaf -> Error(Nil)
    Node(value, _, _) -> Ok(value)
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.steps {
    [] -> Error(Nil)
    [prev, ..steps] -> {
      let focus = case prev {
        Left(value, right) -> Node(value, zipper.focus, right)
        Right(value, left) -> Node(value, left, zipper.focus)
      }
      Ok(Zipper(steps, focus))
    }
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Leaf -> Error(Nil)
    Node(value, left, right) -> {
      let steps = [Left(value, right), ..zipper.steps]
      Ok(Zipper(steps, left))
    }
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Leaf -> Error(Nil)
    Node(value, left, right) -> {
      let steps = [Right(value, left), ..zipper.steps]
      Ok(Zipper(steps, right))
    }
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper.focus {
    Leaf -> Zipper(zipper.steps, Node(value, Leaf, Leaf))
    Node(_, left, right) -> Zipper(zipper.steps, Node(value, left, right))
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Leaf -> Error(Nil)
    Node(value, _, right) -> Ok(Zipper(zipper.steps, Node(value, tree, right)))
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper.focus {
    Leaf -> Error(Nil)
    Node(value, left, _) -> Ok(Zipper(zipper.steps, Node(value, left, tree)))
  }
}
