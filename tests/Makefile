mkfile_path = $(abspath $(lastword $(MAKEFILE_LIST)))

TARGET = riscv64-unknown-elf

AS = $(TARGET)-as
GCC = $(TARGET)-gcc
SPIKE = ../../riscv-isa-sim/build/spike --log-commits --isa rv32im
CFLAGS = -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -march=rv32i -mabi=ilp32 -Tlink.ld -Isrc/
ASFLAGS = -march=rv32i -mabi=ilp32
OBJD = $(TARGET)-objdump

TEST_SRC = $(shell cat src/testlist)
TEST_OBJ_SEGRE = $(patsubst %.S, build_segre/%.o, $(TEST_SRC))
TEST_OBJ_SPIKE = $(patsubst %.S, build_spike/%.o, $(TEST_SRC))
TEST_HEX_SEGRE = $(patsubst build_segre/%.o, hex_segre/%.hex, $(TEST_OBJ_SEGRE))
TEST_RES_SPIKE = $(patsubst build_spike/%.o, result_segre/%.result, $(TEST_OBJ_SPIKE))

.PHONY: clean
all: build_dirs build gen_hex gen_results

build_dirs:
	mkdir -p build_segre
	mkdir -p build_spike
	mkdir -p hex_segre
	mkdir -p result_segre

build: build_dirs $(TEST_OBJ_SEGRE) $(TEST_OBJ_SPIKE)
gen_hex: build_dirs $(TEST_HEX_SEGRE)
gen_results: build_dirs $(TEST_RES_SPIKE)

build_segre/%.o: src/%.S
	cp $^ segre_test.S
	$(AS) $(ASFLAGS) src/segre_harness.S -o $@
	rm segre_test.S

build_spike/%.o: src/%.S
	cp $^ segre_test.S
	$(GCC) $(CFLAGS) src/spike_harness.S -o $@
	rm segre_test.S

hex_segre/%.hex: build_segre/%.o
	$(OBJD) -d $^ | grep -E "[a-f0-9]+:" | awk '{print $$2}' > $@;

result_segre/%.result: build_spike/%.o
	rm -rf $@
	$(SPIKE) $^ 2> tmp.result
	echo 0 >> $@
	cat tmp.result | grep "x 1" | tail -n 1 | sed -e 's/x 1/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 2" | tail -n 1 | sed -e 's/x 2/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 3" | tail -n 2 | head -n 1 | sed -e 's/x 3/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 4" | tail -n 1 | sed -e 's/x 4/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 5" | tail -n 1 | sed -e 's/x 5/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 6" | tail -n 1 | sed -e 's/x 6/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 7" | tail -n 1 | sed -e 's/x 7/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 8" | tail -n 1 | sed -e 's/x 8/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x 9" | tail -n 1 | sed -e 's/x 9/x1/g' | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x10" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x11" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x12" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x13" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x14" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x15" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x16" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x17" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x18" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x19" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x20" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x21" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x22" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x23" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x24" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x25" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x26" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x27" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x28" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x29" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x30" | tail -n 2 | head -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	cat tmp.result | grep "x31" | tail -n 1 | awk '{print $$7}' | cut -c 3-11 | xargs -I {} echo {} >> $@
	rm tmp.result

clean:
	rm -rf hex_segre build_spike build_segre result_segre