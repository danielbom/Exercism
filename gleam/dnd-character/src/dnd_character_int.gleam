import gleam/int

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
  // result: [-4..4]
  // score: [2..18]
  //  - 2 : [0..16]
  //  / 2 : [0..8]
  //  - 4 : [-4..4]
  { { score - 2 } / 2 } - 4
}

pub fn ability() -> Int {
  // result: [3..18]
  // random: [0..16)
  //   + 3 : [3..19) 
  3 + int.random(16)
}
