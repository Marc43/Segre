import segre_pkg::*;

//4KB pages, 32 entries, direct mapping
//Virtual address -> 32 bits
//Physical address -> 20 bits

//Module definition
module segre_dtlb (

    input logic clock_i,
    input logic rsn_i,

    //Maybe i'll just use the required trimmed address, to be decided
    input logic [WORD_SIZE-1:0] vaddr_i,

    output logic tlbmiss_o,
    output logic [PHYSICAL_ADDR_SIZE-1:0] paddr_o
    //TO FILL
);

//Internal structure and variables

//Estic molt espesote, continuo mes tard (fa falta fer distincio de tag/index per a la TLB?)
