`ifdef USE_MODELSIM
    `define uvm_info(_a, _b, _c) $info("%0s: %0s", _a, _b);
    `define uvm_fatal(_a, _b) $fatal("%0s: %0s", _a, _b);
`else
    `include "uvm_macros.svh"
    import uvm_pkg::*;
`endif

import segre_pkg::*;

module memory (
    input logic clk_i,
    input logic rsn_i,

    // RD || WR request
    input logic rd_i,
    input logic wr_i,

    // RD WR request ready
    output logic mem_ready_o,

    input memop_data_type_e data_type_i,
    input logic [WORD_SIZE-1:0] addr_i,
    input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] data_i,
    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line_o
);

parameter NUM_WORDS = 1024 * 64; // 64Kb
parameter TEXT_REGION = 0;
//parameter DATA_REGION = 1024*32;
parameter DATA_REGION = 32'hA000;

// Duration of requests in cycles
parameter REQUEST_DURATION = 9;

logic [7:0] mem [NUM_WORDS-1:0];

logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] rd_data;

logic [$clog2(REQUEST_DURATION)-1:0] cyc_counter;

logic mem_ready;
assign mem_ready_o = mem_ready;

// This signal is used to get the first 4 bits of the addr to 0 in order to read cache lines correctly
logic [WORD_SIZE-1:0] aligned_addr_to_cache_lines;
logic [WORD_SIZE-1:0] addr_i_ff;
assign aligned_addr_to_cache_lines = {addr_i_ff >> 4, 4'b0000}; // For a good desing, use parameters...

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        addr_i_ff <= 0;
    end
    else begin
        if (((rd_i || wr_i) && (cyc_counter != 1)) || mem_ready) begin
            addr_i_ff <= addr_i;
        end
        else begin
            addr_i_ff <= addr_i_ff;
        end
    end
end

// If read or write, there's a request to mem
logic mem_request;
assign mem_request = rd_i | wr_i;

logic aux_rd;
logic aux_wr;

// Internal signal to start the reading of the memory
logic write_read_data;

int num_of_instructions = 0;

int hex_file_fd;
string test_name;

`define rd_word_mem(mem, addr) \
    `uvm_info("memory", $sformatf("Reading %0h from %0h", {mem[addr], mem[addr+1], mem[addr+2], mem[addr+3]}, addr), UVM_LOW);

`define wr_word_mem(mem, word, addr) \
    `uvm_info("memory", $sformatf("Writting at %0h the data %0h", addr, word), UVM_LOW); \
    mem[addr] = word >> 24; \
    mem[addr+1] = word >> 16; \
    mem[addr+2] = word >> 8; \
    mem[addr+3] = word; \

initial begin
    int addr = 0;
    static string line, hex_file_name;

    // Read the hex file path and open the file in read mode
    num_of_instructions = 0;

    // Check for test files and setup fds for the test bench and memory
    if (!$value$plusargs("TEST_NAME=%s", test_name))
        `uvm_fatal("top_tb", "Couldn't find the TEST_NAME argument, please provide it with +TEST_NAME=<testname>")
    else
        `uvm_info("top_tb", $sformatf("Starting test: %s", test_name), UVM_LOW)

    hex_file_fd = $fopen($sformatf("./tests/hex_segre/%s.hex", test_name), "r");
    if (!hex_file_fd)
        `uvm_fatal("top_tb", $sformatf("Couldn't find the hex file for %s", test_name))

    `uvm_info("memory", "Start writing test to memory", UVM_LOW)
    while (!$feof(hex_file_fd)) begin
        if ($fgets(line, hex_file_fd)) begin
            assert (addr < DATA_REGION) else `uvm_fatal("memory", ".text was about to get written in .data section")
            `uvm_info("memory", $sformatf("Writting in %0h the data %0d", addr, line.substr(0, 7)), UVM_LOW);
            mem[addr]   = line.substr(6, 7).atohex();
            mem[addr+1] = line.substr(4, 5).atohex();
            mem[addr+2] = line.substr(2, 3).atohex();
            mem[addr+3] = line.substr(0, 1).atohex();
            addr += 4;
            num_of_instructions++;
        end
    end
    `uvm_info("memory", $sformatf("Test written into memory, %0d instructions written", num_of_instructions), UVM_LOW)

    addr = DATA_REGION;
    `uvm_info("memory", "Start writing data to memory", UVM_LOW)
    `wr_word_mem(mem, 32'hfafafafa, addr)
    `wr_word_mem(mem, 32'hfafafafa, addr+4)
    `wr_word_mem(mem, 32'hfafafafa, addr+8)
    `wr_word_mem(mem, 32'hfafafafa, addr+12)
    `wr_word_mem(mem, 32'hfafafafa, addr+16)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+20)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+24)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+28)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+32)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+36)
    `wr_word_mem(mem, 32'hfafafafa, addr+40)
    `wr_word_mem(mem, 32'hfafafafa, addr+44)
    `wr_word_mem(mem, 32'hfafafafa, addr+48)
    `wr_word_mem(mem, 32'hfafafafa, addr+52)
    `wr_word_mem(mem, 32'hfafafafa, addr+56)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+60)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+64)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+68)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+72)
    `wr_word_mem(mem, 32'h5a5a5a5a, addr+76)
    for (int i = addr+80; i < NUM_WORDS; i = i + 4) begin
        `wr_word_mem(mem, 32'h00000000, i)
    end
end

always @(posedge clk_i) begin

    if (!rsn_i) begin
        cyc_counter = 'b0;
        aux_rd = 1'b0;
        aux_wr = 1'b0;
    end
    else begin

        // Start the count of REQUEST_DURATION cycles
        if (mem_request || cyc_counter != 1) begin
            cyc_counter = cyc_counter + 1;
        end

        if (mem_request) begin
            aux_rd = rd_i;
            aux_wr = wr_i;
        end
        else begin
            aux_rd = aux_rd;
            aux_wr = aux_wr;
        end

        /*
         * - When REQUEST_DURATION-1 we start reading memory to have it at cycle REQUEST_DURATION (1 cycle after)
         * - When REQUEST_DURATION, we set mem_ready_o to 1 and we stop reading.
         * - When different from above, not ready and not reading.
         */
        if (cyc_counter == REQUEST_DURATION-1) begin
            write_read_data = aux_rd || aux_wr;
        end
        else if (cyc_counter == REQUEST_DURATION) begin
            write_read_data = 1'b0;
            aux_rd = 1'b0;
            aux_wr = 1'b0;
            mem_ready = 1'b1;
            cyc_counter = 0;
        end
        else begin
            write_read_data = 1'b0;
            mem_ready = 1'b0;
        end

        // Read
        if (write_read_data && aux_rd) begin
            rd_data = 0;
            for (int i = CACHE_LINE_SIZE_BYTES-1; i >= 0; i--) begin
                rd_data = {rd_data, mem[aligned_addr_to_cache_lines+i]};
            end
        end

        // Write
        if (write_read_data && aux_wr) begin
            for (int i = 0; i < CACHE_LINE_SIZE_BYTES; i++) begin
                mem[aligned_addr_to_cache_lines+i] = data_i[i];
            end
        end

    end

    memory_verbose();
end

always @(posedge clk_i) begin
    cache_line_o <= rd_data;
end

task memory_verbose;
    if (write_read_data && aux_rd) begin
        `uvm_info("memory", $sformatf("Reading data: %h from %h", rd_data, addr_i), UVM_MEDIUM)
    end

    if (write_read_data && aux_wr) begin
        `uvm_info("memory", $sformatf("Writing %s: %h at %h", data_type_i.name(), data_i, aligned_addr_to_cache_lines), UVM_MEDIUM)
    end
endtask

endmodule : memory
