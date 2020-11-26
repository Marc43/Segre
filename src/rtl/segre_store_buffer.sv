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

//---------------------------INTERNAL STRUCTURES/DEFINITIONS------------------------//
//Definition and declaration of entries of the SB
typedef struct packed {
    logic [WORD_SIZE-1:0] data;
    logic [WORD_SIZE-1:0] addr;
} sb_entry_t;
//I hope this garbage is right because it is not highlighting it...
sb_entry_t [SB_ENTRY_BITS-1:0] sb_entries;

//Pointers and indicators
logic [SB_ENTRY_BITS-1:0] head;
logic [SB_ENTRY_BITS-1:0] tail;

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
 typedef enum logic [1:0] {
    EMPTY,
    NOT_EMPTY,
    FULL,
    FLUSHING
 } sb_states_t;

sb_states_t sb_state;
sb_states_t sb_next_state;

//--------------------SEQUENTIAL LOGIC MANAGEMENT----------------------------------//
//State switching
always_ff @ (posedge clk_i, negedge rsn_i) begin
    //Initial state
    if (!rsn_i) begin
       head <= 'b0;
       tail <= 'b0;
       sb_state <= EMPTY;
    end
    //Next states
    else begin
        sb_state <= sb_next_state;
    end
end

//Pointer udpates (no se si ho estic fent bé Marc, m'estic inspirant una mica
//entre la separació de lògica i estats que veig al arbiter)
always @(posedge clk_i, negedge rsn_i) begin
    if (is_store_i && (sb_state == EMPTY || sb_state == NOT_EMPTY))
        //Add new entry
        sb_entries[tail].data <= data_i;
        sb_entries[tail].address <= address_i;
        tail <= tail+1;
end

//-----------------------COMBINATORIAL LOGIC MANAGEMENT------------------------------//
always_comb begin
    //Initial behavior coming from a reset
    if (!rsn_i) begin
        sb_next_state = EMPTY;
    end
    else begin
        //Behavior when dealing with a STORE
        if (is_store_i) begin
            if (sb_state == EMPTY) begin
                sb_next_state = NOT_EMPTY;
            end
        end

        //Behavior when dealing with a LOAD
        else if (is_load_i) begin
            //TODO
        end

        //Behavior when dealing with an ALU op
        else if (is_alu_i) begin
            //TODO
        end
    end
end
