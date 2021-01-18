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

//IF STAGE
logic [WORD_SIZE-1:0] if_addr;
logic if_mem_rd;
logic instruction_hit_if;
logic valid_if;
logic [WORD_SIZE-1:0] if_instr;
logic [ADDR_SIZE-1:0] if_mem_addr;

// ID STAGE
logic [REG_SIZE-1:0] src_a_identifier_id;
logic [REG_SIZE-1:0] src_b_identifier_id;
logic [WORD_SIZE-1:0] instr_id;
logic valid_id;
logic finish_test_id;
logic id_prod_data_stage_ex;
logic id_prod_data_stage_mem;

// REGISTER FILE
logic [REG_SIZE-1:0] rf_raddr_a;
logic [REG_SIZE-1:0] rf_raddr_b;
logic [WORD_SIZE-1:0] rf_data_a;
logic [WORD_SIZE-1:0] rf_data_b;

// ID STAGE
logic [WORD_SIZE-1:0] id_pc;
memop_data_type_e id_memop_type;
logic [WORD_SIZE-1:0] id_alu_src_a;
logic [WORD_SIZE-1:0] id_alu_src_b;
logic [WORD_SIZE-1:0] id_rf_st_data;
logic id_rf_we;
logic [REG_SIZE-1:0] id_rf_waddr;
logic id_is_jaljalr;
alu_opcode_e id_alu_opcode;
logic id_memop_rd;
logic id_memop_wr;
logic id_memop_sign_ext;
logic [WORD_SIZE-1:0] id_br_src_a;
logic [WORD_SIZE-1:0] id_br_src_b;
logic rd_raddr_a_id;
logic rd_raddr_b_id;

// EX STAGE
memop_data_type_e ex_memop_type;
memop_data_type_e ex_data_type;
logic [WORD_SIZE-1:0] ex_alu_res;
logic [WORD_SIZE-1:0] ex_addr;
logic [WORD_SIZE-1:0] ex_rf_st_data;
logic [REG_SIZE-1:0]  ex_rf_waddr;
logic ex_memop_rd;
logic ex_memop_wr;
logic ex_memop_sign_ext;
logic ex_rf_we;
logic ex_rd;
logic ex_wr;
logic ex_tkbr;
logic [WORD_SIZE-1:0] ex_new_pc;
logic ex_data_cache_is_busy;
logic ex_data_cache_is_hit;
logic ex_is_jaljalr;
logic [ADDR_SIZE-1:0] ex_seq_new_pc;
logic valid_ex;
logic finish_test_ex;
logic ex_prod_data_stage_ex;
logic ex_prod_data_stage_mem;
logic is_load_ex;

// MEM STAGE
logic [WORD_SIZE-1:0] mem_res;
logic mem_rf_we;
logic [REG_SIZE-1:0] mem_rf_waddr;
logic [ADDR_SIZE-1:0] mem_new_pc;
logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_wr_data;
logic valid_mem;
logic [ADDR_SIZE-1:0] mem_addr;
logic mem_rd;
logic mem_wr;
memop_data_type_e mem_data_type;
logic mem_dc_rd;
logic mem_dc_wr;
logic mem_sb_draining;
logic mem_is_load;

//// WB STAGE Use _q instead.
logic [WORD_SIZE-1:0] wb_res_d;
logic wb_rf_we_d;
logic [REG_SIZE-1:0] wb_rf_waddr_d;
logic tkbr_d;
logic [ADDR_SIZE-1:0] wb_new_pc_d;
logic valid_wb_d;
logic data_produced_wb_d;

logic [WORD_SIZE-1:0] wb_res_q;
logic wb_rf_we_q;
logic [REG_SIZE-1:0] wb_rf_waddr_q;
logic [ADDR_SIZE-1:0] wb_new_pc_q;
logic valid_wb_q;
logic data_produced_wb_q;

logic ic_if_hit;
logic ctrl_block_if;
logic ctrl_inject_nops_if;
logic ctrl_blocked_if;

logic ctrl_block_id;
logic ctrl_inject_nops_id;
bypass_id_sel_e ctrl_mul_sel_a_id;
bypass_id_sel_e ctrl_mul_sel_b_id;

