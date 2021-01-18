import segre_pkg::*;

module segre_ex_stage (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    input logic valid_id_i,

    input logic finish_test_i,

    // Bypasses
    input bypass_ex_sel_e mux_sel_load_i,
    input bypass_ex_sel_e mux_sel_a_i,
    input bypass_ex_sel_e mux_sel_b_i,

    input logic [WORD_SIZE-1:0] op_res_stage_mem_i,
    input logic [WORD_SIZE-1:0] op_res_stage_wb_i,
    input logic [WORD_SIZE-1:0] op_res_stage_m5_i,

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
    output logic tkbr_o,
    output logic [ADDR_SIZE-1:0] new_pc_o,

    // pc + 4
    input logic [ADDR_SIZE-1:0] pc_i,
    output logic [ADDR_SIZE-1:0] seq_new_pc_o,
    input logic is_jaljalr_i,
    output logic is_jaljalr_o,

    input logic block_ex_i, // Block this stage (flip-flops)
    input logic inject_nops_i, // Inject NOPs to the following stages
    output logic valid_ex_o, // Indicate the next stage if it's processing valid data

    output logic is_load_o, // Goes to ctrl

    input logic prod_data_stage_ex_i,
    input logic prod_data_stage_mem_i,

    output logic prod_data_stage_ex_o,
    output logic prod_data_stage_mem_o,

    output logic data_produced_ex_o,

    output logic finish_test_o

);

logic [WORD_SIZE-1:0] alu_res;
logic tkbr;

logic [WORD_SIZE-1:0] alu_src_a_d;
logic [WORD_SIZE-1:0] alu_src_b_d;
logic rf_we_d;
logic memop_sign_ext_d;
memop_data_type_e memop_type_d;
logic memop_rd_d;
logic memop_wr_d;
alu_opcode_e alu_opcode_d;
logic [WORD_SIZE-1:0] br_src_a_d;
logic [WORD_SIZE-1:0] br_src_b_d;
logic [ADDR_SIZE-1:0] seq_new_pc_d;
logic is_jaljalr_d;
logic [REG_SIZE-1:0] rf_waddr_d;
logic [WORD_SIZE-1:0] rf_st_data_d;
logic valid_ex_d;
logic finish_test_d;
logic prod_data_stage_ex_d;
logic prod_data_stage_mem_d;
bypass_ex_sel_e mux_sel_load_d;
bypass_ex_sel_e mux_sel_a_d;
bypass_ex_sel_e mux_sel_b_d;

logic [WORD_SIZE-1:0] alu_src_a_q;
logic [WORD_SIZE-1:0] alu_src_b_q;
logic rf_we_q;
logic memop_sign_ext_q;
memop_data_type_e memop_type_q;
logic memop_rd_q;
logic memop_wr_q;
alu_opcode_e alu_opcode_q;
logic [WORD_SIZE-1:0] br_src_a_q;
logic [WORD_SIZE-1:0] br_src_b_q;
logic [ADDR_SIZE-1:0] seq_new_pc_q;
logic is_jaljalr_q;
logic [REG_SIZE-1:0] rf_waddr_q;
logic [WORD_SIZE-1:0] rf_st_data_q;
logic valid_ex_q;
logic finish_test_q;
logic prod_data_stage_ex_q;
logic prod_data_stage_mem_q;
bypass_ex_sel_e mux_sel_load_q;
bypass_ex_sel_e mux_sel_a_q;
bypass_ex_sel_e mux_sel_b_q;

logic [WORD_SIZE-1:0] muxed_store_data;
logic [WORD_SIZE-1:0] muxed_src_a;
logic [WORD_SIZE-1:0] muxed_src_b;

