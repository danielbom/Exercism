import gleam/list
import gleam/string

pub fn first_letter(name: String) -> String {
  string.trim_start(name)
  |> string.slice(0, 1)
}

pub fn initial(name: String) {
  first_letter(name)
  |> string.uppercase()
  |> string.append(".")
}

pub fn initials(full_name: String) {
  string.split(full_name, " ")
  |> list.map(initial)
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  let fst = initials(full_name1)
  let snd = initials(full_name2)
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> fst <> "  +  " <> snd <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
