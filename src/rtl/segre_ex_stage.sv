import segre_pkg::*;

module segre_ex_stage (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // ID EX interface
    // ALU
    input alu_opcode_e alu_opcode_i,
    input logic [WORD_SIZE-1:0] alu_src_a_i,
    input logic [WORD_SIZE-1:0] alu_src_b_i,
    // Register file
    input logic rf_we_i,
    input logic [REG_SIZE-1:0] rf_waddr_i,
    input logic [WORD_SIZE-1:0] rf_st_data_i,
    // Memop
    input memop_data_type_e memop_type_i,
    input logic memop_rd_i,
    input logic memop_wr_i,
    input logic memop_sign_ext_i,
    // Branch | Jal
    input logic [WORD_SIZE-1:0] br_src_a_i,
    input logic [WORD_SIZE-1:0] br_src_b_i,

    // EX MEM interface
    // ALU
    output logic [WORD_SIZE-1:0] alu_res_o,
    // Register file
    output logic rf_we_o,
    output logic [REG_SIZE-1:0] rf_waddr_o,
    output logic [WORD_SIZE-1:0] rf_st_data_o,
    // Memop
    output memop_data_type_e memop_type_o,
    output logic memop_rd_o,
    output logic memop_wr_o,
    output logic memop_sign_ext_o,

    // Tkbr
    // TODO Connect this somewhere, must empty the instructions between FETCH, DECODE
    output logic tkbr_o,
    output logic [ADDR_SIZE-1:0] new_pc_o,

    // pc + 4
    input logic [ADDR_SIZE-1:0] seq_new_pc_i,
    output logic [ADDR_SIZE-1:0] seq_new_pc_o,
    input logic is_jaljalr_i,
    output logic is_jaljalr_o,

    input logic block_ex_i, // Block this stage (flip-flops)
    input logic inject_nops_i, // Inject NOPs to the following stages
    output logic valid_mem_o // Indicate the next stage if it's processing valid data

);

logic [WORD_SIZE-1:0] alu_res;
logic tkbr;

segre_alu alu (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    .alu_opcode_i (alu_opcode_i),
    .alu_src_a_i  (alu_src_a_i),
    .alu_src_b_i  (alu_src_b_i),

    .alu_res_o (alu_res)
);

segre_tkbr trbr (
    .br_src_a_i   (br_src_a_i),
    .br_src_b_i   (br_src_b_i),
    .alu_opcode_i (alu_opcode_i),
    .tkbr_o       (tkbr)
);

logic [WORD_SIZE-1:0] alu_res_d;
logic rf_we_d;
logic [REG_SIZE-1:0] rf_waddr_d;
logic [WORD_SIZE-1:0] rf_st_data_d;
memop_data_type_e memop_type_d;
logic memop_rd_d;
logic memop_wr_d;
logic memop_sign_ext_d;
logic [ADDR_SIZE-1:0] new_pc_d;
logic is_jaljalr_d;
logic [ADDR_SIZE-1:0] seq_new_pc_d;

logic [WORD_SIZE-1:0] alu_res_q;
logic rf_we_q;
logic [REG_SIZE-1:0] rf_waddr_q;
logic [WORD_SIZE-1:0] rf_st_data_q;
memop_data_type_e memop_type_q;
logic memop_rd_q;
logic memop_wr_q;
logic memop_sign_ext_q;
logic [ADDR_SIZE-1:0] new_pc_q;
logic is_jaljalr_q;
logic [ADDR_SIZE-1:0] seq_new_pc_q;

always_comb begin
    if (!rsn_i) begin
        rf_we_d    = 0;
        memop_rd_d = 0;
        memop_wr_d = 0;
    end
    else begin
        if (block_ex_i) begin
            alu_res_d   = alu_res_q;
            rf_we_d     = rf_we_q;
            rf_waddr_d  = rf_waddr_q;
            rf_st_data_d = rf_st_data_q;
            memop_type_d = memop_type_q;
            memop_rd_d  = memop_rd_q;
            memop_wr_d  = memop_wr_q;
            memop_sign_ext_d = memop_sign_ext_q;
            new_pc_d     = new_pc_q;
            seq_new_pc_d = seq_new_pc_q;
            is_jaljalr_d = is_jaljalr_q;
        end
        else if (inject_nops_i) begin
            rf_we_d    = 0;
            memop_rd_d = 0;
            memop_wr_d = 0;
        end
        else begin
            alu_res_d        = (alu_opcode_i == ALU_JAL) ? br_src_a_i : alu_res;
            rf_we_d          = rf_we_i;
            rf_waddr_d       = rf_waddr_i;
            rf_st_data_d     = rf_st_data_i;
            memop_type_d     = memop_type_i;
            memop_rd_d       = memop_rd_i;
            memop_wr_d       = memop_wr_i;
            memop_sign_ext_d = memop_sign_ext_i;
            new_pc_d         = alu_res;
            seq_new_pc_d     = seq_new_pc_i;
            is_jaljalr_d     = is_jaljalr_i;
        end
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        rf_we_q <= 0;
        memop_rd_q <= 0;
        memop_wr_q <= 0;
    end
    else begin
        ////// This must be routed to IF stage at some point and to the logic...
        tkbr_o <= tkbr;
        ///////
        alu_res_q   <= alu_res_d;
        rf_we_q     <= rf_we_d;
        rf_waddr_q  <= rf_waddr_d;
        rf_st_data_q <= rf_st_data_d;
        memop_type_q <= memop_type_d;
        memop_rd_q  <= memop_rd_d;
        memop_wr_q  <= memop_wr_d;
        memop_sign_ext_q <= memop_sign_ext_d;
        new_pc_q     <= new_pc_d;
        seq_new_pc_q <= seq_new_pc_d;
        is_jaljalr_q <= is_jaljalr_d;
    end
end

assign alu_res_o   = alu_res_q;
assign rf_we_o     = rf_we_q;
assign rf_waddr_o  = rf_waddr_q;
assign rf_st_data_o = rf_st_data_q;
assign memop_type_o = memop_type_q;
assign memop_rd_o  = memop_rd_q;
assign memop_wr_o  = memop_wr_q;
assign memop_sign_ext_o = memop_sign_ext_q;
assign new_pc_o     = new_pc_q;
assign seq_new_pc_o = seq_new_pc_q;
assign is_jaljalr_o = is_jaljalr_q;

endmodule : segre_ex_stage
