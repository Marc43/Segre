import segre_pkg::*;

//We assume that it only reads/writes one register at a time
//EXCEPT when dealing with exception, which have their three dedicated inputs for their three CSR

//---------------------------------------------------//
//--------------MODULE DEFINITION--------------------//
//---------------------------------------------------//

module segre_csr_register_file (
    // Clock and Reset
    input logic clk_i,
    input logic rsn_i,

    // Write enable for normalitos
    input logic we_i,

    // Write enable for especialitos (exceptions)
    input logic exc_we_i,

    // Read/write register IDs
    input logic [CSR_ID_BIT_SIZE:0] r_id_i,
    input logic [CSR_ID_BIT_SIZE:0] w_id_i,

    // Write data
    input logic [WORD_SIZE-1:0] w_data_i,

    // Write data for exception registers (written if exc_we_i=1)
    input logic [WORD_SIZE-1:0] w_data_mstatus_i,   // Register that codifies processor status (privilege, etc)
    input logic [WORD_SIZE-1:0] w_data_mtvec_i,     // @ of routine to manage the event
    input logic [WORD_SIZE-1:0] w_data_mepc_i,      // @ of return when finishing the event
    input logic [WORD_SIZE-1:0] w_data_mcause_i,    // ID cause of the event
    //POTENTIAL TODO: we should include the mscratch register?

    // Data outputs
    output logic [WORD_SIZE-1:0] data_o
);



//-----------------------------------------------------//
//----------INTERNAL STRUCTURE AND VARIABLES-----------//
//-----------------------------------------------------//

//Registers can't be organized as an array, they have an identifier
logic [WORD_SIZE-1:0] mstatus_reg;
logic [WORD_SIZE-1:0] mtvec_reg; 
logic [WORD_SIZE-1:0] mepc_reg; 
logic [WORD_SIZE-1:0] mcause_reg; 

//Debug register for default cases
logic [WORD_SIZE-1:0] debug_reg;



//-----------------------------------------------------//
//--------------------BEHAVIOR-------------------------//
//-----------------------------------------------------//

always_ff @(posedge clk_i) begin
    //Initialize regs
    if (!rsn_i) begin
        mstatus_reg <= 32'b0;
        mtvec_reg   <= 32'b0;
        mepc_reg    <= 32'b0;
        mcause_reg  <= 32'b0;
        debug_reg   <= 32'h0;
    end
    //Write into regs using IDs if no exception found
    else if (!exc_we_i && we_i) begin
        case (w_id_i)
           MSTATUS_ID   : mstatus_reg    <= w_data_i;
           MTVEC_ID     : mtvec_reg      <= w_data_i;
           MEPC_ID      : mepc_reg       <= w_data_i;
           MCAUSE_ID    : mcause_reg     <= w_data_i;
           default      : debug_reg      <= 32'h00000001; //Value to see that we've fucked up something when writing
        endcase
    end
    //Exception, ignore everything else and update related regs
    else if (exc_we_i) begin
        mstatus_reg <= w_data_mstatus_i;
        mtvec_reg   <= w_data_mtvec_i;
        mepc_reg    <= w_data_mepc_i;
        mcause_reg  <= w_data_mcause_i;
    end
end

//Output data pointed by ID
always_comb begin
    case (r_id_i)
        MSTATUS_ID  : data_o    = mstatus_reg;
        MTVEC_ID    : data_o    = mtvec_reg;
        MEPC_ID     : data_o    = mepc_reg;
        MCAUSE_ID   : data_o    = mcause_reg;
        default     : data_o    = 12'hfe0; //Debug value
    endcase
end

endmodule : segre_csr_register_file