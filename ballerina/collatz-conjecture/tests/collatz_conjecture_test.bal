import ballerina/test;

@test:Config {}
function testZeroStepsForOne() {
    test:assertEquals(collatzSteps(1), 0);
}

@test:Config {
    enable: true
}
function testDivideIfEven() {
    test:assertEquals(collatzSteps(16), 4);
}

@test:Config {
    enable: true
}
function testEvenAndOddSteps() {
    test:assertEquals(collatzSteps(12), 9);
}

@test:Config {
    enable: true
}
function testLargeNumberOfEvenAndOddSteps() {
    test:assertEquals(collatzSteps(1000000), 152);
}

@test:Config {
    enable: true
}
function errorTestZero() {
    int|error e = collatzSteps(0);
    if e is error {
        test:assertEquals(e.message().toString(), "Only positive integers are allowed");
    } else {
        test:assertFail(msg = "Expecting an error");
    }
}

@test:Config {
    enable: true
}
function errorTestNegative() {
    int|error e = collatzSteps(-15);
    if e is error {
        test:assertEquals(e.message().toString(), "Only positive integers are allowed");
    } else {
        test:assertFail(msg = "Expecting an error");
    }
}
