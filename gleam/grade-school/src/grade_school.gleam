import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/order.{type Order}
import gleam/string

pub type Student {
  Student(name: String, grade: Int)
}

pub type School {
  School(students: Dict(String, Student))
}

pub fn create() -> School {
  School(dict.new())
}

pub fn roster(school: School) -> List(String) {
  school.students
  |> dict.values()
  |> list.sort(student_compare)
  |> list.map(student_name)
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  use <- bool.guard(dict.has_key(school.students, student), Error(Nil))
  Ok(School(dict.insert(school.students, student, Student(student, grade))))
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  school.students
  |> dict.values()
  |> list.filter(fn(s) { s.grade == desired_grade })
  |> list.sort(student_compare)
  |> list.map(student_name)
}

fn student_compare(a: Student, b: Student) -> Order {
  int.compare(a.grade, b.grade)
  |> order.break_tie(string.compare(a.name, b.name))
}

fn student_name(a: Student) -> String {
  a.name
}
