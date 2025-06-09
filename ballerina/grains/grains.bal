public function square(int n) returns float|error {
    if 0 < n && n <= 64 {
        return 2.0.pow(<float>n-1);
    } else {
        return error("Invalid square");
    }
}

public function total() returns float {
    return 2.0.pow(<float>65-1);
}
