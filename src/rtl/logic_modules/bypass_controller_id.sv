import segre_pkg::*;

module bypass_controller_id (
    input logic clk_i,
    input logic rsn_i,

    // Instruction decode stage

    input logic valid_id_i,

    input logic rd_src_a_id_i,
    input logic rd_src_b_id_i,

    output bypass_id_sel_e mux_sel_a_id_o, // 2 bits to select RF, Execute, Memory, Writeback data
    output bypass_id_sel_e mux_sel_b_id_o,

    // Execute stage

    input logic valid_ex_i,
    input logic data_produced_ex_i,

    input logic depEX_src_a_i,
    input logic depEX_src_b_i,

    output logic use_bypass_a_ex_o,
    output logic use_bypass_b_ex_o,

    // Memory stage

    input logic valid_mem_i,
    input logic data_produced_mem_i,

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
    output logic use_bypass_b_wb_o

);

bypass_id_sel_e bypass_mux_sel_a;
bypass_id_sel_e bypass_mux_sel_b;

always_comb begin
    if (!rsn_i) begin
        bypass_mux_sel_a = ID_RF;
        bypass_mux_sel_b = ID_RF;
        use_bypass_a_ex_o = 0;
        use_bypass_b_ex_o = 0;
        use_bypass_a_wb_o = 0;
        use_bypass_b_wb_o = 0;
        use_bypass_a_mem_o = 0;
        use_bypass_b_mem_o = 0;
    end
    else begin

        // Select for source operand A
        if (valid_ex_i && data_produced_ex_i && depEX_src_a_i) begin
            bypass_mux_sel_a  = EXECUTE_BYPASS;
            use_bypass_a_ex_o = 1;
            use_bypass_a_mem_o = 0;
            use_bypass_a_wb_o = 0;
        end
        else if (valid_mem_i && data_produced_mem_i && depMEM_src_a_i) begin
            bypass_mux_sel_a = MEMORY_BYPASS;
            use_bypass_a_ex_o = 0;
            use_bypass_a_mem_o = 1;
            use_bypass_a_wb_o = 0;
        end
        else if (valid_wb_i && data_produced_ex_i && depEX_src_a_i) begin
            bypass_mux_sel_a = WRITEBACK_BYPASS;
            use_bypass_a_ex_o = 0;
            use_bypass_a_mem_o = 0;
            use_bypass_a_wb_o = 1;
        end
        else begin
            bypass_mux_sel_a = ID_RF;
            use_bypass_a_ex_o = 0;
            use_bypass_a_mem_o = 0;
            use_bypass_a_wb_o = 0;
        end

        // Select for source operand B
        if (valid_ex_i && data_produced_ex_i && depEX_src_b_i) begin
            bypass_mux_sel_b = EXECUTE_BYPASS;
            use_bypass_b_ex_o = 1;
            use_bypass_b_mem_o = 0;
            use_bypass_b_wb_o = 0;
        end
        else if (valid_mem_i && data_produced_mem_i && depMEM_src_b_i) begin
            bypass_mux_sel_b = MEMORY_BYPASS;
            use_bypass_b_mem_o = 1;
            use_bypass_b_ex_o = 0;
            use_bypass_b_wb_o = 0;
        end
        else if (valid_wb_i && data_produced_ex_i && depEX_src_b_i) begin
            bypass_mux_sel_b = WRITEBACK_BYPASS;
            use_bypass_b_wb_o = 1;
            use_bypass_b_ex_o = 0;
            use_bypass_b_mem_o = 0;
        end
        else begin
            bypass_mux_sel_b = ID_RF;
            use_bypass_b_ex_o = 0;
            use_bypass_b_mem_o = 0;
            use_bypass_b_wb_o = 0;
        end
    end
end

assign mux_sel_a_id_o = bypass_mux_sel_a;
assign mux_sel_b_id_o = bypass_mux_sel_b;

endmodule : bypass_controller_id
