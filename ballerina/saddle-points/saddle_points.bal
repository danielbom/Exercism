# Returns the saddle points in the given matrix.
#
# A saddle point is an value that is:
# - equal to the maximum value in its row, and
# - equal to the minimum value in its column.
#
# + matrix - an array of int arrays (i.e. two-dimensional matrix)
# + return - an array of maps [{"row": x, "column": y}, ...]
public function saddlePoints(int[][] matrix) returns map<int>[] {
    var maxs = matrix.'map(a => int:MIN_VALUE);
    var mins = matrix.length() == 0 ? [] : matrix[0].'map(a => int:MAX_VALUE);
    foreach int i in 0..<matrix.length() {
        foreach int j in 0..<matrix[i].length() {
            maxs[i] = matrix[i][j].max(maxs[i]);
            mins[j] = matrix[i][j].min(mins[j]);
        }
    }

    map<int>[] result = [];
    foreach int i in 0 ..< matrix.length() {
        foreach int j in 0 ..< matrix[0].length() {
            if mins[j] == matrix[i][j] && matrix[i][j] == maxs[i] {
                result.push({"row": i + 1, "column": j + 1});
            }
        }
    }
    return result;
}
