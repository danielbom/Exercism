# Search an array for a value and return the index.
#
# + array - a sorted array of integers
# + value - the integer item to find
# + return - the index of the value, or nil if the value is not found
public function find(int[] array, int value) returns int? {
    return findRec(array, value, 0, array.length() - 1);
}

function findRec(int[] array, int value, int begin, int end) returns int? {
    if begin > end {
        return ();
    }
    int middle = (end - begin) / 2 + begin;
    if array[middle] < value {
        return findRec(array, value, middle + 1, end);
    } else if array[middle] > value {
        return findRec(array, value, begin, middle - 1);
    } else {
        return middle;
    }
}
