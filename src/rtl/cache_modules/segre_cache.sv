import segre_pkg::*;

module segre_cache #(parameter ICACHE_DCACHE = ICACHE)
(
    input logic clk_i,
    input logic rsn_i,

    input logic rd_i, // is_load
    input logic wr_i, // is_store
    input logic is_alu_i, // is_alu

    input logic rcvd_mem_request_i,
    input memop_data_type_e data_type_i,
    input logic [WORD_SIZE-1:0] addr_i,
    input logic [WORD_SIZE-1:0] data_i,
    input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_line_i,
    output logic is_hit_o, // If 1 hit, 0 miss (es un temazo!) (fer servir com rd de memoria ~is_hit)
    output logic is_busy_o,
    output logic writeback_mem_o,
    output logic [WORD_SIZE-1:0] writeback_addr_o,
    output logic [WORD_SIZE-1:0] data_o,
    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line_o,
    output logic store_buffer_draining_o,
    output logic rd_o,
    output logic wr_o
);

/*
 * TODO FIXME TODO FIXME *
 * Do not update states if SB has activated signal: store_buffer_draining_o
 * By the moment the maximum cycles it takes to drain the SB is ~5, so we are
 * kind of hiding the latency. But if we decide to increase the number of entries
 * we will have problems.
 */

logic [WORD_SIZE-1:N] addr_tag;
logic [N-1:M] addr_index;
logic [M-1:0] addr_byte;

assign addr_tag   = addr_i[WORD_SIZE-1:N];
assign addr_index = addr_i[N-1:M];
assign addr_byte  = addr_i[M-1:0];

logic [NUMBER_OF_LINES-1:0] valid_bits;
logic [NUMBER_OF_LINES-1:0] dirty_bits;

typedef enum logic [1:0] {
    READING_TAGS,
    WRITING_DATA,
    WRITEBACK_WR,
    REQ_MEM_DATA_WR
} cache_wr_states_t;

typedef enum logic [1:0] {
    READING_DATA,
    WRITEBACK_RD,
    REQ_MEM_DATA_RD
} cache_rd_states_t;

cache_wr_states_t cache_wr_act_state;
cache_rd_states_t cache_rd_act_state;
cache_wr_states_t cache_wr_next_state;
cache_rd_states_t cache_rd_next_state;

logic is_writeback;
logic write_line_from_mem;
logic write_into_word;
logic is_hit_from_tags;
logic is_hit;
logic [WORD_SIZE-1:0] data_from_cache_data;
logic reading_valid_entry_sb_o;
logic draining_buffer_sb_o;
logic draining_buffer;
logic is_hit_sb_o;
logic do_not_block_state_update;

assign write_line_from_mem = ((cache_rd_act_state == REQ_MEM_DATA_RD) && rcvd_mem_request_i);

// If is ICACHE, value is 0, then we must use only the state, if it's 1 is DCACHE, we must take into account SB writes.
assign write_into_word = ICACHE_DCACHE ? reading_valid_entry_sb_o
                                       : (cache_wr_act_state == WRITING_DATA);
assign is_writeback = cache_rd_act_state == WRITEBACK_RD || cache_wr_act_state == WRITEBACK_WR;
assign is_hit = valid_bits[addr_index] && is_hit_from_tags; // Doesn't take into account the state of the cache

// lmao quan hem escrit aquesta brossa jajajaj
assign writeback_mem_o = is_writeback ? 1'b1 : 1'b0;

assign data_o = (cache_rd_act_state == READING_DATA) ? data_from_cache_data : 'b0;

// This signal takes into account whether the states are the correct ones.
// Becoming uglier change by change...
logic is_hit_in_tags_state;
assign is_hit_in_tags_state = is_hit && ((cache_rd_act_state == READING_DATA) && (cache_wr_act_state == READING_TAGS));

assign is_hit_o = is_hit_in_tags_state;

assign draining_buffer = ICACHE_DCACHE ? draining_buffer_sb_o : 0;
assign store_buffer_draining_o = ICACHE_DCACHE ? draining_buffer : 0;

// Draining buffer or the operation is a miss. Then we consider the cache to be busy, this may be changed when pipelined TODO

// This is kind of "complicated" for what it is, but I need to have it as a register. May be changed...
//
logic is_busy;

