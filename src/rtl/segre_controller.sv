import segre_pkg::*;

module segre_controller (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    input logic is_mem_instr_i,
    input logic mem_ready_i,

    // State
    output fsm_state_e state_o

);

fsm_state_e state = IF_STATE;
fsm_state_e next_state;

always_ff @(posedge clk_i) begin
    unique case(state)
        IF_STATE: begin
            if (mem_ready_i) begin
                next_state = ID_STATE;
            end
            else begin
                next_state = IF_STATE;
            end
        end
        ID_STATE: next_state = EX_STATE;
        EX_STATE: next_state = MEM_STATE;
        MEM_STATE: begin
              if (is_mem_instr_i) begin
                  if (mem_ready_i) begin
                    next_state = WB_STATE;
                  end
                  else begin
                    next_state = MEM_STATE;
                  end
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
        default: next_state = IF_STATE;
    endcase
end

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        state = IF_STATE;
    end
    else begin
        state = next_state;
    end
end

assign state_o = state;
endmodule
