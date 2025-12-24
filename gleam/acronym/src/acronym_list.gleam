import gleam/list
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  let #(result, _) =
    phrase
    |> string.to_graphemes()
    |> list.fold(#("", True), fn(state, ch) {
      let #(result, pick) = state
      case pick, ch {
        _, "_" -> #(result, True)
        _, "-" -> #(result, True)
        _, " " -> #(result, True)
        True, ch -> #(result <> string.uppercase(ch), False)
        False, _ -> #(result, False)
      }
    })
  result
}
