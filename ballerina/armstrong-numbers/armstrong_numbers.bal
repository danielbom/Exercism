public function isArmstrongNumber(int number) returns boolean {
    int length = 0;
    {
        int x = number;
        while x > 0 {
            length += 1;
            x /= 10;
        }
    }
    int sum = 0;
    {
        int x = number;
        while x > 0 {
            int digit = x % 10;
            sum += <int>(<float>digit).pow(<float>length);
            x /= 10;
        }
    }
    return sum == number;
}
