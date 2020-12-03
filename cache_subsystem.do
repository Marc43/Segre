onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/clk_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/rsn_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/rd_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/wr_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_alu_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/rcvd_mem_request_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/data_type_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/addr_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/data_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/from_mem_cache_line_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_hit_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/writeback_mem_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/data_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/to_mem_cache_line_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/addr_tag
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/addr_index
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/addr_byte
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/valid_bits
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/dirty_bits
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_wr_act_state
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_rd_act_state
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_wr_next_state
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_rd_next_state
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_writeback
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/write_line_from_mem
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/write_into_word
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_hit_from_tags
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_hit
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/data_from_cache_data
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/reading_valid_entry_sb_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_sb_mux_data
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/cache_sb_mux_addr
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/data_sb_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/addr_sb_o
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_load_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_store_i
add wave -noupdate -expand -group {Cache Signals} /cache_tb/cache/is_hit_sb_o
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/clk_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/rsn_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/wr_into_word_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/data_type_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/wr_line_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/addr_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/data_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/from_mem_cache_line_i
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/to_mem_cache_line_o
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/data_o
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/addr_tag
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/addr_index
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/addr_byte
add wave -noupdate -group {Data Signals} /cache_tb/cache/data/cache_data
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/clk_i
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/rsn_i
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/addr_i
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/wr_en_i
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/is_hit_o
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/addr_tag
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/addr_index
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/addr_byte
add wave -noupdate -group {Tag Signals} /cache_tb/cache/tags/cache_tags
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/clk_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/rsn_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/data_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/addr_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_load_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_store_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_alu_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_hit_i
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/data_o
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/addr_o
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_hit_o
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/reading_valid_entry_o
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/sb_entries
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/rd_ptr
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/wr_ptr
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/data_from_pos
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/addr_from_pos
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/data_from_rd_ptr
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/addr_from_rd_ptr
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_hit_bits
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/is_hit
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/hit_position
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/sb_valid_entry
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/sb_state
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/sb_next_state
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/full
add wave -noupdate -expand -group {Store Buffer} /cache_tb/cache/ssb/empty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 310
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
WaveRestoreZoom {0 ps} {3448832 ps}
