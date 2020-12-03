import segre_pkg::*;

module segre_cache (

    input logic clk_i,
    input logic rsn_i,

    input logic rd_i,
    input logic wr_i,
    input logic rcvd_mem_request_i,
    input memop_data_type_e data_type_i,
    input logic [WORD_SIZE-1:0] addr_i,
    input logic [WORD_SIZE-1:0] data_i,
    input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_line_i,
    output logic is_hit_o, // If 1 hit, 0 miss (es un temazo!) (fer servir com rd de memoria ~is_hit)
    output logic writeback_mem_o,
    output logic [WORD_SIZE-1:0] data_o,
    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line_o

);

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

assign write_line_from_mem = ((cache_rd_act_state == REQ_MEM_DATA_RD || cache_wr_act_state == REQ_MEM_DATA_WR) && rcvd_mem_request_i);
assign write_into_word = cache_wr_act_state == WRITING_DATA;
assign is_writeback = cache_rd_act_state == WRITEBACK_RD || cache_wr_act_state == WRITEBACK_WR;
assign is_hit = valid_bits[addr_index] && is_hit_from_tags;

assign writeback_mem_o = is_writeback ? 1'b1 : 1'b0;

assign data_o = (cache_rd_act_state == READING_DATA) ? data_from_cache_data : 'b0;

assign is_hit_o = is_hit && (cache_rd_act_state == REQ_MEM_DATA_RD || cache_rd_act_state == READING_DATA || cache_wr_act_state == READING_TAGS);


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
    else begin

        /*
         * Read next state
         */
        if (rd_i && cache_rd_act_state == READING_DATA) begin
            if (!is_hit) begin
                if (dirty_bits[addr_index]) begin
                    cache_rd_next_state = WRITEBACK_RD;
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
        else if (cache_rd_act_state == WRITEBACK_RD) begin
            cache_rd_next_state = REQ_MEM_DATA_RD;
        end

        /*
         * Write next state
         */
        if (wr_i && cache_wr_act_state == READING_TAGS) begin
            if (is_hit) begin
                cache_wr_next_state = WRITING_DATA;
            end
            else begin
                if (dirty_bits[addr_index]) begin
                    cache_wr_next_state = WRITEBACK_WR;
                end
                else begin
                    cache_wr_next_state = REQ_MEM_DATA_WR; end
            end
        end
        else if (cache_wr_act_state == WRITING_DATA) begin
            cache_wr_next_state = READING_TAGS;
        end
        else if (cache_wr_act_state == WRITEBACK_WR) begin
            cache_wr_next_state = REQ_MEM_DATA_WR;
        end
        else if (cache_wr_act_state == REQ_MEM_DATA_WR && rcvd_mem_request_i) begin
            cache_wr_next_state = READING_TAGS;
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
    end
end

/////////////////////////////
//// MODULE INSTANTATION ////
/////////////////////////////


segre_cache_data data (
    .clk_i(clk_i),
    .rsn_i(rsn_i),

    .wr_into_word_i(write_into_word),
    .data_type_i(data_type_i),
    .wr_line_i(write_line_from_mem),
    .addr_i(addr_i),
    .data_i(data_i),
    .from_mem_cache_line_i(from_mem_cache_line_i),

    .to_mem_cache_line_o(to_mem_cache_line_o),
    .data_o(data_from_cache_data)
);

segre_cache_tags tags (
    .clk_i(clk_i),
    .rsn_i(rsn_i),

    .addr_i(addr_i),
    .wr_en_i(write_line_from_mem),

    .is_hit_o(is_hit_from_tags)
);

segre_store_buffer ssb (

);


endmodule : segre_cache
