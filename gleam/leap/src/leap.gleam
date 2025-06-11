pub fn is_leap_year(year: Int) -> Bool {
  // year % 4 == 0 && year % 100 != 0 || year % 400 == 0
  case year % 100 == 0 {
    True -> year % 400 == 0
    False -> year % 4 == 0
  }
}
