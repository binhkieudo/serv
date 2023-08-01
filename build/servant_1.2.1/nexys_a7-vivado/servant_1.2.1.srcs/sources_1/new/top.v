`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2023 12:28:18 PM
// Design Name: 
// Module Name: top
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


module top(
         input  wire wb_clk,
         // JTAG
         input  wire i_jtag_trst,
         input  wire i_jtag_tck,
         input  wire i_jtag_tdi,
         output wire o_jtag_tdo,
         input  wire i_jtag_tms
    );
    
    reg [5:0] init_rst = 6'b000000;
    
    always @(posedge wb_clk)
        init_rst <= {init_rst[4:0], 1'b1};
        
    servant
    (
         .wb_clk     (wb_clk),
         .wb_rstn    (init_rst[5]),
         // GPIO
         .q          (),
         // JTAG
         .i_jtag_trst(i_jtag_trst),
         .i_jtag_tck (i_jtag_tck),
         .i_jtag_tdi (i_jtag_tdi),
         .o_jtag_tdo (o_jtag_tdo),
         .i_jtag_tms (i_jtag_tms),
         // Flash control
         .o_flash_SCK (),
         .o_flash_CSn (),
         .o_flash_MOSI(),
         .i_flash_MISO(1'b0)
    );
    
    
endmodule
