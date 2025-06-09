import ballerina/test;

@test:Config
function testAppendEmptyLists() {
    int[] list1 = [];
    int[] list2 = [];
    int[] result = append(list1, list2);
    int[] expected = [];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testAppendListToEmptyList() {
    int[] list1 = [];
    int[] list2 = [1, 2, 3, 4];
    int[] result = append(list1, list2);
    int[] expected = [1, 2, 3, 4];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testAppendEmptyListToList() {
    int[] list1 = [1, 2, 3, 4];
    int[] list2 = [];
    int[] result = append(list1, list2);
    int[] expected = [1, 2, 3, 4];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testAppendNonEmptyLists() {
    int[] list1 = [1, 2];
    int[] list2 = [2, 3, 4, 5];
    int[] result = append(list1, list2);
    int[] expected = [1, 2, 2, 3, 4, 5];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testConcatenateEmptyList() {
    int[][] lists = [];
    int[] result = <int[]>concatenate(lists);
    int[] expected = [];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testConcatenateListOfLists() {
    int[][] lists = [[1, 2], [3], [], [4, 5, 6]];
    int[] result = <int[]>concatenate(lists);
    int[] expected = [1, 2, 3, 4, 5, 6];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testConcatenateListOfNestedLists() {
    int[][][] lists = [[[1], [2]], [[3]], [[]], [[4, 5, 6]]];
    int[][] result = <int[][]>concatenate(lists);
    int[][] expected = [[1], [2], [3], [], [4, 5, 6]];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFilterEmptyList() {
    int[] list = [];
    var fn = function(int n) returns boolean => n % 2 == 1;
    int[] result = filter(list, fn);
    int[] expected = [];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFilterNonEmptyList() {
    int[] list = [1, 2, 3, 5];
    var fn = function(int n) returns boolean => n % 2 == 1;
    int[] result = filter(list, fn);
    int[] expected = [1, 3, 5];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testLengthOfEmptyList() {
    int[] list = [];
    int result = length(list);
    int expected = 0;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testLengthOfNonEmptyList() {
    int[] list = [1, 2, 3, 4];
    int result = length(list);
    int expected = 4;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testMapEmptyList() {
    int[] list = [];
    var fn = function(int n) returns int => n + 1;
    int[] result = myMap(list, fn);
    int[] expected = [];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testMapNonEmptyList() {
    int[] list = [1, 3, 5, 7];
    var fn = function(int n) returns int => n + 1;
    int[] result = myMap(list, fn);
    int[] expected = [2, 4, 6, 8];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFoldlEmptyList() {
    int[] list = [];
    var fn = function(int x, int y) returns int => x + y;
    int initial = 2;
    int result = foldl(list, fn, initial);
    int expected = 2;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFoldlDirectionIndependent() {
    int[] list = [1, 2, 3, 4];
    var fn = function(int x, int y) returns int => x + y;
    int initial = 5;
    int result = foldl(list, fn, initial);
    int expected = 15;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFoldlDirectionDependent() {
    int[] list = [2, 5];
    var fn = function(int acc, int el) returns int => acc / el;
    int initial = 5;
    int result = foldl(list, fn, initial);
    int expected = 0;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFoldrEmptyList() {
    int[] list = [];
    var fn = function(int acc, int el) returns int => el * acc;
    int initial = 2;
    int result = foldr(list, fn, initial);
    int expected = 2;
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testFoldrDirectionIndependent() {
    int[] list = [1, 2, 3, 4];
    var fn = function(int acc, int el) returns int => el + acc;
    int initial = 5;
    int result = foldr(list, fn, initial);
    int expected = 15;
    test:assertEquals(result, expected);
}
@test:Config {
    enable: true
}
function testFoldrDirectionDependent() {
    int[] list = [2, 5];
    var fn = function(int acc, int el) returns int => el / acc;
    int initial = 5;
    int result = foldr(list, fn, initial);
    int expected = 2;
    test:assertEquals(result, expected);
}
@test:Config {
    enable: true
}
function testReverseEmptyList() {
    int[] list = [];
    int[] result = <int[]>reverse(list);
    int[] expected = [];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testReverseNonEmptyList() {
    int[] list = [1, 3, 5, 7];
    int[] result = <int[]>reverse(list);
    int[] expected = [7, 5, 3, 1];
    test:assertEquals(result, expected);
}

@test:Config {
    enable: true
}
function testReverseListOfLists() {
    int[][] list = [[1, 2], [3], [], [4, 5, 6]];
    int[][] result = <int[][]>reverse(list);
    int[][] expected = [[4, 5, 6], [], [3], [1, 2]];
    test:assertEquals(result, expected);
}

