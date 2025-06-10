# Encodes the input text using the rotational cipher technique
#
# + text - the text to encode
# + shiftKey - the number of positions to shift each alphabetic character
# + return - the encoded text
function rotate(string text, int shiftKey) returns string {
    int shift = shiftKey % 26;
    if shift == 0 {
        return text;
    }
    return from var ch in text
        select rotateChar(ch, shift);
}

function rotateChar(string ch, int shift) returns string {
    int code = ch[0].toCodePointInt();
    if a <= code && code <= z {
        code = ((code - a + shift) % 26) + a;
    } else if A <= code && code <= Z {
        code = ((code - A + shift) % 26) + A;
    }
    return checkpanic string:fromCodePointInt(code);
}

int a = string:toCodePointInt("a");
int z = string:toCodePointInt("z");
int A = string:toCodePointInt("A");
int Z = string:toCodePointInt("Z");
