import segre_pkg::*;

//Basic store buffer of 4 entries (we can make it larger later if we want)
//Ara mateix és una mica l'esquelet incomplet, molt probablement li falten estats o està mal plantejat :(

//Port definition
module segre_store_buffer (

    //Standard signals
    input logic clk_i,
    input logic rsn_i,

    //Input ports
    input logic[WORD_SIZE-1:0] data_i,
    input logic[WORD_SIZE-1:0] addr_i,
    //Input signals to determine behavior. Only one can be active at a time.
    input logic is_load_i,
    input logic is_store_i,
    input logic is_alu_i,

    //Output ports
    output logic[WORD_SIZE-1:0] data_o,
    output logic[WORD_SIZE-1:0] addr_o,
    //Output signals depending on behavior
    output logic is_hit_o

);

//---------------------------INTERNAL STRUCTURES/DEFINITIONS------------------------//
//Definition and declaration of entries of the SB
typedef struct packed {
    logic [WORD_SIZE-1:0] data;
    logic [WORD_SIZE-1:0] address;
} sb_entry_t;
//I hope this garbage is right because it is not highlighting it...
sb_entry_t [NUM_SB_ENTRIES-1:0] sb_entries;

//Pointers and indicators
bit signed [SB_ENTRY_BITS-1:0] head;
bit signed [SB_ENTRY_BITS-1:0] tail;

logic [WORD_SIZE-1:0] data_from_pos;
logic [WORD_SIZE-1:0] addr_from_pos;
logic [WORD_SIZE-1:0] data_from_head;
logic [WORD_SIZE-1:0] addr_from_head;

logic [NUM_SB_ENTRIES-1:0] is_hit_bits;
logic is_hit;
logic [NUM_SB_ENTRIES-1:0] hit_position;

logic [NUM_SB_ENTRIES-1:0] sb_valid_entry;

/*
 * FIXME NOT VALID ANYMOREEEEEEE
 * Filthy definition of states:
 *  - EMPTY (if empty and cache not busy do nothing)
 *
 *  - NOT_EMPTY (hi ha alguna peticio adins, si estem en aquest estat
 *      i la cache no esta busy escrivim la peticio mes vella a la cache,
 *      si la cache esta busy i es un load, comprovem si es hit si es hit fem
 *      servir la dada del SB, si miss al SB i hit a cache (sudote), si hi ha dos misses,
 *      anem a memoria a demanarli al papa. Si es un store el fotem, comprovem si estem full,
 *      en aquest cas anem a estat full de
 *  - FULL  (if full and store, stall pipeline and jump to FLUSHING :3 )
 *
 *  - FLUSHING :3 (disable writes, when finished, jump to EMPTY (writes allowed))
 */
 typedef enum logic [1:0] {
    NOT_FLUSHING,
    FLUSHING
 } sb_states_t;

sb_states_t sb_state;
sb_states_t sb_next_state;

logic full, empty;

//assign full = (head - 1) == tail;
//assign empty = head == tail;
assign full = &sb_valid_entry;
assign empty = !(|sb_valid_entry);

//--------------------SEQUENTIAL LOGIC MANAGEMENT----------------------------------//
//State switching
always_ff @ (posedge clk_i, negedge rsn_i) begin : update_state
    //Initial state
    if (!rsn_i) begin
       sb_state <= NOT_FLUSHING;
    end
    //Next states
    else begin
        sb_state <= sb_next_state;
    end
end

always_comb begin : next_state
    if (!rsn_i) begin
        sb_next_state = NOT_FLUSHING;
    end
    else begin
        case (sb_state)
            NOT_FLUSHING: begin
               if (is_store_i && full || is_load_i && !is_hit) begin
                sb_next_state = FLUSHING;
               end
            end

            FLUSHING: begin
                if (empty) begin
                    sb_next_state = NOT_FLUSHING;
                end
            end
        endcase
    end
end

//Pointer udpates (no se si ho estic fent bé Marc, m'estic inspirant una mica
//entre la separació de lògica i estats que veig al arbiter) (ho fas genial, pero mhe petat uns estats)
always_ff @(posedge clk_i, negedge rsn_i) begin : writing_to_sb
    //Initial behavior coming from a reset
    if (!rsn_i) begin
        tail <= 0;
        sb_entries <= 0;
        head <= 0;
        sb_valid_entry <= 'b0;
    end
    else begin
        case (sb_state)
            NOT_FLUSHING: begin
                if (is_store_i && !full) begin
                    //Add new entry
                    $display($sformatf("la cola %h", tail));
                    sb_entries[tail].data <= data_i;
                    sb_entries[tail].address <= addr_i;
                    sb_valid_entry[tail] <= 1;
                    tail <= tail + 1;
                end

                if (is_alu_i) begin
                    sb_valid_entry[head] <= 0;
                    head <= head + 1;
                end
            end

            FLUSHING: begin
                if (!empty) begin
                    sb_valid_entry[head] <= 0;
                    head <= head + 1;
                end
            end
        endcase
    end
end

always_comb begin : reading_from_sb
    if (!rsn_i) begin
        data_from_pos = 0;
        addr_from_pos = 0;
        data_from_head = 0;
        addr_from_head = 0;
    end
    else begin

        case (sb_state)

            NOT_FLUSHING: begin

                if (is_load_i) begin
                // Iterate over the structure to see whether there is
                // a matching address (hit), or not (miss)
                    if (is_hit) begin
                        // I have to serve the data through the hit buffer, not to the cache
                        // but to the end of the stage. There will be a mux in the end of the stage
                        // and the controll will be with is_hit_o
                        //
                        // 0: data from cache
                        // 1: data from store buffer
                        data_from_pos = sb_entries[hit_position].data;
                        addr_from_pos = sb_entries[hit_position].address;
                    end
                end
                else if (is_alu_i) begin
                    data_from_head = sb_entries[head].data;
                    addr_from_head = sb_entries[head].address;
                end
            end

            FLUSHING: begin
                if (!empty) begin
                    data_from_head = sb_entries[head].data;
                    addr_from_head = sb_entries[head].address;
                end
            end
        endcase
    end

end

assign is_hit_o = is_hit && is_load_i;

always_comb begin
    if (!rsn_i) begin
        is_hit_bits = 'b0;
        hit_position = 0;
    end
    else begin
        for (int i = 0; i < NUM_SB_ENTRIES; i++) begin
            is_hit_bits[i] = (addr_i == (sb_entries[i].address)) && sb_valid_entry[i];
            hit_position = is_hit_bits ? i : hit_position;
        end
        is_hit = |is_hit_bits;
    end
end

assign data_o = (is_hit && sb_state == NOT_FLUSHING && is_load_i) ? data_from_pos : data_from_head;
assign addr_o = (is_hit && sb_state == NOT_FLUSHING && is_load_i) ? addr_from_pos : addr_from_head;

endmodule : segre_store_buffer
