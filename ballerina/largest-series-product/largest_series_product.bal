# Find the largest product of the digits of a substring
#
# + digits - the sequence of digits as a string
# + span - the substring size
# + return - the maximum product, or an error
public function largestProduct(string digits, int span) returns int|error {
    if span < 0 {
        return error("span must not be negative");
    } else if digits.length() < span {
        return error("span must be smaller than string length");
    } else if !digits.matches(re `^\d*$`) {
        return error("digits input must only contain digits");
    }
    int[] values = from var digit in digits
        select checkpanic int:fromString(digit);
    return maxRangeProduct(values, 0, span, 0);
}

function maxRangeProduct(int[] values, int index, int span, int result) returns int {
    if index + span > values.length() {
        return result;
    } else {
        var current = rangeProduct(values, index, index, index + span, 1);
        return maxRangeProduct(values, index + 1, span, result.max(current));
    }
}

function rangeProduct(int[] values, int index, int begin, int end, int result) returns int {
    if result == 0 || index >= end {
        return result;
    } else {
        return rangeProduct(values, index + 1, begin, end, result * values[index]);
    }
}
