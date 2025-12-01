import gleam/bool
import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

fn is_pythagorean(a: Int, b: Int, c: Int) -> Bool {
  a*a + b*b == c*c
}

fn find_triplets_loop(a: Int, b: Int, sum: Int, result: List(Triplet)) -> List(Triplet) {
  let c = sum - a - b
  use <- bool.guard(a >= sum, result)
  use <- bool.lazy_guard(a + b >= sum, fn() { find_triplets_loop(a + 1, a + 2, sum, result) })
  let next_result = case c > b && is_pythagorean(a, b, c) {
    True -> [Triplet(a, b, c), ..result]
    False -> result
  }
  find_triplets_loop(a, b + 1, sum, next_result)
}

fn find_triplets(sum: Int) -> List(Triplet) {
  find_triplets_loop(1, 2, sum, [])
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  find_triplets(sum) |> list.reverse()
}

