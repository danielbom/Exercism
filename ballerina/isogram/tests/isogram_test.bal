import ballerina/test;

@test:Config
function EmptyString() {
    test:assertTrue(isIsogram(""));
}

@test:Config {
    enable: true
}
function IsogramWithOnlyLowerCaseCharacters() {
    test:assertTrue(isIsogram("isogram"));
}

@test:Config {
    enable: true
}
function WordWithOneDuplicatedCharacter() {
    test:assertFalse(isIsogram("eleven"));
}

@test:Config {
    enable: true
}
function WordWithOneDuplicatedCharacterFromTheEndOfTheAlphabet() {
    test:assertFalse(isIsogram("zzyzx"));
}

@test:Config {
    enable: true
}
function LongestReportedEnglishIsogram() {
    test:assertTrue(isIsogram("subdermatoglyphic"));
}

@test:Config {
    enable: true
}
function WordWithDuplicatedCharacterInMixedCase() {
    test:assertFalse(isIsogram("Alphabet"));
}

@test:Config {
    enable: true
}
function WordWithDuplicatedCharacterInMixedCaseLowercaseFirst() {
    test:assertFalse(isIsogram("alphAbet"));
}

@test:Config {
    enable: true
}
function HypotheticalIsogrammicWordWithHyphen() {
    test:assertTrue(isIsogram("thumbscrew-japingly"));
}

@test:Config {
    enable: true
}
function HypotheticalWordWithDuplicatedCharacterFollowingHyphen() {
    test:assertFalse(isIsogram("thumbscrew-jappingly"));
}

@test:Config {
    enable: true
}
function IsogramWithDuplicatedHyphen() {
    test:assertTrue(isIsogram("six-year-old"));
}

@test:Config {
    enable: true
}
function MadeUpNameThatIsAnIsogram() {
    test:assertTrue(isIsogram("Emily Jung Schwartzkopf"));
}

@test:Config {
    enable: true
}
function DuplicatedCharacterInTheMiddle() {
    test:assertFalse(isIsogram("accentor"));
}

@test:Config {
    enable: true
}
function SameFirstAndLastCharacters() {
    test:assertFalse(isIsogram("angola"));
}

@test:Config {
    enable: true
}
function WordWithDuplicatedCharacterAndWithTwoHyphens() {
    test:assertFalse(isIsogram("up-to-date"));
}