// Not used right now
logic ctrl_block_ex;
logic ctrl_inject_nops_ex;
logic ctrl_tkbr;
logic ctrl_data_produced_ex;
bypass_ex_sel_e ctrl_mul_sel_load_ex;
bypass_ex_sel_e ctrl_mul_sel_a_ex;
bypass_ex_sel_e ctrl_mul_sel_b_ex;

logic ctrl_block_mem;
logic ctrl_inject_nops_mem;
logic ctrl_blocked_mem;
logic ctrl_data_produced_mem;

logic ctrl_block_wb;
logic ctrl_inject_nops_wb;

logic sel_mem_req;

// M_ext_pipeline
logic valid_m1;
m_ext_opcode_e m1_opcode;
logic m1_rf_we;
logic [REG_SIZE-1:0] m1_rf_waddr;
logic [WORD_SIZE-1:0] m1_rf_src_a;
logic [WORD_SIZE-1:0] m1_rf_src_b;

// End of pipeline (EOP)
logic [REG_SIZE-1:0] m5_waddr;
logic [WORD_SIZE-1:0] m5_wdata;
logic m5_valid;
logic m5_we;

segre_controller controller (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    .sel_mem_req_o (sel_mem_req),

    // Instruction Fetch
    ////////////////////

    // Inputs
    .ic_if_hit_i (ic_if_hit),
    .valid_if_i (valid_if),

    // Outputs
    .block_if_o (ctrl_block_if),
    .inject_nops_if_o (ctrl_inject_nops_if),
    .blocked_1cycle_ago_if_o (ctrl_blocked_if),

    ////////////////////

    // Instruction Decode
    ////////////////////

    // Inputs
    .valid_id_i (valid_id),
    .src_a_identifier_id_i (src_a_identifier_id),
    .src_b_identifier_id_i (src_b_identifier_id),
    .decode_instr_i (instr_id),

    .rd_src_a_id_i (rd_raddr_a_id),
    .rd_src_b_id_i (rd_raddr_b_id),

    // Outuputs
    .block_id_o (ctrl_block_id),
    .inject_nops_id_o (ctrl_inject_nops_id),
    .mul_sel_a_id_o (ctrl_mul_sel_a_id),
    .mul_sel_b_id_o (ctrl_mul_sel_b_id),

    ////////////////////

    // Execution
    ////////////////////

    // Inputs
    .valid_ex_i (valid_ex),
    .dst_reg_identifier_ex_i (ex_rf_waddr),
    .we_ex_i (ex_rf_we),
    .tkbr_i (ex_tkbr),
    .data_produced_ex_i (ctrl_data_produced_ex),
    .is_load_ex_i (is_load_ex),
    .finish_test_i (finish_test_ex),

    // Outputs
    .block_ex_o (ctrl_block_ex),
    .inject_nops_ex_o (ctrl_inject_nops_ex),
    .tkbr_o (ctrl_tkbr),

    .mul_sel_load_ex_o (ctrl_mul_sel_load_ex),
    .mul_sel_a_ex_o (ctrl_mul_sel_a_ex),
    .mul_sel_b_ex_o (ctrl_mul_sel_b_ex),

    ////////////////////

    // Memory

    // Inputs
    .valid_mem_i (valid_mem),
    .dst_reg_identifier_mem_i (mem_rf_waddr),
    .we_mem_i (mem_rf_we),
    .dc_mem_hit_i (mem_data_cache_is_hit),
    .dc_rd_i (mem_dc_rd),
    .dc_wr_i (mem_dc_wr),
    .store_buffer_draining_i (mem_sb_draining),
    .data_produced_mem_i (ctrl_data_produced_mem),
    .is_load_mem_i (mem_is_load),

    // Outputs
    .block_mem_o (ctrl_block_mem),
    .inject_nops_mem_o (ctrl_inject_nops_mem),
    .blocked_1cycle_ago_mem_o (ctrl_blocked_mem),

    ////////////////////

    // Writeback

    // Inputs
    .valid_wb_i (valid_wb_q),
    .dst_reg_identifier_wb_i (wb_rf_waddr_q),
    .we_wb_i (wb_rf_we_q),
    .data_produced_wb_i (data_produced_wb_q),

    // Outputs
    .block_wb_o (ctrl_block_wb),
    .inject_nops_wb_o (ctrl_inject_nops_wb)
);

