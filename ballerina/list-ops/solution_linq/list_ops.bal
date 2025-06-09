// ===============================
// [WARNING]: This code only works on Ballerina 2201.12.6 (Executed on 2025-06-09)
// ===============================

type IntFilter function (int num) returns boolean;

type IntMapper function (int num) returns int;

type IntAccumulator function (int acc, int el) returns int;

public function append(int[] list1, int[] list2) returns int[] {
    return [...list1, ...list2];
}

public function concatenate(int[][]|int[][][] lists) returns int[]|int[][] {
    if lists is int[][] {
        int[] result = from int[] list in lists
            from int item in list
            select item;
        return result;
    }
    if lists is int[][][] {
        int[][] result = from int[][] list in lists
            from int[] item in list
            select item;
        return result;
    }
    return <int[]>[];
}

public function filter(int[] list, IntFilter fn) returns int[] {
    return from var item in list
        where fn(item)
        select item;
}

public function length(int[] list) returns int {
    return list.length();
}

public function myMap(int[] list, IntMapper fn) returns int[] {
    return from var item in list
        select fn(item);
}

public function foldl(int[] list, IntAccumulator fn, int initial) returns int {
    return list.toStream().reduce(fn, initial);
}

// OBS: There's no reverse iterators

public function foldr(int[] list, IntAccumulator fn, int initial) returns int {
    int n = list.length();
    return (stream from var i in 1 ... n
        select list[n - i])
        .reduce(fn, initial);
}

public function reverse(int[]|int[][] list) returns int[]|int[][] {
    if list is int[] {
        int n = list.length();
        int[] result = from int i in 1 ... n
            select list[n - i];
        return result;
    }
    if list is int[][] {
        int n = list.length();
        int[][] result = from int i in 1 ... n
            select list[n - i];
        return result;
    }
    return <int[]>[];
}
