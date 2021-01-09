import segre_pkg::*;

module segre_core (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // Memory signals
    input  logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_rd_data_i,
    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_wr_data_o,
    output logic [ADDR_SIZE-1:0] addr_o,
    input  logic mem_ready_i,
    output logic mem_rd_o,
    output logic mem_wr_o,
    output memop_data_type_e mem_data_type_o
);

logic ic_if_hit;
logic ctrl_block_if;
logic ctrl_inject_nops_if;

segre_controller controller (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    // Instruction Fetch
    ////////////////////

    // Inputs
    .ic_if_hit_i (ic_if_hit),

    // Outputs
    .block_if_o (ctrl_block_if),
    .inject_nops_if_o (ctrl_inject_nops_if)

    ////////////////////

);

//IF STAGE
logic [WORD_SIZE-1:0] if_addr;
logic if_mem_rd;
logic instruction_hit_if;
// ID STAGE
logic [WORD_SIZE-1:0] id_instr;
// REGISTER FILE
logic [REG_SIZE-1:0] rf_raddr_a;
logic [REG_SIZE-1:0] rf_raddr_b;
logic [WORD_SIZE-1:0] rf_data_a;
logic [WORD_SIZE-1:0] rf_data_b;
// EX STAGE
logic [WORD_SIZE-1:0] ex_pc;
memop_data_type_e ex_memop_type;
logic [WORD_SIZE-1:0] ex_alu_src_a;
logic [WORD_SIZE-1:0] ex_alu_src_b;
logic [WORD_SIZE-1:0] ex_rf_st_data;
logic ex_rf_we;
logic [REG_SIZE-1:0] ex_rf_waddr;
logic ex_is_jaljalr;
alu_opcode_e ex_alu_opcode;
logic ex_memop_rd;
logic ex_memop_wr;
logic ex_memop_sign_ext;
logic [WORD_SIZE-1:0] ex_br_src_a;
logic [WORD_SIZE-1:0] ex_br_src_b;
// MEM STAGE
memop_data_type_e mem_memop_type;
memop_data_type_e mem_data_type;
logic [WORD_SIZE-1:0] mem_alu_res;
logic [WORD_SIZE-1:0] mem_addr;
logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_wr_data;
logic [WORD_SIZE-1:0] mem_rf_st_data;
logic [REG_SIZE-1:0]  mem_rf_waddr;
logic mem_memop_rd;
logic mem_memop_wr;
logic mem_memop_sign_ext;
logic mem_rf_we;
logic mem_rd;
logic mem_wr;
logic mem_tkbr;
logic [WORD_SIZE-1:0] mem_new_pc;
logic mem_data_cache_is_busy;
logic mem_data_cache_is_hit;
logic mem_is_jaljalr;
logic [ADDR_SIZE-1:0] mem_seq_new_pc;
// WB STAGE
logic [WORD_SIZE-1:0] wb_res;
logic [REG_SIZE-1:0] wb_rf_waddr;
logic wb_rf_we;
logic [WORD_SIZE-1:0] wb_new_pc;
logic wb_tkbr;

logic mem_stage_rdwr;
assign mem_stage_rdwr = (mem_memop_rd || mem_memop_wr);

//assign addr_o          = (fsm_state == MEM_STATE) ? mem_addr       : if_addr;
//assign mem_rd_o        = (fsm_state == MEM_STATE) ? mem_rd         : if_mem_rd;
//assign mem_wr_o        = (fsm_state == MEM_STATE) ? mem_wr         : 1'b0;
//assign mem_data_type_o = (fsm_state == MEM_STATE) ? mem_data_type  : WORD;

// TODO This is DONE THIS WAY BECASUE I AM ONLY TESTING ARITHMETIC/LOGIC INSTRUCTIONS
// OF COURSE AT SOME POINT WE HAVE TO ARBITRATE BETWEEN MEMORY ACCESSES OF STAGES
// INSTRUCTION FETCH AND MEMORY.
assign addr_o          = if_addr;
assign mem_rd_o        = if_mem_rd;
assign mem_wr_o        = 1'b0;
assign mem_data_type_o = WORD;
assign mem_wr_data_o   = mem_wr_data;

segre_if_stage if_stage (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    // Memory
    .cache_instr_line_i (mem_rd_data_i),
    .mem_ready_i (mem_ready_i),
    .pc_o        (if_addr),
    .mem_rd_o    (if_mem_rd),

    // IF ID interface
    .instr_o     (id_instr),

    // WB interface
    .tkbr_i      (wb_tkbr),
    .new_pc_i    (wb_new_pc),

    // To controller signals
    .instruction_hit_o (ic_if_hit),

    .block_if_i (ctrl_block_if),
    .inject_nops_i (ctrl_inject_nops_if)

);

