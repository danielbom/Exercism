public function isIsogram(string sentence) returns boolean {
    map<()> seen = {};
    foreach var ch in sentence.toLowerAscii() {
        if isLower(ch) {
            if seen.hasKey(ch) {
                return false;
            }
            seen[ch] = ();
        }
    }
    return true;
}

int a = string:toCodePointInt("a");
int z = string:toCodePointInt("z");

function isLower(string:Char ch) returns boolean {
    int code = string:toCodePointInt(ch);
    return a <= code && code <= z;
}
