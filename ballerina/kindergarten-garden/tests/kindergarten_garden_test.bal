import ballerina/test;

@test:Config
function testPartialGardenForAlice1() {
    KindergartenGarden garden = new KindergartenGarden("RC\nGG");
    test:assertEquals(garden.plants("Alice"), ["radishes", "clover", "grass", "grass"]);
}

@test:Config {
    enable: true
}
function testPartialGardenForAlice2() {
    KindergartenGarden garden = new KindergartenGarden("VC\nRC");
    test:assertEquals(garden.plants("Alice"), ["violets", "clover", "radishes", "clover"]);
}

@test:Config {
    enable: true
}
function testPartialGardenForBob1() {
    KindergartenGarden garden = new KindergartenGarden("VVCG\nVVRC");
    test:assertEquals(garden.plants("Bob"), ["clover", "grass", "radishes", "clover"]);
}

@test:Config {
    enable: true
}
function testPartialGardenForBob2() {
    KindergartenGarden garden = new KindergartenGarden("VVCCGG\nVVCCGG");
    test:assertEquals(garden.plants("Bob"), ["clover", "clover", "clover", "clover"]);
}

@test:Config {
    enable: true
}
function testPartialGardenForCharlie() {
    KindergartenGarden garden = new KindergartenGarden("VVCCGG\nVVCCGG");
    test:assertEquals(garden.plants("Charlie"), ["grass", "grass", "grass", "grass"]);
}

@test:Config {
    enable: true
}
function testFullGardenForAlice() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Alice"), ["violets", "radishes", "violets", "radishes"]);
}

@test:Config {
    enable: true
}
function testFullGardenForBob() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Bob"), ["clover", "grass", "clover", "clover"]);
}

@test:Config {
    enable: true
}
function testFullGardenForCharlie() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Charlie"), ["violets", "violets", "clover", "grass"]);
}

@test:Config {
    enable: true
}
function testFullGardenForDavid() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("David"), ["radishes", "violets", "clover", "radishes"]);
}

@test:Config {
    enable: true
}
function testFullGardenForEve() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Eve"), ["clover", "grass", "radishes", "grass"]);
}

@test:Config {
    enable: true
}
function testFullGardenForFred() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Fred"), ["grass", "clover", "violets", "clover"]);
}

@test:Config {
    enable: true
}
function testFullGardenForGinny() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Ginny"), ["clover", "grass", "grass", "clover"]);
}

@test:Config {
    enable: true
}
function testFullGardenForHarriet() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Harriet"), ["violets", "radishes", "radishes", "violets"]);
}

@test:Config {
    enable: true
}
function testFullGardenForIleana() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Ileana"), ["grass", "clover", "violets", "clover"]);
}

@test:Config {
    enable: true
}
function testFullGardenForJoseph() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Joseph"), ["violets", "clover", "violets", "grass"]);
}

@test:Config {
    enable: true
}
function testFullGardenForKincaid() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Kincaid"), ["grass", "clover", "clover", "grass"]);
}

@test:Config {
    enable: true
}
function testFullGardenForLarry() {
    KindergartenGarden garden = new KindergartenGarden("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV");
    test:assertEquals(garden.plants("Larry"), ["grass", "violets", "clover", "violets"]);
}