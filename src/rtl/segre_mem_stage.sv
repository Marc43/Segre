import segre_pkg::*;

module segre_mem_stage (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // To logic
    output logic cache_is_busy_o,
    output logic cache_is_hit_o,

    // Memory
    input  logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line_i,
    input  logic mem_ready_i,
    output logic [WORD_SIZE-1:0] addr_o,
    output logic memop_rd_o,
    output logic memop_wr_o,
    output memop_data_type_e memop_type_o,
    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line_o,

    // EX MEM interface
    // ALU
    input logic [WORD_SIZE-1:0] alu_res_i,

    // Register file
    input logic rf_we_i,
    input logic [REG_SIZE-1:0] rf_waddr_i,
    input logic [WORD_SIZE-1:0] rf_st_data_i,

    // Memop
    input memop_data_type_e memop_type_i,
    input logic memop_sign_ext_i,
    input logic memop_rd_i,
    input logic memop_wr_i,

    // Branch | Jal
    input logic tkbr_i,
    input logic [WORD_SIZE-1:0] new_pc_i,

    // MEM WB interface
    output logic [WORD_SIZE-1:0] op_res_o,

    // Register file
    output logic rf_we_o,
    output logic [REG_SIZE-1:0] rf_waddr_o,

    // Branch | Jal
    output logic tkbr_o,
    output logic [WORD_SIZE-1:0] new_pc_o
);

logic [WORD_SIZE-1:0] read_cache_data;
logic [WORD_SIZE-1:0] processed_read_cache_data;

always_comb begin
    if (memop_sign_ext_i) begin
        unique case(memop_type_i)
            BYTE: processed_read_cache_data = { {24{read_cache_data[7]}}, read_cache_data[7:0] };
            HALF: processed_read_cache_data = { {16{read_cache_data[15]}}, read_cache_data[15:0] };
            WORD: processed_read_cache_data = read_cache_data[WORD_SIZE-1:0];
            default: processed_read_cache_data = read_cache_data[WORD_SIZE-1:0];
        endcase
    end
    else begin
        unique case(memop_type_i)
            BYTE: processed_read_cache_data = { {24{1'b0}}, read_cache_data[7:0] };
            HALF: processed_read_cache_data = { {16{1'b0}}, read_cache_data[15:0] };
            WORD: processed_read_cache_data = read_cache_data[WORD_SIZE-1:0];
            default: processed_read_cache_data = read_cache_data[WORD_SIZE-1:0];
        endcase
    end
end

logic is_alu;
assign is_alu = !memop_wr_i && !memop_rd_i;

// TODO Some changes must be done in near future
// - send draining to logic in order to stall pipeline

logic is_hit;
logic is_busy;
logic cache_read_data;
logic writeback;
logic store_buffer_draining;
logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line;

segre_cache
#(
    .ICACHE_DCACHE(DCACHE)
)
data_cache
(

    .clk_i (clk_i),
    .rsn_i (rsn_i),

    .rd_i (memop_rd_i),
    .wr_i (memop_wr_i),
    .is_alu_i (is_alu),

    .rcvd_mem_request_i (mem_ready_i),
    .data_type_i (memop_type_i),
    .addr_i (alu_res_i), // Address is calculated in the previous stage (ALU)
    .data_i (rf_st_data_i), // Data to store comes from the register file
    .from_mem_cache_line_i (cache_line_i),

    .is_hit_o (is_hit),
    .is_busy_o (is_busy),
    .data_o (read_cache_data),

    .writeback_mem_o (writeback),
    .to_mem_cache_line_o (to_mem_cache_line),
    .store_buffer_draining_o (store_buffer_draining)

);

// To logic/memory signals

assign writeback_mem_o = writeback;
assign to_mem_cache_line_o = to_mem_cache_line;
assign cache_is_busy_o = is_busy;
assign cache_is_hit_o = is_hit;

// It is a load or a missed store, both cases require a read from main memory
assign memop_rd_o   = (memop_wr_i || memop_rd_i) && !is_hit;
// This also requires a stall TODO
assign memop_wr_o   = writeback;
assign addr_o       = alu_res_i;
assign memop_type_o = memop_type_i;

// ------

always_ff @(posedge clk_i) begin

    // To WB
    op_res_o   = memop_rd_i ? processed_read_cache_data : alu_res_i; // Load case : Bypassing ALU result case
    rf_we_o    = rf_we_i;
    rf_waddr_o = rf_waddr_i;
    tkbr_o     = tkbr_i;
    new_pc_o   = new_pc_i;

end

endmodule
