import gleam/list

pub type Pizza {
  Caprese
  Formaggio
  Margherita
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_loop(0, pizza)
}

fn pizza_price_loop(acc: Int, pizza: Pizza) -> Int {
  case pizza {
    Margherita -> acc + 7
    Caprese -> acc + 9
    Formaggio -> acc + 10
    ExtraSauce(inner) -> acc + 1 |> pizza_price_loop(inner)
    ExtraToppings(inner) -> acc + 2 |> pizza_price_loop(inner)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let fee = case order {
    [_] -> 3
    [_, _] -> 2
    _ -> 0
  }
  list.fold(order, fee, pizza_price_loop)
}
