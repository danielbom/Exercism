import gleam/list
import gleam/string

const verses = [
  #("This is", " the horse and the hound and the horn"),
  #("that belonged to", " the farmer sowing his corn"),
  #("that kept", " the rooster that crowed in the morn"),
  #("that woke", " the priest all shaven and shorn"),
  #("that married", " the man all tattered and torn"),
  #("that kissed", " the maiden all forlorn"),
  #("that milked", " the cow with the crumpled horn"),
  #("that tossed", " the dog"),
  #("that worried", " the cat"),
  #("that killed", " the rat"),
  #("that ate", " the malt"),
  #("that lay in", " the house that Jack built."),
]

pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  list.range(start_verse, end_verse)
  |> list.map(recite_verse)
  |> string.join("\n")
}

fn recite_verse(ix: Int) -> String {
  verses
  |> list.reverse()
  |> list.take(ix)
  |> list.index_map(fn(verse, i) {
    let #(continue, part) = verse
    case i == ix - 1 {
      True -> "This is" <> part
      False -> continue <> part
    }
  })
  |> list.reverse()
  |> string.join(" ")
}

