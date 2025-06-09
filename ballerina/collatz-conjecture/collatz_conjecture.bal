# Returns the number of steps required to reach 1.
#
# + n - number
# + return - number of steps
function collatzSteps(int n) returns int|error {
    if n < 1 {
        return error("Only positive integers are allowed");
    }
    return collatzStepsRec(n, 0);
}

function collatzStepsRec(int n, int count) returns int {
    if n == 1 {
        return count;
    } else if n % 2 == 0 {
        return collatzStepsRec(n / 2, count + 1);
    } else {
        return collatzStepsRec(n * 3 + 1, count + 1);
    }
}
