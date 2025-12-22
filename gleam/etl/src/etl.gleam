import gleam/dict.{type Dict}
import gleam/string
import gleam/list

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  use result, points, letters <- dict.fold(legacy, dict.new())
  use result, letter <- list.fold(letters, result)
  dict.insert(result, string.lowercase(letter), points)
}
