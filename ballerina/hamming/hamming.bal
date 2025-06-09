public function distance(string strand1, string strand2) returns int|error {
    int n1 = strand1.length();
    int n2 = strand2.length();
    if n1 != n2 {
        return error("Unequal strand lengths");
    }
    int count = 0;
    foreach int i in 0 ..< n1 {
        if strand1[i] != strand2[i] {
            count += 1;
        }
    }
    return count;
}
