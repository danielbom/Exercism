import gleam/float
import gleam/int
import gleam/result

pub fn prime(number: Int) -> Result(Int, Nil) {
  case number > 0 {
    True -> Ok(prime_loop(number, 2))
    False -> Error(Nil)
  }
}

fn prime_loop(index: Int, number: Int) -> Int {
  case is_prime(number), index {
    True, 1 -> number
    True, _ -> prime_loop(index - 1, number + 1)
    False, _ -> prime_loop(index, number + 1)
  }
}

fn is_prime(number: Int) -> Bool {
  case number {
    number if number < 2 -> False
    number if number < 4 -> True
    number if number % 2 == 0 -> False
    number if number % 3 == 0 -> False
    number ->
      is_prime_loop(
        number,
        number
          |> int.to_float()
          |> float.square_root()
          |> result.unwrap(0.0)
          |> float.add(1.0)
          |> float.truncate(),
        3,
      )
  }
}

fn is_prime_loop(number: Int, max: Int, div: Int) -> Bool {
  case max > div, number % div == 0 {
    False, _ -> True
    _, True -> False
    _, False -> is_prime_loop(number, max, div + 2)
  }
}
