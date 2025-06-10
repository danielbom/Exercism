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
    var result = "";
    foreach var ch in text {
        int code = ch.toCodePointInt();
        if a <= code && code <= z {
            code = ((code - a + shift) % 26) + a;
        } else if A <= code && code <= Z {
            code = ((code - A + shift) % 26) + A;
        }
        result += checkpanic string:fromCodePointInt(code);
    }
    return result;
}

int a = string:toCodePointInt("a");
int z = string:toCodePointInt("z");
int A = string:toCodePointInt("A");
int Z = string:toCodePointInt("Z");