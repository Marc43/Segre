import segre_pkg::*;

module segre_arbiter (
    input logic clk_i,
    input logic rsn_i,

    input  cache_mem_req_t icache_request_i,
    input  cache_mem_req_t dcache_request_i,

    output cache_mem_req_t selected_request_o
);

cache_mem_req_t [ARB_BUF_SIZE-1:0] requests;

logic [ARB_PTR_SIZE-1:0] wr_ptr;
logic [ARB_PTR_SIZE-1:0] rd_ptr;

logic valid_req_icache, valid_req_dcache, valid_req_sel;

assign valid_req_icache = icache_request_i.rd || icache_request_i.wr;
assign valid_req_dcache = dcache_request_i.rd || dcache_request_i.wr;
assign valid_req_sel = selected_request_o.rd || selected_request_o.wr;

always @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end
    else begin
        if (valid_req_icache && valid_req_dcache) begin
            requests[wr_ptr] <= icache_request_i;
            requests[wr_ptr+1] <= dcache_request_i;
            wr_ptr <= wr_ptr + 2;
        end
        else if (valid_req_icache) begin
            requests[wr_ptr] <= icache_request_i;
            wr_ptr <= wr_ptr + 1;
        end
        else if (valid_req_dcache) begin
            requests[wr_ptr] <= dcache_request_i;
            wr_ptr <= wr_ptr + 1;
        end

        if (wr_ptr != rd_ptr) begin
            selected_request_o <= requests[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
        else begin
            selected_request_o <= '{default:'0};
        end
    end
end

endmodule : segre_arbiter
