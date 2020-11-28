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

module sb_cache_tb;

    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic rsn;

    logic [WORD_SIZE-1:0] data_tb;
    logic [WORD_SIZE-1:0] addr_tb;

    logic is_load;
    logic is_store;
    logic is_alu;

    logic [WORD_SIZE-1:0] data_o_sb;
    logic [WORD_SIZE-1:0] addr_o_sb;
    logic is_hit_o_sb;

    segre_store_buffer ssb(

        //Standard signals
        .clk_i(clk),
        .rsn_i(rsn),

        //Input ports
        .data_i(data_tb),
        .addr_i(addr_tb),

        //Input signals to determine behavior. Only one can be active at a time.
        .is_load_i(is_load),
        .is_store_i(is_store),
        .is_alu_i(is_alu),

        //Output ports
        .data_o(data_o_sb),
        .addr_o(addr_o_sb),
        .is_hit_o(is_hit_o_sb)

    );

    logic rd;
    logic wr;
    logic rcvd_mem_req;
    memop_data_type_e data_type;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_in;
    logic is_hit;
    logic writeback_mem;
    logic [WORD_SIZE-1:0] data_out;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_out;

    logic [WORD_SIZE-1:N] addr_tag;
    logic [N-1:M] addr_index;
    logic [M-1:0] addr_byte;

    assign addr = {addr_tag, addr_index, addr_byte};

    logic [WORD_SIZE-1:0] cache_sb_mux_data;
    logic [WORD_SIZE-1:0] cache_sb_mux_addr;

    segre_cache cache
    (
        .clk_i (clk),
        .rsn_i (rsn),

        .rd_i (rd),
        .wr_i (wr),
        .rcvd_mem_request_i (rcvd_mem_req),
        .data_type_i (data_type),
        .addr_i (cache_sb_mux_addr),
        .data_i (cache_sb_mux_data),
        .from_mem_cache_line_i (from_mem_cache_in),
        .is_hit_o (is_hit),
        .writeback_mem_o (writeback_mem),
        .data_o (data_out),
        .to_mem_cache_line_o (to_mem_cache_out)
    );

  logic muxes_signal;
  assign muxes_signal = is_hit_o_sb & is_store;

  always @*
  case (muxes_signal)
     0 : cache_sb_mux_data <=  data_tb;
     1 : cache_sb_mux_data <= data_o_sb;
     default : cache_sb_mux_data <= data_tb;
  endcase

  always @*
  case (muxes_signal)
     0 : cache_sb_mux_addr <= addr_tb;
     1 : cache_sb_mux_addr <= addr_o_sb;
     default : cache_sb_mux_data <= addr_tb;
  endcase

  initial begin
      clk <= 0;
      rsn <= 0;
  end

  assign wr = is_alu || (is_load && is_hit_o_sb);

  always #10 clk = ~clk;

  initial begin
    int addr_var = 0;
    repeat(2) @(posedge clk);
    rsn <= 1;

    is_load = 0;
    is_store = 0;
    is_alu = 0;

    repeat(10) @(posedge clk);

    // FILL the SB
    repeat(4) begin
        is_store = 1;
        data_tb = $random();
        addr_tb = addr_var;
        addr_var = addr_var + 1;
        @(posedge clk);
        is_store = 0;
    end

    repeat(4) begin
        is_alu = 1;
        @(posedge clk);
        is_alu = 0;
    end

    is_store = 0;

    repeat(10) @(posedge clk);

    $finish;

  end
endmodule : sb_cache_tb

