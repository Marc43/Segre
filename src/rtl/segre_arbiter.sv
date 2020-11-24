import segre_pkg::*;

module segre_arbiter (
    input logic clk_i,
    input logic rsn_i,

    // Incoming from caches
    input logic icache_valid_req_i,
    input  cache_mem_req_t icache_request_i,
    input logic dcache_valid_req_i,
    input  cache_mem_req_t dcache_request_i,

    // From Memory
    input logic valid_cache_line_i,
    input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_line_i,

    // To Memory
    output cache_mem_req_t selected_request_o,

    // To caches
    output logic icache_valid_o,
    output logic dcache_valid_o,
    output [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line_o
);

typedef enum logic [1:0] {
    WAIT_MEM_RSP,
    SEND_NEW_CACHE_REQ
} arb_states_t;

arb_states_t act_state, nxt_state;

cache_mem_req_t [ARB_BUF_SIZE-1:0] requests;

logic [ARB_PTR_SIZE-1:0] wr_ptr;
logic [ARB_PTR_SIZE-1:0] rd_ptr;

logic valid_req_icache, valid_req_dcache, valid_req_sel;

logic full, empty;

assign full = rd_ptr - 1 == wr_ptr;
assign empty = rd_ptr == wr_ptr;

assign valid_req_icache = (icache_request_i.rd || icache_request_i.wr) && icache_valid_req_i;
assign valid_req_dcache = (dcache_request_i.rd || dcache_request_i.wr) && dcache_valid_req_i;
assign valid_req_sel = selected_request_o.rd || selected_request_o.wr;

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        act_state <= SEND_NEW_CACHE_REQ;
    end
    else begin
        act_state <= nxt_state;
    end
end

always_comb begin
    if (!rsn_i) begin
        nxt_state = SEND_NEW_CACHE_REQ;
    end

    case (act_state)
        WAIT_MEM_RSP: begin
            if (valid_cache_line_i) begin
                nxt_state = SEND_NEW_CACHE_REQ;
            end
        end

        SEND_NEW_CACHE_REQ: begin
            if (wr_ptr != rd_ptr) begin
                nxt_state = WAIT_MEM_RSP;
            end
        end
    endcase
end

/*
 *  requests buffer structure:
 *  ARB_PTR_SIZE+1       ARB_PTR_SIZE-1               0
 *   |       cache              |       request       |
 *
 */

// FIXME It's useless but I'm kind of lazy these days
function cache_mem_req_t write_request(cache_mem_req_t request, cache_id_e cache);
    cache_mem_req_t ret;

    ret = request;
    ret.cache_id = cache;

    return ret;
endfunction : write_request

always @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        wr_ptr <= 0;
    end
    else begin

        if (!full) begin
            if (valid_req_icache && valid_req_dcache) begin
                requests[wr_ptr] <= icache_request_i;
                requests[wr_ptr].cache_id <= ICACHE;
                requests[wr_ptr+1] <= dcache_request_i;
                requests[wr_ptr+1].cache_id <= DCACHE;
                wr_ptr <= wr_ptr + 2;
            end
            else if (valid_req_icache) begin
                requests[wr_ptr] <= icache_request_i;
                requests[wr_ptr].cache_id <= ICACHE;
                wr_ptr <= wr_ptr + 1;
            end
            else if (valid_req_dcache) begin
                requests[wr_ptr] <= dcache_request_i;
                requests[wr_ptr].cache_id <= DCACHE;
                wr_ptr <= wr_ptr + 1;
            end
        end
    end

end

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        rd_ptr <= 0;
    end
    else begin
        case (act_state)
            SEND_NEW_CACHE_REQ: begin
                if (!empty) begin
                    selected_request_o <= requests[rd_ptr];
                    rd_ptr <= rd_ptr + 1;
                end
            end
        endcase


    end

end

logic valid_cache_line;
assign valid_cache_line = (act_state == WAIT_MEM_RSP) ? valid_cache_line_i : 0;

assign icache_valid_o = valid_cache_line ? !selected_request_o.cache_id : 0;
assign dcache_valid_o = valid_cache_line ? selected_request_o.cache_id : 0;
assign cache_line_o = from_mem_cache_line_i;

endmodule : segre_arbiter
