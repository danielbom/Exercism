# Returns the age on another planet or error if it is not a planet.
#
# + planet - planet name as a string
# + seconds - person's age measured in seconds
# + return - person's age in years of that planet, or error if unknown planet.
function age(string planet, int seconds) returns float|error {
    match planet {
        "Mercury" => {
            return _age(0.2408467, seconds);
        }
        "Venus" => {
            return _age(0.61519726, seconds);
        }
        "Earth" => {
            return _age(1.0, seconds);
        }
        "Mars" => {
            return _age(1.8808158, seconds);
        }
        "Jupiter" => {
            return _age(11.862615, seconds);
        }
        "Saturn" => {
            return _age(29.447498, seconds);
        }
        "Uranus" => {
            return _age(84.016846, seconds);
        }
        "Neptune" => {
            return _age(164.79132, seconds);
        }
        _ => {
            return error("not a planet");
        }
    }
}

function _age(float factor, int seconds) returns float {
    return (<float>seconds / (factor * 31557600)).round(2);
}
