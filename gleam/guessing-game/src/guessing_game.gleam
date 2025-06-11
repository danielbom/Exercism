pub fn reply(guess: Int) -> String {
  case guess {
    40 -> "Too low"
    41 -> "So close"
    42 -> "Correct"
    43 -> "So close"
    _ -> {
      case guess > 43 {
        True -> "Too high"
        False -> "Too low"
      }
    }
  }
}
