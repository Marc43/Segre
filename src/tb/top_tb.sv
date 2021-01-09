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

localparam NUM_REGS = 2**REG_SIZE;

module top_tb;

    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic rsn;

    string test_name;
    int result_file_fd;

    segre_soc soc ();

    assign soc.segre_core_if.clk = clk;
    assign soc.segre_core_if.rsn = rsn;

    initial begin
        // Check for test files and setup fds for the test bench and memory
        if (!$value$plusargs("TEST_NAME=%s", test_name))
            `uvm_fatal("top_tb", "Couldn't find the TEST_NAME argument, please provide it with +TEST_NAME=<testname>")

        result_file_fd = $fopen($sformatf("./tests/result_segre/%s.result", test_name), "r");
        if (!result_file_fd)
            `uvm_warning("top_tb", $sformatf("Couldn't find the result file for %s", test_name))

    end

    initial begin
        clk <= 0;
        rsn <= 0;
    end

    always #10 clk = ~clk;

    initial begin
        repeat(2) @(posedge clk);
        rsn <= 1;
        fork
            begin
                `uvm_info("top_tb", "Starting test", UVM_LOW)
                run_tb;
            end
            begin
                monitor_tb;
            end
        join_any
        `uvm_info("top_tb", $sformatf("Results for test: %0s", test_name), UVM_LOW)
        check_results;
        `uvm_info("top_tb", "End Of Test", UVM_LOW)
        $finish;
    end

    task run_tb();
        while(keep_running_tb()) @(posedge clk);
    endtask

    function bit keep_running_tb();
        if (soc.dut.id_instr == 32'hfff01073 && soc.dut.fsm_state == ID_STATE) begin
            return 0;
        end

        return 1;
    endfunction

    function void check_results();
        int golden_results [32];
        static int counter = 0; // FIXME Static bc it is not modified. vlog reported errors
        logic [WORD_SIZE-1:0][NUM_REGS-1:0] segre_rf;
        string line;
        static bit error = 0;

        assign segre_rf = soc.dut.segre_rf.rf_reg;

        if (result_file_fd) begin
            // Read results from file
            while (!$feof(result_file_fd)) begin
                if ($fgets(line, result_file_fd)) begin
                    golden_results[counter] = line.atohex();
                    counter++;
                end
            end

            // Compare results
            foreach(golden_results[i]) begin
                if (golden_results[i] != segre_rf[i]) begin
                    error = 1;
                    `uvm_info("top_tb", $sformatf("Register file mismatch: In x%0d spike reported %0h and segre %0h", i, golden_results[i], segre_rf[i]), UVM_LOW)
                end
            end

            // Print both register files
            `uvm_info("top_tb", "Register\tSpike\t\t \t\tSegre", UVM_LOW)
            foreach(golden_results[i]) begin
                `uvm_info("top_tb", $sformatf("x%0d\t%0h\t\t \t\t%0h", i, golden_results[i], segre_rf[i]), UVM_LOW)
            end

            if (error)
                `uvm_error("top_tb", "REGISTER FILE MISSMATCH")
        end
        else begin
            `uvm_info("top_tb", "Register  Segre", UVM_LOW)
            foreach(golden_results[i]) begin
                `uvm_info("top_tb", $sformatf("x%0d      %0h", i, segre_rf[i]), UVM_LOW)
            end
        end
    endfunction

    task monitor_tb();
        `uvm_info("top_tb", "Starting tb monitor", UVM_LOW)
        forever begin
            static string instr_decoded;
            @(posedge clk);
            if (soc.dut.fsm_state == IF_STATE) begin
                    $display("DATA TO SEND LIBDECODER: %0d", soc.dut.id_instr);
`ifndef USE_MODELSIM
                    instr_decoded = decode_instruction(int'(soc.dut.id_instr));
`endif
                    `uvm_info("top_tb", $sformatf("PC: 0x%0h: %s (0x%0h) ", soc.dut.if_addr, instr_decoded, soc.dut.id_instr), UVM_LOW)
            end
        end
        `uvm_fatal("top_tb", "Shouldn't have reach this part of the monitor_tb")
    endtask

endmodule
