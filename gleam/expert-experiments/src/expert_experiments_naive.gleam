pub fn with_retry(experiment: fn() -> Result(t, e)) -> Result(t, e) {
  case experiment() {
    Ok(value) -> Ok(value)
    Error(_) -> experiment()
  }
}

pub fn record_timing(
  time_logger: fn() -> Nil,
  experiment: fn() -> Result(t, e),
) -> Result(t, e) {
  time_logger()
  let value = experiment()
  time_logger()
  value
}

pub fn run_experiment(
  name: String,
  setup: fn() -> Result(t, e),
  action: fn(t) -> Result(u, e),
  record: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  case setup() {
    Ok(x) ->
      case action(x) {
        Ok(y) -> {
          case record(x, y) {
            Ok(z) -> {
              Ok(#(name, z))
            }
            Error(e) -> Error(e)
          }
        }
        Error(e) -> Error(e)
      }
    Error(e) -> Error(e)
  }
}
