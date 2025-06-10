public function eggCount(int displayValue) returns int {
    int count = 0;
    int x = displayValue;
    while x > 0 {
        if (x & 1) > 0 {
            count += 1;
        }
        x >>= 1;
    }
    return count;
}
