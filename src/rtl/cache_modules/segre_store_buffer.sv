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
    input memop_data_type_e data_type_i,
    //Input signals to determine behavior. Only one can be active at a time.
    input logic is_load_i,
    input logic is_store_i,
    input logic is_alu_i,

    // Indicates if the cache found the position to write or not, if miss, do nothing!
    input logic is_hit_i,

    //Output ports
    output logic[WORD_SIZE-1:0] data_o,
    output logic[WORD_SIZE-1:0] addr_o,
    output memop_data_type_e data_type_o,
    //Output signals depending on behavior
    output logic is_hit_o,
    output logic reading_valid_entry_o,
    output logic is_draining_o
);

//---------------------------INTERNAL STRUCTURES/DEFINITIONS------------------------//
//Definition and declaration of entries of the SB
typedef struct packed {
    logic [WORD_SIZE-1:0] data;
    logic [WORD_SIZE-1:0] address;
    memop_data_type_e data_type;
} sb_entry_t;
//I hope this garbage is right because it is not highlighting it...
sb_entry_t [NUM_SB_ENTRIES-1:0] sb_entries;

//Pointers and indicators
logic [SB_ENTRY_BITS-1:0] rd_ptr;
logic [SB_ENTRY_BITS-1:0] wr_ptr;

logic [WORD_SIZE-1:0] data_from_pos;
logic [WORD_SIZE-1:0] addr_from_pos;
memop_data_type_e data_type_from_pos;
logic [WORD_SIZE-1:0] data_from_rd_ptr;
logic [WORD_SIZE-1:0] addr_from_rd_ptr;
memop_data_type_e data_type_from_rd_ptr;

logic [NUM_SB_ENTRIES-1:0] is_hit_bits;
logic is_hit;
logic [NUM_SB_ENTRIES-1:0] hit_position;

logic [NUM_SB_ENTRIES-1:0] sb_valid_entry;

typedef enum logic [1:0] {
    NOT_DRAINING,
    DRAINING
 } sb_states_t;

sb_states_t sb_state;
sb_states_t sb_next_state;

logic full, empty;

//assign full = (rd_ptr - 1) == wr_ptr;
//assign empty = rd_ptr == wr_ptr;
assign full = &sb_valid_entry;
assign empty = !(|sb_valid_entry);

logic [WORD_SIZE-1:N] addr_tag;
logic [N-1:M] addr_index;
logic [M-1:0] addr_byte;

assign addr_tag   = addr_i[WORD_SIZE-1:N];
assign addr_index = addr_i[N-1:M];
assign addr_byte  = addr_i[M-1:0];

logic is_draining;

//--------------------SEQUENTIAL LOGIC MANAGEMENT----------------------------------//
//State switching
always_ff @ (posedge clk_i, negedge rsn_i) begin : update_state
    //Initial state
    if (!rsn_i) begin
       sb_state <= NOT_DRAINING;
    end
    //Next states
    else begin
        sb_state <= sb_next_state;
    end
end

always_comb begin : next_state
    if (!rsn_i) begin
        sb_next_state = NOT_DRAINING;
    end
    else begin
        case (sb_state)
            NOT_DRAINING: begin
               /* When there is a load miss (miss in the cache tags) where the index (cache line)
                * collides with one that has valid data, and we have a hit in the store buffer meaning that
                * there is pending request for that line, we have to block the pipeline and flush the store buffer completely.
                */

               /* The second case of the or is really confusing, let us explain it here:
                * We are issuing a read operation (load), where:
                * is_hit_i is the cache hit, in this case it is a miss.
                * is_hit   is the store buffer hit, if is 1 means that the line that is being read in
                * cache it is also pending to be written by an entry of the store buffer.
                */
               if ((is_store_i && full) || is_load_i && !is_hit_i && is_hit) begin
                sb_next_state = DRAINING;
               end
            end

            DRAINING: begin
                if (empty) begin
                    sb_next_state = NOT_DRAINING;
                end
            end
        endcase
    end
end

//Pointer udpates (no se si ho estic fent bé Marc, m'estic inspirant una mica
//entre la separació de lògica i estats que veig al arbiter) (ho fas genial, pero mhe petat uns estats)
always @(posedge clk_i, negedge rsn_i) begin : writing_to_sb
    //Initial behavior coming from a reset
    if (!rsn_i) begin
        wr_ptr <= 0;
        sb_entries <= 0;
        rd_ptr <= 0;
        sb_valid_entry <= 'b0;
    end
    else begin
        case (sb_state)
            NOT_DRAINING: begin
                if (is_store_i && !full && !is_draining) begin
                    //Add new entry
                    sb_entries[wr_ptr].data <= data_i;
                    sb_entries[wr_ptr].address <= addr_i;
                    sb_entries[wr_ptr].data_type <= data_type_i;
                    sb_valid_entry[wr_ptr] <= 1;
                    wr_ptr <= wr_ptr + 1;
                end

                if (is_alu_i && !empty || is_draining) begin
                    sb_valid_entry[rd_ptr] <= 0;
                    rd_ptr <= rd_ptr + 1;
                end
            end

            DRAINING: begin
                if (!empty) begin
                    sb_valid_entry[rd_ptr] <= 0;
                    rd_ptr <= rd_ptr + 1;
                end
            end
        endcase
    end
end


always_comb begin : reading_from_sb
    if (!rsn_i) begin
        data_from_pos = 0;
        addr_from_pos = 0;
        data_type_from_pos = BYTE;
        data_from_rd_ptr = 0;
        addr_from_rd_ptr = 0;
        data_type_from_rd_ptr = BYTE;
    end
    else begin

        case (sb_state)

            NOT_DRAINING: begin
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
                        data_type_from_pos = sb_entries[hit_position].data_type;
                    end
                end
                else if (is_alu_i && !empty || is_draining) begin
                    data_from_rd_ptr = sb_entries[rd_ptr].data;
                    addr_from_rd_ptr = sb_entries[rd_ptr].address;
                    data_type_from_rd_ptr = sb_entries[rd_ptr].data_type;
                end
            end

            DRAINING: begin
                if (!empty) begin
                    data_from_rd_ptr = sb_entries[rd_ptr].data;
                    addr_from_rd_ptr = sb_entries[rd_ptr].address;
                    data_type_from_rd_ptr = sb_entries[rd_ptr].data_type;
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
            is_hit_bits[i] = (addr_index == (sb_entries[i].address[N-1:M])) && sb_valid_entry[i];
            hit_position = is_hit_bits ? i : hit_position;
        end
        is_hit = |is_hit_bits;
    end
end

assign is_draining = (sb_state == DRAINING) || full && is_store_i;

assign data_o = (is_hit && (sb_state == NOT_DRAINING) && is_load_i) ? data_from_pos : data_from_rd_ptr;
assign addr_o = (is_hit && (sb_state == NOT_DRAINING) && is_load_i) ? addr_from_pos : addr_from_rd_ptr;
assign data_type_o = (is_hit && (sb_state == NOT_DRAINING) && is_load_i) ? data_type_from_pos : data_type_from_rd_ptr;
assign reading_valid_entry_o = (is_alu_i || (sb_state == DRAINING) || is_draining) && !empty;
assign is_draining_o = is_draining;

endmodule : segre_store_buffer
