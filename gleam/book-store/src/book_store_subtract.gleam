import gleam/dict
import gleam/float
import gleam/int
import gleam/list
import gleam/order

const book_price = 800.0

const max = 800_000_000.0

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> list.group(fn(it) { it })
  |> dict.values()
  |> list.map(list.length)
  |> list.sort(order.reverse(int.compare))
  |> lowerest_price_loop(0.0)
}

fn lowerest_price_loop(counts: List(Int), acc: Float) -> Float {
  let counts = counts |> list.filter(fn(it) { it > 0 })
  [
    case counts {
      [a, b, c, d, x, ..tail] ->
        [a - x, b - x, c - x, d - x, ..tail]
        |> lowerest_price_loop(price_acc(acc, x, 5.0, 0.75))
      _ -> max
    },
    case counts {
      [a, b, c, x, ..tail] ->
        [a - x, b - x, c - x, ..tail]
        |> lowerest_price_loop(price_acc(acc, x, 4.0, 0.8))
      _ -> max
    },
    case counts {
      [a, b, x, ..tail] ->
        [a - x, b - x, ..tail]
        |> lowerest_price_loop(price_acc(acc, x, 3.0, 0.9))
      _ -> max
    },
    case counts {
      [a, x, ..tail] ->
        [a - x, ..tail]
        |> lowerest_price_loop(price_acc(acc, x, 2.0, 0.95))
      _ -> max
    },
    case counts {
      [x, ..tail] ->
        tail
        |> lowerest_price_loop(price_acc(acc, x, 1.0, 1.0))
      _ -> max
    },
    case counts {
      [] -> acc
      _ -> max
    },
  ]
  |> list.fold(max, float.min)
}

fn price_acc(acc, x, count, discount) {
  acc +. { int.to_float(x) *. book_price *. count *. discount }
}
