const int EARTH_YEAR_SECONDS = 31557600;

# Returns the age on another planet or error if it is not a planet.
#
# + planet - planet name as a string
# + seconds - person's age measured in seconds
# + return - person's age in years of that planet, or error if unknown planet.
function age(string planet, int seconds) returns float|error {
    float period = check orbital_period(planet);
    return (1.0 * seconds / EARTH_YEAR_SECONDS / period).round(2);
}

function orbital_period(string planet) returns float|error {
    match planet {
        "Mercury" => {
            return 0.2408467;
        }
        "Venus" => {
            return 0.61519726;
        }
        "Earth" => {
            return 1.0;
        }
        "Mars" => {
            return 1.8808158;
        }
        "Jupiter" => {
            return 11.862615;
        }
        "Saturn" => {
            return 29.447498;
        }
        "Uranus" => {
            return 84.016846;
        }
        "Neptune" => {
            return 164.79132;
        }
        _ => {
            return error("not a planet");
        }
    }
}
