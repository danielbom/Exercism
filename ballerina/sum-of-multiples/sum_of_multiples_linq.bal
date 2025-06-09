public function sum_linq(int[] factors, int 'limit) returns int {
    return (map from int f in factors
                where f > 0
                from int i in int:range(f, 'limit, f)
                select [i.toString(), i])
        .reduce(isolated function(int total, int next)
            returns int => total + next, 0);
}
