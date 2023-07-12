# Auto-generated project tcl file


create_project servant_1.2.1 -force




set_property generic {memfile=/home/binhkieudo/Workspace/XRPIX/serv/sw/blinky.hex memsize=8192 frequency=32 } [get_filesets sources_1]


read_verilog {../src/serv_1.2.1/rtl/serv_bufreg.v}
read_verilog {../src/serv_1.2.1/rtl/serv_bufreg2.v}
read_verilog {../src/serv_1.2.1/rtl/serv_alu.v}
read_verilog {../src/serv_1.2.1/rtl/serv_csr.v}
read_verilog {../src/serv_1.2.1/rtl/serv_ctrl.v}
read_verilog {../src/serv_1.2.1/rtl/serv_decode.v}
read_verilog {../src/serv_1.2.1/rtl/serv_immdec.v}
read_verilog {../src/serv_1.2.1/rtl/serv_mem_if.v}
read_verilog {../src/serv_1.2.1/rtl/serv_rf_if.v}
read_verilog {../src/serv_1.2.1/rtl/serv_rf_ram_if.v}
read_verilog {../src/serv_1.2.1/rtl/serv_rf_ram.v}
read_verilog {../src/serv_1.2.1/rtl/serv_state.v}
read_verilog {../src/serv_1.2.1/rtl/serv_top.v}
read_verilog {../src/serv_1.2.1/rtl/serv_rf_top.v}
read_verilog {../src/serv_1.2.1/rtl/serv_aligner.v}
read_verilog {../src/serv_1.2.1/rtl/serv_compdec.v}
read_verilog {../src/servant_1.2.1/servant/servant_clock_gen.v}
read_verilog {../src/servant_1.2.1/servant/servant_timer.v}
read_verilog {../src/servant_1.2.1/servant/servant_gpio.v}
read_verilog {../src/servant_1.2.1/servant/servant_arbiter.v}
read_verilog {../src/servant_1.2.1/servant/servant_mux.v}
read_verilog {../src/servant_1.2.1/servant/servant_ram.v}
read_verilog {../src/servant_1.2.1/servant/servant.v}
read_verilog {../src/servant_1.2.1/servant/servix_clock_gen.v}
read_verilog {../src/servant_1.2.1/servant/servix.v}
read_xdc {../src/servant_1.2.1/data/nexys_a7.xdc}

set_property include_dirs [list .] [get_filesets sources_1]
set_property top servix [current_fileset]
set_property source_mgmt_mode None [current_project]


