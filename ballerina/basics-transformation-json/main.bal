import ballerina/io;

type FillUpEntry record {|
    int employeeId;
    int odometerReading;
    decimal gallons;
    decimal gasPrice;
|};

type EmployeeFillUpSummary record {|
    readonly int employeeId;
    int gasFillUpCount;
    decimal totalFuelCost;
    decimal totalGallons;
    int totalMilesAccrued;
|};

function read(string inputFilePath) returns FillUpEntry[]|error {
    json payload = check io:fileReadJson(inputFilePath);
    return check payload.fromJsonWithType();
}

function process(FillUpEntry[] entries) returns EmployeeFillUpSummary[] {
    table<EmployeeFillUpSummary> key(employeeId) result = table [];
    table<record {readonly int employeeId; int min; int max;}> key(employeeId) minMaxes = table [];
    foreach var entry in entries {
        EmployeeFillUpSummary summary;
        if result.hasKey(entry.employeeId) {
            summary = result.get(entry.employeeId);
            var minMax = minMaxes.get(entry.employeeId);
            if minMax.min > entry.odometerReading {
                minMax.min = entry.odometerReading;
            }
            if minMax.max < entry.odometerReading {
                minMax.max = entry.odometerReading;
            }
        } else {
            summary = {
                gasFillUpCount: 0,
                totalFuelCost: 0,
                totalGallons: 0,
                totalMilesAccrued: 0,
                employeeId: entry.employeeId
            };
            result.put(summary);
            minMaxes.add({
                employeeId: entry.employeeId,
                max: entry.odometerReading,
                min: entry.odometerReading
            });
        }
        summary.gasFillUpCount += 1;
        summary.totalFuelCost += entry.gallons * entry.gasPrice;
        summary.totalGallons += entry.gallons;
    }
    foreach var minMax in minMaxes {
        EmployeeFillUpSummary summary = result.get(minMax.employeeId);
        summary.totalMilesAccrued = minMax.max - minMax.min;
    }
    return result.toArray().sort("ascending", (it) => it.employeeId);
}

function write(EmployeeFillUpSummary[] result, string outputFilePath) returns error? {
    check io:fileWriteJson(outputFilePath, result);
}

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    var employees = check read(inputFilePath);
    var result = process(employees);
    check write(result, outputFilePath);
}
