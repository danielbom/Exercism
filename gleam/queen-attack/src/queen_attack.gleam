import gleam/int

pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  case queen.row, queen.column {
    row, _ if 0 > row -> Error(RowTooSmall)
    row, _ if row >= 8 -> Error(RowTooLarge)
    _, col if 0 > col -> Error(ColumnTooSmall)
    _, col if col >= 8 -> Error(ColumnTooLarge)
    _, _ -> Ok(Nil)
  }
}

pub fn can_attack(black_queen b: Position, white_queen w: Position) -> Bool {
  b.row == w.row
  || b.column == w.column
  || int.absolute_value(b.row - w.row) == int.absolute_value(b.column - w.column)
}
