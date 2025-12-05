import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  rows_loop(n, [])
}

fn rows_loop(n: Int, result: List(List(Int))) -> List(List(Int)) {
  case n > 0, result {
    True, [] -> rows_loop(n - 1, [[1]])
    True, [row, ..] -> rows_loop(n - 1, [next_row(row), ..result])
    False, _ -> list.reverse(result)
  }
}

fn next_row(row: List(Int)) -> List(Int) {
  next_row_loop(row, [1])
}

fn next_row_loop(row: List(Int), result: List(Int)) -> List(Int) {
  case row {
    [fst, snd, ..rest] -> next_row_loop([snd, ..rest], [fst + snd, ..result])
    _ -> [1, ..result]
  }
}