always_ff @(posedge clk_i) begin
    if (!rsn_i) begin
        is_busy <= 0;
    end
    else begin
        if ((cache_rd_act_state == READING_DATA) && rd_i || (cache_wr_act_state == READING_TAGS) && wr_i) begin
            is_busy <= draining_buffer || !is_hit_in_tags_state;
        end
        else if (is_hit_in_tags_state) begin
            is_busy <= draining_buffer;
        end
    end
end

assign is_busy_o = is_busy;

assign do_not_block_state_update = ICACHE_DCACHE ? draining_buffer || (!is_hit && is_hit_sb_o) : 0;

assign rd_o = (cache_rd_act_state == REQ_MEM_DATA_RD);
assign wr_o = (cache_wr_act_state == WRITEBACK_WR) || (cache_rd_act_state == WRITEBACK_RD);

always_ff @(posedge clk_i, negedge rsn_i) begin
    if(!rsn_i) begin
        cache_wr_act_state <= READING_TAGS;
        cache_rd_act_state <= READING_DATA;
    end
    else begin
        cache_wr_act_state <= cache_wr_next_state;
        cache_rd_act_state <= cache_rd_next_state;
    end
end

always_comb begin

    if (!rsn_i) begin
        cache_wr_next_state = READING_TAGS;
        cache_rd_next_state = READING_DATA;
    end
    /* Another confusing case, do not update state if:
     *  - sb is draining
     *  - there is a miss in the cache and there is a hit in the sb, we need to drain first.
     */
    else if (do_not_block_state_update) begin
        cache_wr_next_state = cache_wr_act_state;
        cache_rd_next_state = cache_rd_act_state;
    end
    else begin
        /*
         * Read next state
         */
        if (rd_i && cache_rd_act_state == READING_DATA) begin
            if (!is_hit) begin
                if (dirty_bits[addr_index]) begin
                    cache_rd_next_state = WRITEBACK_RD;
                    cache_wr_next_state = REQ_MEM_DATA_WR;
                end
                else begin
                    cache_rd_next_state = REQ_MEM_DATA_RD;
                end
            end
            else begin
                cache_rd_next_state = READING_DATA;
            end

        end
        else if (cache_rd_act_state == REQ_MEM_DATA_RD && rcvd_mem_request_i) begin
            cache_rd_next_state = READING_DATA;
        end
        else if (cache_rd_act_state == WRITEBACK_RD && cache_wr_next_state == REQ_MEM_DATA_WR && rcvd_mem_request_i) begin
            cache_rd_next_state = REQ_MEM_DATA_RD;
        end

        /*
         * Write next state
         */
        if (wr_i && cache_wr_act_state == READING_TAGS) begin
            if (!is_hit) begin
                if (dirty_bits[addr_index]) begin
                    cache_wr_next_state = WRITEBACK_WR;
                end
                else begin
                    cache_wr_next_state = WRITING_DATA;
                    cache_rd_next_state = REQ_MEM_DATA_RD;
                end
            end
            else begin
                cache_wr_next_state = WRITING_DATA;
            end
        end
        else if (cache_wr_act_state == WRITING_DATA) begin
            if (cache_rd_act_state != READING_TAGS) begin
                cache_wr_next_state = WRITING_DATA;
            end
            else if (valid_bits[addr_index]) begin
                cache_wr_next_state = READING_TAGS;
            end
            else begin
                cache_wr_next_state = READING_TAGS;
                cache_rd_next_state = REQ_MEM_DATA_RD;
            end
        end
        else if (cache_wr_act_state == WRITEBACK_WR) begin
            cache_wr_next_state = REQ_MEM_DATA_WR;
        end
        else if (cache_wr_act_state == REQ_MEM_DATA_WR && rcvd_mem_request_i) begin
            cache_wr_next_state = WRITING_DATA;
            cache_rd_next_state = REQ_MEM_DATA_RD;
        end
    end
end

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        valid_bits <= 'b0;
        dirty_bits <= 'b0;
    end
    else begin
        if (write_into_word) begin
            dirty_bits[addr_index] <= 1'b1;
        end
        else if (write_line_from_mem) begin
            valid_bits[addr_index] <= 1'b1;
            dirty_bits[addr_index] <= 1'b0;
        end
        else if (is_writeback) begin
            valid_bits[addr_index] <= 1'b0;
            dirty_bits[addr_index] <= 1'b0;
        end
    end
