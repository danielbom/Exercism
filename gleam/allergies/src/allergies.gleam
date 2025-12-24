import gleam/int
import gleam/list

pub type Allergen {
  Eggs
  Peanuts
  Shellfish
  Strawberries
  Tomatoes
  Chocolate
  Pollen
  Cats
}

const allergens = [
  #(Eggs, 0),
  #(Peanuts, 1),
  #(Shellfish, 2),
  #(Strawberries, 3),
  #(Tomatoes, 4),
  #(Chocolate, 5),
  #(Pollen, 6),
  #(Cats, 7),
]

pub fn allergic_to(allergen: Allergen, score: Int) -> Bool {
  let assert Ok(value) = list.key_find(allergens, allergen)
  let value = int.bitwise_shift_left(1, value)
  int.bitwise_and(score, value) > 0
}

pub fn list(score: Int) -> List(Allergen) {
  allergens
  |> list.flat_map(fn(allergen) {
    case allergic_to(allergen.0, score) {
      True -> [allergen.0]
      False -> []
    }
  })
}
