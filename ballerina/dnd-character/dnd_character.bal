import ballerina/random;

class DndCharacter {
    int strength;
    int dexterity;
    int constitution;
    int intelligence;
    int wisdom;
    int charisma;
    int hitpoints;
    
    public function init() {
        self.strength = ability();
        self.dexterity = ability();
        self.constitution = ability();
        self.intelligence = ability();
        self.wisdom = ability();
        self.charisma = ability();
        self.hitpoints = 10 + modifier(self.constitution);
    }

    public function getStrength() returns int => self.strength;

    public function getDexterity() returns int => self.dexterity;

    public function getConstitution() returns int => self.constitution;

    public function getIntelligence() returns int => self.intelligence;

    public function getWisdom() returns int => self.wisdom;

    public function getCharisma() returns int => self.charisma;

    public function getHitpoints() returns int => self.hitpoints;
}

public function ability() returns int {
    int min = 6;
    int sum = 0;
    foreach var _ in 0 ..< 3 {
        var x = checkpanic random:createIntInRange(1, 6);
        min = x.min(min);
        sum += x;
    }
    return sum - min;
}

public function modifier(int score) returns int {
    return (score - 2) / 2 - 4;
}
