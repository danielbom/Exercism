import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn proteins(rna: String) -> Result(List(String), Nil) {
  [
    #(["AUG"], "Methionine"),
    #(["UUU", "UUC"], "Phenylalanine"),
    #(["UUA", "UUG"], "Leucine"),
    #(["UCU", "UCC", "UCA", "UCG"], "Serine"),
    #(["UAU", "UAC"], "Tyrosine"),
    #(["UGU", "UGC"], "Cysteine"),
    #(["UGG"], "Tryptophan"),
    #(["UAA", "UAG", "UGA"], "STOP"),
  ]
  |> list.flat_map(fn(keys_value) {
    let #(keys, value) = keys_value
    list.map(keys, fn(key) { #(key, value) })
  })
  |> dict.from_list()
  |> proteins_loop(string.to_graphemes(rna), [])
}

fn proteins_loop(
  aminoacids: Dict(String, String),
  rna: List(String),
  result: List(String),
) -> Result(List(String), Nil) {
  case rna {
    [a, b, c, ..rest] -> {
      let codon = string.concat([a, b, c])
      case dict.get(aminoacids, codon) {
        Ok("STOP") -> proteins_loop(aminoacids, [], result)
        Ok(aminoacid) -> proteins_loop(aminoacids, rest, [aminoacid, ..result])
        Error(_) -> Error(Nil)
      }
    }
    [] -> Ok(list.reverse(result))
    _ -> Error(Nil)
  }
}
