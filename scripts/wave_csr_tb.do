onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -group CSR_TB /csr_regfile_tb/clk
add wave -noupdate -group CSR_TB /csr_regfile_tb/rsn
add wave -noupdate -group CSR_TB /csr_regfile_tb/we_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/exc_we_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/r_id_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/w_id_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/w_data_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/w_data_mtvec_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/w_data_mepc_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/w_data_mcause_tb
add wave -noupdate -group CSR_TB /csr_regfile_tb/data_o_tb

add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/clk_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/rsn_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/we_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/exc_we_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/r_id_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/w_id_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/w_data_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/w_data_mtvec_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/w_data_mepc_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/w_data_mcause_i
add wave -noupdate -group CSR_MODULE /csr_regfile_tb/csr_regfile/data_o

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
