import gleam/list
import gleam/result

pub type Resistance {
  Resistance(unit: String, value: Int)
}

pub fn label(colors: List(String)) -> Result(Resistance, Nil) {
  use values <- result.then(colors |> list.try_map(value))
  case values {
    [a, b, c, ..] -> Ok(simplify(0, power10(a * 10 + b, c)))
    _ -> Error(Nil)
  }
}

fn simplify(level: Int, value: Int) -> Resistance {
  case level == 3 || value / 1000 == 0 || value % 1000 != 0 {
    True -> Resistance(unit(level), value)
    False -> simplify(level + 1, value / 1000)
  }
}

fn power10(x, count) {
  case count > 0 {
    True -> power10(x * 10, count - 1)
    False -> x
  }
}

fn value(color: String) -> Result(Int, Nil) {
  case color {
    "black" -> Ok(0)
    "brown" -> Ok(1)
    "red" -> Ok(2)
    "orange" -> Ok(3)
    "yellow" -> Ok(4)
    "green" -> Ok(5)
    "blue" -> Ok(6)
    "violet" -> Ok(7)
    "grey" -> Ok(8)
    "white" -> Ok(9)
    _ -> Error(Nil)
  }
}

fn unit(level: Int) {
  case level {
    0 -> "ohms"
    1 -> "kiloohms"
    2 -> "megaohms"
    3 -> "gigaohms"
    _ -> ""
  }
}
