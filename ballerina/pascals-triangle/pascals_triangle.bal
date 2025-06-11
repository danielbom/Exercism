function rows(int count) returns int[][] {
    int[][] result = [];
    foreach int i in 0 ..< count {
        if result.length() == 0 {
            result.push([1]);
        } else if result.length() == 1 {
            result.push([1, 1]);
        } else {
            result.push(next(result[result.length() - 1]));
        }
    }
    return result;
}

function next(int[] previous) returns int[] {
    int[] result = [1];
    foreach int i in 0 ..< previous.length() - 1 {
        result.push(previous[i] + previous[i + 1]);
    }
    result.push(1);
    return result;
}
