import segre_pkg::*;

//We assume that it only reads/writes one register at a time
//EXCEPT when dealing with exception, which have their three dedicated inputs for their three CSR

//

//---------------------------------------------------//
//--------------MODULE DEFINITION--------------------//
//---------------------------------------------------//

module segre_register_file (
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
    input logic [WORD_SIZE-1:0] w_data_i;

    // Write data for exception registers (written if exc_we_i=1)
    input logic [WORD_SIZE-1:0] w_data_mtvec_i, // @ of routine to manage the event
    input logic [WORD_SIZE-1:0] w_data_mepc_i, // @ of return when finishing the event
    input logic [WORD_SIZE-1:0] w_data_mcause_i, // ID cause of the event

    // Data outputs
    output logic [WORD_SIZE-1:0] data_o
);



//-----------------------------------------------------//
//----------INTERNAL STRUCTURE AND VARIABLES-----------//
//-----------------------------------------------------//

//Registers can't be organized as an array, they have an identifier
logic [WORD_SIZE-1:0] mtvec_reg; 
logic [WORD_SIZE-1:0] mpec_reg; 
logic [WORD_SIZE-1:0] mcause_reg; 



//-----------------------------------------------------//
//--------------------BEHAVIOR-------------------------//
//-----------------------------------------------------//

always_ff @(posedge clk_i) begin
    //Initialize regs
    if (!rsn_i) begin
        mtvec_reg <= 32'b0;
        mpec_reg <= 32'b0;
        mcause_reg <= 32'b0;
    end
    //Write into regs using IDs if no exception found
    else if (!exc_we_i && we_i) begin
        case (w_id_i)
           0 : cache_sb_mux_data <= data_i;
           1 : cache_sb_mux_data <= data_sb_o;
           default : cache_sb_mux_data <= data_i;
        endcase
    end
    //Exception, ignore everything else and update related regs
    else begin
        
    end
end

assign rf_reg[0] = '0;
assign rf_reg[31:1] = rf_reg_aux[31:1];

assign data_a_o = rf_reg[raddr_a_i];
assign data_b_o = rf_reg[raddr_b_i];

endmodule : segre_register_file