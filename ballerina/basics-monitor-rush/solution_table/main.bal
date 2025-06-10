function allocateCubicles(int[] requests) returns int[] {
    return (table key(id) from int id in requests
        order by id
        select {id}
        on conflict ()).keys();
}
