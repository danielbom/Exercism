pub fn new_list() -> List(String) {
  []
}

pub fn existing_list() -> List(String) {
  ["Gleam", "Go", "TypeScript"]
}

fn fold(languages: List(b), initial: a, func: fn(a, b) -> a) -> a {
  case languages {
    [] -> initial
    [head, ..tail] -> fold(tail, func(initial, head), func)
  }
}

pub fn add_language(languages: List(String), language: String) -> List(String) {
  [language, ..languages]
}

pub fn count_languages(languages: List(String)) -> Int {
  fold(languages, 0, fn(acc, _) { acc + 1 })
}

pub fn reverse_list(languages: List(String)) -> List(String) {
  fold(languages, [], add_language)
}

pub fn exciting_list(languages: List(String)) -> Bool {
  case languages {
    [fst, ..] if fst == "Gleam" -> True
    [_, snd] if snd == "Gleam" -> True
    [_, snd, _] if snd == "Gleam" -> True
    _ -> False
  }
}
