import gleam/bit_array
import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  list.fold(dna, <<>>, fn(acc, value) {
    bit_array.append(acc, <<encode_nucleotide(value):2>>)
  })
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_loop([], dna)
}

fn decode_loop(acc, dna: BitArray) {
  case dna {
    <<>> -> Ok(list.reverse(acc))
    <<value:2, rest:bits>> -> {
      decode_nucleotide(value)
      |> result.then(fn(value) { decode_loop([value, ..acc], rest) })
    }
    _ -> Error(Nil)
  }
}
