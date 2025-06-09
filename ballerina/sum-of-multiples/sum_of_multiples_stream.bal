# Find the unique multiples of the given factors that are less than the limit.
# Return the sum of the multiples.
#
# + factors - an array of integers
# + 'limit - the upper limit of the multiples
# + return - the sum of the multiples
public function sum_stream(int[] factors, int 'limit) returns int {
    var values = stream from int i in 1 ... 'limit - 1
        where factors.some(factor => factor > 0 && i % factor == 0)
        select i;
    return stream:reduce(values, function(int a, int b) returns int => a + b, 0);
}
