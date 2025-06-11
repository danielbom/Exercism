pub fn expected_minutes_in_oven() -> Int {
  40
}

pub fn remaining_minutes_in_oven(actual_minutes: Int) -> Int {
  expected_minutes_in_oven() - actual_minutes
}

pub fn preparation_time_in_minutes(layers_count: Int) -> Int {
  2 * layers_count
}

pub fn total_time_in_minutes(layers_count: Int, actual_minutes: Int) {
  actual_minutes + preparation_time_in_minutes(layers_count)
}

pub fn alarm() -> String {
  "Ding!"
}
