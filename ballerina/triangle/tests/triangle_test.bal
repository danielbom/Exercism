import ballerina/test;


@test:Config {}
function testEquilateralTriangleAllSidesAreEqual() {
    int[] sides = [2, 2, 2];
    test:assertTrue(kind(sides, EQUILATERAL));
}

@test:Config {
    enable: true
}
function testEquilateralTriangleAnySideIsUnequal() {
    int[] sides = [2, 3, 2];
    test:assertFalse(kind(sides, EQUILATERAL));
}

@test:Config {
    enable: true
}
function testEquilateralTriangleNoSidesAreEqual() {
    int[] sides = [5, 4, 6];
    test:assertFalse(kind(sides, EQUILATERAL));
}

@test:Config {
    enable: true
}
function testEquilateralTriangleAllZeroSidesIsNotATriangle() {
    int[] sides = [0, 0, 0];
    test:assertFalse(kind(sides, EQUILATERAL));
}

@test:Config {
    enable: true
}
function testEquilateralTriangleSidesMayBeFloats() {
    float[] sides = [0.5, 0.5, 0.5];
    test:assertTrue(kind(sides, EQUILATERAL));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleLastTwoSidesAreEqual() {
    int[] sides = [3, 4, 4];
    test:assertTrue(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleFirstTwoSidesAreEqual() {
    int[] sides = [4, 4, 3];
    test:assertTrue(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleFirstAndLastSidesAreEqual() {
    int[] sides = [4, 3, 4];
    test:assertTrue(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleEquilateralTrianglesAreAlsoIsosceles() {
    int[] sides = [4, 4, 4];
    test:assertTrue(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleNoSidesAreEqual() {
    int[] sides = [2, 3, 4];
    test:assertFalse(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleFirstTriangleInequalityViolation() {
    int[] sides = [1, 1, 3];
    test:assertFalse(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleSecondTriangleInequalityViolation() {
    int[] sides = [1, 3, 1];
    test:assertFalse(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleThirdTriangleInequalityViolation() {
    int[] sides = [3, 1, 1];
    test:assertFalse(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testIsoscelesTriangleSidesMayBeFloats() {
    float[] sides = [0.5, 0.4, 0.5];
    test:assertTrue(kind(sides, ISOSCELES));
}

@test:Config {
    enable: true
}
function testScaleneTriangleNoSidesAreEqual() {
    int[] sides = [5, 4, 6];
    test:assertTrue(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleAllSidesAreEqual() {
    int[] sides = [4, 4, 4];
    test:assertFalse(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleFirstAndSecondSidesAreEqual() {
    int[] sides = [4, 4, 3];
    test:assertFalse(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleFirstAndThirdSidesAreEqual() {
    int[] sides = [3, 4, 3];
    test:assertFalse(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleSecondAndThirdSidesAreEqual() {
    int[] sides = [4, 3, 3];
    test:assertFalse(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleMayNotViolateTriangleInequality() {
    int[] sides = [7, 3, 2];
    test:assertFalse(kind(sides, SCALENE));
}

@test:Config {
    enable: true
}
function testScaleneTriangleSidesMayBeFloats() {
    float[] sides = [0.5, 0.4, 0.6];
    test:assertTrue(kind(sides, SCALENE));
}