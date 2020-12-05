onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/clk_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/rsn_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/rd_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/wr_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/mem_ready_o
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/data_type_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/addr_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/data_i
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/cache_line_o
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/rd_data
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/mem_request
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/cyc_counter
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/aux_rd
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/aux_wr
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/read_data
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/num_of_instructions
add wave -noupdate -group {Testbench Memory} /top_tb/soc/tb_mem/hex_file_fd
add wave -noupdate -group DUT /top_tb/soc/dut/clk_i
add wave -noupdate -group DUT /top_tb/soc/dut/rsn_i
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rd_data_i
add wave -noupdate -group DUT /top_tb/soc/dut/mem_wr_data_o
add wave -noupdate -group DUT /top_tb/soc/dut/addr_o
add wave -noupdate -group DUT /top_tb/soc/dut/mem_ready_i
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rd_o
add wave -noupdate -group DUT /top_tb/soc/dut/mem_wr_o
add wave -noupdate -group DUT /top_tb/soc/dut/mem_data_type_o
add wave -noupdate -group DUT /top_tb/soc/dut/if_addr
add wave -noupdate -group DUT /top_tb/soc/dut/if_mem_rd
add wave -noupdate -group DUT /top_tb/soc/dut/id_instr
add wave -noupdate -group DUT /top_tb/soc/dut/rf_raddr_a
add wave -noupdate -group DUT /top_tb/soc/dut/rf_raddr_b
add wave -noupdate -group DUT /top_tb/soc/dut/rf_data_a
add wave -noupdate -group DUT /top_tb/soc/dut/rf_data_b
add wave -noupdate -group DUT /top_tb/soc/dut/fsm_state
add wave -noupdate -group DUT /top_tb/soc/dut/ex_memop_type
add wave -noupdate -group DUT /top_tb/soc/dut/ex_alu_src_a
add wave -noupdate -group DUT /top_tb/soc/dut/ex_alu_src_b
add wave -noupdate -group DUT /top_tb/soc/dut/ex_rf_st_data
add wave -noupdate -group DUT /top_tb/soc/dut/ex_rf_we
add wave -noupdate -group DUT /top_tb/soc/dut/ex_rf_waddr
add wave -noupdate -group DUT /top_tb/soc/dut/ex_alu_opcode
add wave -noupdate -group DUT /top_tb/soc/dut/ex_memop_rd
add wave -noupdate -group DUT /top_tb/soc/dut/ex_memop_wr
add wave -noupdate -group DUT /top_tb/soc/dut/ex_memop_sign_ext
add wave -noupdate -group DUT /top_tb/soc/dut/ex_br_src_a
add wave -noupdate -group DUT /top_tb/soc/dut/ex_br_src_b
add wave -noupdate -group DUT /top_tb/soc/dut/mem_memop_type
add wave -noupdate -group DUT /top_tb/soc/dut/mem_data_type
add wave -noupdate -group DUT /top_tb/soc/dut/mem_alu_res
add wave -noupdate -group DUT /top_tb/soc/dut/mem_addr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_wr_data
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rf_st_data
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rf_waddr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_memop_rd
add wave -noupdate -group DUT /top_tb/soc/dut/mem_memop_wr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_memop_sign_ext
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rf_we
add wave -noupdate -group DUT /top_tb/soc/dut/mem_rd
add wave -noupdate -group DUT /top_tb/soc/dut/mem_wr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_tkbr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_new_pc
add wave -noupdate -group DUT /top_tb/soc/dut/wb_res
add wave -noupdate -group DUT /top_tb/soc/dut/wb_rf_waddr
add wave -noupdate -group DUT /top_tb/soc/dut/wb_rf_we
add wave -noupdate -group DUT /top_tb/soc/dut/wb_new_pc
add wave -noupdate -group DUT /top_tb/soc/dut/wb_tkbr
add wave -noupdate -group DUT /top_tb/soc/dut/mem_stage_rdwr
add wave -noupdate -divider Stages
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/clk_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/rsn_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/cache_instr_line_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/mem_ready_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/pc_o
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/mem_rd_o
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/fsm_state_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/instr_o
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/tkbr_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/new_pc_i
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/data_type
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/rd
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/wr
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/is_alu
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/data
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/store_buffer_draining
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/is_hit
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/writeback
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/to_mem_cache_line
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/instr_to_feed_decode
add wave -noupdate -group {IF Stage} /top_tb/soc/dut/if_stage/nxt_pc
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/clk_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rsn_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/fsm_state_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/instr_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/pc_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_raddr_a_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_raddr_b_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_data_a_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_data_b_i
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_opcode_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_src_a_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_src_b_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_we_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_waddr_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_type_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_sign_ext_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_rd_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_wr_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_rf_data_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_src_a_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_src_b_o
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_u_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_i_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_s_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_j_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_b_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/src_a_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/src_b_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/a_imm_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/b_imm_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_a_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_b_mux_sel
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_a
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/imm_b
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_raddr_a
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_raddr_b
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_waddr
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/rf_we
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_src_a
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_src_b
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_src_a
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/br_src_b
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_type
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_rd
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_wr
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/memop_sign_ext
add wave -noupdate -group {ID Stage} /top_tb/soc/dut/id_stage/alu_opcode
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/clk_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rsn_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/alu_opcode_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/alu_src_a_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/alu_src_b_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_we_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_waddr_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_st_data_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_type_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_rd_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_wr_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_sign_ext_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/br_src_a_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/br_src_b_i
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/alu_res_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_we_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_waddr_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/rf_st_data_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_type_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_rd_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_wr_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/memop_sign_ext_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/tkbr_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/new_pc_o
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/alu_res
add wave -noupdate -group {EX Stage} /top_tb/soc/dut/ex_stage/tkbr
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/clk_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rsn_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/data_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/data_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/addr_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_rd_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_wr_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_type_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/alu_res_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_we_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_waddr_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_st_data_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_type_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_sign_ext_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_rd_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_wr_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/tkbr_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/new_pc_i
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/op_res_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_we_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_waddr_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/tkbr_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/new_pc_o
add wave -noupdate -group {MEM Stage} /top_tb/soc/dut/mem_stage/mem_data
add wave -noupdate -divider {Register File}
add wave -noupdate /top_tb/soc/dut/segre_rf/clk_i
add wave -noupdate /top_tb/soc/dut/segre_rf/rsn_i
add wave -noupdate /top_tb/soc/dut/segre_rf/we_i
add wave -noupdate /top_tb/soc/dut/segre_rf/raddr_a_i
add wave -noupdate /top_tb/soc/dut/segre_rf/data_a_o
add wave -noupdate /top_tb/soc/dut/segre_rf/raddr_b_i
add wave -noupdate /top_tb/soc/dut/segre_rf/data_b_o
add wave -noupdate /top_tb/soc/dut/segre_rf/waddr_i
add wave -noupdate /top_tb/soc/dut/segre_rf/data_w_i
add wave -noupdate /top_tb/soc/dut/segre_rf/rf_reg
add wave -noupdate /top_tb/soc/dut/segre_rf/rf_reg_aux
add wave -noupdate /top_tb/soc/dut/segre_rf/write_enable
add wave -noupdate -divider Controller
add wave -noupdate /top_tb/soc/dut/controller/clk_i
add wave -noupdate /top_tb/soc/dut/controller/rsn_i
add wave -noupdate /top_tb/soc/dut/controller/is_mem_instr_i
add wave -noupdate /top_tb/soc/dut/controller/mem_ready_i
add wave -noupdate /top_tb/soc/dut/controller/state_o
add wave -noupdate /top_tb/soc/dut/controller/state
add wave -noupdate /top_tb/soc/dut/controller/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {163012 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 348
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {36547 ps} {483247 ps}