//assign addr_o          = (fsm_state == MEM_STATE) ? mem_addr       : if_addr;
//assign mem_rd_o        = (fsm_state == MEM_STATE) ? mem_rd         : if_mem_rd;
//assign mem_wr_o        = (fsm_state == MEM_STATE) ? mem_wr         : 1'b0;
//assign mem_data_type_o = (fsm_state == MEM_STATE) ? mem_data_type  : WORD;

// TODO This is DONE THIS WAY BECASUE I AM ONLY TESTING ARITHMETIC/LOGIC INSTRUCTIONS
// OF COURSE AT SOME POINT WE HAVE TO ARBITRATE BETWEEN MEMORY ACCESSES OF STAGES
// INSTRUCTION FETCH AND MEMORY.
assign addr_o          = sel_mem_req ? mem_addr : if_mem_addr;
assign mem_rd_o        = sel_mem_req ? mem_rd : if_mem_rd;
assign mem_wr_o        = sel_mem_req ? mem_wr : 1'b0;
assign mem_data_type_o = sel_mem_req ? mem_data_type : WORD;
assign mem_wr_data_o   = mem_wr_data;

logic mem_ready_to_if_stage;
logic mem_ready_to_mem_stage;

always_comb begin : mux_mem_ready
    if (!rsn_i) begin
        mem_ready_to_if_stage = 0;
        mem_ready_to_mem_stage = 0;
    end
    else begin
        case (sel_mem_req)
            0 :  begin
                mem_ready_to_if_stage = mem_ready_i;
                mem_ready_to_mem_stage = 0;
            end
            1 : begin
                mem_ready_to_if_stage = 0;
                mem_ready_to_mem_stage = mem_ready_i;
            end
            default: begin
                mem_ready_to_if_stage = mem_ready_i;
                mem_ready_to_mem_stage = 0;
            end
        endcase
    end
end

segre_if_stage if_stage (
    // Clock and Reset
    .clk_i (clk_i),
    .rsn_i (rsn_i),

    // ID-IF
    .pc_i (id_pc),

    // Memory
    .cache_instr_line_i (mem_rd_data_i),
    .mem_ready_i (mem_ready_to_if_stage),
    .pc_o        (if_addr),
    .mem_rd_o    (if_mem_rd),
    .mem_addr_o  (if_mem_addr),

    // IF ID interface
    .instr_o     (if_instr),
    .valid_if_o  (valid_if),

    // WB interface
    .tkbr_i      (ctrl_tkbr),
    .new_pc_i    (ex_new_pc),

    // To controller signals
    .instruction_hit_o (ic_if_hit),

    .block_if_i (ctrl_block_if),
    .blocked_1cycle_ago_i (ctrl_blocked_if),
    .inject_nops_i (ctrl_inject_nops_if)

);

segre_id_stage id_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    // Bypass data

    .ex_rd_data_i (ex_alu_res),
    .mem_rd_data_i (mem_res),
    .wb_rd_data_i (wb_res_q),

    // Bypass control

    .mux_sel_a_id_i (ctrl_mul_sel_a_id),
    .mux_sel_b_id_i (ctrl_mul_sel_b_id),

    // IF ID interface
    .instr_i          (if_instr),
    .pc_i             (if_addr),
    .valid_if_i       (valid_if),

    // Register file read operands
    .rf_raddr_a_o     (rf_raddr_a),
    .rf_raddr_b_o     (rf_raddr_b),
    .rf_data_a_i      (rf_data_a),
    .rf_data_b_i      (rf_data_b),

    // ID EX interface
    .pc_o             (id_pc),
    // ALU
    .alu_opcode_o     (id_alu_opcode),
    .alu_src_a_o      (id_alu_src_a),
    .alu_src_b_o      (id_alu_src_b),
    // Register file
    .rf_we_o          (id_rf_we),
    .rf_waddr_o       (id_rf_waddr),
    // Memop
    .memop_type_o      (id_memop_type),
    .memop_rd_o        (id_memop_rd),
    .memop_wr_o        (id_memop_wr),
    .memop_sign_ext_o  (id_memop_sign_ext),
    .memop_rf_data_o   (id_rf_st_data),
    // Branch | Jump
    .br_src_a_o        (id_br_src_a),
    .br_src_b_o        (id_br_src_b),

    .is_jaljalr_o (id_is_jaljalr),

    .src_a_identifier_o (src_a_identifier_id),
    .src_b_identifier_o (src_b_identifier_id),

    .rd_raddr_a_o (rd_raddr_a_id),
    .rd_raddr_b_o (rd_raddr_b_id),

    .block_id_i (ctrl_block_id),
    .inject_nops_i (ctrl_inject_nops_id),
    .valid_id_o (valid_id),
    .prod_data_stage_ex_o (id_prod_data_stage_ex),
    .prod_data_stage_mem_o (id_prod_data_stage_mem),

    .instr_id_o (instr_id),

    .finish_test_o (finish_test_id),

    .valid_m1_o (valid_m1),
    .m1_opcode_o (m1_opcode),
    .m1_rf_we_o (m1_rf_we),
    .m1_rf_waddr_o (m1_rf_waddr),
    .m1_rf_src_a_o (m1_rf_src_a),
    .m1_rf_src_b_o (m1_rf_src_b)

);

