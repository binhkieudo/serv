-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Fri Aug  4 04:50:05 2023
-- Host        : binhkieudo-hotswap running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/binhkieudo/Workspace/XRPIX/serv/build/servant_1.2.1/nexys_a7-vivado/servant_1.2.1.gen/sources_1/ip/ila_0/ila_0_stub.vhdl
-- Design      : ila_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe7 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe8 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe9 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe10 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe11 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe12 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe13 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe14 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe15 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe16 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe17 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe18 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    probe19 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe20 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe21 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe22 : in STD_LOGIC_VECTOR ( 39 downto 0 );
    probe23 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe24 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe25 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe26 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe27 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe28 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe29 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe30 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe31 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe32 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe33 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe34 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe35 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe36 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe37 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe38 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe39 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe40 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe41 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe42 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe43 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe44 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe45 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe46 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe47 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe48 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe49 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe50 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe51 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe52 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe53 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe54 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe55 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe56 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe57 : in STD_LOGIC_VECTOR ( 127 downto 0 );
    probe58 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe59 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe60 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe61 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe62 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe63 : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end ila_0;

architecture stub of ila_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[0:0],probe1[5:0],probe2[31:0],probe3[1:0],probe4[0:0],probe5[0:0],probe6[0:0],probe7[0:0],probe8[0:0],probe9[0:0],probe10[2:0],probe11[0:0],probe12[0:0],probe13[1:0],probe14[31:0],probe15[31:0],probe16[5:0],probe17[3:0],probe18[4:0],probe19[0:0],probe20[31:0],probe21[31:0],probe22[39:0],probe23[0:0],probe24[0:0],probe25[0:0],probe26[0:0],probe27[0:0],probe28[0:0],probe29[0:0],probe30[31:0],probe31[1:0],probe32[31:0],probe33[31:0],probe34[31:0],probe35[31:0],probe36[3:0],probe37[0:0],probe38[0:0],probe39[31:0],probe40[0:0],probe41[0:0],probe42[0:0],probe43[2:0],probe44[31:0],probe45[31:0],probe46[31:0],probe47[31:0],probe48[0:0],probe49[0:0],probe50[1:0],probe51[0:0],probe52[0:0],probe53[0:0],probe54[0:0],probe55[2:0],probe56[0:0],probe57[127:0],probe58[0:0],probe59[5:0],probe60[0:0],probe61[0:0],probe62[7:0],probe63[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2022.2";
begin
end;
