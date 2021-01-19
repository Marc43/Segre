import segre_pkg::*;

module segre_id_stage (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // Bypass data
    input logic [WORD_SIZE-1:0] ex_rd_data_i,
    input logic [WORD_SIZE-1:0] mem_rd_data_i,
    input logic [WORD_SIZE-1:0] wb_rd_data_i,
    input logic [WORD_SIZE-1:0] m5_rd_data_i,

    // Bypass sel
    input bypass_id_sel_e mux_sel_a_id_i,
    input bypass_id_sel_e mux_sel_b_id_i,

    // IF and ID stage
    input logic [WORD_SIZE-1:0] instr_i,
    input logic [WORD_SIZE-1:0] pc_i,
    input logic valid_if_i,

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

    output logic [ADDR_SIZE-1:0] pc_o,

    // pc + 4
    output logic is_jaljalr_o,

    // To controller

    input logic block_id_i, // Block this stage (flip-flops)
    input logic inject_nops_i, // Inject NOPs to the following stages
    output logic valid_id_o, // Indicate the next stage if it's processing valid data
    output logic blocked_1cycle_ago_o,

    // Signals needed to detect hazards

    output logic [REG_SIZE-1:0] src_a_identifier_o,
    output logic [REG_SIZE-1:0] src_b_identifier_o,

    output logic rd_raddr_a_o,
    output logic rd_raddr_b_o,

    // Bypasses
    // Basically, this means that it produces the data in stage EX or stage MEM
    output logic prod_data_stage_ex_o,
    output logic prod_data_stage_mem_o,

    // To detect the end of the test

    output logic [WORD_SIZE-1:0] instr_id_o,
    output logic finish_test_o,

    // To pipeline M ext

    output logic valid_m1_o,
    output m_ext_opcode_e m1_opcode_o,
    output logic m1_rf_we_o,
    output [REG_SIZE-1:0] m1_rf_waddr_o,
    output [WORD_SIZE-1:0] m1_rf_src_a_o,
    output [WORD_SIZE-1:0] m1_rf_src_b_o

);

m_ext_opcode_e m1_opcode;

logic prod_data_stage_ex;
logic prod_data_stage_mem;

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

logic [WORD_SIZE-1:0] instr_d;
logic [ADDR_SIZE-1:0] pc_d;
logic prod_data_stage_ex_d;
logic prod_data_stage_mem_d;
logic blocked_1cycle_ago_d;


logic [WORD_SIZE-1:0] instr_q;
logic [ADDR_SIZE-1:0] pc_q;
logic prod_data_stage_ex_q;
logic prod_data_stage_mem_q;
logic blocked_1cycle_ago_q;

// TODO FINISH CONNECTING PROD_DATA SIGNALS TO REGISTERS AND SO

logic valid_id_d;
logic valid_id_q;

always_comb begin : decoupling_register_F_ID_1
    if (!rsn_i) begin
        instr_d = NOP_INSTR;
        pc_d    = 32'hfffffffc;
        valid_id_d = 0;
        blocked_1cycle_ago_d = 0;
    end
    else begin
        if (inject_nops_i) begin
            instr_d = NOP_INSTR;
            pc_d    = pc_i;
            valid_id_d = 0;
        end
        else if (block_id_i) begin
            instr_d = instr_q;
            pc_d = pc_q;
            valid_id_d = valid_id_q;
        end
        else begin
            instr_d = instr_i;
            pc_d = pc_i;
            valid_id_d = valid_if_i;
        end

        blocked_1cycle_ago_d = block_id_i;
    end
end

always_ff @(posedge clk_i) begin : decoupling_register_F_ID_2
    if (!rsn_i) begin
        instr_q <= NOP_INSTR;
        pc_q    <= 32'hfffffffc;
        valid_id_q <= 0;
    end
    else begin
        instr_q <= instr_d;
        pc_q <= pc_d;
        valid_id_q <= valid_id_d;
        blocked_1cycle_ago_q <= blocked_1cycle_ago_d;
    end
end

assign blocked_1cycle_ago_o = blocked_1cycle_ago_q;

logic is_M_ext_instr;

