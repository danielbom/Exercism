import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

fn find_triplets(sum: Int) -> List(Triplet) {
  list.range(1, sum - 1)
  |> list.flat_map(fn(a) {
    list.range(a + 1, sum - a - 1)
    |> list.filter_map(fn(b) {
      let c = sum - a - b
      case a*a + b*b == c*c {
        True -> Ok(Triplet(a, b, c))
        False -> Error(#())
      }
    })
  })
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  find_triplets(sum)
}

