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
logic [NUMBER_OF_LINES-1:0][TAG_SIZE-1:0] cache_tags;
logic [NUMBER_OF_LINES-1:0][CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_data;

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
logic write_into_line;
logic is_hit;

assign write_line_from_mem = ((cache_rd_act_state == REQ_MEM_DATA_RD || cache_wr_act_state == REQ_MEM_DATA_WR) && rcvd_mem_request_i);
assign write_into_line = cache_wr_act_state == WRITING_DATA;
assign is_writeback = cache_rd_act_state == WRITEBACK_RD || cache_wr_act_state == WRITEBACK_WR;
assign is_hit = valid_bits[addr_index] && (cache_tags[addr_index] == addr_tag);

assign writeback_mem_o = is_writeback ? 1'b1 : 1'b0;
assign to_mem_cache_line_o = cache_data[addr_index];

assign data_o = (cache_rd_act_state == READING_DATA) ? read_from_cache(addr_index, addr_byte, data_type_i) : 'b0;


assign is_hit_o = is_hit && (cache_rd_act_state == REQ_MEM_DATA_RD || cache_rd_act_state == READING_DATA || cache_wr_act_state == READING_TAGS);

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

function logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] write_value_into_line(input logic [WORD_SIZE-1:0] data, input memop_data_type_e data_type, input logic [M-1:0] elem_byte, input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] cacheline);
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] ret_cacheline;

    ret_cacheline = cacheline;

    case (data_type)
        BYTE: begin
            ret_cacheline[elem_byte] = data[7:0];
        end

        HALF: begin
            ret_cacheline[elem_byte] = data[7:0];
            ret_cacheline[elem_byte+1] = data[15:8];
        end

        WORD: begin
            ret_cacheline[elem_byte] = data[7:0];
            ret_cacheline[elem_byte+1] = data[15:8];
            ret_cacheline[elem_byte+2] = data[23:16];
            ret_cacheline[elem_byte+3] = data[31:24];
        end

        default: $display("What the fuck, which memop_data_type_e then?!");
    endcase

    return ret_cacheline;

endfunction : write_value_into_line

function logic [WORD_SIZE-1:0] read_from_cache(input logic [N-1:M] addr_index, input logic [M-1:0] addr_byte, input memop_data_type_e data_type);
    case (data_type)
        BYTE: begin
            return cache_data[addr_index][addr_byte];
        end

        HALF: begin
            return {cache_data[addr_index][addr_byte+1], cache_data[addr_index][addr_byte]};
        end

        WORD: begin
            return {cache_data[addr_index][addr_byte+3],
                    cache_data[addr_index][addr_byte+2],
                    cache_data[addr_index][addr_byte+1],
                    cache_data[addr_index][addr_byte]};
        end

        default: $display("What the fuck, which memop_data_type_e then?!");

    endcase
endfunction : read_from_cache

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
            cache_wr_next_state = WRITING_DATA;
        end
    end
end

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        valid_bits <= 'b0;
        dirty_bits <= 'b0;
    end
    else begin
        if (write_into_line) begin
            cache_data[addr_index] <= write_value_into_line(data_i, data_type_i, addr_byte, cache_data[addr_index]);
            dirty_bits[addr_index] <= 1'b1;
        end
        else if (write_line_from_mem) begin
            cache_data[addr_index] <= from_mem_cache_line_i;
            cache_tags[addr_index] <= addr_tag;
            valid_bits[addr_index] <= 1'b1;
            dirty_bits[addr_index] <= 1'b0;
        end
    end
end

endmodule : segre_cache
