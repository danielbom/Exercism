public type Item record {|
    int weight;
    int value;
|};

public function maximumValue(Item[] items, int maximumWeight) returns int {
    return findMaximumValue(items, 0, maximumWeight, 0, 0);
}

function findMaximumValue(Item[] items, int currentIndex, int maximumWeight, int currentWeight, int currentValue) returns int {
    int maximumValue = currentValue;
    if currentIndex < items.length() {
        Item currentItem = items[currentIndex];
        if currentItem.weight + currentWeight <= maximumWeight {
            foreach int i in currentIndex + 1 ... items.length() {
                int nextMaximumValue = findMaximumValue(items, i, maximumWeight, currentItem.weight + currentWeight, currentItem.value + currentValue);
                if nextMaximumValue > maximumValue {
                    maximumValue = nextMaximumValue;
                }
            }
        }

        foreach int i in currentIndex + 1 ... items.length() {
            int nextMaximumValue = findMaximumValue(items, i, maximumWeight, currentWeight, currentValue);
            if nextMaximumValue > maximumValue {
                maximumValue = nextMaximumValue;
            }
        }
    }
    return maximumValue;
}
