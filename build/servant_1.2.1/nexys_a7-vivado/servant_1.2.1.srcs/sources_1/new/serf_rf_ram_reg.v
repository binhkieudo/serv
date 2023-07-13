module serv_rf_ram_reg #(
    parameter width     = 8,
    parameter csr_regs  = 4,
    parameter depth     = 32*32/width
)
(
    input  wire                      i_clk,
    input  wire                      i_rst,
    input  wire [$clog2(depth):0]    i_waddr, // registers + csr
    input  wire [width-1:0] 	     i_wdata,
    input  wire 			         i_wen,
    input  wire [$clog2(depth):0]    i_raddr, // registers + csr
    input  wire			             i_ren,
    output wire [width-1:0] 	     o_rdata
);

   localparam ADDR_MSCRATCH = 2'b00,
              ADDR_MTVEC    = 2'b01,
              ADDR_MEPC     = 2'b10,
              ADDR_MTVAL    = 2'b11;
              
   reg [width-1:0] memory [0:depth-1];
   reg [width-1:0] rdata ;
   reg [width-1:0] csr_rdata;
   
   
   
   reg [31:0] csr_mscratch; // 00
   reg [31:0] csr_mtvec;    // 01
   reg [31:0] csr_mepc;     // 10
   reg [31:0] csr_mtval;    // 11
   
   
   integer i;
   initial begin
    for (i = 0; i < depth; i = i + 1)
        memory[i] = 0;
   end
   
   always @(posedge i_clk) begin
      if (i_wen) memory[i_waddr[$clog2(depth)-1:0]] <= i_wdata;
           
      rdata <= memory[i_raddr[$clog2(depth)-1:0]];
   end
   
   // Read and write CSR
   // Write side
   wire [1:0] csr_waddr = i_waddr[3:2];
   wire csr_wren      = i_wen && i_waddr[$clog2(depth)];
   wire [3:0]csr_wrbe = {i_waddr[1]  &&  i_waddr[0],  // 2'b11 
                         i_waddr[1]  && ~i_waddr[0],  // 2'b10
                         ~i_waddr[1] &&  i_waddr[0],  // 2'b01
                         ~i_waddr[1] && ~i_waddr[0]}; // 2'b00
  
   always @(posedge i_clk)
    if (i_rst) begin
        csr_mscratch <= 32'd0;
        csr_mtvec    <= 32'd0;
        csr_mepc     <= 32'd0;
        csr_mtval    <= 32'd0;
    end
    else begin
        // csr_mscratch
        if (csr_wren && csr_wrbe[0] && (i_waddr == ADDR_MSCRATCH)) csr_mscratch[7:0]   <= i_wdata;
        if (csr_wren && csr_wrbe[1] && (i_waddr == ADDR_MSCRATCH)) csr_mscratch[15:8]  <= i_wdata;
        if (csr_wren && csr_wrbe[2] && (i_waddr == ADDR_MSCRATCH)) csr_mscratch[23:16] <= i_wdata;
        if (csr_wren && csr_wrbe[3] && (i_waddr == ADDR_MSCRATCH)) csr_mscratch[31:24] <= i_wdata;
        
        // csr_mtvec
        if (csr_wren && csr_wrbe[0] && (i_waddr == ADDR_MTVEC)) csr_mtvec[7:0]   <= i_wdata;
        if (csr_wren && csr_wrbe[1] && (i_waddr == ADDR_MTVEC)) csr_mtvec[15:8]  <= i_wdata;
        if (csr_wren && csr_wrbe[2] && (i_waddr == ADDR_MTVEC)) csr_mtvec[23:16] <= i_wdata;
        if (csr_wren && csr_wrbe[3] && (i_waddr == ADDR_MTVEC)) csr_mtvec[31:24] <= i_wdata;
        
        // csr_mepc
        if (csr_wren && csr_wrbe[0] && (i_waddr == ADDR_MEPC)) csr_mepc[7:0]   <= i_wdata;
        if (csr_wren && csr_wrbe[1] && (i_waddr == ADDR_MEPC)) csr_mepc[15:8]  <= i_wdata;
        if (csr_wren && csr_wrbe[2] && (i_waddr == ADDR_MEPC)) csr_mepc[23:16] <= i_wdata;
        if (csr_wren && csr_wrbe[3] && (i_waddr == ADDR_MEPC)) csr_mepc[31:24] <= i_wdata; 
        
               
         // csr_mtval
        if (csr_wren && csr_wrbe[0] && (i_waddr == ADDR_MTVAL)) csr_mtval[7:0]   <= i_wdata;
        if (csr_wren && csr_wrbe[1] && (i_waddr == ADDR_MTVAL)) csr_mtval[15:8]  <= i_wdata;
        if (csr_wren && csr_wrbe[2] && (i_waddr == ADDR_MTVAL)) csr_mtval[23:16] <= i_wdata;
        if (csr_wren && csr_wrbe[3] && (i_waddr == ADDR_MTVAL)) csr_mtval[31:24] <= i_wdata;       
    end
    
    // Read side
    wire [1:0]csr_raddr = i_raddr[3:2];
    wire csr_rden = i_raddr[$clog2(depth)];
    wire [3:0]csr_rdbe = {i_raddr[1]  &&  i_raddr[0],  // 2'b11 
                         i_raddr[1]  && ~i_raddr[0],  // 2'b10
                         ~i_raddr[1] &&  i_raddr[0],  // 2'b01
                         ~i_raddr[1] && ~i_raddr[0]}; // 2'b00
   
    always @(posedge i_clk)
        if (i_rst)
            csr_rdata <= {width{1'b0}};
        else
            case (csr_raddr)
                ADDR_MSCRATCH : csr_rdata <= ({width{csr_rdbe[3]}} & csr_mscratch[31:24]) |
                                             ({width{csr_rdbe[2]}} & csr_mscratch[23:16]) |
                                             ({width{csr_rdbe[1]}} & csr_mscratch[15:8])  |
                                             ({width{csr_rdbe[0]}} & csr_mscratch[7:0]);
                ADDR_MTVEC    : csr_rdata <= ({width{csr_rdbe[3]}} & csr_mtvec[31:24]) |
                                             ({width{csr_rdbe[2]}} & csr_mtvec[23:16]) |
                                             ({width{csr_rdbe[1]}} & csr_mtvec[15:8])  |
                                             ({width{csr_rdbe[0]}} & csr_mtvec[7:0]);
                ADDR_MEPC     : csr_rdata <= ({width{csr_rdbe[3]}} & csr_mepc[31:24]) |
                                             ({width{csr_rdbe[2]}} & csr_mepc[23:16]) |
                                             ({width{csr_rdbe[1]}} & csr_mepc[15:8])  |
                                             ({width{csr_rdbe[0]}} & csr_mepc[7:0]);
                ADDR_MTVAL    : csr_rdata <= ({width{csr_rdbe[3]}} & csr_mtval[31:24]) |
                                             ({width{csr_rdbe[2]}} & csr_mtval[23:16]) |
                                             ({width{csr_rdbe[1]}} & csr_mtval[15:8])  |
                                             ({width{csr_rdbe[0]}} & csr_mtval[7:0]);
                default       : csr_rdata <= csr_rdata;
           endcase
   
   /* Reads from reg x0 needs to return 0
    Check that the part of the read address corresponding to the register
    is zero and gate the output
    width LSB of reg index $clog2(width)
    2     4                1
    4     3                2
    8     2                3
    16    1                4
    32    0                5
    */
   reg regzero;

   always @(posedge i_clk)
     regzero <= !(|i_raddr[$clog2(depth)-1:5-$clog2(width)]);

   assign o_rdata = csr_rden? csr_rdata: rdata & ~{width{regzero}};
   
endmodule