segre_id_stage id_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    // IF ID interface
    .instr_i          (id_instr),
    .pc_i             (if_addr),

    // Register file read operands
    .rf_raddr_a_o     (rf_raddr_a),
    .rf_raddr_b_o     (rf_raddr_b),
    .rf_data_a_i      (rf_data_a),
    .rf_data_b_i      (rf_data_b),

    // ID EX interface
    .pc_o             (ex_pc),
    // ALU
    .alu_opcode_o     (ex_alu_opcode),
    .alu_src_a_o      (ex_alu_src_a),
    .alu_src_b_o      (ex_alu_src_b),
    // Register file
    .rf_we_o          (ex_rf_we),
    .rf_waddr_o       (ex_rf_waddr),
    // Memop
    .memop_type_o      (ex_memop_type),
    .memop_rd_o        (ex_memop_rd),
    .memop_wr_o        (ex_memop_wr),
    .memop_sign_ext_o  (ex_memop_sign_ext),
    .memop_rf_data_o   (ex_rf_st_data),
    // Branch | Jump
    .br_src_a_o        (ex_br_src_a),
    .br_src_b_o        (ex_br_src_b),

    .is_jaljalr_o (ex_is_jaljalr),

    .block_id_i (0),
    .inject_nops_i (0)
);

segre_ex_stage ex_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    // ID EX interface
    // ALU
    .alu_opcode_i     (ex_alu_opcode),
    .alu_src_a_i      (ex_alu_src_a),
    .alu_src_b_i      (ex_alu_src_b),
    // Register file
    .rf_we_i          (ex_rf_we),
    .rf_waddr_i       (ex_rf_waddr),
    .rf_st_data_i     (ex_rf_st_data),
    // Memop
    .memop_type_i      (ex_memop_type),
    .memop_rd_i        (ex_memop_rd),
    .memop_wr_i        (ex_memop_wr),
    .memop_sign_ext_i  (ex_memop_sign_ext),
    // Branch | Jump
    .br_src_a_i        (ex_br_src_a),
    .br_src_b_i        (ex_br_src_b),

    // EX MEM interface
    // ALU
    .alu_res_o        (mem_alu_res),
    // Register file
    .rf_we_o          (mem_rf_we),
    .rf_waddr_o       (mem_rf_waddr),
    .rf_st_data_o     (mem_rf_st_data),
    // Memop
    .memop_type_o     (mem_memop_type),
    .memop_rd_o       (mem_memop_rd),
    .memop_wr_o       (mem_memop_wr),
    .memop_sign_ext_o (mem_memop_sign_ext),
    // Branch | Jal
    .tkbr_o           (mem_tkbr),
    .new_pc_o         (mem_new_pc),

    // pc + 4
    .pc_i (ex_pc_i),
    .seq_new_pc_o (mem_seq_new_pc),
    .is_jaljalr_i (ex_is_jaljalr),
    .is_jaljalr_o (mem_is_jaljalr),

    .block_ex_i (0),
    .inject_nops_i (0)
);

segre_mem_stage mem_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    // To Logic
    .cache_is_busy_o (mem_data_cache_is_busy),
    .cache_is_hit_o  (mem_data_cache_is_hit),

    // Memory
    //.data_i         (mem_rd_data_i),
    //.data_o           (mem_wr_data),
    .addr_o           (mem_addr),
    .memop_rd_o       (mem_rd),
    .memop_wr_o       (mem_wr),
    .memop_type_o     (mem_data_type),
    .cache_line_i     (mem_rd_data_i),
    .mem_ready_i      (mem_ready_i),
    .to_mem_cache_line_o (mem_wr_data),

    // EX MEM interface
    // ALU
    .alu_res_i        (mem_alu_res),
    // Register file
    .rf_we_i          (mem_rf_we),
    .rf_waddr_i       (mem_rf_waddr),
    .rf_st_data_i     (mem_rf_st_data),
    // Memop
    .memop_type_i     (mem_memop_type),
    .memop_rd_i       (mem_memop_rd),
    .memop_wr_i       (mem_memop_wr),
    .memop_sign_ext_i (mem_memop_sign_ext),
    // Branch | Jal
    .tkbr_i           (mem_tkbr),
    .new_pc_i         (mem_new_pc),

    // MEM WB intereface
    .op_res_o         (wb_res),
    .rf_we_o          (wb_rf_we),
    .rf_waddr_o       (wb_rf_waddr),
    .tkbr_o           (wb_tkbr),
    .new_pc_o         (wb_new_pc),

    // pc + 4
    .seq_new_pc_i (mem_seq_new_pc),
    .is_jaljalr_i (mem_is_jaljalr),

    .block_mem_i (0),
    .inject_nops_i (0)
);

segre_register_file segre_rf (
    // Clock and Reset
    .clk_i       (clk_i),
    .rsn_i       (rsn_i),

    .we_i        (wb_rf_we),
    .raddr_a_i   (rf_raddr_a),
    .data_a_o    (rf_data_a),
    .raddr_b_i   (rf_raddr_b),
    .data_b_o    (rf_data_b),
    .waddr_i     (wb_rf_waddr),
    .data_w_i    (wb_res)
);

endmodule : segre_core
