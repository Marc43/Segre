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

module cache_tb;

    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic rsn;

    logic rd;
    logic wr;
    logic rcvd_mem_req;
    memop_data_type_e data_type;
    logic [WORD_SIZE-1:0] addr;
    logic [WORD_SIZE-1:0] data_in;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_in;
    logic is_hit;
    logic writeback_mem;
    logic [WORD_SIZE-1:0] data_out;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_out;

    parameter NUMBER_OF_LINES = 4;
    parameter M = $clog2(CACHE_LINE_SIZE_BITS);
    parameter N = $clog2(CACHE_LINE_SIZE_BITS*NUMBER_OF_LINES/8);
    parameter TAG_SIZE = WORD_SIZE - N + 1;

    logic [WORD_SIZE-1:N] addr_tag;
    logic [N-1:M] addr_index;
    logic [M-1:0] addr_byte;

    assign addr = {addr_tag, addr_index, addr_byte};

    segre_cache cache
    (
        .clk_i (clk),
        .rsn_i (rsn),

        .rd_i (rd),
        .wr_i (wr),
        .rcvd_mem_request_i (rcvd_mem_req),
        .data_type_i (data_type),
        .addr_i (addr),
        .data_i (data_in),
        .from_mem_cache_line_i (from_mem_cache_in),
        .is_hit_o (is_hit),
        .writeback_mem_o (writeback_mem),
        .data_o (data_out),
        .to_mem_cache_line_o (to_mem_cache_out)
    );

    `define display_outputs \
        $display($sformatf("is_hit_o: %h", is_hit)); \
        $display($sformatf("writeback_mem_o: %h", writeback_mem)); \
        $display($sformatf("data_o: %h", data_out)); \
        $display($sformatf("to_mem_cache_line_o: %h", to_mem_cache_out));

    task read_petition(input logic [WORD_SIZE-1:N] tag_, input logic [N-1:M] index_, input logic [M-1:0] byte_, memop_data_type_e data_type_);
        @(posedge clk);
        addr_tag = tag_;
        addr_index = index_;
        addr_byte = byte_;
        data_type = data_type_;
        rd = 1;
        wr = 0;
        rcvd_mem_req = 0;
        from_mem_cache_in = 0;
        @(posedge clk); // Acknowledge the read
        @(posedge clk); // Wait for hit/miss

        if (!is_hit) begin
            repeat (10) @(posedge clk); // It's a miss, memory spends 10 cycles to read the line

            addr_tag = 0;
            addr_index = 0;
            addr_byte = 0;

            rd = 1;
            wr = 0;

            rcvd_mem_req = 1; // Line sent from memory
            from_mem_cache_in = 128'hff_ee_dd_cc_bb_aa_99_88_77_66_55_44_33_22_11_00;

            @(posedge clk); // Cache stores the line in the next cycle

            rcvd_mem_req = 0;

        end

        @(posedge clk); // Ready petition again

        rd = 0;

    endtask : read_petition

    initial begin
        clk <= 0;
        rsn <= 0;
    end

    always #10 clk = ~clk;

    initial begin
        repeat(2) @(posedge clk);
        rsn <= 1;

        /*
         *
         *  parameter NUMBER_OF_LINES = 4;
         *  parameter M = $clog2(CACHE_LINE_SIZE/8);
         *  parameter N = $clog2(CACHE_LINE_SIZE*NUMBER_OF_LINES/8);
         *  parameter TAG_SIZE = WORD_SIZE - N + 1;
         *
         * 31                  10           3       0
         * |      TAG          |    INDEX   |  BYTE |
         *
         */

        for (int i = 0; i < NUMBER_OF_LINES-1; i++) begin
            for (int j = 0; j < CACHE_LINE_SIZE_BYTES-1; j++) begin
                read_petition(0, i, j, BYTE);
            end
        end

        for (int i = 0; i < NUMBER_OF_LINES-1; i++) begin
            for (int j = 0; j < CACHE_LINE_SIZE_BYTES-1; j = j + 2) begin
                read_petition(0, i, j, HALF);
            end
        end

        for (int i = 0; i < NUMBER_OF_LINES-1; i++) begin
            for (int j = 0; j < CACHE_LINE_SIZE_BYTES-1; j = j + 4) begin
                read_petition(0, i, j, WORD);
            end
        end

        repeat(50) @(posedge clk);
        $finish;

    end

endmodule : cache_tb
