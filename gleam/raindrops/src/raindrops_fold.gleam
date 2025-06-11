import gleam/int
import gleam/list

pub fn convert(number: Int) -> String {
  [#(3, "Pling"), #(5, "Plang"), #(7, "Plong")]
  |> list.fold("", fn(sounds, pair) {
    let #(factor, sound) = pair
    case number % factor == 0 {
      True -> sounds <> sound
      False -> sounds
    }
  })
  |> fn(sounds) {
    case sounds {
      "" -> int.to_string(number)
      _ -> sounds
    }
  }
}
