import segre_pkg::*;

module segre_controller (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    input logic finish_test_i,
    output logic finish_test_o,

    output logic sel_mem_req_o,

    // INSTRUCTION FETCH STAGE

    input valid_if_i,

    input logic ic_if_hit_i, // instruction cache @ if stage

    output logic block_if_o,
    output logic inject_nops_if_o, // Not used
    output logic blocked_1cycle_ago_if_o,

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
    input logic tkbr_i,

    output logic block_ex_o,
    output logic inject_nops_ex_o,
    output logic tkbr_o,

    //////////////////////////////////

    // MEM STAGE

    input logic dc_rd_i,
    input logic dc_wr_i,
    input logic dc_mem_hit_i, // data cache hit @ mem stage
    input logic store_buffer_draining_i,

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

assign tkbr_o = tkbr_i;

logic finish_test_d_1;
logic finish_test_d_2;
logic finish_test_d_3;

logic finish_test_q_1;
logic finish_test_q_2;
logic finish_test_q_3;

logic or_block_if;
logic or_block_id;
logic or_block_ex;
logic or_block_mem;
logic or_block_wb;

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
            inject_nops_id = !or_block_id;
        end
//        else if (tkbr_i) begin
//            block_if = 1;
//            inject_nops_id = 0;
//        end
        else if (finish_test_q_1) begin
            block_if = 1;
            inject_nops_id = 1;
        end
        else begin
            block_if = 0;
            inject_nops_id = 0;
        end
    end
end

logic blocked1cycleago_if_d;
logic blocked1cycleago_if_q;

always_comb begin
    if (!rsn_i) begin
        blocked1cycleago_if_d = 0;
    end
    else begin
        blocked1cycleago_if_d = block_if;
    end
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        blocked1cycleago_if_q <= 0;
    end
    else begin
        blocked1cycleago_if_q <= blocked1cycleago_if_d;
    end
end

assign blocked_1cycle_ago_if_o = blocked1cycleago_if_q;

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

always_comb begin : data_dependences_detection_or_tkbr
    if (!rsn_i) begin
        block_id = 0;
        inject_nops_ex = 0;
    end
    else begin
        if ((depEX || depMEM || depWB) && valid_id_i) begin
            block_id = 1;
            inject_nops_ex = 1;
        end
        else if (tkbr_i) begin
            // Not blocking ID and injecting nops in EX
            // results in discarding instructions, that's
            // exactly what we need.
            block_id = 0;
            inject_nops_ex = 1;
        end
        else begin
            block_id = 0;
            inject_nops_ex = 0;
        end

    end
end

//////////////////////////////
// MEM CONTROL

logic block_mem;
logic inject_nops_wb;

always_comb begin : cache_miss_in_mem
    if (!rsn_i) begin
        block_mem = 0;
        inject_nops_wb = 0;
    end
    else begin
        if (!dc_mem_hit_i && valid_mem_i && (dc_rd_i || dc_wr_i)) begin
            block_mem = 1;
            inject_nops_wb = 1;
        end
        else if (store_buffer_draining_i) begin
            block_mem = 1;
            inject_nops_wb = 1;
        end
        else begin
            block_mem = 0;
            inject_nops_wb = 0;
        end
    end
end

assign or_block_if = block_if || or_block_id;
assign or_block_id = block_id || or_block_ex; //|| block_ex_o;
assign or_block_ex = 0 || or_block_mem; //|| block_mem_o;
assign or_block_mem = block_mem || or_block_wb; // || block_wb_o;
assign or_block_wb = 0;

assign block_if_o = or_block_if;
assign block_id_o = or_block_id;
assign block_ex_o = or_block_ex;
assign block_mem_o = or_block_mem;
assign block_wb_o = 0;

assign inject_nops_id_o = inject_nops_id;
assign inject_nops_if_o = 0; //inject_nops_if; TODO Is this really possible?
assign inject_nops_ex_o = inject_nops_ex;
assign inject_nops_mem_o = 0;
assign inject_nops_wb_o = inject_nops_wb;

// Finish test signal

always_comb begin
    if (!rsn_i) begin
        finish_test_d_1 = 0;
    end
    else begin
        if (!finish_test_q_1) begin
            finish_test_d_1 = finish_test_i;
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

assign finish_test_o = finish_test_q_3;

// Arbiter part

/*
 * As long as caches do keep the requests
 * until they are served we can just give priority
 * to the IC rather than the DC.
 *
 * We need ic_hit and dc_hit, we will capture the
 * rcvd_mem_req and send it to which one we have to.
 *
 * Also, we will have and output controlling
 * the muxes of addr and data to main memory.
 */

logic rcvd_mem_req;
logic sel_mem_req;

always_comb begin
    if (!rsn_i) begin
        rcvd_mem_req = 0;
        sel_mem_req = 0;
    end
    else begin
        if (!ic_if_hit_i && !dc_mem_hit_i && (dc_rd_i || dc_wr_i) && valid_mem_i) begin
            sel_mem_req = 0; // Select IC addr and data
        end
        else if (!ic_if_hit_i) begin
            sel_mem_req = 0;
        end
        else if (!dc_mem_hit_i && (dc_rd_i || dc_wr_i) && valid_mem_i) begin
            sel_mem_req = 1;
        end
        else begin
            sel_mem_req = 0; // Select IC addr and data
        end
    end
end

assign sel_mem_req_o = sel_mem_req;


endmodule : segre_controller
