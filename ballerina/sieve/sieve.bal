# Returns the prime numbers less than or equal to the given limit.
#
# + 'limit - as an int
# + return - prime numbers as an array of int
public function primes(int 'limit) returns int[] {
    int[] xs = 'limit > 1 ? [2] : [];
    foreach int i in 3 ... 'limit {
        if xs.every(x => i % x !== 0) {
            xs.push(i);
        }
    }
    return xs;
}
