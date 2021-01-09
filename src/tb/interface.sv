import segre_pkg::*;
interface segre_core_if_t;
    logic clk;
    logic rsn;
    logic [ADDR_SIZE-1:0] addr;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_rd_data;
    logic [CACHE_LINE_SIZE_BYTES-1:0][7:0] mem_wr_data;
    logic mem_ready;
    logic mem_rd;
    logic mem_wr;
    memop_data_type_e mem_data_type;
endinterface : segre_core_if_t
