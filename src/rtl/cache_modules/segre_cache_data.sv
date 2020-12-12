import segre_pkg::*;

module segre_cache_data (

    input logic clk_i,
    input logic rsn_i,

    input logic wr_into_word_i,
    input memop_data_type_e data_type_i,
    input logic wr_line_i,
    input logic [WORD_SIZE-1:0] addr_i,
    input logic [WORD_SIZE-1:0] data_i,
    input logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] from_mem_cache_line_i,

    output logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] to_mem_cache_line_o,
    output logic [WORD_SIZE-1:0] data_o

);

logic [WORD_SIZE-1:N] addr_tag;
logic [N-1:M] addr_index;
logic [M-1:0] addr_byte;

assign addr_tag   = addr_i[WORD_SIZE-1:N];
assign addr_index = addr_i[N-1:M];
assign addr_byte  = addr_i[M-1:0];

logic [NUMBER_OF_LINES-1:0][CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_data;

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

function logic [WORD_SIZE-1:0] read_from_cache(input logic [N-1:M] addr_index, input logic [M-1:0] addr_byte, input memop_data_type_e data_type, input [NUMBER_OF_LINES-1:0][CACHE_LINE_SIZE_BYTES-1:0][7:0] cache_data);
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
    if (!rsn_i) begin
        cache_data <= 'b0;
    end
    else begin
        if (wr_into_word_i) begin
            cache_data[addr_index] <= write_value_into_line(data_i, data_type_i, addr_byte, cache_data[addr_index]);
        end
        else if (wr_line_i) begin
            cache_data[addr_index] <= from_mem_cache_line_i;
        end
    end
end

assign to_mem_cache_line_o = cache_data[addr_index];
assign data_o = read_from_cache(addr_index, addr_byte, data_type_i, cache_data);

endmodule : segre_cache_data