always_comb begin : decoupling_register_ID_EX_1
    if (!rsn_i) begin
        rf_we_d          = 0;
        memop_rd_d       = 0;
        memop_wr_d       = 0;
        is_jaljalr_d = 0;
        valid_ex_d = 0;
        finish_test_d = 0;
        prod_data_stage_ex_d = 0;
        prod_data_stage_mem_d = 0;
        mux_sel_load_d = NO_BYPASS;
        mux_sel_a_d = NO_BYPASS;
        mux_sel_b_d = NO_BYPASS;
    end
    else begin
        if (block_ex_i) begin
            alu_src_a_d      = alu_src_a_q;
            alu_src_b_d      = alu_src_b_q;
            rf_we_d          = rf_we_q;
            rf_waddr_d       = rf_waddr_q;
            memop_sign_ext_d = memop_sign_ext_q;
            memop_type_d     = memop_type_q;
            memop_rd_d       = memop_rd_q;
            memop_wr_d       = memop_wr_q;
            br_src_a_d       = br_src_a_q;
            br_src_b_d       = br_src_b_q;
            alu_opcode_d     = alu_opcode_q;
            seq_new_pc_d = seq_new_pc_q;
            is_jaljalr_d = is_jaljalr_q;
            rf_st_data_d = rf_st_data_q;
            valid_ex_d = valid_ex_q;
            finish_test_d = finish_test_q;
            prod_data_stage_ex_d = prod_data_stage_ex_q;
            prod_data_stage_mem_d = prod_data_stage_mem_q;
            mux_sel_load_d = mux_sel_load_q;
            mux_sel_a_d = mux_sel_a_q;
            mux_sel_b_d = mux_sel_b_q;
        end
        else if (inject_nops_i) begin
            rf_we_d          = 0;
            memop_rd_d       = 0;
            memop_wr_d       = 0;
            is_jaljalr_d = 0;
            valid_ex_d = 0;
            finish_test_d = 0;
            alu_opcode_d = ALU_ADD;
            prod_data_stage_ex_d = 0;
            prod_data_stage_mem_d = 0;
        end
        else begin
            alu_src_a_d      = alu_src_a_i;
            alu_src_b_d      = alu_src_b_i;
            rf_we_d          = rf_we_i;
            rf_waddr_d       = rf_waddr_i;
            memop_sign_ext_d = memop_sign_ext_i;
            memop_type_d     = memop_type_i;
            memop_rd_d       = memop_rd_i;
            memop_wr_d       = memop_wr_i;
            br_src_a_d       = br_src_a_i;
            br_src_b_d       = br_src_b_i;
            alu_opcode_d     = alu_opcode_i;
            seq_new_pc_d = pc_i + 4;
            is_jaljalr_d = is_jaljalr_i;
            rf_st_data_d = rf_st_data_i;
            valid_ex_d = valid_id_i;
            finish_test_d = finish_test_i;
            prod_data_stage_ex_d = prod_data_stage_ex_i;
            prod_data_stage_mem_d = prod_data_stage_mem_i;
            mux_sel_load_d = mux_sel_load_i;
            mux_sel_a_d = mux_sel_a_i;
            mux_sel_b_d = mux_sel_b_i;
        end
    end
end

always_ff @(posedge clk_i) begin : decoupling_register_ID_EX_2
    if (!rsn_i) begin
        rf_we_q          <= 0;
        memop_rd_q       <= 0;
        memop_wr_q       <= 0;
        is_jaljalr_q     <= 0;
        valid_ex_q <= 0;
        finish_test_q <= 0;
        prod_data_stage_ex_q <= 0;
        prod_data_stage_mem_q <= 0;
        mux_sel_load_q <= NO_BYPASS;
        mux_sel_a_q <= NO_BYPASS;
        mux_sel_b_q <= NO_BYPASS;
    end
    else begin
        alu_src_a_q      <= alu_src_a_d;
        alu_src_b_q      <= alu_src_b_d;
        rf_we_q          <= rf_we_d;
        rf_waddr_q       <= rf_waddr_d;
        memop_sign_ext_q <= memop_sign_ext_d;
        memop_type_q     <= memop_type_d;
        memop_rd_q       <= memop_rd_d;
        memop_wr_q       <= memop_wr_d;
        br_src_a_q       <= br_src_a_d;
        br_src_b_q       <= br_src_b_d;
        alu_opcode_q     <= alu_opcode_d;
        seq_new_pc_q <= seq_new_pc_d;
        is_jaljalr_q <= is_jaljalr_d;
        valid_ex_q <= valid_ex_d;
        rf_st_data_q <= rf_st_data_d;
        finish_test_q <= finish_test_d;
        prod_data_stage_ex_q <= prod_data_stage_ex_d;
        prod_data_stage_mem_q <= prod_data_stage_mem_d;
        mux_sel_load_q <= mux_sel_load_d;
        mux_sel_a_q <= mux_sel_a_d;
        mux_sel_b_q <= mux_sel_b_d;
    end
end

segre_alu alu (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    .alu_opcode_i (alu_opcode_q),
    .alu_src_a_i  (muxed_src_a),
    .alu_src_b_i  (muxed_src_b),

    .alu_res_o (alu_res)
);

logic [WORD_SIZE-1:0] muxed_br_src_a;
logic [WORD_SIZE-1:0] muxed_br_src_b;

