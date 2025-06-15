import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  use content <- result.then(simplifile.read(path) |> result.replace_error(Nil))
  content
  |> string.trim()
  |> string.split("\n")
  |> Ok()
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path
  |> simplifile.create_file()
  |> result.replace_error(Nil)
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  path
  |> simplifile.append(email <> "\n")
  |> result.replace_error(Nil)
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  use _ <- result.then(create_log_file(log_path))
  use emails <- result.then(read_emails(emails_path))
  list.each(emails, fn(email) {
    use _ <- result.then(send_email(email))
    log_sent_email(log_path, email)
  })
  Ok(Nil)
}
