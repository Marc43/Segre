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
    input logic clk_i,
    input logic rsn_i,

    //IN
    //Virtual address
    input logic [WORD_SIZE - 1:0] vaddr_i,
    //Physical page (when we have a miss we need to fetch the traduction somehow)
    input logic [PHYSICAL_ADDR_SIZE - 1:0] ppage_i,
    input logic write_enable_i,

    //OUT
    output logic tlb_miss_o,
    output logic [PHYSICAL_ADDR_SIZE - 1:0] paddr_o
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

//Intermediate signals
logic tlb_miss;

//-----------------------------------------------------//
//--------------------BEHAVIOR-------------------------//
//-----------------------------------------------------//

always_comb begin
    //Detect HIT/MISS
    tlb_miss = tlb_entries[vaddr_i_index].valid && vaddr_i_tag == tlb_entries[vaddr_i_index].vpage[VIRT_PAGE_BITS - 1: TLB_ENTRY_BITS] ? 0 : 1;

    //Generate TLB index/tag from vaddr_i
    vaddr_i_index = vaddr_i[WORD_SIZE - TLB_TAG_BITS - 1:PAGE_OFFSET_BITS];
    vaddr_i_tag = vaddr_i[WORD_SIZE - 1:TLB_TAG_BITS + PAGE_OFFSET_BITS];
    vaddr_i_offset = vaddr_i[PAGE_OFFSET_BITS - 1:0];
end

always_ff @(posedge clk_i, negedge rsn_i) begin
    //Initialize full TLB
    if(!rsn_i) begin
        for(int i =  0; i < TLB_ENTRIES ; i++) begin
            tlb_entries[i].valid <= 1'b0;
        end
    end

    else begin
        //Miss handling, it should produce an exception and then call the OS
        //but we will just do the conversion+allocation here for the time being
        if (tlb_miss) begin
            tlb_entries[vaddr_i_index].valid = 1'b1;
            tlb_entries[vaddr_i_index].vpage = vaddr_i[WORD_SIZE - 1 : VIRT_PAGE_BITS];
            tlb_entries[vaddr_i_index].ppage = tlb_entries[vaddr_i_index].vpage[PHYS_PAGE_BITS - 1 : 0] + 8'h08;
        end
    end
end

//Write new translation into TLB if we see a write_enable (this is absolutely theoretical and probably wrong)
//NOT USED UNTIL EXCEPTIONS WORKING
//always_ff @(posedge clk_i, negedge rsn_i) begin
//    if (write_enable_i) begin
//        tlb_entries[vaddr_i_index].ppage <= ppage_i;
//        tlb_entries[vaddr_i_index].vpage <= {vaddr_i_tag, vaddr_i_index};
//        tlb_entries[vaddr_i_index].valid <= 1;
//    end
//end

assign tlb_miss_o = tlb_miss;
assign paddr_o = {tlb_entries[vaddr_i_index].ppage, vaddr_i_offset};

endmodule
