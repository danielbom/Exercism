public function square(int n) returns int {
    return n * n;
}

public function sum(int n) returns int {
    return n * (n + 1) / 2;
}

public function squareOfSum(int n) returns int {
    return square(sum(n));
}

public function sumOfSquares(int n) returns int {
    return n * (n + 1) * (2 * n + 1) / 6;
}

public function differenceOfSquares(int n) returns int {
    return squareOfSum(n) - sumOfSquares(n);
}
