[int, string][] romans = [
    [1000, "M"],
    [900, "CM"],
    [500, "D"],
    [400, "CD"],
    [100, "C"],
    [90, "XC"],
    [50, "L"],
    [40, "XL"],
    [10, "X"],
    [9, "IX"],
    [5, "V"],
    [4, "IV"],
    [1, "I"]
];

# Convert an integer to a Roman number.
#
# + number - the integer to convert
# + return - the Roman number as a string
function roman(int number) returns string {
    return "".'join(...romanSymbols(number));
}

function romanSymbols(int number) returns string[] {
    int value = number;
    string[] results = [];
    foreach var [bound, letter] in romans {
        while value >= bound {
            results.push(letter);
            value -= bound;
        }
    }
    return results;
}