segre_decode decode (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    .instr_i          (instr_q),

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

    .rd_raddr_a_o (rd_raddr_a_o),
    .rd_raddr_b_o (rd_raddr_b_o),

    // Memop
    .memop_type_o     (memop_type),
    .memop_rd_o       (memop_rd),
    .memop_wr_o       (memop_wr),
    .memop_sign_ext_o (memop_sign_ext),

    // When they produce the data
    .prod_data_stage_ex_o (prod_data_stage_ex),
    .prod_data_stage_mem_o (prod_data_stage_mem),

    // Whether it is for M ext pipeline
    .is_M_ext_instr_o (is_M_ext_instr),
    .m1_opcode_o (m1_opcode)
);

// For the moment imm_a will always be 0
assign imm_a = '0;

logic [WORD_SIZE-1:0] muxed_src_a;
logic [WORD_SIZE-1:0] muxed_src_b;

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
        ALU_A_REG: alu_src_a = muxed_src_a;
        ALU_A_IMM: alu_src_a = imm_a;
        ALU_A_PC : alu_src_a = pc_q;
        default: ;
    endcase
end

always_comb begin : alu_src_b_mux
    unique case(src_b_mux_sel)
        ALU_B_REG: alu_src_b = muxed_src_b;
        ALU_B_IMM: alu_src_b = imm_b;
        default: ;
    endcase
end

always_comb begin : br_src_a_mux
    unique case (br_a_mux_sel)
        BR_A_REG: br_src_a = muxed_src_a;
        BR_A_PC : br_src_a = pc_i;
        default : ;
    endcase
end

always_comb begin : br_src_b_mux
    unique case (br_b_mux_sel)
        BR_B_REG: br_src_b = muxed_src_b;
        default: ;
    endcase
end

assign alu_src_a_o = alu_src_a;
assign alu_src_b_o = alu_src_b;
assign rf_we_o     = !is_M_ext_instr ? rf_we : 0;
assign rf_waddr_o  = rf_waddr;
assign memop_sign_ext_o = memop_sign_ext;
assign memop_type_o = memop_type;
assign memop_rd_o = memop_rd;
assign memop_wr_o = memop_wr;
assign br_src_a_o = br_src_a;
assign br_src_b_o = br_src_b;
assign alu_opcode_o = alu_opcode;
assign memop_rf_data_o = muxed_src_b;
assign is_jaljalr_o = !is_M_ext_instr ? ((alu_opcode == ALU_JAL) || (alu_opcode == ALU_JALR)) : 0;

// Not in the flip-flop because this comes from the register file.
assign rf_raddr_a_o = rf_raddr_a;
assign rf_raddr_b_o = rf_raddr_b;

assign src_a_identifier_o = rf_raddr_a;
assign src_b_identifier_o = rf_raddr_b;

assign pc_o = pc_q;
assign valid_id_o = !is_M_ext_instr ? valid_id_q : 0;

assign instr_id_o = instr_q;

assign finish_test_o = (instr_q == 32'hfff01073) && valid_id_q;

assign prod_data_stage_ex_o = !is_M_ext_instr ? prod_data_stage_ex : 0;
assign prod_data_stage_mem_o = !is_M_ext_instr ? prod_data_stage_mem : 0;

assign valid_m1_o = is_M_ext_instr;
assign m1_rf_we_o = is_M_ext_instr;
assign m1_opcode_o = m1_opcode;
assign m1_rf_waddr_o = rf_waddr;
assign m1_rf_src_a_o = alu_src_a;
assign m1_rf_src_b_o = alu_src_b;

// Bypass data

always_comb begin : BYPASS_SRC_A
    case (mux_sel_a_id_i)
        ID_RF: begin
            muxed_src_a = rf_data_a_i;
        end
        EXECUTE_BYPASS: begin
            muxed_src_a = ex_rd_data_i;
        end
        MEMORY_BYPASS: begin
            muxed_src_a = mem_rd_data_i;
        end
        WRITEBACK_BYPASS: begin
            muxed_src_a = wb_rd_data_i;
        end
        M5_BYPASS: begin
            muxed_src_a = m5_rd_data_i;
        end
    endcase
end

always_comb begin : BYPASS_SRC_B
    case (mux_sel_b_id_i)
        ID_RF: begin
            muxed_src_b = rf_data_b_i;
        end
        EXECUTE_BYPASS: begin
            muxed_src_b = ex_rd_data_i;
        end
        MEMORY_BYPASS: begin
            muxed_src_b = mem_rd_data_i;
        end
        WRITEBACK_BYPASS: begin
            muxed_src_b = wb_rd_data_i;
        end
        M5_BYPASS: begin
            muxed_src_b = m5_rd_data_i;
        end
    endcase
end

endmodule : segre_id_stage
