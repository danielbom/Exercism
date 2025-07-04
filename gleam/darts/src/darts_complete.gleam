import gleam/float

pub fn score(x: Float, y: Float) -> Int {
  case float.square_root(x *. x +. y *. y) {
    Ok(d) if d <=. 1.0 -> 10
    Ok(d) if d <=. 5.0 -> 5
    Ok(d) if d <=. 10.0 -> 1
    _ -> 0
  }
}
