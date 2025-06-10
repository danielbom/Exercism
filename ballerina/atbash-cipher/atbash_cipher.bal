public function encode(string phrase) returns string {
    return intersperse(" ", 5, decode(phrase));
}

public function decode(string phrase) returns string {
    return from var ch in phrase
        select rotateChar(ch);
}

function intersperse(string fill, int steps, string text) returns string {
    var result = "";
    foreach int i in 0..<text.length() {
        // intersperse groups of 5
        if i > 0 && i % steps == 0 {
            result += fill;
        }
        result += text[i];
    }
    return result;
}

public function rotateChar(string ch) returns string {
    var code = ch[0].toCodePointInt();
    if _a <= code && code <= _z {
        code = (26 - (code - _a + 1)) + _a;
    } else if _A <= code && code <= _Z {
        code = (26 - (code - _A + 1)) + _a;
    } else if _0 <= code && code <= _9 {
        return ch;
    } else {
        // remove
        return "";
    }
    return checkpanic string:fromCodePointInt(code);
}

int _a = string:toCodePointInt("a");
int _z = string:toCodePointInt("z");
int _A = string:toCodePointInt("A");
int _Z = string:toCodePointInt("Z");
int _0 = string:toCodePointInt("0");
int _9 = string:toCodePointInt("9");
