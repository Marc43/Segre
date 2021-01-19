import segre_pkg::*;

module bypass_controller (
    input logic clk_i,
    input logic rsn_i,

    // Instruction decode stage

    input logic valid_id_i,

    input logic rd_src_a_id_i,
    input logic rd_src_b_id_i,

    input logic is_store_id_i,

    output bypass_id_sel_e mux_sel_a_id_o, // 2 bits to select RF, Execute, Memory, Writeback data
    output bypass_id_sel_e mux_sel_b_id_o,

    // Execute stage

    input logic valid_ex_i,
    input logic data_produced_ex_i,

    input logic is_load_ex_i,

    input logic depEX_src_a_i,
    input logic depEX_src_b_i,

    output logic use_bypass_a_ex_o,
    output logic use_bypass_b_ex_o,

    // 1 bit to select bypass from memory or writeback
    // This signal must be driven through a register
    // we will use the decoupling register ID_EX

    output bypass_ex_sel_e mux_sel_load_ex_o, // Only used for load-store cases to retrieve the loaded data in older instr.
    output bypass_ex_sel_e mux_sel_a_ex_o,
    output bypass_ex_sel_e mux_sel_b_ex_o,

    // Memory stage

    input logic valid_mem_i,
    input logic data_produced_mem_i,

    input logic is_load_mem_i,

    input logic depMEM_src_a_i,
    input logic depMEM_src_b_i,

    output logic use_bypass_a_mem_o,
    output logic use_bypass_b_mem_o,

    // Writeback stage

    input logic valid_wb_i,
    input logic data_produced_wb_i,

    input logic depWB_src_a_i,
    input logic depWB_src_b_i,

    output logic use_bypass_a_wb_o,
    output logic use_bypass_b_wb_o,

    // M4 stage

    input logic valid_m4_i,
    input logic depM4_src_a_i,
    input logic depM4_src_b_i,

    // M5 stage

    input logic valid_m5_i,
    input logic depM5_src_a_i,
    input logic depM5_src_b_i

);

/*
 * Bypasses to DECODE stage
 */

bypass_id_sel_e bypass_mux_sel_a;
bypass_id_sel_e bypass_mux_sel_b;

logic use_bypass_a_ex = 0;
logic use_bypass_b_ex = 0;
logic use_bypass_a_wb = 0;
logic use_bypass_b_wb = 0;
logic use_bypass_a_mem = 0;
logic use_bypass_b_mem = 0;

always_comb begin : SRC_MUXES_LOGIC_ID
    if (!rsn_i) begin
        bypass_mux_sel_a = ID_RF;
        bypass_mux_sel_b = ID_RF;
        use_bypass_a_ex = 0;
        use_bypass_b_ex = 0;
        use_bypass_a_wb = 0;
        use_bypass_b_wb = 0;
        use_bypass_a_mem = 0;
        use_bypass_b_mem = 0;
    end
    else begin

        // Select for source operand A
        if (valid_ex_i && data_produced_ex_i && depEX_src_a_i) begin
            bypass_mux_sel_a  = EXECUTE_BYPASS;
            use_bypass_a_ex = 1;
            use_bypass_a_mem = 0;
            use_bypass_a_wb = 0;
        end
        else if (valid_mem_i && data_produced_mem_i && depMEM_src_a_i) begin
            bypass_mux_sel_a = MEMORY_BYPASS;
            use_bypass_a_ex = 0;
            use_bypass_a_mem = 1;
            use_bypass_a_wb = 0;
        end
        else if (valid_wb_i && depWB_src_a_i) begin
            bypass_mux_sel_a = WRITEBACK_BYPASS;
            use_bypass_a_ex = 0;
            use_bypass_a_mem = 0;
            use_bypass_a_wb = 1;
        end
        else if (valid_m5_i && depM5_src_a_i) begin
            bypass_mux_sel_a = M5_BYPASS;
        end
        else begin
            bypass_mux_sel_a = ID_RF;
            use_bypass_a_ex = 0;
            use_bypass_a_mem = 0;
            use_bypass_a_wb = 0;
        end

        // Select for source operand B
        if (valid_ex_i && data_produced_ex_i && depEX_src_b_i) begin
            bypass_mux_sel_b = EXECUTE_BYPASS;
            use_bypass_b_ex = 1;
            use_bypass_b_mem = 0;
            use_bypass_b_wb = 0;
        end
        else if (valid_mem_i && data_produced_mem_i && depMEM_src_b_i) begin
            bypass_mux_sel_b = MEMORY_BYPASS;
            use_bypass_b_mem = 1;
            use_bypass_b_ex = 0;
            use_bypass_b_wb = 0;
        end
        else if (valid_wb_i && depWB_src_b_i) begin
            bypass_mux_sel_b = WRITEBACK_BYPASS;
            use_bypass_b_wb = 1;
            use_bypass_b_ex = 0;
            use_bypass_b_mem = 0;
        end
        else if (valid_m5_i && depM5_src_b_i) begin
            bypass_mux_sel_b = M5_BYPASS;
        end
        else begin
            bypass_mux_sel_b = ID_RF;
            use_bypass_b_ex = 0;
            use_bypass_b_mem = 0;
            use_bypass_b_wb = 0;
        end
    end
