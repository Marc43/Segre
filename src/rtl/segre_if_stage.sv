import segre_pkg::*;

module segre_if_stage (
    // Clock and Reset
    input  logic clk_i,
    input  logic rsn_i,

    // Memory
    input  logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_instr_line_i,
    input  logic mem_ready_i,
    output logic [ADDR_SIZE-1:0] pc_o,
    output logic mem_rd_o,

    // FSM state
    input fsm_state_e fsm_state_i,

    // IF ID interface
    output logic [WORD_SIZE-1:0] instr_o,

    // WB interface
    input logic tkbr_i,
    input logic [WORD_SIZE-1:0] new_pc_i,

    // To controller signals
    output logic instruction_hit_o
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
assign rd = (fsm_state_i == IF_STATE) ? 1'b1 : 1'b0;
assign wr = 0;
assign is_alu = 0;
assign data = 0;
assign instruction_hit_o = is_hit;

logic [ADDR_SIZE-1:0] nxt_pc;

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
    .addr_i(nxt_pc),
    .data_i(data),
    .from_mem_cache_line_i(cache_instr_line_i),

    .is_hit_o(is_hit),
    .data_o(instr_to_feed_decode),

    // Unused (conectadas por vicio)
    .writeback_mem_o(writeback),
    .to_mem_cache_line_o(to_mem_cache_line),
    .store_buffer_draining_o(store_buffer_draining)

);

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        nxt_pc <= 0;
    end
    else if (!instruction_hit_o && fsm_state_i == IF_STATE) begin
        nxt_pc <= nxt_pc;
    end
    else if (instruction_hit_o && fsm_state_i == IF_STATE) begin
        nxt_pc <= nxt_pc + 4;
    end
    else begin
        if (tkbr_i && fsm_state_i == WB_STATE) begin
            nxt_pc <= new_pc_i;
        end
        else begin
            nxt_pc <= nxt_pc;
        end
    end
end

assign mem_rd_o = rd && !is_hit;

always_ff @(posedge clk_i) begin
    instr_o <= (is_hit && (fsm_state_i == IF_STATE)) ? instr_to_feed_decode : NOP_INSTR;
    pc_o    <= nxt_pc;
end

endmodule : segre_if_stage
