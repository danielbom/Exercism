import gleam/int
import gleam/list
import gleam/string

pub fn convert(number: Int) -> String {
  let sounds =
    [#(3, "Pling"), #(5, "Plang"), #(7, "Plong")]
    |> list.filter(fn(p) { number % p.0 == 0 })
    |> list.map(fn(p) { p.1 })
  case sounds {
    [] -> int.to_string(number)
    _ -> string.concat(sounds)
  }
}
