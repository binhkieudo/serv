set_property SRC_FILE_INFO {cfile:/home/binhkieudo/Public/Workspace/XRPIX/serv/build/servant_1.2.1/src/servant_1.2.1/data/nexys_a7.xdc rfile:../../../../src/servant_1.2.1/data/nexys_a7.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN E3  IOSTANDARD LVCMOS33 } [get_ports i_clk];
set_property src_info {type:XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN D4  IOSTANDARD LVCMOS33 } [get_ports q]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk];
