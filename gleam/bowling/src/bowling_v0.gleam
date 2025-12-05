import gleam/int
import gleam/list

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

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
        [Frame([_], _), ..] -> False
        [Frame([snd, fst], _), ..] if snd + fst == max_pins -> False
        _ -> True
      }
    frames_count if frames_count == max_frames + 1 ->
      case game.frames {
        [Frame([_], ..), Frame([_], _), ..] -> False
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
          Ok(Game([Frame([knocked_pins], []), ..game.frames]))
        }
        [Frame([_, _], _), ..] -> {
          Ok(Game([Frame([knocked_pins], []), ..game.frames]))
        }
        [Frame([fst], _), ..] if fst == max_pins -> {
          Ok(Game([Frame([knocked_pins], []), ..game.frames]))
        }
        [Frame([fst], _), ..] if fst + knocked_pins > max_pins -> {
          Error(InvalidPinCount)
        }
        [Frame([fst], _), ..frames] -> {
          Ok(Game([Frame([knocked_pins, fst], []), ..frames]))
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
    [frame] -> acc + int.sum(frame.rolls)
    [Frame([single], _), ..next_frames] if single == max_pins -> {
      case next_frames {
        [Frame([snd, fst], _), ..] -> {
          score_loop(next_frames, count + 1, acc + single + fst + snd)
        }
        [Frame([fst], _), Frame([snd], _), ..] -> {
          score_loop(next_frames, count + 1, acc + single + fst + snd)
        }
        [Frame([fst], _), Frame([_, snd], _), ..] -> {
          score_loop(next_frames, count + 1, acc + single + fst + snd)
        }
        _ -> panic
      }
    }
    [Frame([snd, fst], _), ..next_frames] if snd + fst == max_pins -> {
      case next_frames {
        [Frame([next], _), ..] -> {
          score_loop(next_frames, count + 1, acc + fst + snd + next)
        }
        [Frame([_, next], _), ..] -> {
          score_loop(next_frames, count + 1, acc + fst + snd + next)
        }
        _ -> panic
      }
    }
    [Frame([snd, fst], _), ..next_frames] -> {
      score_loop(next_frames, count + 1, acc + fst + snd)
    }
    _ -> panic
  }
}
