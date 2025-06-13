pub fn today(days: List(Int)) -> Int {
  case days {
    [head, ..] -> head
    [] -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [head, ..tail] -> [head + 1, ..tail]
    [] -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [head, ..tail] -> head == 0 || has_day_without_birds(tail)
    [] -> False
  }
}

pub fn total(days: List(Int)) -> Int {
  total_loop(days, 0)
}

fn total_loop(days, acc) {
  case days {
    [head, ..tail] -> total_loop(tail, acc + head)
    [] -> acc
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  busy_days_loop(days, 0)
}

fn busy_days_loop(days, acc) {
  case days {
    [head, ..tail] -> {
      let busy = case head >= 5 {
        True -> 1
        False -> 0
      }
      busy_days_loop(tail, acc + busy)
    }
    [] -> acc
  }
}
