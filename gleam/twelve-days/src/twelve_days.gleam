pub fn verse(number: Int) -> String {
  let begin =
    "On the "
    <> ordinal(number)
    <> " day of Christmas my true love gave to me: "
  range_reversed(number, 1, begin, fn(result, current) {
    case current == number, current == 1 {
      True, _ -> result <> part(current)
      _, True -> result <> ", and " <> part(current)
      _, False -> result <> ", " <> part(current)
    }
  })
}

pub fn lyrics(from starting_verse: Int, to ending_verse: Int) -> String {
  range(starting_verse, ending_verse, "", fn(result, number) {
    case result {
      "" -> verse(number)
      _ -> result <> "\n" <> verse(number)
    }
  })
}

fn ordinal(number: Int) -> String {
  case number {
    1 -> "first"
    2 -> "second"
    3 -> "third"
    4 -> "fourth"
    5 -> "fifth"
    6 -> "sixth"
    7 -> "seventh"
    8 -> "eighth"
    9 -> "ninth"
    10 -> "tenth"
    11 -> "eleventh"
    12 -> "twelfth"
    _ -> ""
  }
}

fn part(number: Int) -> String {
  case number {
    1 -> "a Partridge in a Pear Tree."
    2 -> "two Turtle Doves"
    3 -> "three French Hens"
    4 -> "four Calling Birds"
    5 -> "five Gold Rings"
    6 -> "six Geese-a-Laying"
    7 -> "seven Swans-a-Swimming"
    8 -> "eight Maids-a-Milking"
    9 -> "nine Ladies Dancing"
    10 -> "ten Lords-a-Leaping"
    11 -> "eleven Pipers Piping"
    12 -> "twelve Drummers Drumming"
    _ -> ""
  }
}

fn range(start: Int, end: Int, result: a, next: fn(a, Int) -> a) -> a {
  case start <= end {
    True -> range(start + 1, end, next(result, start), next)
    False -> result
  }
}

fn range_reversed(end: Int, start: Int, result: a, next: fn(a, Int) -> a) -> a {
  case end >= start {
    True -> range_reversed(end - 1, start, next(result, end), next)
    False -> result
  }
}
