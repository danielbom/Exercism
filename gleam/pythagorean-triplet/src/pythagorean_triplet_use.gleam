import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

fn find_triplets(sum: Int) -> List(Triplet) {
  use a <- list.flat_map(list.range(1, sum / 3))
  use b <- list.filter_map(list.range(a + 1, sum - a - 1))
  let c = sum - a - b
  case a*a + b*b == c*c {
    True -> Ok(Triplet(a, b, c))
    False -> Error(#())
  }
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  find_triplets(sum)
}

