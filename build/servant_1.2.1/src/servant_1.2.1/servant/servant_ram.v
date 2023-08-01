module servant_ram
  #(//Memory parameters
    parameter depth = 256,
    parameter aw    = $clog2(depth),
    parameter memfile = "")
   (input wire 		   i_wb_clk,
    input wire 		   i_wb_rst,
    input wire [31:2]  i_wb_adr,
    input wire [31:0]  i_wb_dat,
    input wire [3:0]   i_wb_sel,
    input wire 		   i_wb_we,
    input wire 		   i_wb_cyc,
    output reg [31:0]  o_wb_rdt,
    output reg 		   o_wb_ack
);

   wire [3:0] 		we = {4{i_wb_we & i_wb_cyc}} & i_wb_sel;

   reg [31:0] 		mem [0:depth/4-1] /* verilator public */;

   wire [aw-3:0] 	addr = i_wb_adr[aw-1:2];
   
   
   integer i;
   initial begin
    for (i = 0; i < depth/4; i = i + 1)
        mem[i] = 32'd0;

        //mem[0] = 32'h04000413; // addi x8, x0, 64 -- set step bit in dcsr
        //mem[1] = 32'h7b141073; // csrrw x0, dpc, x8
        //mem[2] = 32'h7b200073; // dret
//        mem[0] = 32'h00100413; // addi x8, x0, 1   // 00
//        mem[1] = 32'h00400413; // addi x8, x0, 4   // 04
//        mem[2] = 32'h00100073; // ebreak           // 08
//        mem[3] = 32'h00800413; // addi x8, x0, 8   // 0c
//        mem[4] = 32'h00c00413; // addi x8, x0, 12  // 10
//        mem[5] = 32'h00100073; // ebreak           // 14 
//        mem[6] = 32'h01000413; // addi x8, x0, 16  // 18
//        mem[7] = 32'h01400413; // addi x8, x0, 20  // 1c
//        mem[0] = 32'h00100073;
        // _start
        mem[0] = 32'h40000537; // [00] lui a0, %hi(GPIO_BASE)
        mem[1] = 32'h00050513; // [04] addi a0, a0, %lo(GPIO_BASE)
        mem[2] = 32'h00100337; // [08] li t1, DELAY
        mem[3] = 32'h00000293; // [1c] addi	t0, zero, 0
        // bl1
        mem[4] = 32'h00550023; // [20] sb t0, 0(a0)
        mem[5] = 32'h0012C293; // [24] xori t0, t0, 1
        mem[6] = 32'h000073B3; // [28] and t2, zero, zero
        // time1
        mem[7] = 32'h00138393; // [2c] addi t2, t2, 1
        mem[8] = 32'hFE731EE3; // [30] bne t1, t2, time1
        mem[9] = 32'hFEDFF06F; // [34] j bl1
        mem[10] = 32'h00000000; 
   end
   

   always @(posedge i_wb_clk)
     if (i_wb_rst)
       o_wb_ack <= 1'b0;
     else
       o_wb_ack <= i_wb_cyc & !o_wb_ack;

   always @(posedge i_wb_clk) begin
      if (we[0]) mem[addr][7:0]   <= i_wb_dat[7:0];
      if (we[1]) mem[addr][15:8]  <= i_wb_dat[15:8];
      if (we[2]) mem[addr][23:16] <= i_wb_dat[23:16];
      if (we[3]) mem[addr][31:24] <= i_wb_dat[31:24];
      
      o_wb_rdt <= mem[addr];
   end

endmodule
