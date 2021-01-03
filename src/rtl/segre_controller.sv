import segre_pkg::*;

module segre_controller (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    input logic is_mem_instr_i,
    input logic mem_ready_i,
    input logic instruction_hit_if_i,
    input logic data_cache_is_busy_i,
    input logic data_cache_is_hit_i,

    // State
    output fsm_state_e state_o

);

fsm_state_e state;
fsm_state_e next_state;

always_comb begin
    unique case(state)
        IF_STATE: begin
            if (instruction_hit_if_i) begin
                next_state = ID_STATE;
            end
            else begin
                next_state = IF_STATE;
            end
        end
        ID_STATE: next_state = EX_STATE;
        EX_STATE: next_state = MEM_STATE;
        MEM_STATE: begin

              if (data_cache_is_busy_i || (!data_cache_is_hit_i && is_mem_instr_i)) begin
                next_state = MEM_STATE;
              end
              else begin
                next_state = WB_STATE;
              end

    // Equivalent to:
    //            if (is_mem_instr_i && !mem_ready_i) begin
    //                next_state = MEM_STATE;
    //            end
    //            else if (!is_mem_instr_i || mem_ready_i) begin
    //                next_state = WB_STATE;
    //            end
        end
        WB_STATE: next_state = IF_STATE;
        default: next_state = IF_STATE;
    endcase
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        state <= IF_STATE;
    end
    else begin
        state <= next_state;
    end
end

assign state_o = state;

endmodule
