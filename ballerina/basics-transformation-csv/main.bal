import ballerina/io;

type InputData record {
    readonly int employee_id;
    int odometer_reading;
    decimal gallons;
    decimal gas_price;
};

type OutputData record {
    readonly int employee_id;
    int gas_fill_up_count = 0;
    decimal total_fuel_cost = 0;
    decimal total_gallons = 0;
    int start_miles_accrued = 0;
    int total_miles_accrued = 0;
};

type EmployeesTable table<InputData>;

function read(string inputFilePath) returns EmployeesTable|error {
    io:ReadableCSVChannel reader = check io:openReadableCsvFile(inputFilePath);
    return check reader
        .toTable(InputData, ["employee_id", "odometer_reading", "gallons", "gas_price"])
        .ensureType(EmployeesTable);
}

function process(EmployeesTable employees) returns table<OutputData> {
    table<OutputData> key<int> result = table key(employee_id) [];
    foreach InputData employee in employees {
        if result.hasKey(employee.employee_id) {
            OutputData data = result.get(employee.employee_id);
            data.gas_fill_up_count += 1;
            data.total_fuel_cost += employee.gas_price * employee.gallons;
            data.total_gallons += employee.gallons;
            data.total_miles_accrued = employee.odometer_reading - data.start_miles_accrued;
        } else {
            result.add({
                employee_id: employee.employee_id,
                gas_fill_up_count: 1,
                start_miles_accrued: employee.odometer_reading,
                total_miles_accrued: 0,
                total_gallons: employee.gallons,
                total_fuel_cost: employee.gas_price * employee.gallons
            });
        }
    }
    return result;
}

function write(table<OutputData> result, string outputFilePath) returns error? {
    var writer = check io:openWritableCsvFile(outputFilePath);
    foreach OutputData outputData in from var o in result
        order by o.employee_id
        select o {
        string[] rec = [
            outputData.employee_id.toString(),
            outputData.gas_fill_up_count.toString(),
            outputData.total_fuel_cost.toString(),
            outputData.total_gallons.toString(),
            outputData.total_miles_accrued.toString()
        ];
        _ = check writer.write(rec);
    }
    check writer.close();
}

function processFuelRecords(string inputFilePath, string outputFilePath) returns error? {
    var employees = check read(inputFilePath);
    var result = process(employees);
    check write(result, outputFilePath);
}
