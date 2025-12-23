import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  dna
  |> string.to_graphemes()
  |> list.try_fold(
    dict.from_list([#("A", 0), #("C", 0), #("G", 0), #("T", 0)]),
    fn(counter, n) {
      case dict.get(counter, n) {
        Ok(count) -> Ok(dict.insert(counter, n, count + 1))
        Error(_) -> Error(Nil)
      }
    },
  )
}
