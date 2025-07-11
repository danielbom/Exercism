import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let index =
    list.index_fold(students, -1, fn(acc, curr, ix) {
      case curr == student {
        True -> ix
        False -> acc
      }
    })
  diagram
  |> string.split("\n")
  |> list.flat_map(fn(line) {
    string.to_graphemes(line)
    |> list.map(plant_from_string)
    |> list.sized_chunk(2)
    |> list.index_fold([], fn(acc, curr, ix) {
      case ix == index {
        True -> curr
        False -> acc
      }
    })
  })
}

fn plant_from_string(text: String) -> Plant {
  case text {
    "R" -> Radishes
    "C" -> Clover
    "V" -> Violets
    "G" -> Grass
    _ -> panic as "unknown plant"
  }
}

const students = [
  Alice,
  Bob,
  Charlie,
  David,
  Eve,
  Fred,
  Ginny,
  Harriet,
  Ileana,
  Joseph,
  Kincaid,
  Larry,
]
