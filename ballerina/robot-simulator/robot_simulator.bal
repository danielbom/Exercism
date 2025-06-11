public type Position readonly & record {
    int x;
    int y;
};

public enum Direction {
    NORTH, EAST, SOUTH, WEST
}

public type Robot readonly & record {|
    Position position;
    Direction direction;
|};

public function newRobot(Position position = {x: 0, y: 0}, Direction direction = NORTH) returns Robot {
    return {position, direction};
}

public function move(Robot robot, string instructions) returns Robot {
    var {x, y} = robot.position;
    var dir = robot.direction;
    foreach var it in instructions {
        match it {
            "A" => {
                match dir {
                    NORTH => {
                        y += 1;
                    }
                    EAST => {
                        x += 1;
                    }
                    SOUTH => {
                        y -= 1;
                    }
                    WEST => {
                        x -= 1;
                    }
                }
            }
            "R" => {
                match dir {
                    NORTH => {
                        dir = EAST;
                    }
                    EAST => {
                        dir = SOUTH;
                    }
                    SOUTH => {
                        dir = WEST;
                    }
                    WEST => {
                        dir = NORTH;
                    }
                }
            }
            "L" => {
                match dir {
                    NORTH => {
                        dir = WEST;
                    }
                    EAST => {
                        dir = NORTH;
                    }
                    SOUTH => {
                        dir = EAST;
                    }
                    WEST => {
                        dir = SOUTH;
                    }
                }
            }
        }
    }
    return {position: {x, y}, direction: dir};
}