segre_tkbr trbr (
    .br_src_a_i   (muxed_br_src_a),
    .br_src_b_i   (muxed_br_src_b),
    .alu_opcode_i (alu_opcode_q),
    .tkbr_o       (tkbr)
);

// Bypasses

always_comb begin : LOAD_BYPASS
    if (!rsn_i) begin
        muxed_store_data = rf_st_data_q;
    end
    else begin
        case (mux_sel_load_q)
            NO_BYPASS: begin
                muxed_store_data = rf_st_data_q;
            end
            MEM_BYPASS: begin
                muxed_store_data = op_res_stage_mem_i;
            end
            WB_BYPASS: begin
                muxed_store_data = op_res_stage_wb_i;
            end
            default: begin
                muxed_store_data = rf_st_data_q;
            end
        endcase
    end
end

always_comb begin : SRC_A_BYPASS
    if (!rsn_i) begin
        muxed_src_a = alu_src_a_q;
    end
    else begin
        case (mux_sel_a_q)
            NO_BYPASS: begin
                muxed_src_a = alu_src_a_q;
            end
            MEM_BYPASS: begin
                muxed_src_a = op_res_stage_mem_i;
            end
            WB_BYPASS: begin
                muxed_src_a = op_res_stage_wb_i;
            end
            MUL_M5_BYPASS: begin
                muxed_src_a = op_res_stage_m5_i;
            end
            default: begin
                muxed_src_a = alu_src_a_q;
            end
        endcase
    end
end

always_comb begin : SRC_B_BYPASS
    if (!rsn_i) begin
        muxed_src_b = alu_src_b_q;
    end
    else begin
        case (mux_sel_b_q)
            NO_BYPASS: begin
                muxed_src_b = alu_src_b_q;
            end
            MEM_BYPASS: begin
                muxed_src_b = op_res_stage_mem_i;
            end
            WB_BYPASS: begin
                muxed_src_b = op_res_stage_wb_i;
            end
            MUL_M5_BYPASS: begin
                muxed_src_b = op_res_stage_m5_i;
            end
            default: begin
                muxed_src_b = alu_src_b_q;
            end
        endcase
    end
end

always_comb begin : BR_SRC_A_BYPASS
    if (!rsn_i) begin
        muxed_br_src_a = br_src_a_q;
    end
    else begin
        case (mux_sel_a_q)
            NO_BYPASS: begin
                muxed_br_src_a = br_src_a_q;
            end
            MEM_BYPASS: begin
                muxed_br_src_a = op_res_stage_mem_i;
            end
            WB_BYPASS: begin
                muxed_br_src_a = op_res_stage_wb_i;
            end
            MUL_M5_BYPASS: begin
                muxed_br_src_a = op_res_stage_m5_i;
            end
            default: begin
                muxed_br_src_a = br_src_a_q;
            end
        endcase
    end
end

always_comb begin : BR_SRC_B_BYPASS
    if (!rsn_i) begin
        muxed_br_src_b = br_src_b_q;
    end
    else begin
        case (mux_sel_b_q)
            NO_BYPASS: begin
                muxed_br_src_b = br_src_b_q;
            end
            MEM_BYPASS: begin
                muxed_br_src_b = op_res_stage_mem_i;
            end
            WB_BYPASS: begin
                muxed_br_src_b = op_res_stage_wb_i;
            end
            MUL_M5_BYPASS: begin
                muxed_br_src_b = op_res_stage_m5_i;
            end
            default: begin
                muxed_br_src_b = br_src_b_q;
            end
        endcase
    end
end

assign alu_res_o   = (alu_opcode_q == ALU_JAL) ? br_src_a_q : alu_res;
assign rf_we_o     = rf_we_q;
assign rf_waddr_o  = rf_waddr_q;
assign rf_st_data_o = muxed_store_data;
assign memop_type_o = memop_type_q;
assign memop_rd_o  = memop_rd_q;
assign memop_wr_o  = memop_wr_q;
assign memop_sign_ext_o = memop_sign_ext_q;
assign seq_new_pc_o = seq_new_pc_q;
assign is_jaljalr_o = is_jaljalr_q;
assign valid_ex_o = valid_ex_q;

assign tkbr_o = tkbr;
assign new_pc_o     = alu_res;

assign finish_test_o = finish_test_q;

assign prod_data_stage_ex_o = prod_data_stage_ex_q;
assign prod_data_stage_mem_o = prod_data_stage_mem_q;

assign data_produced_ex_o = prod_data_stage_ex_q;

assign is_load_o = memop_rd_q;

endmodule : segre_ex_stage