segre_ex_stage ex_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    .valid_id_i       (valid_id),

    .finish_test_i    (finish_test_id),

    // Bypass

    .mux_sel_load_i   (ctrl_mul_sel_load_ex),
    .mux_sel_a_i      (ctrl_mul_sel_a_ex),
    .mux_sel_b_i      (ctrl_mul_sel_b_ex),

    .op_res_stage_mem_i (mem_res),
    .op_res_stage_wb_i  (wb_res_q),

    // ID EX interface
    // ALU
    .alu_opcode_i     (id_alu_opcode),
    .alu_src_a_i      (id_alu_src_a),
    .alu_src_b_i      (id_alu_src_b),
    // Register file
    .rf_we_i          (id_rf_we),
    .rf_waddr_i       (id_rf_waddr),
    .rf_st_data_i     (id_rf_st_data),
    // Memop
    .memop_type_i      (id_memop_type),
    .memop_rd_i        (id_memop_rd),
    .memop_wr_i        (id_memop_wr),
    .memop_sign_ext_i  (id_memop_sign_ext),
    // Branch | Jump
    .br_src_a_i        (id_br_src_a),
    .br_src_b_i        (id_br_src_b),

    // EX MEM interface
    // ALU
    .alu_res_o        (ex_alu_res),
    // Register file
    .rf_we_o          (ex_rf_we),
    .rf_waddr_o       (ex_rf_waddr),
    .rf_st_data_o     (ex_rf_st_data),
    // Memop
    .memop_type_o     (ex_memop_type),
    .memop_rd_o       (ex_memop_rd),
    .memop_wr_o       (ex_memop_wr),
    .memop_sign_ext_o (ex_memop_sign_ext),
    // Branch | Jal
    .tkbr_o           (ex_tkbr),
    .new_pc_o         (ex_new_pc),

    // pc + 4
    .pc_i (id_pc),
    .seq_new_pc_o (ex_seq_new_pc),
    .is_jaljalr_i (id_is_jaljalr),
    .is_jaljalr_o (ex_is_jaljalr),

    .block_ex_i (ctrl_block_ex),
    .inject_nops_i (ctrl_inject_nops_ex),
    .valid_ex_o (valid_ex),

    .is_load_o (is_load_ex),

    .prod_data_stage_ex_i (id_prod_data_stage_ex),
    .prod_data_stage_mem_i (id_prod_data_stage_mem),

    .prod_data_stage_ex_o (ex_prod_data_stage_ex),
    .prod_data_stage_mem_o (ex_prod_data_stage_mem),

    .data_produced_ex_o (ctrl_data_produced_ex),

    .finish_test_o (finish_test_ex)
);

