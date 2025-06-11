import gleam/list
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
  let #(_, st) =
    list.fold(romans, #(number, sb.new()), fn(s, r) {
      case s.0 / r.0 {
        n if n > 0 -> #(s.0 - n * r.0, repeat(s.1, r.1, n))
        _ -> s
      }
    })
  sb.to_string(st)
}

fn repeat(st: StringTree, value: String, count: Int) -> StringTree {
  case count > 0 {
    True -> repeat(sb.append(st, value), value, count - 1)
    False -> st
  }
}
