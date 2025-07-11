pub fn egg_count(number: Int) -> Int {
  egg_count_loop(0, number)
}

fn egg_count_loop(count: Int, number: Int) -> Int {
  case number {
    0 -> count
    n -> egg_count_loop(count + { n % 2 }, n / 2)
  }
}
