var sounds = [[3, "Pling"], [5, "Plang"], [7, "Plong"]];

public function convert(int n) returns string {
    var result = "";
    foreach var [factor, sound] in sounds {
        if n % factor == 0 {
            result += sound;
        }
    }
    return result.length() > 0 ? result : n.toString();
}
