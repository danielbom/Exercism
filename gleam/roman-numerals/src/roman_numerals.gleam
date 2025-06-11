import gleam/string_tree.{type StringTree} as sb

const romans = [
  #(1000, "M"),
  #(900, "CM"),
  #(500, "D"),
  #(400, "CD"),
  #(100, "C"),
  #(90, "XC"),
  #(50, "L"),
  #(40, "XL"),
  #(10, "X"),
  #(9, "IX"),
  #(5, "V"),
  #(4, "IV"),
  #(1, "I"),
]

pub fn convert(number: Int) -> String {
  convert_loop(romans, number, sb.new())
}

fn convert_loop(rs: List(#(Int, String)), x: Int, st: StringTree) {
  case rs {
    [] -> sb.to_string(st)
    [r, ..rs] -> {
      let n = x / r.0
      convert_loop(rs, x - n * r.0, repeat(st, r.1, n))
    }
  }
}

fn repeat(st: StringTree, value: String, count: Int) -> StringTree {
  case count > 0 {
    True -> repeat(sb.append(st, value), value, count - 1)
    False -> st
  }
}
