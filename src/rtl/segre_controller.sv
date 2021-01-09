import segre_pkg::*;

module segre_controller (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // INSTRUCTION FETCH STAGE

    input logic ic_if_hit_i,

    output logic block_if_o,
    output logic inject_nops_if_o,

    ///////////////////////////////////

    // INSTRUCTION DECODE STAGE

    input logic [REG_SIZE-1:0] src_a_identifier_id_i,
    input logic [REG_SIZE-1:0] src_b_identifier_id_i,

    output logic block_id_o,
    output logic inject_nops_id_o,

    //////////////////////////////////

    // EXECUTION STAGE

    input logic [REG_SIZE-1:0] dst_reg_identifier_ex_i,
    input logic we_ex_i,

    output logic block_ex_o,
    output logic inject_nops_ex_o,

    //////////////////////////////////

    // MEM STAGE

    input logic [REG_SIZE-1:0] dst_reg_identifier_mem_i,
    input logic we_mem_i,

    //////////////////////////////////

    // WB STAGE

    input logic [REG_SIZE-1:0] dst_reg_identifier_wb_i,
    input logic we_wb_i


);

// INSTRUCTION FETCH CONTROL

logic block_if;
logic inject_nops_if;

always_comb begin : miss_when_fetching_instruction
    if (!rsn_i) begin
        block_if = 0;
        inject_nops_if = 0;
    end
    else begin
        if (!ic_if_hit_i) begin
            block_if = 1;
            inject_nops_if = 1;
        end
        else begin
            block_if = 0;
            inject_nops_if = 0;
        end
    end
end

assign block_if_o = block_if;
assign inject_nops_if_o = inject_nops_if;

//////////////////////////////

// DECODE CONTROL ( a little bit of EX too :) )

logic block_id;
logic inject_nops_id;
logic inject_nops_ex;

logic depEX;
logic depMEM;
logic depWB;

assign depEX = ((src_a_identifier_id_i == dst_reg_identifier_ex_i) || (src_b_identifier_id_i == dst_reg_identifier_ex_i)) && we_ex_i;
assign depMEM = ((src_a_identifier_id_i == dst_reg_identifier_mem_i) || (src_b_identifier_id_i == dst_reg_identifier_mem_i)) && we_mem_i;
assign depWB = ((src_a_identifier_id_i == dst_reg_identifier_wb_i) || (src_b_identifier_id_i == dst_reg_identifier_wb_i)) && we_wb_i;

always_comb begin : data_dependences_detection
    if (!rsn_i) begin
        block_id = 0;
        inject_nops_id = 0;
    end
    else begin
        if (depEX || depMEM || depWB) begin
            block_id = 1;
            inject_nops_ex = 1;
        end
        else begin
            block_id = 0;
            inject_nops_ex = 0;
        end

    end
end

endmodule : segre_controller
