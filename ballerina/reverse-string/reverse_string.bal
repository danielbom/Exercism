public function reverse(string str) returns string {
    return checkpanic string:fromCodePointInts(str.toCodePointInts().reverse());
}
