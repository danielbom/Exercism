import gleam/list

pub type Triplet {
  Triplet(Int, Int, Int)
}

type TripletSum {
  TripletSum(Int, Int, Int, Int)
}

fn next_triplet_sum(ts: TripletSum) -> Result(TripletSum, #()) {
  let TripletSum(sum, a, b, c) = ts
  let can_inc_a = a + 1 < sum / 3
  let can_inc_b = b + 1 < sum - a - 1
  case can_inc_b, can_inc_a {
    True, _ -> Ok(TripletSum(sum, a, b + 1, c - 1))
    _, True -> Ok(TripletSum(sum, a + 1, a + 2, sum - a - a - 3))
    _, _ -> Error(#())
  }
}

fn find_triplets_loop(ts: TripletSum, result: List(Triplet)) -> List(Triplet) {
  let TripletSum(_, a, b, c) = ts
  let next_result = case a*a + b*b == c*c {
    True -> [Triplet(a, b, c), ..result]
    False -> result
  }
  case next_triplet_sum(ts) {
    Ok(next_ts) -> find_triplets_loop(next_ts, next_result)
    Error(_) -> next_result
  }
}

fn find_triplets(sum: Int) -> List(Triplet) {
  find_triplets_loop(TripletSum(sum, 1, 2, sum - 3), [])
}

pub fn triplets_with_sum(sum: Int) -> List(Triplet) {
  find_triplets(sum) |> list.reverse()
}

