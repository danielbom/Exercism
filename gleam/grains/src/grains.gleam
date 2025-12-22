import gleam/int

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case 0 < square && square <= 64 {
    True -> Ok(pow2(square))
    False -> Error(InvalidSquare)
  }
}

pub fn total() -> Int {
  pow2(65) - 1
}

fn pow2(square: Int) -> Int {
  int.bitwise_shift_left(1, square - 1)
}
