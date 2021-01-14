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


//---------------------------------------------------//
//--------------TESTBENCH DEFINITION-----------------//
//---------------------------------------------------//
module csr_regfile_tb;

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rsn;

//Standard write enable
logic we_tb;

// Write enable for especialitos (exceptions)
logic exc_we_tb;

// Read/write register IDs
logic [CSR_ID_BIT_SIZE:0] r_id_tb;
logic [CSR_ID_BIT_SIZE:0] w_id_tb;

// Write data
logic [WORD_SIZE-1:0] w_data_tb;

// Write data for exception registers (written if exc_we_i=1)
logic [WORD_SIZE-1:0] w_data_mtvec_tb; // @ of routine to manage the event
logic [WORD_SIZE-1:0] w_data_mepc_tb; // @ of return when finishing the event
logic [WORD_SIZE-1:0] w_data_mcause_tb; // ID cause of the event

// Data outputs
logic [WORD_SIZE-1:0] data_o_tb;

//Target module connection
segre_csr_register_file csr_regfile(

    //Standard signals
    .clk_i(clk),
    .rsn_i(rsn),

    .we_i(we_tb),
    .exc_we_i(exc_we_tb),

    .r_id_i(r_id_tb),
    .w_id_i(w_id_tb),
    
    .w_data_i(w_data_tb),

    .w_data_mtvec_i(w_data_mtvec_tb),
    .w_data_mepc_i(w_data_mepc_tb), 
    .w_data_mcause_i(w_data_mcause_tb),

    .data_o(data_o_tb)
);



//-----------------------------------------------------//
//--------------------BEHAVIOR-------------------------//
//-----------------------------------------------------//
//Initializing signals
initial begin
    clk <= 0;
    rsn <= 0;
end

always #10 clk = ~clk;

//Tests
initial begin
    //Two cycles for initial reset
    repeat(2) @(posedge clk);
    rsn <= 1;

    //Normal writes and reads to a register position
    for(int i = 0; i < 4; i++) begin
        we_tb <= 1;
        exc_we_tb <= 0;
        r_id_tb <= 12'h305;
        w_id_tb <= 12'h305;

        w_data_tb <= 32'hfaf0 + i;

        repeat(1) @(posedge clk);
    end

    //Set signals however the fuck between tests so we don't get lost
    we_tb <= 0;
    rsn <= 0;
    repeat(2) @(posedge clk);
    
    //Test exceptions to capture registers
    rsn <= 1;
    exc_we_tb <= 1;
    w_data_mtvec_tb <= 12'hff0;    
    w_data_mepc_tb <= 12'hff1;    
    w_data_mcause_tb <= 12'hff2;    

    repeat(4) @(posedge clk);

    //Finish the simulation
    $finish;
end


endmodule : csr_regfile_tb
