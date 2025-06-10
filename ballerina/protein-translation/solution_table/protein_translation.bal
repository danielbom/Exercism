
# Translate a sequence of codons to a list of proteins.
#
# + strand - an RNA strand as a string
# + return - array of protein names, or error
public function proteins(string strand) returns string[]|error {
    string[] result = [];
    foreach var i in int:range(0, strand.length(), 3) {
        if i + 3 > strand.length() {
            return error("Invalid codon");
        }
        var codon = strand.substring(i, i + 3);
        var protein = aminoAcids[codon]?.protein;
        if protein is () {
            return error("Invalid codon");
        } else if protein == "STOP" {
            return result;
        } else {
            result.push(protein);
        }
    }
    return result;
}

table<AminoAcid> key(codon) aminoAcids = table [
    {codon: "AUG", protein: "Methionine"},
    {codon: "UUU", protein: "Phenylalanine"},
    {codon: "UUC", protein: "Phenylalanine"},
    {codon: "UUA", protein: "Leucine"},
    {codon: "UUG", protein: "Leucine"},
    {codon: "UCU", protein: "Serine"},
    {codon: "UCC", protein: "Serine"},
    {codon: "UCA", protein: "Serine"},
    {codon: "UCG", protein: "Serine"},
    {codon: "UAU", protein: "Tyrosine"},
    {codon: "UAC", protein: "Tyrosine"},
    {codon: "UGU", protein: "Cysteine"},
    {codon: "UGC", protein: "Cysteine"},
    {codon: "UGG", protein: "Tryptophan"},
    {codon: "UAA", protein: "STOP"},
    {codon: "UAG", protein: "STOP"},
    {codon: "UGA", protein: "STOP"}
];

type AminoAcid record {|
    readonly string codon;
    readonly string protein;
|};
