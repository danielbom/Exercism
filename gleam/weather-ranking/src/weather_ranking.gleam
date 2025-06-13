import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

fn temperature_to_celcius(temp: Temperature) -> Float {
  case temp {
    Celsius(value) -> value
    Fahrenheit(value) -> fahrenheit_to_celsius(value)
  }
}

pub fn compare_temperature(lhs: Temperature, rhs: Temperature) -> Order {
  let lhs = temperature_to_celcius(lhs)
  let rhs = temperature_to_celcius(rhs)
  float.compare(lhs, rhs)
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, fn(a, b) {
    compare_temperature(a.temperature, b.temperature)
  })
}
