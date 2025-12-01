import gleam/list
import gleam/int
import gleam/float

pub fn lowest_price(books: List(Int)) -> Float {
  let assert [amo1, amo2, amo3, amo4, amo5] =
    [1, 2, 3, 4, 5]
    |> list.map(fn(n) { list.count(books, fn(b) { n == b }) })
    |> list.sort(int.compare)
    |> list.reverse
    |> list.map(int.to_float)
  
  { amo1 -. amo2 } *. 800. +.
  { amo2 -. amo3 } *. 1520. +.
  { amo3 -. amo4 } *. 2160. +.
  { amo4 -. amo5 } *. 2560. +.
  amo5             *. 3000. -. 
  float.min(amo5, amo3 -. amo4) *. 40.
}