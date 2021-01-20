onerror {resume}
quietly virtual function -install /top_tb/soc/dut/if_stage/instruction_cache/data -env /top_tb/#INITIAL#56 { &{/top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][3], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][2], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][1], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][0] }} instr_0
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Core /top_tb/soc/dut/clk_i
add wave -noupdate -group Core /top_tb/soc/dut/rsn_i
add wave -noupdate -group Core /top_tb/soc/dut/mem_rd_data_i
add wave -noupdate -group Core /top_tb/soc/dut/mem_wr_data_o
add wave -noupdate -group Core /top_tb/soc/dut/addr_o
add wave -noupdate -group Core /top_tb/soc/dut/mem_ready_i
add wave -noupdate -group Core /top_tb/soc/dut/mem_rd_o
add wave -noupdate -group Core /top_tb/soc/dut/mem_wr_o
add wave -noupdate -group Core /top_tb/soc/dut/mem_data_type_o
add wave -noupdate -group Core /top_tb/soc/dut/if_addr
add wave -noupdate -group Core /top_tb/soc/dut/if_mem_rd
add wave -noupdate -group Core /top_tb/soc/dut/instruction_hit_if
add wave -noupdate -group Core /top_tb/soc/dut/valid_if
add wave -noupdate -group Core /top_tb/soc/dut/if_instr
add wave -noupdate -group Core /top_tb/soc/dut/src_a_identifier_id
add wave -noupdate -group Core /top_tb/soc/dut/src_b_identifier_id
add wave -noupdate -group Core /top_tb/soc/dut/instr_id
add wave -noupdate -group Core /top_tb/soc/dut/valid_id
add wave -noupdate -group Core /top_tb/soc/dut/rf_raddr_a
add wave -noupdate -group Core /top_tb/soc/dut/rf_raddr_b
add wave -noupdate -group Core /top_tb/soc/dut/rf_data_a
add wave -noupdate -group Core /top_tb/soc/dut/rf_data_b
add wave -noupdate -group Core /top_tb/soc/dut/id_pc
add wave -noupdate -group Core /top_tb/soc/dut/id_memop_type
add wave -noupdate -group Core /top_tb/soc/dut/id_alu_src_a
add wave -noupdate -group Core /top_tb/soc/dut/id_alu_src_b
add wave -noupdate -group Core /top_tb/soc/dut/id_rf_st_data
add wave -noupdate -group Core /top_tb/soc/dut/id_rf_we
add wave -noupdate -group Core /top_tb/soc/dut/id_rf_waddr
add wave -noupdate -group Core /top_tb/soc/dut/id_is_jaljalr
add wave -noupdate -group Core /top_tb/soc/dut/id_alu_opcode
add wave -noupdate -group Core /top_tb/soc/dut/id_memop_rd
add wave -noupdate -group Core /top_tb/soc/dut/id_memop_wr
add wave -noupdate -group Core /top_tb/soc/dut/id_memop_sign_ext
add wave -noupdate -group Core /top_tb/soc/dut/id_br_src_a
add wave -noupdate -group Core /top_tb/soc/dut/id_br_src_b
add wave -noupdate -group Core /top_tb/soc/dut/ex_memop_type
add wave -noupdate -group Core /top_tb/soc/dut/ex_data_type
add wave -noupdate -group Core /top_tb/soc/dut/ex_alu_res
add wave -noupdate -group Core /top_tb/soc/dut/ex_addr
add wave -noupdate -group Core /top_tb/soc/dut/ex_rf_st_data
add wave -noupdate -group Core /top_tb/soc/dut/ex_rf_waddr
add wave -noupdate -group Core /top_tb/soc/dut/ex_memop_rd
add wave -noupdate -group Core /top_tb/soc/dut/ex_memop_wr
add wave -noupdate -group Core /top_tb/soc/dut/ex_memop_sign_ext
add wave -noupdate -group Core /top_tb/soc/dut/ex_rf_we
add wave -noupdate -group Core /top_tb/soc/dut/ex_rd
add wave -noupdate -group Core /top_tb/soc/dut/ex_wr
add wave -noupdate -group Core /top_tb/soc/dut/ex_tkbr
add wave -noupdate -group Core /top_tb/soc/dut/ex_new_pc
add wave -noupdate -group Core /top_tb/soc/dut/ex_data_cache_is_busy
add wave -noupdate -group Core /top_tb/soc/dut/ex_data_cache_is_hit
add wave -noupdate -group Core /top_tb/soc/dut/ex_is_jaljalr
add wave -noupdate -group Core /top_tb/soc/dut/ex_seq_new_pc
add wave -noupdate -group Core /top_tb/soc/dut/valid_ex
add wave -noupdate -group Core /top_tb/soc/dut/mem_res
add wave -noupdate -group Core /top_tb/soc/dut/mem_rf_we
add wave -noupdate -group Core /top_tb/soc/dut/mem_rf_waddr
add wave -noupdate -group Core /top_tb/soc/dut/mem_new_pc
add wave -noupdate -group Core /top_tb/soc/dut/mem_wr_data
add wave -noupdate -group Core /top_tb/soc/dut/valid_mem
add wave -noupdate -group Core /top_tb/soc/dut/mem_addr
add wave -noupdate -group Core /top_tb/soc/dut/mem_rd
add wave -noupdate -group Core /top_tb/soc/dut/mem_wr
add wave -noupdate -group Core /top_tb/soc/dut/mem_data_type
add wave -noupdate -group Core /top_tb/soc/dut/wb_res_d
add wave -noupdate -group Core /top_tb/soc/dut/wb_rf_we_d
add wave -noupdate -group Core /top_tb/soc/dut/wb_rf_waddr_d
add wave -noupdate -group Core /top_tb/soc/dut/tkbr_d
add wave -noupdate -group Core /top_tb/soc/dut/wb_new_pc_d
add wave -noupdate -group Core /top_tb/soc/dut/valid_wb_d
add wave -noupdate -group Core /top_tb/soc/dut/wb_res_q
add wave -noupdate -group Core /top_tb/soc/dut/wb_rf_we_q
add wave -noupdate -group Core /top_tb/soc/dut/wb_rf_waddr_q
add wave -noupdate -group Core /top_tb/soc/dut/wb_new_pc_q
add wave -noupdate -group Core /top_tb/soc/dut/valid_wb_q
add wave -noupdate -group Core /top_tb/soc/dut/ic_if_hit
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_block_if
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_inject_nops_if
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_block_id
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_inject_nops_id
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_block_ex
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_inject_nops_ex
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_block_mem
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_inject_nops_mem
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_block_wb
add wave -noupdate -group Core /top_tb/soc/dut/ctrl_inject_nops_wb
add wave -noupdate -group Core /top_tb/soc/dut/sel_mem_req
add wave -noupdate -group Core /top_tb/soc/dut/mem_data_cache_is_hit
add wave -noupdate -group Core /top_tb/soc/dut/mem_ready_to_if_stage
add wave -noupdate -group Core /top_tb/soc/dut/mem_ready_to_mem_stage
add wave -noupdate -group Core /top_tb/soc/dut/mem_data_cache_is_busy
add wave -noupdate -group Core /top_tb/soc/dut/mem_rd_data_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/clk_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/rsn_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/rd_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/wr_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_alu_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/rcvd_mem_request_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_type_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/addr_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/from_mem_cache_line_i
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_hit_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_busy_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/writeback_mem_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/writeback_addr_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/rd_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/wr_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/to_mem_cache_line_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/store_buffer_draining_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/addr_tag
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/addr_index
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/addr_byte
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/valid_bits
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/dirty_bits
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_wr_act_state
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_rd_act_state
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_wr_next_state
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_rd_next_state
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_writeback
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/write_line_from_mem
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/write_into_word
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_hit_from_tags
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_hit
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_from_cache_data
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/reading_valid_entry_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/draining_buffer_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/draining_buffer
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_hit_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/do_not_block_state_update
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_hit_in_tags_state
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_busy
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/tag_in_cacheline
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/writeback_addr
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_data
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_addr
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/cache_sb_mux_dtype
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/addr_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/data_type_sb_o
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/sb_muxes_select
add wave -noupdate -group {Data Cache} /top_tb/soc/dut/mem_stage/data_cache/is_alu
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/clk_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/rsn_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/wr_into_word_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/data_type_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/wr_line_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/addr_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/data_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/from_mem_cache_line_i
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/to_mem_cache_line_o
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/data_o
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/addr_tag
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/addr_index
add wave -noupdate -group {Data Cache} -expand -group Data /top_tb/soc/dut/mem_stage/data_cache/data/addr_byte
add wave -noupdate -group {Data Cache} -expand -group Data -expand /top_tb/soc/dut/mem_stage/data_cache/data/cache_data
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/clk_i
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/rsn_i
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/addr_i
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/wr_en_i
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/is_hit_o
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/tag_in_index_o
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/addr_tag
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/addr_index
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/addr_byte
add wave -noupdate -group {Data Cache} -group Tags /top_tb/soc/dut/mem_stage/data_cache/tags/cache_tags
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/clk_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/rsn_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_type_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_load_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_store_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_alu_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_hit_i
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_type_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_hit_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/reading_valid_entry_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_draining_o
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/sb_entries
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/rd_ptr
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/wr_ptr
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_from_pos
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_from_pos
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_type_from_pos
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_from_rd_ptr
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_from_rd_ptr
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/data_type_from_rd_ptr
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_hit_bits
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/is_hit
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/hit_position
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/sb_valid_entry
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/sb_state
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/sb_next_state
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/full
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/empty
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_tag
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_index
add wave -noupdate -group StoreBuffer /top_tb/soc/dut/mem_stage/data_cache/genblk1/ssb/addr_byte
add wave -noupdate -group Memory /top_tb/soc/tb_mem/clk_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/rsn_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/rd_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/wr_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/mem_ready_o
add wave -noupdate -group Memory /top_tb/soc/tb_mem/data_type_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/addr_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/data_i
add wave -noupdate -group Memory /top_tb/soc/tb_mem/cache_line_o
add wave -noupdate -group Memory /top_tb/soc/tb_mem/rd_data
add wave -noupdate -group Memory /top_tb/soc/tb_mem/cyc_counter
add wave -noupdate -group Memory /top_tb/soc/tb_mem/mem_ready
add wave -noupdate -group Memory /top_tb/soc/tb_mem/aligned_addr_to_cache_lines
add wave -noupdate -group Memory /top_tb/soc/tb_mem/addr_i_ff
add wave -noupdate -group Memory /top_tb/soc/tb_mem/mem_request
add wave -noupdate -group Memory /top_tb/soc/tb_mem/aux_rd
add wave -noupdate -group Memory /top_tb/soc/tb_mem/aux_wr
add wave -noupdate -group Memory /top_tb/soc/tb_mem/write_read_data
add wave -noupdate -group Memory /top_tb/soc/tb_mem/num_of_instructions
add wave -noupdate -group Memory /top_tb/soc/tb_mem/hex_file_fd
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/clk_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/rsn_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/valid_id_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/rd_src_a_id_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/rd_src_b_id_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_a_id_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_b_id_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/valid_ex_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/data_produced_ex_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/is_load_ex_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depEX_src_a_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depEX_src_b_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_a_ex_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_b_ex_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_load_ex_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_a_ex_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_b_ex_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/valid_mem_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/data_produced_mem_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/is_load_mem_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depMEM_src_a_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depMEM_src_b_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_a_mem_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_b_mem_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/valid_wb_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/data_produced_wb_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depWB_src_a_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/depWB_src_b_i
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_a_wb_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/use_bypass_b_wb_o
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/bypass_mux_sel_a
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/bypass_mux_sel_b
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_load_ex
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_a_ex
add wave -noupdate -group {Bypass Controller} /top_tb/soc/dut/controller/bypass/mux_sel_b_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/clk_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/rsn_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/sel_mem_req_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_if_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/ic_if_hit_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_if_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_if_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked_1cycle_ago_if_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/src_a_identifier_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/src_b_identifier_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/rd_src_a_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/rd_src_b_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/is_store_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/decode_instr_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m1_in_id_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_id_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_id_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/mul_sel_a_id_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/mul_sel_b_id_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_ex_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_ex_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/we_ex_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/tkbr_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/data_produced_ex_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/is_load_ex_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/mul_sel_load_ex_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/mul_sel_a_ex_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/mul_sel_b_ex_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_ex_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_ex_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/tkbr_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dc_rd_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dc_wr_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dc_mem_hit_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/store_buffer_draining_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/data_produced_mem_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_mem_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_mem_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/we_mem_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/is_load_mem_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_mem_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_mem_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked_1cycle_ago_mem_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_wb_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_wb_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/we_wb_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/data_produced_wb_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_wb_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_wb_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m1_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_m1_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_m1_o
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m2_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_m2_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m3_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_m3_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m4_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_m4_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/valid_m5_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_m5_i
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_a_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_b_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_a_mem
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_b_mem
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_a_wb
add wave -noupdate -group Controller /top_tb/soc/dut/controller/id_use_bypass_b_wb
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_d_1
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_d_2
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_d_3
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_d_4
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_q_1
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_q_2
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_q_3
add wave -noupdate -group Controller /top_tb/soc/dut/controller/finish_test_q_4
add wave -noupdate -group Controller /top_tb/soc/dut/controller/or_block_if
add wave -noupdate -group Controller /top_tb/soc/dut/controller/or_block_id
add wave -noupdate -group Controller /top_tb/soc/dut/controller/or_block_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/or_block_mem
add wave -noupdate -group Controller /top_tb/soc/dut/controller/or_block_wb
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_if
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_if
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_id
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked1cycleago_if_d
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked1cycleago_if_q
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_id
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depEX_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depMEM_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depWB_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM1_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM2_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM3_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM4_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM5_src_a
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depEX_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depMEM_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depWB_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM1_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM2_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM3_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM4_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM5_src_b
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depEX
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depMEM
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depWB
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_ex
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_mem
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_wb
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_m1
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_m2
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_m3
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_m4
add wave -noupdate -group Controller /top_tb/soc/dut/controller/dstzero_m5
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM1
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM2
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM3
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM4
add wave -noupdate -group Controller /top_tb/soc/dut/controller/depM5
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_m1
add wave -noupdate -group Controller /top_tb/soc/dut/controller/block_mem
add wave -noupdate -group Controller /top_tb/soc/dut/controller/inject_nops_wb
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked1cycleago_mem_d
add wave -noupdate -group Controller /top_tb/soc/dut/controller/blocked1cycleago_mem_q
add wave -noupdate -group Controller /top_tb/soc/dut/controller/rcvd_mem_req
add wave -noupdate -group Controller /top_tb/soc/dut/controller/sel_mem_req
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/clk_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/rsn_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/cache_instr_line_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/mem_ready_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/new_pc_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/inject_nops_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instruction_hit_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/mem_rd_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/data_type
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/rd
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/wr
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/is_alu
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/data
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/store_buffer_draining
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/is_hit
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/writeback
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/to_mem_cache_line
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instr_to_feed_decode
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/tkbr_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instr_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/valid_if_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/block_if_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/blocked_1cycle_ago_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/block_id_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/blocked_id_1cycle_ago_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/mem_addr_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/tkbr_latch
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc_cache
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/clk_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rsn_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/ex_rd_data_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/mem_rd_data_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/wb_rd_data_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/mux_sel_a_id_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/mux_sel_b_id_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_if_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_a_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_b_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_data_a_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_data_b_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_opcode_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_src_a_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_src_b_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_we_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_waddr_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_type_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_sign_ext_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_rd_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_wr_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_rf_data_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_src_a_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_src_b_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/is_jaljalr_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/block_id_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/inject_nops_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_id_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/src_a_identifier_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/src_b_identifier_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rd_raddr_a_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rd_raddr_b_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_ex_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_mem_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_id_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/finish_test_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_ex
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_mem
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_u_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_i_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_s_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_j_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_b_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/src_a_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/src_b_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/a_imm_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/b_imm_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_a_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_b_mux_sel
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_a
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/imm_b
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_a
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_b
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_waddr
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_we
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_src_a
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_src_b
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_src_a
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/br_src_b
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_type
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_rd
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_wr
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/memop_sign_ext
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/alu_opcode
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_ex_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_mem_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_ex_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/prod_data_stage_mem_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_id_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_id_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/muxed_src_a
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/muxed_src_b
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/clk_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rsn_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/valid_m1_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/opcode_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_we_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/src_a_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/src_b_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_waddr_i
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/valid_m3_o
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_waddr_o
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_wdata_o
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/valid_m5_o
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_we_o
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_valid_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_src_a_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_src_b_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_rf_waddr_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_opcode_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_we_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_valid_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_src_a_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_src_b_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_rf_waddr_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_opcode_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m1_we_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_valid_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_src_a_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_src_b_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_rf_waddr_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_opcode_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_we_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_valid_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_src_a_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_src_b_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_rf_waddr_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_opcode_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m2_we_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_valid_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_src_a_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_src_b_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_rf_waddr_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_opcode_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_we_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_valid_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_src_a_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_src_b_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_rf_waddr_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_opcode_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m3_we_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_valid_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_src_a_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_src_b_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_rf_waddr_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_opcode_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_we_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_valid_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_src_a_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_src_b_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_rf_waddr_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_opcode_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m4_we_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_valid_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_src_a_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_src_b_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_rf_waddr_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_opcode_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_we_d
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_valid_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_src_a_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_src_b_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_rf_waddr_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_opcode_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/m5_we_q
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/mul_op
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/rf_wdata
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/signed_src_a
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/signed_src_b
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/unsigned_src_a
add wave -noupdate -expand -group M_ext_pipeline /top_tb/soc/dut/M_ext/unsigned_src_b
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/clk_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rsn_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/valid_id_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/finish_test_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_load_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_a_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_b_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/op_res_stage_mem_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/op_res_stage_wb_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_opcode_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_a_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_b_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_we_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_waddr_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_st_data_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_type_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_rd_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_wr_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_a_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_b_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_res_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_we_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_waddr_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_st_data_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_type_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_rd_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_wr_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/tkbr_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/new_pc_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/pc_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/block_ex_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/inject_nops_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/valid_ex_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/is_load_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_ex_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_mem_i
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_ex_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_mem_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/data_produced_ex_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/finish_test_o
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_res
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/tkbr
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_a_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_b_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_we_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_type_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_rd_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_wr_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_opcode_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_a_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_b_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_waddr_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_st_data_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/valid_ex_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/finish_test_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_ex_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_mem_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_load_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_a_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_b_d
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_a_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_src_b_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_we_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_type_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_rd_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/memop_wr_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/alu_opcode_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_a_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/br_src_b_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_waddr_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/rf_st_data_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/valid_ex_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/finish_test_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_ex_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/prod_data_stage_mem_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_load_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_a_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/mux_sel_b_q
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/muxed_store_data
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/muxed_src_a
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/muxed_src_b
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/muxed_br_src_a
add wave -noupdate -group EX /top_tb/soc/dut/ex_stage/muxed_br_src_b
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/clk_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rsn_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/valid_ex_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/blocked_1cycle_ago_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/cache_is_busy_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/cache_is_hit_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/cache_line_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/mem_ready_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/addr_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_rd_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_wr_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_type_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/to_mem_cache_line_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/alu_res_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_we_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_type_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_rd_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_wr_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/new_pc_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/op_res_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_we_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/new_pc_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/block_mem_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/inject_nops_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/valid_mem_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/prod_data_stage_ex_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/prod_data_stage_mem_i
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/data_produced_mem_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_load_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/dc_rd_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/dc_wr_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/sb_draining_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/read_cache_data
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/processed_read_cache_data
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_hit
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_busy
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/writeback
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/store_buffer_draining
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/to_mem_cache_line
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/alu_res_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_we_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_type_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_rd_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_wr_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/new_pc_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/valid_mem_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/data_produced_mem_d
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/alu_res_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_we_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_type_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_rd_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_wr_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/new_pc_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/valid_mem_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/data_produced_mem_q
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_alu
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/aux_addr
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/aux_memop
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/aux_data
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/writeback_addr
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/rd
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/wr
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/writeback_mem_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_o
add wave -noupdate -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_o
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /top_tb/soc/dut/wb_res_d
add wave -noupdate /top_tb/soc/dut/wb_rf_we_d
add wave -noupdate /top_tb/soc/dut/wb_rf_waddr_d
add wave -noupdate /top_tb/soc/dut/tkbr_d
add wave -noupdate /top_tb/soc/dut/wb_new_pc_d
add wave -noupdate /top_tb/soc/dut/valid_wb_d
add wave -noupdate /top_tb/soc/dut/wb_res_q
add wave -noupdate /top_tb/soc/dut/wb_rf_we_q
add wave -noupdate /top_tb/soc/dut/wb_rf_waddr_q
add wave -noupdate /top_tb/soc/dut/wb_new_pc_q
add wave -noupdate /top_tb/soc/dut/valid_wb_q
add wave -noupdate /top_tb/soc/dut/ctrl_block_wb
add wave -noupdate /top_tb/soc/dut/ctrl_inject_nops_wb
add wave -noupdate /top_tb/soc/dut/m5_waddr
add wave -noupdate /top_tb/soc/dut/m5_wdata
add wave -noupdate /top_tb/soc/dut/m5_valid
add wave -noupdate /top_tb/soc/dut/m5_we
add wave -noupdate /top_tb/soc/dut/ctrl_valid_m3
add wave -noupdate /top_tb/soc/dut/muxed_we
add wave -noupdate /top_tb/soc/dut/muxed_rf_waddr
add wave -noupdate /top_tb/soc/dut/muxed_rf_w_data
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/clk_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/rsn_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/we_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/raddr_a_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/data_a_o
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/raddr_b_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/data_b_o
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/waddr_i
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/data_w_i
add wave -noupdate -expand -group {REGISTER FILE} -expand /top_tb/soc/dut/segre_rf/rf_reg
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/rf_reg_aux
add wave -noupdate -expand -group {REGISTER FILE} /top_tb/soc/dut/segre_rf/write_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1094619843 ps} 0} {{Cursor 2} {2550000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 163
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
WaveRestoreZoom {1094397460 ps} {1096114576 ps}
