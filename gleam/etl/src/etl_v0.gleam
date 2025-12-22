import gleam/dict.{type Dict}
import gleam/string
import gleam/list

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  dict.fold(legacy, dict.new(), fn(result, points, letters) {
    list.fold(letters, result, fn(result, letter) {
      dict.insert(result, string.lowercase(letter), points)
    })
  })
}
