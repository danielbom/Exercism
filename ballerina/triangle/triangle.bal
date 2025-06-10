enum TriangleType {
    EQUILATERAL,
    ISOSCELES,
    SCALENE
}

# Determines the type of triangle based on the sides
# 
# + sides - The sides of the triangle
# + 'type - The type of triangle
# + return - Whether the sides form the triangle type
function kind(float[]|int[] sides, TriangleType 'type) returns boolean {
    if sides.length() != 3 {
        return false;
    }
    if sides is float[] {
        return floatIsTriangle(sides[0], sides[1], sides[2])
            && floatKind(sides[0], sides[1], sides[2], 'type);
    }
    if sides is int[] {
        return intIsTriangle(sides[0], sides[1], sides[2])
            && intKind(sides[0], sides[1], sides[2], 'type);
    }
    return false;
}

function floatKind(float a, float b, float c, TriangleType 'type) returns boolean {
    if a != b && b != c && a != c {
        return SCALENE == 'type;
    } else if a == b && b == c {
        return EQUILATERAL == 'type || ISOSCELES == 'type;
    } else {
        return ISOSCELES == 'type;
    }
}

function floatIsTriangle(float a, float b, float c) returns boolean {
    return a > 0.0
        && b > 0.0
        && c > 0.0 
        && a + b >= c
        && a + c >= b
        && b + c >= a;
}


function intKind(int a, int b, int c, TriangleType 'type) returns boolean {
    if a != b && b != c && a != c {
        return SCALENE == 'type;
    } else if a == b && b == c {
        return EQUILATERAL == 'type || ISOSCELES == 'type;
    } else {
        return ISOSCELES == 'type;
    }
}

function intIsTriangle(int a, int b, int c) returns boolean {
    return a > 0
        && b > 0
        && c > 0 
        && a + b >= c
        && a + c >= b
        && b + c >= a;
}
