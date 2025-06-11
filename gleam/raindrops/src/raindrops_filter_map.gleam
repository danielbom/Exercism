import gleam/int
import gleam/list
import gleam/string

pub fn convert(number: Int) -> String {
  let sounds =
    [#(3, "Pling"), #(5, "Plang"), #(7, "Plong")]
    |> list.filter_map(fn(pair) {
      let #(factor, sound) = pair
      case number % factor == 0 {
        True -> Ok(sound)
        False -> Error(Nil)
      }
    })
  case sounds {
    [] -> int.to_string(number)
    _ -> string.concat(sounds)
  }
}
