vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../servant_1.2.1.gen/sources_1/ip/ila_1/hdl/verilog" \
"../../../../servant_1.2.1.gen/sources_1/ip/ila_1/sim/ila_1.v" \


vlog -work xil_defaultlib \
"glbl.v"

