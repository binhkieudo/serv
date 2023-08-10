vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../servant_1.2.1.gen/sources_1/ip/vio_0_1/hdl/verilog" "+incdir+../../../../servant_1.2.1.gen/sources_1/ip/vio_0_1/hdl" \
"/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../servant_1.2.1.gen/sources_1/ip/vio_0_1/hdl/verilog" "+incdir+../../../../servant_1.2.1.gen/sources_1/ip/vio_0_1/hdl" \
"../../../../servant_1.2.1.gen/sources_1/ip/vio_0_1/sim/vio_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

