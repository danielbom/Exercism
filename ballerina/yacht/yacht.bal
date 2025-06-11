# Determine the score of a set of dice against a Yacht category.
#
# + dice - an array of 5 integers
# + category - the name of a combination of dice
# + return - the score
public function score(int[] dice, string category) returns int {
    match category {
        "ones" => {
            return dice.filter(it => it == 1).length() * 1;
        }
        "twos" => {
            return dice.filter(it => it == 2).length() * 2;
        }
        "threes" => {
            return dice.filter(it => it == 3).length() * 3;
        }
        "fours" => {
            return dice.filter(it => it == 4).length() * 4;
        }
        "fives" => {
            return dice.filter(it => it == 5).length() * 5;
        }
        "sixes" => {
            return dice.filter(it => it == 6).length() * 6;
        }
        "full house" if diceGroupPattern(dice, [2, 3]) => {
            return dice.reduce(function(int a, int b) returns int => a + b, 0);
        }
        "four of a kind" => {
            var grouped = groupDice(dice);
            var values = grouped.entries().toArray().'map(it => [checkpanic int:fromString(it[0]), it[1]]).sort("descending", (a) => a[1]);
            if values[0][1] >= 4 {
                return values[0][0] * 4;
            }
        }
        "little straight" if dicePattern(dice, [1, 2, 3, 4, 5]) => {
            return 30;
        }
        "big straight" if dicePattern(dice, [2, 3, 4, 5, 6]) => {
            return 30;
        }
        "choice" => {
            return dice.reduce(function(int a, int b) returns int => a + b, 0);
        }
        "yacht" if diceGroupPattern(dice, [5]) => {
            return 50;
        }
    }
    return 0;
}

function dicePattern(int[] dice, int[] pattern) returns boolean {
    var values = dice.sort();
    return values == pattern;
}

function diceGroupPattern(int[] dice, int[] pattern) returns boolean {
    var grouped = groupDice(dice);
    var values = grouped.toArray().sort();
    return values == pattern;
}

function groupDice(int[] dice) returns map<int> {
    map<int> result = {};
    foreach var it in dice {
        var itKey = it.toString();
        if result.hasKey(itKey) {
            result[itKey] = result.get(itKey) + 1;
        } else {
            result[itKey] = 1;
        }
    }
    return result;
}
