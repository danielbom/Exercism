import ballerina/test;

@test:Config
function testEmptyRNASequence() {
    string expected = toRna("");
    test:assertEquals(expected, "");
}

@test:Config {
    enable: true
}
function testRNAComplementOfCytosineIsGuanine() {
    string expected = toRna("C");
    test:assertEquals(expected, "G");
}

@test:Config {
    enable: true
}
function testRNAComplementOfGuanineIsCytosine() {
    string expected = toRna("G");
    test:assertEquals(expected, "C");
}

@test:Config {
    enable: true
}
function testRNAComplementOfThymineIsAdenine() {
    string expected = toRna("T");
    test:assertEquals(expected, "A");
}

@test:Config {
    enable: true
}
function testRNAComplementOfAdenineIsUracil() {
    string expected = toRna("A");
    test:assertEquals(expected, "U");
}

@test:Config {
    enable: true
}
function testRNAComplement() {
    string expected = toRna("ACGTGGTCTTAA");
    test:assertEquals(expected, "UGCACCAGAAUU");
}
