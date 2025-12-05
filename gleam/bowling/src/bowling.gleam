import gleam/int
import gleam/list

type Frame =
  List(Int)

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

const max_frames = 10

const max_pins = 10

fn game_is_complete(game: Game) -> Bool {
  case list.length(game.frames) {
    frames_count if frames_count < max_frames -> False
    frames_count if frames_count == max_frames ->
      case game.frames {
        [[_], ..] -> False
        [[snd, fst], ..] if snd + fst == max_pins -> False
        _ -> True
      }
    frames_count if frames_count == max_frames + 1 ->
      case game.frames {
        [[_], [_], ..] -> False
        _ -> True
      }
    _ -> True
  }
}

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  case game_is_complete(game) {
    True -> Error(GameComplete)
    False -> {
      case game.frames {
        _ if knocked_pins < 0 -> Error(InvalidPinCount)
        _ if knocked_pins > max_pins -> Error(InvalidPinCount)
        [] -> {
          Ok(Game([[knocked_pins], ..game.frames]))
        }
        [[_, _], ..] -> {
          Ok(Game([[knocked_pins], ..game.frames]))
        }
        [[fst], ..] if fst == max_pins -> {
          Ok(Game([[knocked_pins], ..game.frames]))
        }
        [[fst], ..] if fst + knocked_pins > max_pins -> {
          Error(InvalidPinCount)
        }
        [[fst], ..frames] -> {
          Ok(Game([[fst, knocked_pins], ..frames]))
        }
        _ -> panic as "unreachable"
      }
    }
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  case game_is_complete(game) {
    True -> Ok(score_loop(list.reverse(game.frames), 0, 0))
    False -> Error(GameNotComplete)
  }
}

fn score_loop(frames: List(Frame), count: Int, acc: Int) -> Int {
  case frames {
    _ if count >= max_frames -> acc
    [frame] -> acc + int.sum(frame)
    [[single], ..next_frames] if single == max_pins -> {
      case next_frames {
        [[snd, fst], ..] -> {
          score_loop(next_frames, count + 1, acc + single + fst + snd)
        }
        [[fst], [snd, ..], ..] -> {
          score_loop(next_frames, count + 1, acc + single + fst + snd)
        }
        _ -> panic
      }
    }
    [[snd, fst], ..next_frames] if snd + fst == max_pins -> {
      case next_frames {
        [[next, ..], ..] -> {
          score_loop(next_frames, count + 1, acc + fst + snd + next)
        }
        _ -> panic
      }
    }
    [[snd, fst], ..next_frames] -> {
      score_loop(next_frames, count + 1, acc + fst + snd)
    }
    _ -> panic
  }
}
