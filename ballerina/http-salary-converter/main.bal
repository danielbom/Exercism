import ballerina/http;

type CurrencyRates record {
    string base;
    map<decimal> rates;
};

# The exchange rate API
final http:Client exchangeRateClient = check new ("http://localhost:8080");

# Convert provided salary to local currency.
#
# + salary - Salary in source currency
# + sourceCurrency - Soruce currency
# + localCurrency - Employee's local currency
# + return - Salary in local currency or error
public function convertSalary(decimal salary, string sourceCurrency, string localCurrency) returns decimal|error {
    CurrencyRates exchangeRate = check exchangeRateClient->/rates/[sourceCurrency];
    decimal convertionRate = exchangeRate.rates[localCurrency] ?: 0.0;
    return salary * convertionRate;
}
