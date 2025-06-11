import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[INFO]:" <> rest -> string.trim(rest)
    "[ERROR]:" <> rest -> string.trim(rest)
    "[WARNING]:" <> rest -> string.trim(rest)
    _ -> log_line
  }
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]:" <> _ -> "info"
    "[ERROR]:" <> _ -> "error"
    "[WARNING]:" <> _ -> "warning"
    _ -> log_line
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
