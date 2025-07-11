import gleam/list
import gleam/string

pub type Robot {
  Robot(direction: Direction, position: Position)
}

pub type Direction {
  North
  East
  South
  West
}

pub type Position {
  Position(x: Int, y: Int)
}

pub fn create(direction: Direction, position: Position) -> Robot {
  Robot(direction, position)
}

pub fn move(
  direction: Direction,
  position: Position,
  instructions: String,
) -> Robot {
  string.to_graphemes(instructions)
  |> list.fold(create(direction, position), move_once)
}

pub fn move_once(robot: Robot, instruction: String) {
  let Position(x, y) = robot.position
  case robot.direction, instruction {
    North, "A" -> Robot(robot.direction, Position(x, y+1))
    East, "A" -> Robot(robot.direction, Position(x+1, y))
    South, "A" -> Robot(robot.direction, Position(x, y-1))
    West, "A" -> Robot(robot.direction, Position(x-1, y))

    North, "L" -> Robot(West, robot.position)
    East, "L" -> Robot(North, robot.position)
    South, "L" -> Robot(East, robot.position)
    West, "L" -> Robot(South, robot.position)

    North, "R" -> Robot(East, robot.position)
    East, "R" -> Robot(South, robot.position)
    South, "R" -> Robot(West, robot.position)
    West, "R" -> Robot(North, robot.position)

    _, _ -> robot
  }
}
