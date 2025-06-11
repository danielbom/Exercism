import gleam/list

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  factors
  |> list.filter(fn(it) { it > 0 })
  |> sum_loop(limit - 1, 0)
}

fn sum_loop(factors: List(Int), limit: Int, acc: Int) {
  case limit > 0 {
    True -> {
      let acc = case list.any(factors, fn(it) { limit % it == 0 }) {
        True -> acc + limit
        False -> acc
      }
      sum_loop(factors, limit - 1, acc)
    }
    False -> acc
  }
}
