public type Item record {|
    int weight;
    int value;
|};

public function maximumValue(Item[] anyItems, int maximumWeight) returns int {
    Item[] items = anyItems.filter(x => x.weight <= maximumWeight);
    [int, Item][] possibleItems = items.enumerate();
    int maxValue = 0;
    foreach var i in 0 ..< items.length() {
        maxValue = int:max(maxValue, items[i].value);
        [int, Item][] nexts = [];
        foreach var [begin, item] in possibleItems {
            foreach var j in begin + 1 ..< items.length() {
                var newWeight = item.weight + items[j].weight;
                var newValue = item.value + items[j].value;
                if newWeight < maximumWeight {
                    nexts.push([j, {weight: newWeight, value: newValue}]);
                    maxValue = int:max(maxValue, newValue);
                } else if newWeight == maximumWeight {
                    maxValue = int:max(maxValue, newValue);
                }
            }
        }
        possibleItems = nexts;
    }
    return maxValue;
}
