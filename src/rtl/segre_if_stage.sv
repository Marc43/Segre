import segre_pkg::*;

module segre_if_stage (
    // Clock and Reset
    input  logic clk_i,
    input  logic rsn_i,

    // Memory
    input  logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_instr_line_i,
    input  logic mem_ready_i,

    // WB interface
    input logic tkbr_i,
    input logic [WORD_SIZE-1:0] new_pc_i,

    // To/From controller signals
    input logic block_if_i, // Block this stage (flip-flops)
    input logic blocked_1cycle_ago_i,
    input logic inject_nops_i, // Inject NOPs to the following stages
    output logic valid_if_o, // Indicate the next stage if it's processing valid data
    output logic instruction_hit_o,
    output logic mem_rd_o,

    // IF ID interface
    // To flip-flops
    output logic [WORD_SIZE-1:0] instr_o,
    output logic [ADDR_SIZE-1:0] pc_virt_o,
    output logic [ADDR_SIZE-1:0] pc_phys_o,

    // From ID
    input logic [ADDR_SIZE-1:0] pc_i

);

// Cache inputs
memop_data_type_e data_type;
logic rd;
logic wr;
logic is_alu;
logic [WORD_SIZE-1:0] data;

// Cache outputs
logic store_buffer_draining;
logic is_hit;
logic writeback;
logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line;
logic [WORD_SIZE-1:0] instr_to_feed_decode;

assign data_type = WORD;
assign rd = 1'b1;
assign wr = 0;
assign is_alu = 0;
assign data = 0;
assign instruction_hit_o = is_hit;

logic [ADDR_SIZE-1:0] pc;

//TLB intermediate signals
logic tlb_miss;
logic [PHYSICAL_ADDR_SIZE - 1:0] paddr;
logic [ADDR_SIZE-1:0] extended_paddr; //This is total bullshit, but we might save the caches as they are this way

//Extend the physical address to be fed to the cache (don't do this at home kids)
always_comb begin
    extended_paddr = {12'h000, paddr};
end

always_comb begin : pc_mux
    if (!rsn_i) begin
        pc = 0;
    end
    else begin
        if (tkbr_i) begin
            pc = new_pc_i;
        end
        else if (block_if_i || blocked_1cycle_ago_i) begin
            pc = pc;
        end
        else begin
            pc = pc_i + 4;
        end
    end

end

assign valid_if_o = (block_if_i || !rsn_i) ? 1'b0 : 1'b1;


//Submodule instances

//iTLB
segre_itlb itlb(
    //Control
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    //Inputs
    .vaddr_i (pc),
    .ppage_i (not_used),
    .write_enable_i (not_used),

    //Outputs
    .tlb_miss_o (tlb_miss),
    .paddr_o (paddr)
);

//iCACHE
segre_cache
#(
    .ICACHE_DCACHE(ICACHE)
)
instruction_cache
(
    .clk_i(clk_i),
    .rsn_i(rsn_i),

    .rd_i(rd),
    .wr_i(wr),
    .is_alu_i(is_alu),

    .rcvd_mem_request_i(mem_ready_i),
    .data_type_i(data_type),
    .addr_i(extended_paddr),
    .data_i(data),
    .from_mem_cache_line_i(cache_instr_line_i),

    .is_hit_o(is_hit),
    .data_o(instr_to_feed_decode),

    // Unused (conectadas por vicio)
    .writeback_mem_o(writeback),
    .to_mem_cache_line_o(to_mem_cache_line),
    .store_buffer_draining_o(store_buffer_draining)

);

// TODO Rediscover this when we put tkbr
//always_comb begin
//    if (!rsn_i) begin
//        nxt_pc = 0;
//    end
//    //else if (!instruction_hit_o && fsm_state_i == IF_STATE) begin
//    else if (!instruction_hit_o) begin
//        nxt_pc = nxt_pc;
//    end
//    //else if (instruction_hit_o && fsm_state_i == IF_STATE) begin
//    else if (instruction_hit_o) begin
//        nxt_pc = nxt_pc + 4;
//    end
//    else begin
//        //if (tkbr_i && fsm_state_i == WB_STATE) begin
//        if (tkbr_i) begin
//            nxt_pc = new_pc_i;
//        end
//        else begin
//            nxt_pc = nxt_pc;
//        end
//    end
//end

assign mem_rd_o = rd && !is_hit && rsn_i;
assign instr_o = instr_to_feed_decode;
assign pc_virt_o = pc;
assign pc_phys_o = extended_paddr;

endmodule : segre_if_stage
