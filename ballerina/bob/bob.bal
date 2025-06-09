# Returns Bob's response to someone talking to him.
#
# + input - whatever is said to Bob
# + return - Bob's response
public function hey(string input) returns string {
    string cleanInput = input.trim();
    if cleanInput.length() == 0 {
        return "Fine. Be that way!";
    }
    if isShouting(cleanInput) {
        if endsWithChar(cleanInput, "?") {
            return "Calm down, I know what I'm doing!";
        } else {
            return "Whoa, chill out!";
        }
    }
    if endsWithChar(cleanInput, "?") {
        return "Sure.";
    }
    return "Whatever.";
}

function isShouting(string input) returns boolean {
    boolean result = false;
    int a = string:toCodePointInt("a");
    int z = string:toCodePointInt("z");
    int A = string:toCodePointInt("A");
    int Z = string:toCodePointInt("Z");
    foreach var item in input {
        int code = string:toCodePointInt(item);
        if a <= code && code <= z {
            return false;
        }
        if A <= code && code <= Z {
            result = true;
        }
    }
    return result;
}

function endsWithChar(string input, string ch) returns boolean {
    if input.length() == 0 {
        return false;
    } else {
        return input[input.length() - 1] == ch;
    }
}
