function commands(int input) returns string[] {
    string[] result = [];
    if (input & (1 << 0)) > 0 {
        result.push("wink");
    }
    if (input & (1 << 1)) > 0 {
        result.push("double blink");
    }
    if (input & (1 << 2)) > 0 {
        result.push("close your eyes");
    }
    if (input & (1 << 3)) > 0 {
        result.push("jump");
    }
    if (input & (1 << 4)) > 0 {
        result = result.reverse();
    }
    return result;
}
