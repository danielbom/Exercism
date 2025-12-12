import gleam/int
import gleam/string

pub type Clock {
  Clock(minutes: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  Clock(normalize(hour * 60 + minute))
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes + minutes))
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  Clock(normalize(clock.minutes - minutes))
}

pub fn display(clock: Clock) -> String {
  let hour = clock |> hour |> int.to_string |> string.pad_start(2, "0")
  let minute = clock |> minute |> int.to_string |> string.pad_start(2, "0")
  hour <> ":" <> minute
}

pub fn minute(clock: Clock) -> Int {
  clock.minutes % 60
}

pub fn hour(clock: Clock) -> Int {
  { clock.minutes / 60 } % 24
}

fn normalize(minutes: Int) -> Int {
  let day = 24 * 60
  case minutes > day, minutes <= 0 {
    True, _ -> minutes % day
    _, True -> normalize(day + minutes)
    _, _ -> minutes
  }
}
