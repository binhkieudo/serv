`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2023 12:39:18 AM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );
    
     reg wb_clk = 1'b0;
     reg wb_rst = 1'b1;
     // GPIO
     wire q;
     // JTAG
     reg i_jtag_trst = 1'b0;
     reg i_jtag_tck  = 1'b0;
     reg i_jtag_tdi  = 1'b0;
     wire o_jtag_tdo;
     reg i_jtag_tms  = 1'b0;
     // Flash control
     wire o_flash_SCK;
     wire o_flash_CSn;
     wire o_flash_MOSI;
     reg i_flash_MISO = 1'b0;

    servant udt (.*);
    
    wire [31:0] ibus_address = udt.cpu.o_ibus_adr >> 2;
    
    always #1 wb_clk = ~wb_clk;
    
    initial begin
        #4 wb_rst = 1'b0;
        #100000 $stop;
    end
    
endmodule
