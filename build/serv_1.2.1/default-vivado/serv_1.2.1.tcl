# Auto-generated project tcl file


create_project serv_1.2.1 -force

set_property part xc7a100tcsg324-1 [current_project]





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

set_property include_dirs [list .] [get_filesets sources_1]
set_property top serv_rf_top [current_fileset]
set_property source_mgmt_mode None [current_project]


