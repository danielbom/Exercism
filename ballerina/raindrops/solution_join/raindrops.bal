public function convert(int n) returns string {
    string raindrops = "".'join(
        n % 3 == 0 ? "Pling" : "",
        n % 5 == 0 ? "Plang" : "",
        n % 7 == 0 ? "Plong" : ""
    );
    return raindrops.length() == 0 ? n.toString() : raindrops;
}
