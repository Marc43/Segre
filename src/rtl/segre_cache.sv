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

logic is_hit;

assign is_hit = valid_bits[addr_index] && (cache_tags[addr_index] == addr_tag) && (rd_i || wr_i);
assign is_hit_o = is_hit;

// TODO States for storing (reading tags, then writing data if possible)
typedef enum logic [1:0] {
    READING_TAGS,
    WRITING_DATA
} cache_wr_states_t;

cache_wr_states_t cache_wr_state;

logic waiting_mem;

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

always @(posedge clk_i) begin
    if (!rsn_i) begin
        waiting_mem <= 0;
        valid_bits <= 'b0;
        dirty_bits <= 'b0;
        cache_wr_state <= READING_TAGS;
    end
    else begin

        if (waiting_mem && rcvd_mem_request_i) begin
            // Write the read data from memory
            cache_tags[addr_index] <= addr_tag;
            cache_data[addr_index] <= from_mem_cache_line_i;
            valid_bits[addr_index] <= 1;
            dirty_bits[addr_index] <= 0;
            waiting_mem <= 0;
        end

        if (rd_i && !waiting_mem) begin
            data_o <= cache_data[addr_index];
            writeback_mem_o <= 0;

            if (!is_hit) begin

                if (dirty_bits[addr_index]) begin
                    writeback_mem_o <= 1;
                    to_mem_cache_line_o <= cache_data[addr_index];
                end

                waiting_mem <= 1;
            end
            else begin
                waiting_mem <= 0;
            end

        end
        else if (wr_i && !waiting_mem) begin

            if (cache_wr_state == READING_TAGS) begin

                if (is_hit) begin
                    cache_wr_state <= WRITING_DATA;
                end
                else begin

                    if (dirty_bits[addr_index]) begin
                        writeback_mem_o <= 1;
                        to_mem_cache_line_o <= cache_data[addr_index];
                    end

                    waiting_mem <= 1;
                end

            end
            else if (cache_wr_state == WRITING_DATA) begin
                cache_tags[addr_index] <= addr_tag;
                dirty_bits[addr_index] <= 1;
                write_value_into_line(data_i, data_type_i, addr_byte, cache_data[addr_index]);
                waiting_mem <= 0;
            end
        end
    end
end

endmodule : segre_cache