end

logic [WORD_SIZE-N-1:0] tag_in_cacheline;
logic [WORD_SIZE-1:0] writeback_addr;

// Pick the stable one when there is no writeback.
assign writeback_addr_o = !is_writeback ? writeback_addr : {tag_in_cacheline, addr_index, 4'b0000};

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        writeback_addr <= 0;
    end
    else begin
        if (is_writeback) begin
            writeback_addr <= {tag_in_cacheline, addr_index, 4'b0000};
        end
        else begin
            writeback_addr <= writeback_addr;
        end

    end
end

/*
 * When the Store Buffer has a valid position signal
 * reading_valid_entry_sb_o will become 1 and that means
 * that cache data will write the store buffer entry.
 * Otherwise, when it's 0, it will write whatever is feeded
 * from the stage.
 */

/////////////////// 2-1 MUX Outputs
logic [WORD_SIZE-1:0] cache_sb_mux_data;
logic [WORD_SIZE-1:0] cache_sb_mux_addr;
memop_data_type_e cache_sb_mux_dtype;
//////////////////

logic [WORD_SIZE-1:0] data_sb_o;
logic [WORD_SIZE-1:0] addr_sb_o;
memop_data_type_e data_type_sb_o;

logic sb_muxes_select;
assign sb_muxes_select = (ICACHE_DCACHE == DCACHE) ? reading_valid_entry_sb_o : 0;

always @* begin
    case (sb_muxes_select)
       0 : cache_sb_mux_data <= data_i;
       1 : cache_sb_mux_data <= data_sb_o;
       default : cache_sb_mux_data <= data_i;
    endcase
end

always @* begin
    case (sb_muxes_select)
       0 : cache_sb_mux_addr <= addr_i;
       1 : cache_sb_mux_addr <= addr_sb_o;
       default : cache_sb_mux_data <= addr_i;
    endcase
end

always @* begin
    case (sb_muxes_select)
        0 : cache_sb_mux_dtype <= data_type_i;
        1 : cache_sb_mux_dtype <= data_type_sb_o;
        default : cache_sb_mux_dtype <= data_type_i;
    endcase
end

/////////////////////////////
//// MODULE INSTANTATION ////
/////////////////////////////

segre_cache_data data (
    .clk_i(clk_i),
    .rsn_i(rsn_i),

    .wr_into_word_i(write_into_word),
    .wr_line_i(write_line_from_mem),
    .addr_i(cache_sb_mux_addr),
    .data_i(cache_sb_mux_data),
    .data_type_i(cache_sb_mux_dtype),
    .from_mem_cache_line_i(from_mem_cache_line_i),

    .to_mem_cache_line_o(to_mem_cache_line_o),
    .data_o(data_from_cache_data)
);

segre_cache_tags tags (
    .clk_i(clk_i),
    .rsn_i(rsn_i),

    .addr_i(addr_i),
    .wr_en_i(write_line_from_mem),

    .is_hit_o(is_hit_from_tags),

    // Tag in the index of addr_i
    .tag_in_index_o(tag_in_cacheline)
);

logic is_alu;
assign is_alu = is_alu_i && (cache_rd_act_state == READING_DATA) && (cache_wr_act_state == READING_TAGS);

generate
    if (ICACHE_DCACHE == DCACHE)
        segre_store_buffer ssb (
            .clk_i(clk_i),
            .rsn_i(rsn_i),

            .data_i(data_i),
            .addr_i(addr_i),
            .data_type_i(data_type_i),

            .is_load_i(rd_i),
            .is_store_i(wr_i),
            .is_alu_i(is_alu),

            .is_hit_i(is_hit_o),

            .data_o(data_sb_o),
            .addr_o(addr_sb_o),
            .data_type_o(data_type_sb_o),

            // TODO This signal must be used to
            // select which data is feed to the WB stage
            // whether it is from cache, from sb or from ALU
            .is_hit_o(is_hit_sb_o),

            .reading_valid_entry_o(reading_valid_entry_sb_o),

            .is_draining_o(draining_buffer_sb_o)
        );
endgenerate

endmodule : segre_cache
