import ballerina/test;

@test:Config
function testPairedSquareBrackets() {
    string value = "[]";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testEmptyString() {
    string value = "";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testUnpairedBrackets() {
    string value = "[[";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testWrongOrderedBrackets() {
    string value = "}{";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testWrongClosingBracket() {
    string value = "{]";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testPairedWithWhitespace() {
    string value = "{ }";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testPartiallyPairedBrackets() {
    string value = "{[])";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testSimpleNestedBrackets() {
    string value = "{[]}";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testSeveralPairedBrackets() {
    string value = "{}[]";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testPairedAndNestedBrackets() {
    string value = "([{}({}[])])";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testUnopenedClosingBrackets() {
    string value = "{[)][]}";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testUnpairedAndNestedBrackets() {
    string value = "([{])";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testPairedAndWrongNestedBrackets() {
    string value = "[({]})";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testPairedAndWrongNestedBracketsButInnermostAreCorrect() {
    string value = "[({}])";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testPairedAndIncompleteBrackets() {
    string value = "{}[";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testTooManyClosingBrackets() {
    string value = "[]]";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testEarlyUnexpectedBrackets() {
    string value = ")()";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testEarlyMismatchedBrackets() {
    string value = "{)()";
    test:assertFalse(isPaired(value));
}

@test:Config {
    enable: true
}
function testMathExpression() {
    string value = "(((185 + 223.85) * 15) - 543)/2";
    test:assertTrue(isPaired(value));
}

@test:Config {
    enable: true
}
function testComplexLatexExpression() {
    string value = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)";
    test:assertTrue(isPaired(value));
}
