import segre_pkg::*;

//4KB pages, 32 entries, direct mapping
//Virtual address -> 32 bits
//Physical address -> 20 bits
//12 first bits of virtual address used as page offset, the rest are used as page number

//Dissection of a given input virtual address is...
// ---------------------------------------------------------------------------
// |                VPage bits(20b)            |||||||   Page Offset(12b)    |
// |31---------------------------------------12|||||||11--------------------0|
// |31---------------------------17|16-------12|||||||                       |
// |          TAG(15b)             | INDEX(5b) |||||||                       |
// ---------------------------------------------------------------------------


//---------------------------------------------------//
//--------------MODULE DEFINITION--------------------//
//---------------------------------------------------//

module segre_dtlb (
    //CONTROL
    input logic clock_i,
    input logic rsn_i,
    
    //IN
    //Virtual address
    input logic [WORD_SIZE - 1:0] vaddr_i,
    //Physical address (when we have a miss we need to fetch the traduction somehow)
    input logic [PHYSICAL_ADDR_SIZE - 1:0] paddr_i;

    //OUT
    output logic tlb_miss_o,
    output logic [PHYSICAL_ADDR_SIZE - 1:0] paddr_o
    //TO FILL maybe
);



//-----------------------------------------------------//
//----------INTERNAL STRUCTURE AND VARIABLES-----------//
//-----------------------------------------------------//

//Components of TLB
typedef struct packed{
    logic [VIRT_PAGE_BITS - 1:0] vpage;
    logic [PHYS_PAGE_BITS - 1:0] ppage;
    logic [1:0] mode; //R(00), W(01), RW(10), X(11) (necessari els modes?)
    logic valid;
} tlb_entry;
tlb_entry [TLB_ENTRIES] tlb_entries;

//Auxiliar vars
//TLB index/tag/offsset generated from vaddr_i
logic [TLB_ENTRY_BITS - 1:0] vaddr_i_index; 
logic [TLB_TAG_BITS - 1:0] vaddr_i_tag;
logic [PAGE_OFFSET_BITS - 1:0] vaddr_i_offset;



//-----------------------------------------------------//
//--------------------BEHAVIOR-------------------------//
//-----------------------------------------------------//

//Initialize full TLB as invalid
always_ff @(posedge clk_i, negedge rsn_i) begin
    if(!rsn_i) begin
        //This for might be overkill, but I wasn't sure that assigning 0 YOLO-style would work with a struct array
        for(int i =  0; i <= TLB_ENTRIES-1 ; i++) begin
            tlb_entries[i].valid <= 1'b0;
        end
    end
end

//Generate TLB index/tag from vaddr_i
always_comb begin
    vaddr_i_index = vaddr_i[WORD_SIZE - TLB_TAG_BITS - 1:PAGE_OFFSET_BITS];
    vaddr_i_tag = vaddr_i[WORD_SIZE - 1:TLB_TAG_BITS + PAGE_OFFSET_BITS];
    vaddr_i_offset = vaddr_i[PAGE_OFFSET_BITS - 1:0];
end

//Detect HIT/MISS
//If HIT -> puke out physical address
//If MISS -> puke out tlb_miss_o = 1, maybe jam execution until "resolved"? 
//              -> NO, WE DON'T JAM SHIT BECAUSE I'VE BEEN LIED TO, just propagate the miss down the pipeline until it hits WB stage
if (tlb_entries[vaddr_i_index].valid 
    && vaddr_i_tag == tlb_entries[vaddr_i_index].vpage[VIRT_PAGE_BITS - 1: TLB_ENTRY_BITS]) begin
    assign tlb_miss_o = 0;
    assign paddr_o = {tlb_entries[vaddr_i_index].ppage, vaddr_i_offset;
end
else begin
    assign tlb_miss_o = 1;
    assign paddr_o = 12'b101010101010; //Doesn't matter but at least we can identify this case while debugging
end

endmodule