import segre_pkg::*;

module segre_id_stage (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // FSM State
    input fsm_state_e fsm_state_i,

    // IF and ID stage
    input logic [WORD_SIZE-1:0] instr_i,
    input logic [WORD_SIZE-1:0] pc_i,

    // Register file read operands
    output logic [REG_SIZE-1:0]  rf_raddr_a_o,
    output logic [REG_SIZE-1:0]  rf_raddr_b_o,
    input  logic [WORD_SIZE-1:0] rf_data_a_i,
    input  logic [WORD_SIZE-1:0] rf_data_b_i,

    // ID EX interface
    // ALU
    output alu_opcode_e alu_opcode_o,
    output logic [WORD_SIZE-1:0] alu_src_a_o,
    output logic [WORD_SIZE-1:0] alu_src_b_o,
    // Register file
    output logic rf_we_o,
    output logic [REG_SIZE-1:0] rf_waddr_o,
    // Memop
    output memop_data_type_e memop_type_o,
    output logic memop_sign_ext_o,
    output logic memop_rd_o,
    output logic memop_wr_o,
    output logic [WORD_SIZE-1:0] memop_rf_data_o,
    // Branch | Jump
    output logic [WORD_SIZE-1:0] br_src_a_o,
    output logic [WORD_SIZE-1:0] br_src_b_o,

    // pc + 4
    output logic is_jaljalr_o,
    output logic [ADDR_SIZE-1:0] seq_new_pc_o,

    input logic block_id_i, // Block this stage (flip-flops)
    input logic inject_nops_i, // Inject NOPs to the following stages
    output logic valid_ex_o // Indicate the next stage if it's processing valid data
);

logic [WORD_SIZE-1:0] imm_u_type;
logic [WORD_SIZE-1:0] imm_i_type;
logic [WORD_SIZE-1:0] imm_s_type;
logic [WORD_SIZE-1:0] imm_j_type;
logic [WORD_SIZE-1:0] imm_b_type;
alu_src_a_e src_a_mux_sel;
alu_src_b_e src_b_mux_sel;
alu_imm_a_e a_imm_mux_sel;
alu_imm_b_e b_imm_mux_sel;
br_src_a_e br_a_mux_sel;
br_src_b_e br_b_mux_sel;
logic [WORD_SIZE-1:0] imm_a;
logic [WORD_SIZE-1:0] imm_b;
logic [REG_SIZE-1:0] rf_raddr_a;
logic [REG_SIZE-1:0] rf_raddr_b;
logic [REG_SIZE-1:0] rf_waddr;
logic rf_we;
logic [WORD_SIZE-1:0] alu_src_a;
logic [WORD_SIZE-1:0] alu_src_b;
logic [WORD_SIZE-1:0] br_src_a;
logic [WORD_SIZE-1:0] br_src_b;
memop_data_type_e memop_type;
logic memop_rd;
logic memop_wr;
logic memop_sign_ext;
alu_opcode_e alu_opcode;

// Not in the flip-flop because this comes from the register file.
assign rf_raddr_a_o = rf_raddr_a;
assign rf_raddr_b_o = rf_raddr_b;

segre_decode decode (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    .instr_i          (instr_i),

    // Immediates
    .imm_u_type_o     (imm_u_type),
    .imm_i_type_o     (imm_i_type),
    .imm_s_type_o     (imm_s_type),
    .imm_j_type_o     (imm_j_type),
    .imm_b_type_o     (imm_b_type),

    // ALU
    .alu_opcode_o     (alu_opcode),
    .src_a_mux_sel_o  (src_a_mux_sel),
    .src_b_mux_sel_o  (src_b_mux_sel),
    .a_imm_mux_sel_o  (a_imm_mux_sel),
    .b_imm_mux_sel_o  (b_imm_mux_sel),
    .br_a_mux_sel_o   (br_a_mux_sel),
    .br_b_mux_sel_o   (br_b_mux_sel),

    // Register file
    .raddr_a_o        (rf_raddr_a),
    .raddr_b_o        (rf_raddr_b),
    .waddr_o          (rf_waddr),
    .rf_we_o          (rf_we),

    // Memop
    .memop_type_o     (memop_type),
    .memop_rd_o       (memop_rd),
    .memop_wr_o       (memop_wr),
    .memop_sign_ext_o (memop_sign_ext)
);

// For the moment imm_a will always be 0
assign imm_a = '0;

