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

parameter NUMBER_OF_LINES = 4;
parameter M = $clog2(CACHE_LINE_SIZE_BITS);
parameter N = $clog2(NUMBER_OF_LINES) + M;
parameter TAG_SIZE = WORD_SIZE - N + 1;

logic [WORD_SIZE-1:N] addr_tag;
logic [N-1:M] addr_index;
logic [M-1:0] addr_byte;

assign addr_tag   = addr_i[WORD_SIZE-1:N];
assign addr_index = addr_i[N-1:M];
assign addr_byte  = addr_i[M-1:0];

logic [NUMBER_OF_LINES-1:0] valid_bits;
logic [NUMBER_OF_LINES-1:0] dirty_bits;
logic [NUMBER_OF_LINES-1:0][TAG_SIZE-1:0] cache_tags;
logic [NUMBER_OF_LINES-1:0][CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_data;

typedef enum logic [2:0] {
    IDLE_WR,
    READING_TAGS,
    WRITING_DATA,
    WRITEBACK_WR,
    REQ_MEM_DATA_WR
} cache_wr_states_t;

typedef enum logic [1:0] {
    IDLE_RD,
    READING_DATA,
    WRITEBACK_RD,
    REQ_MEM_DATA_RD
} cache_rd_states_t;

cache_wr_states_t cache_wr_state;
cache_rd_states_t cache_rd_state;

logic is_hit;

assign is_hit = valid_bits[addr_index] && (cache_tags[addr_index] == addr_tag);

// Hit is visible when request to mem, reading data or reading tags
assign is_hit_o = is_hit && (cache_rd_state == REQ_MEM_DATA_RD || cache_rd_state == READING_DATA || cache_wr_state == READING_TAGS);

// TODO Divide read and write, always_comb and always respectively

/*
 *  How will petitions to main memory be?
 *
 *      - Do petition once and hope that memory will get back to you
 *
 *      - Issue the petition each cycle until memory answers
 *
 *      - What will do the ARB???? Find out what characteristics should have
 *
 */

task write_value_into_line(input logic [WORD_SIZE-1:0] data, input memop_data_type_e data_type, input logic [M-1:0] elem_byte, inout logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_line);

    case (data_type)
        BYTE: begin
            cache_line[elem_byte] <= data[7:0];
        end

        HALF: begin
            cache_line[elem_byte] <= data[7:0];
            cache_line[elem_byte+1] <= data[15:8];
        end

        WORD: begin
            cache_line[elem_byte] <= data[7:0];
            cache_line[elem_byte+1] <= data[15:8];
            cache_line[elem_byte+2] <= data[23:16];
            cache_line[elem_byte+3] <= data[31:24];
        end

        default: $display("What the fuck, which memop_data_type_e then?!");
    endcase

endtask : write_value_into_line

task read_from_cache(input logic [N-1:M] addr_index, input logic [M-1:0] addr_byte, input memop_data_type_e data_type, output [WORD_SIZE-1:0] data);
    case (data_type)
        BYTE: begin
            data = cache_data[addr_index][addr_byte];
        end

        HALF: begin
            data = {cache_data[addr_index][addr_byte+1], cache_data[addr_index][addr_byte]};
        end

        WORD: begin
            data = {cache_data[addr_index][addr_byte+3],
                    cache_data[addr_index][addr_byte+2],
                    cache_data[addr_index][addr_byte+1],
                    cache_data[addr_index][addr_byte]};
        end

        default: $display("What the fuck, which memop_data_type_e then?!");

    endcase
endtask : read_from_cache

always_ff @(posedge clk_i) begin

    if (!rsn_i) begin
        cache_wr_state <= IDLE_WR;
        cache_rd_state <= IDLE_RD;
    end
    else begin

        /*
         * Read next state
         */
        if (rd_i && cache_rd_state == IDLE_RD
                 && cache_wr_state == IDLE_WR) begin
            if (!is_hit) begin
                if (dirty_bits[addr_index]) begin
                    cache_rd_state <= WRITEBACK_RD;
                end
                else begin
                    cache_rd_state <= REQ_MEM_DATA_RD;
                end
            end
            else begin
                cache_rd_state <= READING_DATA;
            end

        end

        if (cache_rd_state == REQ_MEM_DATA_RD && rcvd_mem_request_i) begin
            cache_rd_state <= READING_DATA;
        end

        if (cache_rd_state == WRITEBACK_RD) begin
            cache_rd_state <= REQ_MEM_DATA_RD;
        end

        if (cache_rd_state == READING_DATA) begin
            cache_rd_state <= IDLE_RD;
        end

        /*
         * Write next state
         */
        if (wr_i && cache_wr_state == IDLE_WR
                 && cache_rd_state == IDLE_RD) begin
            cache_wr_state <= READING_TAGS;
        end

        if (cache_wr_state == READING_TAGS) begin
            if (is_hit) begin
                cache_wr_state <= WRITING_DATA;
            end
            else begin
                if (dirty_bits[addr_index]) begin
                    cache_wr_state <= WRITEBACK_WR;
                end
                else begin
                    cache_wr_state <= REQ_MEM_DATA_WR; end
            end
        end

        if (cache_wr_state == WRITING_DATA) begin
            cache_wr_state <= IDLE_WR;
        end

        if (cache_wr_state == REQ_MEM_DATA_WR && rcvd_mem_request_i) begin
            cache_wr_state <= WRITING_DATA;
        end
    end
end

always_comb begin
    if (!rsn_i) begin
        valid_bits <= 'b0;
        dirty_bits <= 'b0;
        writeback_mem_o <= 0;
        to_mem_cache_line_o <= 0;
    end
    else begin

        /*
         * Read states
         */
        if (cache_rd_state == IDLE_RD) begin
            writeback_mem_o <= 0;
        end

        if (cache_rd_state == READING_DATA) begin
            read_from_cache(addr_index, addr_byte, data_type_i, data_o);
        end

        // It is a miss and there's a collision, writeback to memory
        if (cache_rd_state == WRITEBACK_RD) begin
            writeback_mem_o <= 1;
            to_mem_cache_line_o <= cache_data[addr_index];
        end

        // Memory request has been received
        if (cache_rd_state == REQ_MEM_DATA_RD
            && rcvd_mem_request_i) begin
            cache_tags[addr_index] <= addr_tag;
            cache_data[addr_index] <= from_mem_cache_line_i;
            valid_bits[addr_index] <= 1;
            dirty_bits[addr_index] <= 0;
        end

        /*
         * Write states
         */
        if (cache_wr_state == IDLE_WR) begin
            writeback_mem_o <= 0;
        end

        if (cache_wr_state == READING_TAGS) begin
            if (is_hit) begin
                dirty_bits[addr_index] <= 1;
            end
        end

        if (cache_wr_state == WRITING_DATA) begin
            cache_tags[addr_index] <= addr_tag;
            write_value_into_line(data_i, data_type_i, addr_byte, cache_data[addr_index]);
        end

        if (cache_wr_state == WRITEBACK_WR) begin
            writeback_mem_o <= 1;
            to_mem_cache_line_o <= cache_data[addr_index];
        end

        if (cache_wr_state == REQ_MEM_DATA_WR && rcvd_mem_request_i) begin
            cache_tags[addr_index] <= addr_tag;
            cache_data[addr_index] <= from_mem_cache_line_i;
            valid_bits[addr_index] <= 1;
            dirty_bits[addr_index] <= 0;
        end

    end
end

endmodule : segre_cache
