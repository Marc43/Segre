import segre_pkg::*;

//Basic store buffer of 4 entries (we can make it larger later if we want)
//Ara mateix és una mica l'esquelet incomplet, molt probablement li falten estats o està mal plantejat :(

//Port definition
module segre_store_buffer(
    //Standard signals
    input logic clk_i;
    input logic rsn_i;

    //Input ports
    input logic[WORD_SIZE-1:0] data_i;
    input logic[WORD_SIZE-1:0] addr_i;
    //Input signals to determine behavior. Only one can be active at a time.
    input logic is_load_i;
    input logic is_store_i;
    input logic is_alu_i;

    //Output ports
    output logic[WORD_SIZE-1:0] data_o;
    output logic[WORD_SIZE-1:0] addr_o;
    //Output signals depending on behavior
    output logic is_hit_o;
);

//---------------------------INTERNAL STRUCTURES------------------------------------//
//Entries of the SB
// TODO
// good idea to collapse into one structure
// struct_t data_entries, addr_entires
//
//typedef struct packed {
//    logic [WORD_SIZE-1:0] data;
//    logic [WORD_SIZE-1:0] addr;
//} cache_mem_req_t;
logic [SB_ENTRY_BITS-1:0][WORD_SIZE-1:0] data_entries;
logic [SB_ENTRY_BITS-1:0][WORD_SIZE-1:0] addr_entries;

//Pointers and indicators
logic [SB_ENTRY_BITS-1:0] head;
logic [SB_ENTRY_BITS-1:0] tail;
logic is_full;

/*
 * Filthy definition of states:
 *  - EMPTY (if empty and cache not busy do nothing)
 *
 *  - NOT_EMPTY (hi ha alguna peticio adins, si estem en aquest estat
 *      i la cache no esta busy escrivim la peticio mes vella a la cache,
 *      si la cache esta busy i es un load, comprovem si es hit si es hit fem
 *      servir la dada del SB, si miss al SB i hit a cache (sudote), si hi ha dos misses,
 *      anem a memoria a demanarli al papa. Si es un store el fotem, comprovem si estem full,
 *      en aquest cas anem a estat full del estambul)
 *  - FULL  (if full and store, stall pipeline and jump to FLUSHING :3 )
 *
 *  - FLUSHING :3 (disable writes, when finished, jump to EMPTY (writes allowed))
 */

//--------------------SEQUENTIAL LOGIC AND STATE MANAGEMENT--------------------------//
always_ff @ (posedge clk_i, negedge rsn_i) begin
    //Ara mateix ni zorra de que posar aquí, només l'estat inicial
    if(!rsn_i) begin
       head <= 'b0;
       tail <= 'b0;
       is_full <= 0;
    end
end

//-----------------------COMBINATORIAL LOGIC MANAGEMENT------------------------------//
always_comb begin
    //Behavior when dealing with a STORE
    else if (is_store_i) begin
        //TODO
    end

    //Behavior when dealing with a LOAD
    if (is_load_i) begin
        //TODO
    end

    //Behavior when dealing with an ALU op
    else if (is_alu_i) begin
        //TODO
    end

end
