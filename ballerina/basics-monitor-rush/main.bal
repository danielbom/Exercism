function allocateCubicles(int[] requests) returns int[] {
    return consecutiveDedup(requests.sort());
}

function consecutiveDedup(int[] values) returns int[] {
    if values.length() == 0 {
        return values;
    }
    int? previous = ();
    int[] result = [];
    foreach var current in values {
        if previous != current {
            result.push(current);
        }
        previous = current;
    }
    return result;
}
