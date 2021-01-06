onerror {resume}
quietly virtual function -install /top_tb/soc/dut/if_stage/instruction_cache/data -env /top_tb/#INITIAL#56 { &{/top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][3], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][2], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][1], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][0] }} instr_0
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
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/clk_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/rsn_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/cache_instr_line_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/mem_ready_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/pc_o
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/mem_rd_o
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/fsm_state_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/instr_o
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/tkbr_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/new_pc_i
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/data_type
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/rd
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/wr
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/is_alu
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/data
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/store_buffer_draining
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/is_hit
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/writeback
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/to_mem_cache_line
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/instr_to_feed_decode
add wave -noupdate -expand -group {IF Stage} /top_tb/soc/dut/if_stage/nxt_pc
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
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/clk_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rsn_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/addr_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_rd_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_wr_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_type_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/alu_res_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_we_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_waddr_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_st_data_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_type_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_sign_ext_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_rd_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/memop_wr_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/tkbr_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/new_pc_i
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/op_res_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_we_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/rf_waddr_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/tkbr_o
add wave -noupdate -expand -group {MEM Stage} /top_tb/soc/dut/mem_stage/new_pc_o
add wave -noupdate -divider {Data Cache}
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/clk_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/rsn_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/rd_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/wr_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_alu_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/rcvd_mem_request_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_type_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/addr_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/from_mem_cache_line_i
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_hit_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_busy_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/writeback_mem_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/to_mem_cache_line_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/store_buffer_draining_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/addr_tag
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/addr_index
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/addr_byte
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/valid_bits
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/dirty_bits
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_wr_act_state
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_rd_act_state
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_wr_next_state
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_rd_next_state
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_writeback
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/write_line_from_mem
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/write_into_word
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_hit_from_tags
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_hit
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_from_cache_data
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/reading_valid_entry_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/draining_buffer_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/draining_buffer
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/is_hit_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/do_not_block_state_update
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_data
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_addr
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_dtype
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/addr_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/data_type_sb_o
add wave -noupdate /top_tb/soc/dut/mem_stage/data_cache/sb_muxes_select
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/clk_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/rsn_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/wr_into_word_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/data_type_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/wr_line_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/addr_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/data_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/from_mem_cache_line_i
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/to_mem_cache_line_o
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/data_o
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/addr_tag
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/addr_index
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/addr_byte
add wave -noupdate -group {DCache Data} /top_tb/soc/dut/mem_stage/data_cache/data/cache_data
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/clk_i
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/rsn_i
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/addr_i
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/wr_en_i
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/is_hit_o
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/addr_tag
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/addr_index
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/addr_byte
add wave -noupdate -group {DCache Tags} /top_tb/soc/dut/mem_stage/data_cache/tags/cache_tags
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
add wave -noupdate /top_tb/soc/dut/if_stage/clk_i
add wave -noupdate /top_tb/soc/dut/if_stage/rsn_i
add wave -noupdate /top_tb/soc/dut/if_stage/cache_instr_line_i
add wave -noupdate /top_tb/soc/dut/if_stage/mem_ready_i
add wave -noupdate /top_tb/soc/dut/if_stage/pc_o
add wave -noupdate /top_tb/soc/dut/if_stage/mem_rd_o
add wave -noupdate /top_tb/soc/dut/if_stage/fsm_state_i
add wave -noupdate /top_tb/soc/dut/if_stage/instr_o
add wave -noupdate /top_tb/soc/dut/if_stage/tkbr_i
add wave -noupdate /top_tb/soc/dut/if_stage/new_pc_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_hit_o
add wave -noupdate /top_tb/soc/dut/if_stage/data_type
add wave -noupdate /top_tb/soc/dut/if_stage/rd
add wave -noupdate /top_tb/soc/dut/if_stage/wr
add wave -noupdate /top_tb/soc/dut/if_stage/is_alu
add wave -noupdate /top_tb/soc/dut/if_stage/data
add wave -noupdate /top_tb/soc/dut/if_stage/store_buffer_draining
add wave -noupdate /top_tb/soc/dut/if_stage/is_hit
add wave -noupdate /top_tb/soc/dut/if_stage/writeback
add wave -noupdate /top_tb/soc/dut/if_stage/to_mem_cache_line
add wave -noupdate /top_tb/soc/dut/if_stage/instr_to_feed_decode
add wave -noupdate /top_tb/soc/dut/if_stage/nxt_pc
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/clk_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rsn_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rd_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/wr_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_alu_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rcvd_mem_request_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_type_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/from_mem_cache_line_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/writeback_mem_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/to_mem_cache_line_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/store_buffer_draining_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_tag
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_index
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_byte
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/valid_bits
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/dirty_bits
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_wr_act_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_rd_act_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_wr_next_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_rd_next_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_writeback
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/write_line_from_mem
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/write_into_word
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_from_tags
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_from_cache_data
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/reading_valid_entry_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/draining_buffer_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_data
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_addr
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_dtype
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_type_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/sb_muxes_select
add wave -noupdate -divider {Instruction Cache}
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/clk_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rsn_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rd_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/wr_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_alu_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/rcvd_mem_request_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_type_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/from_mem_cache_line_i
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_busy_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/writeback_mem_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/to_mem_cache_line_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/store_buffer_draining_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_tag
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_index
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_byte
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/valid_bits
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/dirty_bits
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_wr_act_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_rd_act_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_wr_next_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_rd_next_state
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_writeback
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/write_line_from_mem
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/write_into_word
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_from_tags
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_from_cache_data
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/reading_valid_entry_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/draining_buffer_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/draining_buffer
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/is_hit_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/do_not_block_state_update
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_data
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_addr
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/cache_sb_mux_dtype
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/addr_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/data_type_sb_o
add wave -noupdate /top_tb/soc/dut/if_stage/instruction_cache/sb_muxes_select
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/clk_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/rsn_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/wr_into_word_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/data_type_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/wr_line_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/addr_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/data_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/from_mem_cache_line_i
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/to_mem_cache_line_o
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/data_o
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/addr_tag
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/addr_index
add wave -noupdate -group Data /top_tb/soc/dut/if_stage/instruction_cache/data/addr_byte
add wave -noupdate -group Data -expand -subitemconfig {{/top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3]} -expand} /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/clk_i
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/rsn_i
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/addr_i
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/wr_en_i
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/is_hit_o
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/addr_tag
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/addr_index
add wave -noupdate -group Tags /top_tb/soc/dut/if_stage/instruction_cache/tags/addr_byte
add wave -noupdate -group Tags -expand /top_tb/soc/dut/if_stage/instruction_cache/tags/cache_tags
add wave -noupdate -group Tags -divider {Data Cache}
add wave -noupdate /top_tb/soc/dut/controller/data_cache_is_busy_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5129350 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {4619145 ps} {5798045 ps}
