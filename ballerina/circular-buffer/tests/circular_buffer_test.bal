import ballerina/test;

@test:Config
function testEmptyBufferShouldFail() {
    CircularBuffer buffer = new(1);

    int|error result = buffer.read();
    if result is error {
        test:assertEquals(result.message(), "Empty buffer");
    } else {
        test:assertFail("Expected an error reading the buffer");
    }
}

@test:Config {
    enable: true
}
function testReadItemJustWritten() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.read(), 1);
}

@test:Config {
    enable: true
}
function testEachItemMayOnlyBeReadOnce() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.read(), 1);

    int|error readResult = buffer.read();
    if readResult is error {
        test:assertEquals(readResult.message(), "Empty buffer");
    } else {
        test:assertFail("Expected an error reading from buffer the second time");
    }
}

@test:Config {
    enable: true
}
function testItemsAreReadInTheOrderTheyAreWritten() {
    CircularBuffer buffer = new(2);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.read(), 1);
    test:assertEquals(buffer.read(), 2);
}

@test:Config {
    enable: true
}
function testFullBufferCanNotBeWrittenTo() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);

    error? writeResult = buffer.write(2);
    if writeResult is error {
        test:assertEquals(writeResult.message(), "Full buffer");
    } else {
        test:assertFail("Expected an error writing to buffer the second time");
    }
}

@test:Config {
    enable: true
}
function testAReadFreesUpCapacityForAnotherWrite() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.read(), 1);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.read(), 2);
}

@test:Config {
    enable: true
}
function testReadPositionMaintainedEvenAcrossMultipleWrites() {
    CircularBuffer buffer = new(3);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.read(), 1);
    test:assertEquals(buffer.write(3), null);
    test:assertEquals(buffer.read(), 2);
    test:assertEquals(buffer.read(), 3);
}

@test:Config {
    enable: true
}
function testItemsClearedOutOfBufferCanNotBeRead() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);
    buffer.clear();

    int|error readResult = buffer.read();
    if readResult is error {
        test:assertEquals(readResult.message(), "Empty buffer");
    } else {
        test:assertFail("Expected an error reading from buffer");
    }
}

@test:Config {
    enable: true
}
function testClearFreesUpCapacityForAnotherWrite() {
    CircularBuffer buffer = new(1);

    test:assertEquals(buffer.write(1), null);
    buffer.clear();
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.read(), 2);
}

@test:Config {
    enable: true
}
function testClearDoesNothingOnEmptyBuffer() {
    CircularBuffer buffer = new(1);

    buffer.clear();
    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.read(), 1);
}

@test:Config {
    enable: true
}
function testOverwriteActsLikeWriteOnNonFullBuffer() {
    CircularBuffer buffer = new(2);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.overwrite(2), null);
    test:assertEquals(buffer.read(), 1);
    test:assertEquals(buffer.read(), 2);
}

@test:Config {
    enable: true
}
function testOverwriteReplacesTheOldestItemInFullBuffer() {
    CircularBuffer buffer = new(2);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.overwrite(3), null);
    test:assertEquals(buffer.read(), 2);
    test:assertEquals(buffer.read(), 3);
}

@test:Config {
    enable: true
}
function testOverwriteReplacesTheOldestItemRemainingInBufferFollowingARead() {
    CircularBuffer buffer = new(3);

    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.write(3), null);
    test:assertEquals(buffer.read(), 1);
    test:assertEquals(buffer.write(4), null);
    test:assertEquals(buffer.overwrite(5), null);
    test:assertEquals(buffer.read(), 3);
    test:assertEquals(buffer.read(), 4);
    test:assertEquals(buffer.read(), 5);
}

@test:Config {
    enable: true
}
function testInitialClearDoesNotAffectWrappingAround() {
    CircularBuffer buffer = new(2);

    buffer.clear();
    test:assertEquals(buffer.write(1), null);
    test:assertEquals(buffer.write(2), null);
    test:assertEquals(buffer.overwrite(3), null);
    test:assertEquals(buffer.overwrite(4), null);
    test:assertEquals(buffer.read(), 3);
    test:assertEquals(buffer.read(), 4);

    int|error readResult = buffer.read();
    if readResult is error {
        test:assertEquals(readResult.message(), "Empty buffer");
    } else {
        test:assertFail("Expected an error reading from buffer");
    }
}
