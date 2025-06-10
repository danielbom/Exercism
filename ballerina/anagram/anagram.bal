public function anagrams(string word, string[] candidates) returns string[] {
    var wordLower = word.toLowerAscii();
    var wordCodes = wordLower.toCodePointInts().sort();
    return from var candidate in candidates
        where candidate.length() == word.length()
        let var candidateLower = candidate.toLowerAscii()
        where wordLower != candidateLower
        let var candidateCodes = candidateLower.toCodePointInts().sort()
        where wordCodes == candidateCodes
        select candidate;
}
