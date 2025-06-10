class Allergies {
    int score;
    string[] allergies;

    function init(int score) {
        self.score = score;
        self.allergies = from var [allergy, code] in allergies.entries()
            where (score & code) > 0
            select allergy;
    }

    function allergicTo(string candidate) returns boolean {
        var code = allergies[candidate] ?: 0;
        return (self.score & code) > 0;
    }

    function list() returns string[] {
        return self.allergies;
    }
}

map<int> allergies = {
    "eggs": 1,
    "peanuts": 2,
    "shellfish": 4,
    "strawberries": 8,
    "tomatoes": 16,
    "chocolate": 32,
    "pollen": 64,
    "cats": 128
};

