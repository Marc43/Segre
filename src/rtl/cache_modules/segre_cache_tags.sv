import segre_pkg::*;

module segre_cache_tags (

    input logic clk_i,
    input logic rsn_i,
    input logic [WORD_SIZE-1:0] addr_i,
    input logic wr_en_i,
    output logic is_hit_o,
    output logic [WORD_SIZE-N-1:0] tag_in_index_o
);

logic [WORD_SIZE-1:N] addr_tag;
logic [N-1:M] addr_index;
logic [M-1:0] addr_byte;

assign addr_tag   = addr_i[WORD_SIZE-1:N];
assign addr_index = addr_i[N-1:M];
assign addr_byte  = addr_i[M-1:0];

logic [NUMBER_OF_LINES-1:0][TAG_SIZE-1:0] cache_tags;

always_ff @(posedge clk_i, negedge rsn_i) begin
    if (!rsn_i) begin
        cache_tags <= 'b0;
    end
    else begin
        if (wr_en_i) begin
            cache_tags[addr_index] <= addr_tag;
        end
    end
end

assign is_hit_o = (cache_tags[addr_index] == addr_tag);
assign tag_in_index_o = cache_tags[addr_index];

endmodule : segre_cache_tags
