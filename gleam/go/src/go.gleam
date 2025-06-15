import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  Ok(game)
  |> result.then(rule1)
  |> result.map(rule2)
  |> result.then(rule3)
  |> result.then(rule4)
  |> result.map(fn(game) { Game(..game, player: swap_player(game.player)) })
  |> result.try_recover(fn(reason) { Ok(Game(..game, error: reason)) })
  |> result.unwrap(game)
}

fn swap_player(player: Player) -> Player {
  case player {
    Black -> White
    White -> Black
  }
}
