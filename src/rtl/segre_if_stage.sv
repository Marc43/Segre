import segre_pkg::*;

module segre_if_stage (
    // Clock and Reset
    input  logic clk_i,
    input  logic rsn_i,

    // Memory
    input  logic [WORD_SIZE-1:0] instr_i,
    input  logic mem_ready_i,
    output logic [ADDR_SIZE-1:0] pc_o,
    output logic mem_rd_o,

    // FSM state
    input fsm_state_e fsm_state_i,

    // IF ID interface
    output logic [WORD_SIZE-1:0] instr_o,

    // WB interface
    input logic tkbr_i,
    input logic [WORD_SIZE-1:0] new_pc_i
);

logic [ADDR_SIZE-1:0] nxt_pc;

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        nxt_pc <= 0;
    end
    else if (!mem_ready_i && fsm_state_i == IF_STATE) begin
        nxt_pc <= nxt_pc;
    end
    else begin
        if (tkbr_i && fsm_state_i == WB_STATE) begin
            nxt_pc <= new_pc_i;
        end
        else if (fsm_state_i == WB_STATE) begin
            nxt_pc <= nxt_pc + 4;
        end
        else begin
            nxt_pc <= nxt_pc;
        end
    end
end

assign mem_rd_o = fsm_state_i == IF_STATE ? 1'b1 : 1'b0;

always_ff @(posedge clk_i) begin
    instr_o <= mem_ready_i ? instr_i : NOP_INSTR;
    pc_o    <= nxt_pc;
end

endmodule : segre_if_stage
