onerror {resume}
quietly virtual function -install /top_tb/soc/dut/if_stage/instruction_cache/data -env /top_tb/#INITIAL#56 { &{/top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][3], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][2], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][1], /top_tb/soc/dut/if_stage/instruction_cache/data/cache_data[3][0] }} instr_0
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/clk_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/rsn_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/valid_if_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/ic_if_hit_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_if_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_if_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/valid_id_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/src_a_identifier_id_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/src_b_identifier_id_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_id_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_id_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/valid_ex_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_ex_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/we_ex_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_ex_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_ex_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/valid_mem_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_mem_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/we_mem_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_mem_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_mem_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/valid_wb_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/dst_reg_identifier_wb_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/we_wb_i
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_wb_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_wb_o
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_if
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_if
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_id
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/block_id
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/inject_nops_ex
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/depEX
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/depMEM
add wave -noupdate -expand -group Controller /top_tb/soc/dut/controller/depWB
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/clk_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/rsn_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/cache_instr_line_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/mem_ready_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/tkbr_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/new_pc_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/block_if_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/inject_nops_i
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/valid_if_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instruction_hit_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/mem_rd_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instr_o
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc_o
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
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/instr_to_feed_decode
add wave -noupdate -expand -group IF /top_tb/soc/dut/if_stage/pc
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/clk_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rsn_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_if_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_a_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_raddr_b_o
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_data_a_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_data_b_i
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/rf_data_b_o
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
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/instr_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/pc_q
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_id_d
add wave -noupdate -expand -group ID /top_tb/soc/dut/id_stage/valid_id_q
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/clk_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rsn_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/valid_id_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_data_b_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_opcode_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_a_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_b_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_we_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_waddr_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_st_data_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_type_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rd_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_wr_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_a_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_b_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_res_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_we_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_waddr_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_st_data_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_type_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rd_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_wr_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/tkbr_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/new_pc_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/pc_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/block_ex_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/inject_nops_i
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/valid_ex_o
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_res
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/tkbr
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_a_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_b_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_we_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_type_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rd_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_wr_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_opcode_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_a_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_b_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rf_data_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_waddr_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_st_data_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/valid_ex_d
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_a_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_src_b_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_we_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_sign_ext_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_type_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rd_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_wr_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/alu_opcode_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_a_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/br_src_b_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/memop_rf_data_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/seq_new_pc_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/is_jaljalr_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_waddr_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/rf_st_data_q
add wave -noupdate -expand -group EX /top_tb/soc/dut/ex_stage/valid_ex_q
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/clk_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rsn_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/valid_ex_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/cache_is_busy_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/cache_is_hit_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/cache_line_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/mem_ready_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/addr_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_rd_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_wr_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_type_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/to_mem_cache_line_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/alu_res_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_we_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_type_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_rd_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_wr_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/tkbr_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/new_pc_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/op_res_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_we_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/tkbr_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/new_pc_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/block_mem_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/inject_nops_i
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/valid_mem_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/read_cache_data
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/processed_read_cache_data
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_hit
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_busy
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/writeback
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/store_buffer_draining
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/to_mem_cache_line
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/check_if_hit
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/output_address
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/output_memop_type
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/output_data
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/muxed_memop_type
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/alu_res_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_we_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_type_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_rd_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_wr_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/new_pc_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/tkbr_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/valid_mem_d
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/alu_res_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_we_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_st_data_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_type_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_rd_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_wr_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_sign_ext_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/new_pc_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/tkbr_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/valid_mem_q
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_alu
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/aux_addr
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/aux_memop
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/aux_data
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/writeback_addr
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rd
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/wr
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/writeback_mem_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_rd_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/memop_wr_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_we_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/rf_waddr_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/tkbr_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/new_pc_ff
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/seq_new_pc_o
add wave -noupdate -expand -group MEM /top_tb/soc/dut/mem_stage/is_jaljalr_o
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
add wave -noupdate /top_tb/soc/dut/tkbr_q
add wave -noupdate /top_tb/soc/dut/wb_new_pc_q
add wave -noupdate /top_tb/soc/dut/valid_wb_q
add wave -noupdate /top_tb/soc/dut/ctrl_block_wb
add wave -noupdate /top_tb/soc/dut/ctrl_inject_nops_wb
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
WaveRestoreCursors {{Cursor 1} {390000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 93
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
WaveRestoreZoom {0 ps} {1182699 ps}