segre_mem_stage mem_stage (
    // Clock and Reset
    .clk_i            (clk_i),
    .rsn_i            (rsn_i),

    .valid_ex_i       (valid_ex),
    .blocked_1cycle_ago_i (ctrl_blocked_mem),

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
    .mem_ready_i      (mem_ready_to_mem_stage),
    .to_mem_cache_line_o (mem_wr_data),

    // EX MEM interface
    // ALU
    .alu_res_i        (ex_alu_res),
    // Register file
    .rf_we_i          (ex_rf_we),
    .rf_waddr_i       (ex_rf_waddr),
    .rf_st_data_i     (ex_rf_st_data),
    // Memop
    .memop_type_i     (ex_memop_type),
    .memop_rd_i       (ex_memop_rd),
    .memop_wr_i       (ex_memop_wr),
    .memop_sign_ext_i (ex_memop_sign_ext),
    // Branch | Jal
    .new_pc_i         (ex_new_pc),

    // MEM WB intereface
    .op_res_o         (mem_res),
    .rf_we_o          (mem_rf_we),
    .rf_waddr_o       (mem_rf_waddr),
    .new_pc_o         (mem_new_pc),

    // pc + 4
    .seq_new_pc_i (ex_seq_new_pc),
    .is_jaljalr_i (ex_is_jaljalr),

    .block_mem_i (ctrl_block_mem),
    .inject_nops_i (ctrl_inject_nops_mem),
    .valid_mem_o (valid_mem),

    .prod_data_stage_ex_i (ex_prod_data_stage_ex),
    .prod_data_stage_mem_i (ex_prod_data_stage_mem),

    .data_produced_mem_o (ctrl_data_produced_mem),

    .is_load_o (mem_is_load),

    .dc_rd_o (mem_dc_rd),
    .dc_wr_o (mem_dc_wr),
    .sb_draining_o (mem_sb_draining)
);

always_comb begin : decoupling_register_MEM_WB_1
    if (!rsn_i) begin
        wb_rf_we_d = 0;
        valid_wb_d = 0;
        data_produced_wb_d = 0;
    end
    else begin
        if (ctrl_block_wb) begin
            wb_res_d = wb_res_q;
            wb_rf_we_d = wb_rf_we_q;
            wb_rf_waddr_d = wb_rf_waddr_q;
            wb_new_pc_d = wb_new_pc_q;
            data_produced_wb_d = data_produced_wb_q;
        end
        else if (ctrl_inject_nops_wb) begin
            wb_rf_we_d = 0;
            valid_wb_d = 0;
            data_produced_wb_d = 0;
        end

        else begin
            wb_res_d = mem_res;
            wb_rf_we_d = mem_rf_we;
            wb_rf_waddr_d = mem_rf_waddr;
            wb_new_pc_d = mem_new_pc;
            valid_wb_d = valid_mem;
            data_produced_wb_d = ctrl_data_produced_mem;
        end
    end
end

always_ff @(posedge clk_i) begin : decoupling_register_MEM_WB_2
    if (!rsn_i) begin
        wb_rf_we_q <= 0;
        valid_wb_q <= 0;
        data_produced_wb_q <= 0;
    end
    else begin
        wb_res_q <= wb_res_d;
        wb_rf_we_q <= wb_rf_we_d;
        wb_rf_waddr_q <= wb_rf_waddr_d;
        wb_new_pc_q <= wb_new_pc_d;
        valid_wb_q <= valid_wb_d;
        data_produced_wb_q <= data_produced_wb_d;
    end
end

M_ext_pipeline M_ext (

    .clk_i (clk_i),
    .rsn_i (rsn_i),

    .valid_m1_i (valid_m1),

    .opcode_i (m1_opcode),

    .rf_we_i (m1_rf_we),
    .rf_waddr_i (m1_rf_waddr),

    .src_a_i (m1_rf_src_a),
    .src_b_i (m1_rf_src_b),

    .valid_m3_o (ctrl_valid_m3),

    .rf_waddr_o (m5_waddr),
    .rf_wdata_o (m5_wdata),
    .valid_m5_o (m5_valid),
    .rf_we_o (m5_we)

);

logic muxed_we;
logic [REG_SIZE-1:0] muxed_rf_waddr;
logic [WORD_SIZE-1:0] muxed_rf_w_data;

always_comb begin
    if (m5_valid) begin
        muxed_we = m5_we;
        muxed_rf_waddr = m5_waddr;
        muxed_rf_w_data = m5_wdata;
    end
    else begin
        muxed_we = wb_rf_we_q;
        muxed_rf_waddr = wb_rf_waddr_q;
        muxed_rf_w_data = wb_res_q;
    end
end

segre_register_file segre_rf (

    .clk_i       (clk_i),
    .rsn_i       (rsn_i),

    .we_i        (muxed_we),
    .raddr_a_i   (rf_raddr_a),
    .data_a_o    (rf_data_a),
    .raddr_b_i   (rf_raddr_b),
    .data_b_o    (rf_data_b),
    .waddr_i     (muxed_rf_waddr),
    .data_w_i    (muxed_rf_w_data)

);

endmodule : segre_core
