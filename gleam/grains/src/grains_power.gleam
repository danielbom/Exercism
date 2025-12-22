import gleam/float
import gleam/int

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case 0 < square && square <= 64 {
    True -> Ok(square_unchecked(square))
    False -> Error(InvalidSquare)
  }
}

pub fn total() -> Int {
  square_unchecked(65) - 1
}

fn square_unchecked(square: Int) -> Int {
  case int.power(2, int.to_float(square - 1)) {
    Ok(result) -> float.truncate(result)
    Error(_) -> 0
  }
}
