class CircularBuffer {
    final int[] buffer = [];
    int head = 0;
    int tail = 0;
    int count = 0;

    function init(int capacity) {
        if capacity > 0 {
            self.buffer.setLength(capacity);
        }
    }

    function read() returns int|error {
        if self.count == 0 {
            return error("Empty buffer");
        }
        int value = self.buffer[self.head];
        self.head = (self.head + 1) % self.buffer.length();
        self.count -= 1;
        return value;
    }

    function write(int value) returns error? {
        if self.count == self.buffer.length() {
            return error("Full buffer");
        }
        self.buffer[self.tail] = value;
        self.tail = (self.tail + 1) % self.buffer.length();
        self.count += 1;
    }

    function overwrite(int value) returns error? {
        if self.count == self.buffer.length() {
            self.count -= 1;
            self.tail = self.head;
            self.head = (self.head + 1) % self.buffer.length();
        }
        return self.write(value);
    }

    function clear() {
        self.count = 0;
        self.head = 0;
        self.tail = 0;
    }
}
