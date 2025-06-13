import gleam/list

pub fn wines_of_color(wines: List(Wine), color: Color) -> List(Wine) {
  list.filter(wines, fn(it) { it.color == color })
}

pub fn wines_from_country(wines: List(Wine), country: String) -> List(Wine) {
  list.filter(wines, fn(it) { it.country == country })
}

// Please define the required labelled arguments for this function
pub fn filter(wines: List(Wine), country country: String, color color: Color) -> List(Wine) {
  wines
  |> wines_from_country(country)
  |> wines_of_color(color)
}

pub type Wine {
  Wine(name: String, year: Int, country: String, color: Color)
}

pub type Color {
  Red
  Rose
  White
}
