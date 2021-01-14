set rtl_dir src/rtl
set tb_dir src/tb
set work_dir build/work
set pkg_dir src/pkg

# Create build dir
file mkdir build

# Create work library
vlib $work_dir

# Compile packages
vlog -sv -work $work_dir $pkg_dir/segre_pkg.sv

vlog -sv -work $work_dir $rtl_dir/segre_csr_register_file.sv

vlog -sv -work $work_dir +define+USE_MODELSIM=1 $tb_dir/csr_regfile_tb.sv

vsim -debugDB -dpicpppath /usr/bin/gcc -l build/sim_transcript -voptargs=+acc $work_dir.csr_regfile_tb

#Create the wave signals
do scripts/wave_csr_tb.do