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
         input  wire SYSCLK_P,
         input  wire SYSCLK_N,
         // JTAG
         input  wire i_jtag_trst,
         input  wire i_jtag_tck,
         input  wire i_jtag_tdi,
         output wire o_jtag_tdo,
         input  wire i_jtag_tms
    );
    
    reg [5:0] init_rst = 6'b000000;
    
    wire wb_clk;
    
    IBUFDS #(
       .DIFF_TERM("FALSE"),       // Differential Termination
       .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE"
       .IOSTANDARD("LVDS")     // Specify the input I/O standard
    ) IBUFDS_inst (
       .O   (wb_clk    ),  // Buffer output
       .I   (SYSCLK_P   ),  // Diff_p buffer input (connect directly to top-level port)
       .IB  (SYSCLK_N   ) // Diff_n buffer input (connect directly to top-level port)
    );
    
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
