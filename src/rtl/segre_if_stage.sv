import segre_pkg::*;

module segre_if_stage (
    // Clock and Reset
    input  logic clk_i,
    input  logic rsn_i,

    input logic blocked_id_1cycle_ago_i,
    input logic block_id_i,

    // Memory
    input  logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_instr_line_i,
    input  logic mem_ready_i,

    output logic [ADDR_SIZE-1:0] mem_addr_o,

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
    output logic [ADDR_SIZE-1:0] pc_o,

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

logic tkbr_latch;

always @(posedge clk_i) begin
    if (!rsn_i) begin
        tkbr_latch = 0;
    end
    else begin
        if (tkbr_i) begin
            tkbr_latch <= tkbr_i;
        end
        else if (!block_if_i || !blocked_1cycle_ago_i) begin
            tkbr_latch <= 0;
        end
    end
end

logic [ADDR_SIZE-1:0] pc;

always_comb begin : pc_mux
    if (!rsn_i) begin
        pc = 32'h0;
    end
    else begin
        if (tkbr_i) begin
            pc = new_pc_i;
        end
        else if (block_if_i) begin // || blocked_1cycle_ago_i) begin
            pc = pc_i;
        end
        else if (tkbr_latch) begin
            pc = pc_i;
        end
        else begin
            pc = pc_i + 4;
        end
    end

end

assign valid_if_o = (block_if_i || !rsn_i) ? 1'b0 : 1'b1;

logic [ADDR_SIZE-1:0] pc_cache;

always_comb begin
    if (!rsn_i) begin
        pc_cache = 0;
    end
    else begin
        if (tkbr_i) begin
            pc_cache = new_pc_i;
        end
        else if (tkbr_latch && blocked_1cycle_ago_i) begin
            pc_cache = pc_i;
        end
        // lmao poner recuerdo salto
//        else if (blocked_1cycle_ago_i) begin
//            pc_cache = pc_i;
//        end
        else begin
            pc_cache = pc_i + 4;
        end
    end
end

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
    .addr_i(pc_cache),
    .data_i(data),
    .from_mem_cache_line_i(cache_instr_line_i),

    .is_hit_o(is_hit),
    .data_o(instr_to_feed_decode),

    // Unused (conectadas por vicio)
    .writeback_mem_o(writeback),
    .to_mem_cache_line_o(to_mem_cache_line),
    .store_buffer_draining_o(store_buffer_draining)

);

assign mem_rd_o = rd && !is_hit && rsn_i;
assign instr_o = instr_to_feed_decode;
assign pc_o = pc;
assign mem_addr_o = pc_cache;

endmodule : segre_if_stage
