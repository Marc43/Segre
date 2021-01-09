onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sb_cache_tb/clk
add wave -noupdate /sb_cache_tb/rsn
add wave -noupdate -group {TB } /sb_cache_tb/data_tb
add wave -noupdate -group {TB } /sb_cache_tb/addr_tb
add wave -noupdate -group {TB } /sb_cache_tb/is_load
add wave -noupdate -group {TB } /sb_cache_tb/is_store
add wave -noupdate -group {TB } /sb_cache_tb/is_alu
add wave -noupdate -group {TB } /sb_cache_tb/data_o_sb
add wave -noupdate -group {TB } /sb_cache_tb/addr_o_sb
add wave -noupdate -group {TB } /sb_cache_tb/is_hit_o_sb
add wave -noupdate -group {TB } /sb_cache_tb/rd
add wave -noupdate -group {TB } /sb_cache_tb/wr
add wave -noupdate -group {TB } /sb_cache_tb/rcvd_mem_req
add wave -noupdate -group {TB } /sb_cache_tb/data_type
add wave -noupdate -group {TB } /sb_cache_tb/from_mem_cache_in
add wave -noupdate -group {TB } /sb_cache_tb/is_hit
add wave -noupdate -group {TB } /sb_cache_tb/writeback_mem
add wave -noupdate -group {TB } /sb_cache_tb/data_out
add wave -noupdate -group {TB } /sb_cache_tb/to_mem_cache_out
add wave -noupdate -group {TB } /sb_cache_tb/addr_tag
add wave -noupdate -group {TB } /sb_cache_tb/addr_index
add wave -noupdate -group {TB } /sb_cache_tb/addr_byte
add wave -noupdate -group {TB } /sb_cache_tb/addr
add wave -noupdate -group {TB } /sb_cache_tb/cache_sb_mux_data
add wave -noupdate -group {TB } /sb_cache_tb/cache_sb_mux_addr
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/clk_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/rsn_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/data_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/addr_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_load_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_store_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_alu_i
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/data_o
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/addr_o
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_hit_o
add wave -noupdate -expand -group {STORE BUFFER} -expand /sb_cache_tb/ssb/sb_entries
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/data_from_rd_ptr
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/addr_from_rd_ptr
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/rd_ptr
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/wr_ptr
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/data_from_pos
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/addr_from_pos
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_hit_bits
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/is_hit
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/hit_position
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/sb_valid_entry
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/sb_state
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/sb_next_state
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/full
add wave -noupdate -expand -group {STORE BUFFER} /sb_cache_tb/ssb/empty
add wave -noupdate -group CACHE /sb_cache_tb/cache/clk_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/rsn_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/rd_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/wr_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/rcvd_mem_request_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/data_type_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/addr_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/data_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/from_mem_cache_line_i
add wave -noupdate -group CACHE /sb_cache_tb/cache/is_hit_o
add wave -noupdate -group CACHE /sb_cache_tb/cache/writeback_mem_o
add wave -noupdate -group CACHE /sb_cache_tb/cache/data_o
add wave -noupdate -group CACHE /sb_cache_tb/cache/to_mem_cache_line_o
add wave -noupdate -group CACHE /sb_cache_tb/cache/addr_tag
add wave -noupdate -group CACHE /sb_cache_tb/cache/addr_index
add wave -noupdate -group CACHE /sb_cache_tb/cache/addr_byte
add wave -noupdate -group CACHE /sb_cache_tb/cache/valid_bits
add wave -noupdate -group CACHE /sb_cache_tb/cache/dirty_bits
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_tags
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_data
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_wr_act_state
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_rd_act_state
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_wr_next_state
add wave -noupdate -group CACHE /sb_cache_tb/cache/cache_rd_next_state
add wave -noupdate -group CACHE /sb_cache_tb/cache/is_writeback
add wave -noupdate -group CACHE /sb_cache_tb/cache/write_line_from_mem
add wave -noupdate -group CACHE /sb_cache_tb/cache/write_into_line
add wave -noupdate -group CACHE /sb_cache_tb/cache/is_hit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {240676 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
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
WaveRestoreZoom {0 ps} {937984 ps}
