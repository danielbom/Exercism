function isPaired(string value) returns boolean {
    [string, string][] pairs = [
        ["(", ")"],
        ["{", "}"],
        ["[", "]"]
    ];
    var opening = map from var [fst, snd] in pairs
        select [fst, snd];
    var closing = map from var [_, snd] in pairs
        select [snd, ()];
    string[] stack = [];
    foreach var ch in value {
        var close = opening[ch];
        if close is string {
            stack.push(close);
            continue;
        }
        if closing.hasKey(ch) {
            if stack.length() == 0 || stack.pop() != ch {
                return false;
            }
        }
    }
    return stack.length() == 0;
}
