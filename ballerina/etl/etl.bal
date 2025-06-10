public function transform(map<string[]> old) returns map<int> {
    return map from var [point, values] in old.entries()
        from var letter in values
        select [
            letter.toLowerAscii(),
            checkpanic int:fromString(point)
        ];
}
