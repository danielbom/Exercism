import ballerina/http;

final http:Client airlineReservationEP = check new ("http://localhost:9091/airline");
final http:Client hotelReservationEP = check new ("http://localhost:9092/hotel");
final http:Client carRentalEP = check new ("http://localhost:9093/car");

service /travel on new http:Listener(9090) {

    resource function post arrangeTour(@http:Payload TourArrangement payload) returns http:Response|error {
        var airlineReservation = createReservation(payload, payload.preference.airline);
        ServiceResponse airlineResponse = check airlineReservationEP->/reserve.post(airlineReservation, targetType = ServiceResponse);
        if airlineResponse.status is FAILED {
            return httpError("Failed to reserve airline! Provide a valid 'preference' for 'airline' and try again");
        }

        var carReservation = createReservation(payload, payload.preference.car);
        ServiceResponse carResponse = check carRentalEP->/rent.post(carReservation, targetType = ServiceResponse);
        if carResponse.status is FAILED {
            return httpError("Failed to rent car! Provide a valid 'preference' for 'car' and try again");
        }

        var hotelReservation = createReservation(payload, payload.preference.accomodation);
        ServiceResponse hotelResponse = check hotelReservationEP->/reserve.post(hotelReservation, targetType = ServiceResponse);
        if hotelResponse.status is FAILED {
            return httpError("Failed to reserve hotel! Provide a valid 'preference' for 'accommodation' and try again");
        }

        return httpOk();
    }
}

function createReservation(TourArrangement payload, string preference) returns Reservation {
    return {
        name: payload.name,
        arrivalDate: payload.arrivalDate,
        departureDate: payload.departureDate,
        preference: preference
    };
}

function httpError(string errorMessage) returns http:Response {
    http:Response response = new;
    response.statusCode = 400;
    response.setHeader(http:CONTENT_TYPE, "application/json");
    response.setPayload({"message": errorMessage}.toJsonString());
    return response;
}

function httpOk() returns http:Response {
    http:Response response = new;
    response.statusCode = 201;
    response.setHeader(http:CONTENT_TYPE, "application/json");
    response.setPayload({"message": "Congratulations! Your journey is ready!!"}.toString());
    return response;
}

# The payload type received from the tour arrangement service.
#
# + name - Name of the tourist
# + arrivalDate - The arrival date of the tourist
# + departureDate - The departure date of the tourist
# + preference - The preferences for the airline, hotel, and the car rental
type TourArrangement record {|
    string name;
    string arrivalDate;
    string departureDate;
    Preference preference;
|};

# The different prefenrences for the tour.
#
# + airline - The preference for airline ticket. Can be `First`, `Bussiness`, `Economy`
# + accomodation - The prefenerece for the hotel reservarion. Can be `delux` or `superior`
# + car - The preference for the car rental. Can be `air conditioned`, or `normal`
type Preference record {|
    string airline;
    string accomodation;
    string car;
|};

// Define a record type to send requests to the Airline Ticket reservation services.
type Reservation record {|
    string name;
    string arrivalDate;
    string departureDate;
    string preference;
|};

// The response type received from the reservation services
type ServiceResponse record {|
    Status status;
|};

// Possible statuses of the reservation service responses
enum Status {
    SUCCESS = "Success",
    FAILED = "Failed"
}
