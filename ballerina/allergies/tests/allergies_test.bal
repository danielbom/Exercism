import ballerina/test;

@test:Config
function testNotAllergicToAnythingIncludingEggs() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("eggs"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToEggs() {
    Allergies allergies = new(1);
    test:assertTrue(allergies.allergicTo("eggs"));
}

@test:Config {
    enable: true
}
function testAllergicToEggsAndSomethingElse() {
    Allergies allergies = new(3);
    test:assertTrue(allergies.allergicTo("eggs"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesEggs() {
    Allergies allergies = new(2);
    test:assertFalse(allergies.allergicTo("eggs"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingEggs() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("eggs"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingPeanuts() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("peanuts"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToPeanuts() {
    Allergies allergies = new(2);
    test:assertTrue(allergies.allergicTo("peanuts"));
}

@test:Config {
    enable: true
}
function testAllergicToPeanutsAndSomethingElse() {
    Allergies allergies = new(7);
    test:assertTrue(allergies.allergicTo("peanuts"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesPeanuts() {
    Allergies allergies = new(5);
    test:assertFalse(allergies.allergicTo("peanuts"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingPeanuts() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("peanuts"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingShellfish() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("shellfish"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToShellfish() {
    Allergies allergies = new(4);
    test:assertTrue(allergies.allergicTo("shellfish"));
}

@test:Config {
    enable: true
}
function testAllergicToShellfishAndSomethingElse() {
    Allergies allergies = new(14);
    test:assertTrue(allergies.allergicTo("shellfish"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesShellfish() {
    Allergies allergies = new(10);
    test:assertFalse(allergies.allergicTo("shellfish"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingShellfish() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("shellfish"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingStrawberries() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("strawberries"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToStrawberries() {
    Allergies allergies = new(8);
    test:assertTrue(allergies.allergicTo("strawberries"));
}

@test:Config {
    enable: true
}
function testAllergicToStrawberriesAndSomethingElse() {
    Allergies allergies = new(28);
    test:assertTrue(allergies.allergicTo("strawberries"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesStrawberries() {
    Allergies allergies = new(20);
    test:assertFalse(allergies.allergicTo("strawberries"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingStrawberries() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("strawberries"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingTomatoes() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("tomatoes"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToTomatoes() {
    Allergies allergies = new(16);
    test:assertTrue(allergies.allergicTo("tomatoes"));
}

@test:Config {
    enable: true
}
function testAllergicToTomatoesAndSomethingElse() {
    Allergies allergies = new(56);
    test:assertTrue(allergies.allergicTo("tomatoes"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesTomatoes() {
    Allergies allergies = new(40);
    test:assertFalse(allergies.allergicTo("tomatoes"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingTomatoes() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("tomatoes"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingChocolate() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("chocolate"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToChocolate() {
    Allergies allergies = new(32);
    test:assertTrue(allergies.allergicTo("chocolate"));
}

@test:Config {
    enable: true
}
function testAllergicToChocolateAndSomethingElse() {
    Allergies allergies = new(112);
    test:assertTrue(allergies.allergicTo("chocolate"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesChocolate() {
    Allergies allergies = new(80);
    test:assertFalse(allergies.allergicTo("chocolate"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingChocolate() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("chocolate"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingPollen() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("pollen"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToPollen() {
    Allergies allergies = new(64);
    test:assertTrue(allergies.allergicTo("pollen"));
}

@test:Config {
    enable: true
}
function testAllergicToPollenAndSomethingElse() {
    Allergies allergies = new(224);
    test:assertTrue(allergies.allergicTo("pollen"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesPollen() {
    Allergies allergies = new(160);
    test:assertFalse(allergies.allergicTo("pollen"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingPollen() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("pollen"));
}

@test:Config {
    enable: true
}
function testNotAllergicToAnythingIncludingCats() {
    Allergies allergies = new(0);
    test:assertFalse(allergies.allergicTo("cats"));
}

@test:Config {
    enable: true
}
function testAllergicOnlyToCats() {
    Allergies allergies = new(128);
    test:assertTrue(allergies.allergicTo("cats"));
}

@test:Config {
    enable: true
}
function testAllergicToCatsAndSomethingElse() {
    Allergies allergies = new(192);
    test:assertTrue(allergies.allergicTo("cats"));
}

@test:Config {
    enable: true
}
function testAllergicToSomethingBesidesCats() {
    Allergies allergies = new(64);
    test:assertFalse(allergies.allergicTo("cats"));
}

@test:Config {
    enable: true
}
function testAllergicToEverythingIncludingCats() {
    Allergies allergies = new(255);
    test:assertTrue(allergies.allergicTo("cats"));
}

@test:Config {
    enable: true
}
function testListWhenAlergicToNothing() {
    Allergies allergies = new(0);
    string[] expected = [];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToJustEggs() {
    Allergies allergies = new(1);
    string[] expected = ["eggs"];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToJustPeanuts() {
    Allergies allergies = new(2);
    string[] expected = ["peanuts"];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToJustStrawberries() {
    Allergies allergies = new(8);
    string[] expected = ["strawberries"];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToEggsAndPeanuts() {
    Allergies allergies = new(3);
    string[] expected = ["eggs", "peanuts"];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToMoreThanEggsButNotPeanuts() {
    Allergies allergies = new(5);
    string[] expected = ["eggs", "shellfish"];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToLotsOfStuff() {
    Allergies allergies = new(248);
    string[] expected = [
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats"
        ];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenAllergicToEverything() {
    Allergies allergies = new(255);
    string[] expected = [
        "eggs",
        "peanuts",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats"
        ];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenNoAllergenScoreParts() {
    Allergies allergies = new(509);
    string[] expected = [
        "eggs",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats"
        ];
    test:assertEquals(allergies.list(), expected);
}

@test:Config {
    enable: true
}
function testListWhenNoAllergenScorePartsWithoutHighestValidScore() {
    Allergies allergies = new(257);
    string[] expected = ["eggs"];
    test:assertEquals(allergies.list(), expected);
}

