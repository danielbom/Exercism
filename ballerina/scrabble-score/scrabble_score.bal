type Score record {|
    readonly string letter;
    readonly int score;
|};

table<Score> key(letter) scoreTable = table [
    {letter: "A", score: 1},
    {letter: "E", score: 1},
    {letter: "I", score: 1},
    {letter: "O", score: 1},
    {letter: "U", score: 1},
    {letter: "L", score: 1},
    {letter: "N", score: 1},
    {letter: "R", score: 1},
    {letter: "S", score: 1},
    {letter: "T", score: 1},
    {letter: "D", score: 2},
    {letter: "G", score: 2},
    {letter: "B", score: 3},
    {letter: "C", score: 3},
    {letter: "M", score: 3},
    {letter: "P", score: 3},
    {letter: "F", score: 4},
    {letter: "H", score: 4},
    {letter: "V", score: 4},
    {letter: "W", score: 4},
    {letter: "Y", score: 4},
    {letter: "K", score: 5},
    {letter: "J", score: 8},
    {letter: "X", score: 8},
    {letter: "Q", score: 10},
    {letter: "Z", score: 10}
];

# Calculate the points score for a word
#
# + word - the word to check
# + return - the points score for the word
function score(string word) returns int {
    var scores = stream from var letter in word.toUpperAscii()
        select scoreTable[letter]?.score ?: 0;
    return scores
        .reduce(isolated function(int total, int score) returns int => total + score, 0);
}
