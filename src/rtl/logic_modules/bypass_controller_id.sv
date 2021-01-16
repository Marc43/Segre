import segre_pkg::*;

module bypass_controller_id (
    input logic clk_i,
    input logic rsn_i,

    // Instruction decode stage

    input logic [REG_SIZE-1:0] src_a_identifier_id_i,
    input logic [REG_SIZE-1:0] src_b_identifier_id_i,

    input logic rd_src_a_id_i,
    input logic rd_src_b_id_i,

    output logic [1:0] mux_sel_a_id_o, // 2 bits to select RF, Execute, Memory, Writeback data
    output logic [1:0] mux_sel_b_id_o,

    // Execute stage

    input logic valid_ex_i,
    input logic data_produced_ex_i,
    input logic [REG_SIZE-1:0] dst_reg_identifier_ex_i,

    input logic depEX_src_a_i,
    input logic depEX_src_b_i,

    // Memory stage

    input logic valid_ex_i,
    input logic data_produced_ex_i,
    input logic [REG_SIZE-1:0] dst_reg_identifier_ex_i,

    input logic depMEM_src_a_i,
    input logic depMEM_src_b_i,

    // Writeback stage

    input logic valid_ex_i,
    input logic data_produced_ex_i,
    input logic [REG_SIZE-1:0] dst_reg_identifier_ex_i,

    input logic depWB_src_a_i,
    input logic depWB_src_b_i

);

endmodule : bypass_controller_id
