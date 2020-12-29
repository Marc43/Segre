import segre_pkg::*;

//4KB pages, 32 entries, direct mapping
//Virtual address -> 32 bits
//Physical address -> 20 bits

//12 first bits used as page offset, the rest are used as page numbers


//Module definition
module segre_dtlb (

    input logic clock_i,
    input logic rsn_i,

    //Input address
    input logic [WORD_SIZE-1:0] vaddr_i,

    output logic tlbmiss_o,
    output logic [PHYSICAL_ADDR_SIZE-1:0] paddr_o
    //TO FILL
);

//Internal structure and variables
typedef struct packed{
    logic [VIRT_PAGE_BITS-1:0] vpage;
    logic [PHYS_PAGE_BITS-1:0] ppage;
    logic [1:0] mode; //R(00), W(01), X(10) (necessari els modes?)
    logic valid;
} tlb_entry;

tlb_entry [TLB_ENTRIES-1:0] tlb_entries;

//Behavior
//TODO initialize everything to invalid


endmodule