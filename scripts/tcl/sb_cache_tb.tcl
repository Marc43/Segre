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

vlog -sv -work $work_dir $rtl_dir/segre_cache.sv
vlog -sv -work $work_dir $rtl_dir/segre_store_buffer.sv

vlog -sv -work $work_dir $tb_dir/sb_cache_tb.sv

vsim -debugDB -dpicpppath /usr/bin/gcc -l build/sim_transcript -voptargs=+acc $work_dir.sb_cache_tb
