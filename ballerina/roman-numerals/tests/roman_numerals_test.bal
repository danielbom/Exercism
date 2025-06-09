import ballerina/test;

@test:Config {}
function test1isI() {
    test:assertEquals(roman(1), "I");
}

@test:Config {
    enable: true
}
function test2isII() {
    test:assertEquals(roman(2), "II");
}

@test:Config {
    enable: true
}
function test3isIII() {
    test:assertEquals(roman(3), "III");
}

@test:Config {
    enable: true
}
function test4isIV() {
    test:assertEquals(roman(4), "IV");
}

@test:Config {
    enable: true
}
function test5isV() {
    test:assertEquals(roman(5), "V");
}

@test:Config {
    enable: true
}
function test6isVI() {
    test:assertEquals(roman(6), "VI");
}

@test:Config {
    enable: true
}
function test9isIX() {
    test:assertEquals(roman(9), "IX");
}

@test:Config {
    enable: true
}
function test16isXVI() {
    test:assertEquals(roman(16), "XVI");
}

@test:Config {
    enable: true
}
function test27isXXVII() {
    test:assertEquals(roman(27), "XXVII");
}

@test:Config {
    enable: true
}
function test48isXLVIII() {
    test:assertEquals(roman(48), "XLVIII");
}

@test:Config {
    enable: true
}
function test49isXLIX() {
    test:assertEquals(roman(49), "XLIX");
}

@test:Config {
    enable: true
}
function test59isLIX() {
    test:assertEquals(roman(59), "LIX");
}

@test:Config {
    enable: true
}
function test66isLXVI() {
    test:assertEquals(roman(66), "LXVI");
}

@test:Config {
    enable: true
}
function test93isXCIII() {
    test:assertEquals(roman(93), "XCIII");
}

@test:Config {
    enable: true
}
function test141isCXLI() {
    test:assertEquals(roman(141), "CXLI");
}

@test:Config {
    enable: true
}
function test163isCLXIII() {
    test:assertEquals(roman(163), "CLXIII");
}

@test:Config {
    enable: true
}
function test166isCLXVI() {
    test:assertEquals(roman(166), "CLXVI");
}

@test:Config {
    enable: true
}
function test402isCDII() {
    test:assertEquals(roman(402), "CDII");
}

@test:Config {
    enable: true
}
function test575isDLXXV() {
    test:assertEquals(roman(575), "DLXXV");
}

@test:Config {
    enable: true
}
function test666isDCLXVI() {
    test:assertEquals(roman(666), "DCLXVI");
}

@test:Config {
    enable: true
}
function test911isCMXI() {
    test:assertEquals(roman(911), "CMXI");
}

@test:Config {
    enable: true
}
function test1024isMXXIV() {
    test:assertEquals(roman(1024), "MXXIV");
}

@test:Config {
    enable: true
}
function test1666isMDCLXVI() {
    test:assertEquals(roman(1666), "MDCLXVI");
}

@test:Config {
    enable: true
}
function test3000isMMM() {
    test:assertEquals(roman(3000), "MMM");
}

@test:Config {
    enable: true
}
function test3001isMMMI() {
    test:assertEquals(roman(3001), "MMMI");
}

@test:Config {
    enable: true
}
function test3999isMMMCMXCIX() {
    test:assertEquals(roman(3999), "MMMCMXCIX");
}
