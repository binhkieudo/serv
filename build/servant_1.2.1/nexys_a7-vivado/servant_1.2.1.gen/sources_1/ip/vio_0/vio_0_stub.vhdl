-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Wed Aug  2 18:40:42 2023
-- Host        : binhkieudo running 64-bit Ubuntu 20.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/binhkieudo/Workspace/XRPIX/serv/build/servant_1.2.1/nexys_a7-vivado/servant_1.2.1.gen/sources_1/ip/vio_0/vio_0_stub.vhdl
-- Design      : vio_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vio_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe_in0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe_in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in3 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in5 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in6 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in7 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in8 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in9 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in10 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_in11 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in12 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in13 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in14 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in15 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in16 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in17 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe_in18 : in STD_LOGIC_VECTOR ( 4 downto 0 );
    probe_in19 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in20 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in21 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in22 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in23 : in STD_LOGIC_VECTOR ( 39 downto 0 );
    probe_in24 : in STD_LOGIC_VECTOR ( 39 downto 0 );
    probe_in25 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in26 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in27 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in28 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in29 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    probe_in30 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in31 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in32 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in33 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in34 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in35 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in36 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in37 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in38 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in39 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in40 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_in41 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in42 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in43 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    probe_in44 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in45 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in46 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in47 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in48 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe_in49 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe_in50 : in STD_LOGIC_VECTOR ( 127 downto 0 );
    probe_out0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    probe_out2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    probe_out3 : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );

end vio_0;

architecture stub of vio_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe_in0[0:0],probe_in1[5:0],probe_in2[31:0],probe_in3[1:0],probe_in4[0:0],probe_in5[0:0],probe_in6[0:0],probe_in7[0:0],probe_in8[0:0],probe_in9[0:0],probe_in10[3:0],probe_in11[2:0],probe_in12[0:0],probe_in13[0:0],probe_in14[1:0],probe_in15[31:0],probe_in16[31:0],probe_in17[5:0],probe_in18[4:0],probe_in19[0:0],probe_in20[31:0],probe_in21[31:0],probe_in22[31:0],probe_in23[39:0],probe_in24[39:0],probe_in25[31:0],probe_in26[31:0],probe_in27[31:0],probe_in28[31:0],probe_in29[3:0],probe_in30[0:0],probe_in31[0:0],probe_in32[31:0],probe_in33[0:0],probe_in34[0:0],probe_in35[0:0],probe_in36[2:0],probe_in37[31:0],probe_in38[31:0],probe_in39[31:0],probe_in40[31:0],probe_in41[0:0],probe_in42[0:0],probe_in43[1:0],probe_in44[0:0],probe_in45[0:0],probe_in46[0:0],probe_in47[0:0],probe_in48[0:0],probe_in49[2:0],probe_in50[127:0],probe_out0[0:0],probe_out1[0:0],probe_out2[31:0],probe_out3[1:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "vio,Vivado 2022.2";
begin
end;
