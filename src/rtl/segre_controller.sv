import segre_pkg::*;

module segre_controller (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    output logic finish_test_o,

    // INSTRUCTION FETCH STAGE

    input valid_if_i,

    input logic ic_if_hit_i,

    output logic block_if_o,
    output logic inject_nops_if_o, // Not used

    ///////////////////////////////////

    // INSTRUCTION DECODE STAGE

    input logic valid_id_i,

    input logic [REG_SIZE-1:0] src_a_identifier_id_i,
    input logic [REG_SIZE-1:0] src_b_identifier_id_i,

    input logic [WORD_SIZE-1:0] decode_instr_i,

    output logic block_id_o,
    output logic inject_nops_id_o,

    //////////////////////////////////

    // EXECUTION STAGE

    input logic valid_ex_i,

    input logic [REG_SIZE-1:0] dst_reg_identifier_ex_i,
    input logic we_ex_i,

    output logic block_ex_o,
    output logic inject_nops_ex_o,

    //////////////////////////////////

    // MEM STAGE

    input logic valid_mem_i,

    input logic [REG_SIZE-1:0] dst_reg_identifier_mem_i,
    input logic we_mem_i,

    output logic block_mem_o,
    output logic inject_nops_mem_o,

    //////////////////////////////////

    // WB STAGE

    input logic valid_wb_i,

    input logic [REG_SIZE-1:0] dst_reg_identifier_wb_i,
    input logic we_wb_i,

    output logic block_wb_o,
    output logic inject_nops_wb_o


);

logic finish_test_d_1;
logic finish_test_d_2;
logic finish_test_d_3;
logic finish_test_d_4;

logic finish_test_q_1;
logic finish_test_q_2;
logic finish_test_q_3;
logic finish_test_q_4;

logic or_block_if_id;
logic or_block_id_ex;
logic or_block_ex_mem;
logic or_block_mem_wb;

// INSTRUCTION FETCH CONTROL

logic block_if;
logic inject_nops_if;
logic inject_nops_id;

always_comb begin : miss_when_fetching_instruction
    if (!rsn_i) begin
        block_if = 0;
        inject_nops_id = 0;
    end
    else begin
        if (!ic_if_hit_i) begin
            block_if = 1;
            inject_nops_id = !or_block_id_ex;
        end
        else if (((decode_instr_i == 32'hfff01073) && valid_id_i) || finish_test_q_1) begin
            block_if = 1;
            inject_nops_id = 1;
        end
        else begin
            block_if = 0;
            inject_nops_id = 0;
        end
    end
end


//////////////////////////////

// DECODE CONTROL ( a little bit of EX too :) )

logic block_id;
logic inject_nops_ex;

logic depEX;
logic depMEM;
logic depWB;

assign depEX = ((src_a_identifier_id_i == dst_reg_identifier_ex_i) || (src_b_identifier_id_i == dst_reg_identifier_ex_i)) && we_ex_i && valid_ex_i;
assign depMEM = ((src_a_identifier_id_i == dst_reg_identifier_mem_i) || (src_b_identifier_id_i == dst_reg_identifier_mem_i)) && we_mem_i && valid_mem_i;
assign depWB = ((src_a_identifier_id_i == dst_reg_identifier_wb_i) || (src_b_identifier_id_i == dst_reg_identifier_wb_i)) && we_wb_i && valid_wb_i;

always_comb begin : data_dependences_detection
    if (!rsn_i) begin
        block_id = 0;
        inject_nops_ex = 0;
    end
    else begin
        if ((depEX || depMEM || depWB) && valid_id_i) begin
            block_id = 1;
            inject_nops_ex = 1;
        end
        else begin
            block_id = 0;
            inject_nops_ex = 0;
        end

    end
end

/*
 * Recorda que d'alguna manera has de fer que es bloquejin les etapes anteriors tambe, si no, no funcionara res... TODO
 */

assign or_block_if_id = block_if || block_id;
assign or_block_id_ex = block_id; //|| block_ex_o;
assign or_block_ex_mem = 0; //|| block_mem_o;
assign or_block_mem_wb = 0; // || block_wb_o;

assign block_if_o = or_block_if_id;
assign block_id_o = or_block_id_ex;
assign block_ex_o = or_block_ex_mem;
assign block_mem_o = or_block_mem_wb;
assign block_wb_o = 0;

assign inject_nops_id_o = inject_nops_id;
assign inject_nops_if_o = 0; //inject_nops_if; TODO Is this really possible?
assign inject_nops_ex_o = inject_nops_ex;
assign inject_nops_mem_o = 0;
assign inject_nops_wb_o = 0;

// Finish test signal

always_comb begin
    if (!rsn_i) begin
        finish_test_d_1 = 0;
    end
    else begin
        if (!finish_test_q_1) begin
            finish_test_d_1 = ((decode_instr_i == 32'hfff01073) && valid_id_i);
        end
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        finish_test_q_1 <= 0;
    end
    else begin
        finish_test_q_1 <= finish_test_d_1;
    end
end

always_comb begin
    if (!rsn_i) begin
        finish_test_d_2 = 0;
    end
    else begin
        finish_test_d_2 = finish_test_q_1;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        finish_test_q_2 <= 0;
    end
    else begin
        finish_test_q_2 <= finish_test_d_2;
    end
end

always_comb begin
    if (!rsn_i) begin
        finish_test_d_3 = 0;
    end
    else begin
        finish_test_d_3 = finish_test_q_2;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        finish_test_q_3 <= 0;
    end
    else begin
        finish_test_q_3 <= finish_test_d_3;
    end
end

always_comb begin
    if (!rsn_i) begin
        finish_test_d_4 = 0;
    end
    else begin
        finish_test_d_4 = finish_test_q_3;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        finish_test_q_4 <= 0;
    end
    else begin
        finish_test_q_4 <= finish_test_q_3;
    end
end

assign finish_test_o = finish_test_q_4;

endmodule : segre_controller
