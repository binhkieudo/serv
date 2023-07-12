module servix
(
 input wire  i_clk,
 input wire  i_rst_n,
 output wire q);

   parameter memfile = "blinky.hex";
   parameter memsize = 8192;

   wire      wb_clk;
   wire      wb_rst;
   
   assign wb_clk = i_clk;
   assign wb_rst = !i_rst_n;
    
   servant
     #(.memfile (memfile),
       .memsize (memsize))
   servant
     (.wb_clk (wb_clk),
      .wb_rst (wb_rst),
      .q      (q));

endmodule
