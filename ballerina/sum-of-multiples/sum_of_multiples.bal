# Find the unique multiples of the given factors that are less than the limit.
# Return the sum of the multiples.
#
# + factors - an array of integers
# + 'limit - the upper limit of the multiples
# + return - the sum of the multiples
public function sum(int[] factors, int 'limit) returns int {
    int result = 0;
    foreach int x in 1 ..< 'limit {
        if factors.some(n => n > 0 && x % n == 0) {
            result += x;
        }
    }
    return result;
}
