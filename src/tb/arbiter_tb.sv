`ifdef USE_MODELSIM
    `define uvm_info(_a, _b, _c) $info("%0s: %0s", _a, _b);
    `define uvm_fatal(_a, _b) $fatal("%0s: %0s", _a, _b);
    `define uvm_error(_a, _b) $error("%0s: %0s", _a, _b);
    `define uvm_warning(_a, _b) $warning("%0s: %0s", _a, _b);
`else
    `include "uvm_macros.svh"
    import uvm_pkg::*;
`endif

import segre_pkg::*;

// We should free the pointer but could't find a way to do it with the free_ptr funciton
// because SV seems to lose the ptr since pointers are not a thing in SV
`ifndef USE_MODELSIM
import "DPI-C" function string decode_instruction(input int bits);
import "DPI-C" function void free_ptr(chandle ptr);
`endif

module arbiter_tb;

    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic rsn;

    cache_mem_req_t icache_req;
    cache_mem_req_t dcache_req;

    cache_mem_req_t out_req;

    logic icache_valid_o;
    logic dcache_valid_o;

    logic icache_valid_req, dcache_valid_req;

    logic valid_cache_line;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line_o;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line_i;

    segre_arbiter arb
    (
        .clk_i(clk),
        .rsn_i(rsn),

        .icache_valid_req_i(icache_valid_req),
        .dcache_valid_req_i(dcache_valid_req),

        .icache_request_i(icache_req),
        .dcache_request_i(dcache_req),

        .from_mem_cache_line_i(cache_line_i),

        .selected_request_o(out_req),

        .icache_valid_o(icache_valid_o),
        .dcache_valid_o(dcache_valid_o),

        .valid_cache_line_i(valid_cache_line),

        .cache_line_o(cache_line_o)
    );

    initial begin
        clk <= 0;
        rsn <= 0;
    end

    always #10 clk = ~clk;

    initial begin
        repeat(2) @(posedge clk);
        rsn <= 1;

        icache_req = '{default:'0};
        dcache_req = '{default:'0};

        valid_cache_line = 0;

        icache_valid_req = 0;
        dcache_valid_req = 0;

        @(posedge clk);

        repeat (ARB_BUF_SIZE-1) begin
            icache_valid_req = 1;
            dcache_valid_req = 1;

            icache_req.rd = 0;
            icache_req.wr = 1;
            icache_req.addr = $urandom();

            dcache_req.rd = 0;
            dcache_req.wr = 1;
            dcache_req.addr = $urandom();

            @(posedge clk);
        end

        icache_valid_req = 0;
        dcache_valid_req = 0;
        icache_req.rd = 0;
        icache_req.wr = 0;
        dcache_req.rd = 0;
        dcache_req.wr = 0;

        @(posedge clk);

        repeat (ARB_BUF_SIZE-1) begin
            valid_cache_line = 1;
            cache_line_i = $urandom();
            @(posedge clk);
            valid_cache_line = 0;
            @(posedge clk);
        end

        repeat(50) @(posedge clk);

        $finish;

    end

endmodule : arbiter_tb
