class KindergartenGarden {
    string[] diagram;

    function init(string diagram) {
        self.diagram = re `\s`.split(diagram);
    }

    function plants(string student) returns string[] {
        // window side of 2
        var index = sudents.indexOf(student) ?: 0;
        int begin = index * 2;
        int end = begin + 2;
        return from var line in self.diagram
            from var ix in begin ..< end
            select plants[line[ix]] ?: "?";
    }
}

string[] sudents = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"];
map<string> plants = map from var plant in ["grass", "clover", "radishes", "violets"]
    select [plant[0].toUpperAscii(), plant];
