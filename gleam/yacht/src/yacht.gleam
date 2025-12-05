import gleam/int
import gleam/list

pub type Category {
  Ones
  Twos
  Threes
  Fours
  Fives
  Sixes
  FullHouse
  FourOfAKind
  LittleStraight
  BigStraight
  Choice
  Yacht
}

pub fn score(category: Category, dice: List(Int)) -> Int {
  case category {
    Ones -> count(dice, 1) * 1
    Twos -> count(dice, 2) * 2
    Threes -> count(dice, 3) * 3
    Fours -> count(dice, 4) * 4
    Fives -> count(dice, 5) * 5
    Sixes -> count(dice, 6) * 6
    FullHouse ->
      case count_dices(dice) {
        [#(x, 3), #(y, 2)] -> x * 3 + y * 2
        [#(y, 2), #(x, 3)] -> x * 3 + y * 2
        _ -> 0
      }
    FourOfAKind ->
      case count_dices(dice) {
        [#(x, 5)] -> x * 4
        [#(x, 4), _] -> x * 4
        [_, #(x, 4)] -> x * 4
        _ -> 0
      }
    LittleStraight ->
      case count_dices(dice) {
        [#(1, 1), #(2, 1), #(3, 1), #(4, 1), #(5, 1)] -> 30
        _ -> 0
      }
    BigStraight ->
      case count_dices(dice) {
        [#(2, 1), #(3, 1), #(4, 1), #(5, 1), #(6, 1)] -> 30
        _ -> 0
      }
    Choice -> int.sum(dice)
    Yacht -> 
      case count_dices(dice) {
        [#(_, 5)] -> 50
        _ -> 0
      }
  }
}

fn count_dices(xs: List(Int)) -> List(#(Int, Int)) {
  list.range(1, 6)
  |> list.flat_map(fn(dice) {
    case count(xs, dice) {
      0 -> []
      count -> [#(dice, count)]
    }
  })
}

fn count(xs: List(Int), y: Int) -> Int {
  list.count(xs, fn(x) { x == y })
}
