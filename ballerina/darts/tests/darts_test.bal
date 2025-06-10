import ballerina/test;

@test:Config
function missedTarget() {
    test:assertEquals(score(-9, 9), 0);
}

@test:Config {
    enable: true
}
function onTheOuterCircle() {
    test:assertEquals(score(0, 10), 1);
}

@test:Config {
    enable: true
}
function onTheMiddleCircle() {
    test:assertEquals(score(-5, 0), 5);
}

@test:Config {
    enable: true
}
function onTheInnerCircle() {
    test:assertEquals(score(0, -1), 10);
}

@test:Config {
    enable: true
}
function exactlyOnCentre() {
    test:assertEquals(score(0, 0), 10);
}

@test:Config {
    enable: true
}
function nearTheCentre() {
    test:assertEquals(score(-0.1, -0.1), 10);
}

@test:Config {
    enable: true
}
function justWithinTheInnerCircle() {
    test:assertEquals(score(0.7, 0.7), 10);
}

@test:Config {
    enable: true
}
function justOutsideTheInnerCircle() {
    test:assertEquals(score(0.8, -0.8), 5);
}

@test:Config {
    enable: true
}
function justWithinTheMiddleCircle() {
    test:assertEquals(score(-3.5, 3.5), 5);
}

@test:Config {
    enable: true
}
function justOutsideTheMiddleCircle() {
    test:assertEquals(score(-3.6, -3.6), 1);
}

@test:Config {
    enable: true
}
function justWithinTheOuterCircle() {
    test:assertEquals(score(-7, 7), 1);
}

@test:Config {
    enable: true
}
function justOutsideTheOuterCircle() {
    test:assertEquals(score(7.1, -7.1), 0);
}

@test:Config {
    enable: true
}
function asymmetricPositionBetweenTheInnerAndMiddleCircles() {
    test:assertEquals(score(0.5, -4), 5);
}
