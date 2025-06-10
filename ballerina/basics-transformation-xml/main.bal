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

xmlns "http://www.so2w.org" as s;

function read(string inputFilePath) returns FillUpEntry[]|error {
    xml input = check io:fileReadXml(inputFilePath);
    FillUpEntry[] fillups = [];
    foreach var fillup in input/<s:FuelEvent> {
        var employeeId = check int:fromString(check fillup.employeeId);
        var odometerReading = check int:fromString((fillup/<s:odometerReading>/*).toString());
        var gallons = check decimal:fromString((fillup/<s:gallons>/*).toString());
        var gasPrice = check decimal:fromString((fillup/<s:gasPrice>/*).toString());
        fillups.push({employeeId, odometerReading, gallons, gasPrice});
    }
    return fillups;
}

function process(FillUpEntry[] entries) returns EmployeeFillUpSummary[] {
    table<EmployeeFillUpSummary> key(employeeId) result = table [];
    table<record {readonly int employeeId; int min; int max;}> key(employeeId) minMaxes = table [];
    foreach var entry in entries {
        EmployeeFillUpSummary summary;
        if result.hasKey(entry.employeeId) {
            summary = result.get(entry.employeeId);
            var minMax = minMaxes.get(entry.employeeId);
            minMax.min = minMax.min.min(entry.odometerReading);
            minMax.max = minMax.max.max(entry.odometerReading);
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
    return from var employee in result
        order by employee.employeeId ascending
        select employee;
}

function write(EmployeeFillUpSummary[] result, string outputFilePath) returns error? {
    xml records = from var employee in result
        select check xml:fromString(
                string `<s:employeeFuelRecord employeeId="${employee.employeeId}" xmlns:s="http://www.so2w.org">` +
                string `<s:gasFillUpCount>${employee.gasFillUpCount}</s:gasFillUpCount>` +
                string `<s:totalFuelCost>${employee.totalFuelCost}</s:totalFuelCost>` +
                string `<s:totalGallons>${employee.totalGallons}</s:totalGallons>` +
                string `<s:totalMilesAccrued>${employee.totalMilesAccrued}</s:totalMilesAccrued>` +
                string `</s:employeeFuelRecord>`);
    xml:Element content = xml `<s:employeeFuelRecords>${records}</s:employeeFuelRecords>`;
    check io:fileWriteXml(outputFilePath, content);
}

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    var employees = check read(inputFilePath);
    var result = process(employees);
    check write(result, outputFilePath);
}
