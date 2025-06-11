pub type Approval {
  Maybe
  No
  Yes
}

pub type Cuisine {
  Korean
  Turkish
}

pub type Genre {
  Crime
  Horror
  Romance
  Thriller
}

pub type Activity {
  BoardGame
  Chill
  Movie(Genre)
  Restaurant(Cuisine)
  Walk(Int)
}

pub fn rate_activity(activity: Activity) -> Approval {
  case activity {
    BoardGame -> No
    Chill -> No
    Movie(Crime) -> No
    Movie(Horror) -> No
    Movie(Romance) -> Yes
    Movie(Thriller) -> No
    Restaurant(Korean) -> Yes
    Restaurant(Turkish) -> Maybe
    Walk(n) if 11 < n -> Yes
    Walk(n) if 6 < n -> Maybe
    Walk(_) -> No
  }
}
