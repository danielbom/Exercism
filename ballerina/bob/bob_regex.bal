# Returns Bob's response to someone talking to him.
#
# + input - whatever is said to Bob
# + return - Bob's response
public function hey__regex(string input) returns string {
    if isBlank(input) {
        return "Fine. Be that way!";
    }

    boolean _isQuestion = isQuestion(input);
    boolean _isYelling = isYelling(input);
    if _isYelling {
        return _isQuestion ? "Calm down, I know what I'm doing!" : "Whoa, chill out!";
    } else {
        return _isQuestion ? "Sure." : "Whatever.";
    }
}

function isBlank(string input) returns boolean {
    return re `\s*`.isFullMatch(input);
}

function isQuestion(string input) returns boolean {
    return input.matches(re `.*\?\s*$`);
}

function isYelling(string input) returns boolean {
    return re `.*[A-Z].*`.isFullMatch(input) && !re `.*[a-z].*`.isFullMatch(input);
}
