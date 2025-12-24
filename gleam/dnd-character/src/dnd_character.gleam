import gleam/float
import gleam/int
import gleam/list

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let charisma = ability()
  let constitution = ability()
  let dexterity = ability()
  let intelligence = ability()
  let strength = ability()
  let wisdom = ability()
  let hitpoints = 10 + modifier(constitution)
  Character(
    charisma: charisma,
    constitution: constitution,
    dexterity: dexterity,
    hitpoints: hitpoints,
    intelligence: intelligence,
    strength: strength,
    wisdom: wisdom,
  )
}

pub fn modifier(score: Int) -> Int {
  { { int.to_float(score) -. 10.0 } /. 2.0 }
  |> float.floor()
  |> float.truncate()
}

pub fn ability() -> Int {
  let dices = [dice(), dice(), dice(), dice()]
  let minimum = list.fold(dices, 6, int.min)
  int.sum(dices) - minimum
}

fn dice() -> Int {
  int.random(6) + 1
}