end

assign mux_sel_a_id_o = bypass_mux_sel_a;
assign mux_sel_b_id_o = bypass_mux_sel_b;

/*
 * Bypasses to EXECUTION stage
 */

/*
 * In this block we don't use data_produced signals
 * because we know that data will be produced in the
 * next cycle whether it is in EX or in MEM.
 */

bypass_ex_sel_e mux_sel_load_ex;
bypass_ex_sel_e mux_sel_a_ex;
bypass_ex_sel_e mux_sel_b_ex;

always_comb begin : LOAD_DATA_MUX_EX
    if (!rsn_i) begin
        mux_sel_load_ex = NO_BYPASS;
    end
    else begin

        if (valid_ex_i && is_load_ex_i && depEX_src_b_i) begin
            mux_sel_load_ex = MEM_BYPASS;
        end
        else if (valid_mem_i && is_load_mem_i && depMEM_src_b_i) begin
            mux_sel_load_ex = WB_BYPASS;
        end
        else begin
            mux_sel_load_ex = NO_BYPASS;
        end

    end
end

always_comb begin : SRC_ALU_MUX_EX
    if (!rsn_i) begin
        mux_sel_a_ex = NO_BYPASS;
        mux_sel_b_ex = NO_BYPASS;
    end
    else begin

        /*
         * Strong doubts with what I did
         * to check if I previously used a bypass
         * too busy now to check but, keep it in mind
         * if some error or redundancy pops up
         * TODO
         */

        // Select for source operand A
        if (valid_ex_i && depEX_src_a_i && !use_bypass_a_ex) begin
            mux_sel_a_ex = MEM_BYPASS;
        end
        else if (valid_mem_i && depMEM_src_a_i && !use_bypass_a_mem && !use_bypass_a_ex) begin
            mux_sel_a_ex = WB_BYPASS;
        end
        else if (valid_m4_i && depM4_src_a_i && !use_bypass_a_mem && !use_bypass_a_ex) begin
            mux_sel_a_ex = MUL_M5_BYPASS;
        end
        else begin
            mux_sel_a_ex = NO_BYPASS;
        end

        // Select for source operand B
        if (!is_store_id_i && valid_ex_i && depEX_src_b_i && !use_bypass_b_ex) begin
            mux_sel_b_ex = MEM_BYPASS;
        end
        else if (!is_store_id_i && valid_mem_i && depMEM_src_b_i && !use_bypass_b_mem && !use_bypass_b_ex) begin
            mux_sel_b_ex = WB_BYPASS;
        end
        else if (!is_store_id_i && valid_m4_i && depM4_src_b_i && !use_bypass_b_ex && !use_bypass_b_mem) begin
            mux_sel_b_ex = MUL_M5_BYPASS;
        end
        else begin
            mux_sel_b_ex = NO_BYPASS;
        end
    end
end

assign mux_sel_load_ex_o = mux_sel_load_ex;
assign mux_sel_a_ex_o = mux_sel_a_ex;
assign mux_sel_b_ex_o = mux_sel_b_ex;

assign use_bypass_a_ex_o = use_bypass_a_ex;
assign use_bypass_b_ex_o = use_bypass_b_ex;
assign use_bypass_a_wb_o = use_bypass_a_wb;
assign use_bypass_b_wb_o = use_bypass_b_wb;
assign use_bypass_a_mem_o = use_bypass_a_mem;
assign use_bypass_b_mem_o = use_bypass_b_mem;

endmodule : bypass_controller
