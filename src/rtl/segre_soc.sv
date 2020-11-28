import segre_pkg::*;

module segre_soc ();

    segre_core_if_t segre_core_if();

    segre_core dut(
        .clk_i           (segre_core_if.clk),
        .rsn_i           (segre_core_if.rsn),
        .mem_rd_data_i   (segre_core_if.mem_rd_data),
        .mem_wr_data_o   (segre_core_if.mem_wr_data),
        .addr_o          (segre_core_if.addr),
        .mem_ready_i     (segre_core_if.mem_ready),
        .mem_rd_o        (segre_core_if.mem_rd),
        .mem_wr_o        (segre_core_if.mem_wr),
        .mem_data_type_o (segre_core_if.mem_data_type)
    );

    memory tb_mem (
        .clk_i       (segre_core_if.clk),
        .rsn_i       (segre_core_if.rsn),
        .data_i      (segre_core_if.mem_wr_data),
        .data_o      (segre_core_if.mem_rd_data),
        .addr_i      (segre_core_if.addr),
        .mem_ready_o (segre_core_if.mem_ready),
        .rd_i        (segre_core_if.mem_rd),
        .wr_i        (segre_core_if.mem_wr),
        .data_type_i (segre_core_if.mem_data_type)
    );

endmodule : segre_soc
