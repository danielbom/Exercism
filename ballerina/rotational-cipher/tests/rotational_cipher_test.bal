
import ballerina/test;


@test:Config {}
function testRotateABy0SameOutputAsInput() {
    test:assertEquals(rotate("a", 0), "a");
}

@test:Config {
    enable: true
}
function testRotateABy1() {
    test:assertEquals(rotate("a", 1), "b");
}

@test:Config {
    enable: true
}
function testRotateABy26SameOutputAsInput() {
    test:assertEquals(rotate("a", 26), "a");
}

@test:Config {
    enable: true
}
function testRotateMBy13() {
    test:assertEquals(rotate("m", 13), "z");
}

@test:Config {
    enable: true
}
function testRotateNBy13WithWrapAroundAlphabet() {
    test:assertEquals(rotate("n", 13), "a");
}

@test:Config {
    enable: true
}
function testRotateCapitalLetters() {
    test:assertEquals(rotate("OMG", 5), "TRL");
}

@test:Config {
    enable: true
}
function testRotateSpaces() {
    test:assertEquals(rotate("O M G", 5), "T R L");
}

@test:Config {
    enable: true
}
function testRotateNumbers() {
    test:assertEquals(rotate("Testing 1 2 3 testing", 4), "Xiwxmrk 1 2 3 xiwxmrk");
}

@test:Config {
    enable: true
}
function testRotatePunctuation() {
    test:assertEquals(rotate("Let's eat, Grandma!", 21), "Gzo'n zvo, Bmviyhv!");
}

@test:Config {
    enable: true
}
function testRotateAllLetters() {
    string text = "The quick brown fox jumps over the lazy dog.";
    int shift = 13;
    string expected = "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.";
    test:assertEquals(rotate(text, shift), expected);
}
