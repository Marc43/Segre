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

    segre_arbiter arb
    (
        .clk_i(clk),
        .rsn_i(rsn),

        .icache_request_i(icache_req),
        .dcache_request_i(dcache_req),

        .selected_request_o(out_req)
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

        repeat (ARB_BUF_SIZE-1) begin
            icache_req.rd = 0;
            icache_req.wr = 1;
            icache_req.addr = $urandom();

            dcache_req.rd = 0;
            dcache_req.wr = 1;
            dcache_req.addr = $urandom();

            @(posedge clk);
        end

        icache_req.rd = 0;
        icache_req.wr = 0;
        dcache_req.rd = 0;
        dcache_req.wr = 0;

        repeat(50) @(posedge clk);

        $finish;

    end

endmodule : arbiter_tb