always_comb begin : alu_imm_b_mux
    unique case(b_imm_mux_sel)
        IMM_B_U: imm_b = imm_u_type;
        IMM_B_I: imm_b = imm_i_type;
        IMM_B_S: imm_b = imm_s_type;
        IMM_B_J: imm_b = imm_j_type;
        IMM_B_B: imm_b = imm_b_type;
        default: ;
    endcase
end

always_comb begin : alu_src_a_mux
    unique case(src_a_mux_sel)
        ALU_A_REG: alu_src_a = rf_data_a_i;
        ALU_A_IMM: alu_src_a = imm_a;
        ALU_A_PC : alu_src_a = pc_i;
        default: ;
    endcase
end

always_comb begin : alu_src_b_mux
    unique case(src_b_mux_sel)
        ALU_B_REG: alu_src_b = rf_data_b_i;
        ALU_B_IMM: alu_src_b = imm_b;
        default: ;
    endcase
end

always_comb begin : br_src_a_mux
    unique case (br_a_mux_sel)
        BR_A_REG: br_src_a = rf_data_a_i;
        BR_A_PC : br_src_a = pc_i;
        default : ;
    endcase
end

always_comb begin : br_src_b_mux
    unique case (br_b_mux_sel)
        BR_B_REG: br_src_b = rf_data_b_i;
        default: ;
    endcase
end

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
logic [WORD_SIZE-1:0] memop_rf_data_d;
logic [ADDR_SIZE-1:0] seq_new_pc_d;
logic is_jaljalr_d;
logic [REG_SIZE-1:0] rf_waddr_d;

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
logic [WORD_SIZE-1:0] memop_rf_data_q;
logic [ADDR_SIZE-1:0] seq_new_pc_q;
logic is_jaljalr_q;
logic [REG_SIZE-1:0] rf_waddr_q;

always_comb begin
    if (!rsn_i) begin
        rf_we_d          = 0;
        memop_rd_d       = 0;
        memop_wr_d       = 0;
        is_jaljalr_d = 0;
    end
    else begin
        if (block_id_i) begin
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
            memop_rf_data_d  = memop_rf_data_q;
            seq_new_pc_d = seq_new_pc_q;
            is_jaljalr_d = is_jaljalr_q;
        end
        else if (inject_nops_i) begin
            rf_we_d          = 0;
            memop_rd_d       = 0;
            memop_wr_d       = 0;
            is_jaljalr_d = 0;
        end
        else begin
            alu_src_a_d      = alu_src_a;
            alu_src_b_d      = alu_src_b;
            rf_we_d          = (fsm_state_i == ID_STATE) ? rf_we : 1'b0;
            rf_waddr_d       = rf_waddr;
            memop_sign_ext_d = memop_sign_ext;
            memop_type_d     = memop_type;
            memop_rd_d       = (fsm_state_i == ID_STATE) ? memop_rd : 1'b0;
            memop_wr_d       = (fsm_state_i == ID_STATE) ? memop_wr : 1'b0;
            br_src_a_d       = br_src_a;
            br_src_b_d       = br_src_b;
            alu_opcode_d     = alu_opcode;
            memop_rf_data_d  = rf_data_b_i;
            seq_new_pc_d = pc_i + 4;
            is_jaljalr_d = (alu_opcode == ALU_JAL) || (alu_opcode == ALU_JALR);
        end
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        rf_we_q          <= 0;
        memop_rd_q       <= 0;
        memop_wr_q       <= 0;
        is_jaljalr_q     <= 0;
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
        memop_rf_data_q  <= memop_rf_data_d;
        seq_new_pc_q <= seq_new_pc_d;
        is_jaljalr_q <= is_jaljalr_d;
    end
end

assign alu_src_a_o = alu_src_a_q;
assign alu_src_b_o = alu_src_b_q;
assign rf_we_o = rf_we_q;
assign rf_waddr_o = rf_waddr_q;
assign memop_sign_ext_o = memop_sign_ext_q;
assign memop_type_o = memop_type_q;
assign memop_rd_o = memop_rd_q;
assign memop_wr_o = memop_wr_q;
assign br_src_a_o = br_src_a_q;
assign br_src_b_o = br_src_b_q;
assign alu_opcode_o = alu_opcode_q;
assign memop_rf_data_o = memop_rf_data_q;
assign seq_new_pc_o = seq_new_pc_q;
assign is_jaljalr_o = is_jaljalr_q;

endmodule
