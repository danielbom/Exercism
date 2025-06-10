public function isPangram(string sentence) returns boolean {
    var lettersMap = (map from var ch in sentence.toLowerAscii()
            where ch.matches(re `[a-z]`)
            select [ch, ()]) ;
    return lettersMap.keys().length() == 26;
}
