public function isLeapYear(int year) returns boolean {
    if year % 100 == 0 {
        return year % 400 == 0; 
    } else {
        return year % 4 == 0;
    }
}
