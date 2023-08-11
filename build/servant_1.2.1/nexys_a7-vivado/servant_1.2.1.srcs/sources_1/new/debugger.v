`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 12:52:32 AM
// Design Name: 
// Module Name: debugger
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


module debugger(
        input wire        i_clk,
        // JTAG
        input wire        jtag_trst,        /* probe 0 */ 
        input wire        jtag_tck,         /* probe 1 */
        input wire        jtag_tdi,         /* probe 2 */
        input wire        jtag_tdo,         /* probe 3 */
        input wire        jtag_tms,         /* probe 4 */
        // DMI request
        input wire        dmi_req_valid,    /* probe 5 */
        input wire        dmi_req_ready,    /* probe 6 */
        input wire [5:0]  dmi_req_address,  /* probe 7 */
        input wire [31:0] dmi_req_data,     /* probe 8 */
        input wire [1:0]  dmi_req_op,       /* probe 9 */
        input wire        dmi_rsp_valid,    /* probe 31 */
        input wire        dmi_rsp_ready,    /* probe 32 */
        input wire [31:0] dmi_rsp_data,     /* probe 33 */
        input wire [1:0]  dmi_rsp_op,       /* probe 34 */
        // DM
        input wire [1:0]  dm_maddr,         /* probe 10 */
        input wire        dm_rden,          /* probe 11 */
        input wire        dm_wren,          /* probe 12 */
        input wire [31:0] dm_probuf0,       /* probe 27 */
        input wire [31:0] dm_probuf1,       /* probe 28 */
        input wire [31:0] dm_probuf2,       /* probe 29 */
        input wire [31:0] dm_probuf3,       /* probe 30 */
        input wire [31:0] dm_databuf,       /* probe 36 */
        // Instruction fetch
        input wire [31:0] ibus_adr,         /* probe 13 */
        input wire        ibus_cyc,         /* probe 14 */
        input wire [31:0] ibus_rdt,         /* probe 15 */
        input wire 	      ibus_ack,         /* probe 16 */
        // Debug signal 
        input wire        dbg_dcsr_step,    /* probe 17 */
        input wire        dbg_dcsr_en,      /* probe 18 */
        input wire        dbg_misa_en,      
        input wire        dbg_cpu_process,  /* probe 19 */
        input wire        dbg_cpu_reset,    /* probe 20 */
        input wire        dbg_cpu_halt_req, /* probe 21 */
        input wire        dbg_cpu_halt_ack, /* probe 22 */
        input wire        dbg_cpu_resume_req,   /* probe 23 */
        input wire        dbg_cpu_resume_ack,   /* probe 24 */
        input wire        dbg_cpu_execute_req,  /* probe 25 */
        input wire        dbg_cpu_execute_ack,  /* probe 26 */
        // Sbus
        input wire [31:0] sbus_adr, /* probe 37 */
        input wire [31:0] sbus_dat, /* probe 38 */
        input wire [3:0]  sbus_sel, /* probe 39 */
        input wire        sbus_we,  /* probe 40 */
        input wire        sbus_cyc, /* probe 41 */
        input wire [31:0] sbus_rdt, /* probe 42 */
        input wire        sbus_ack, /* probe 43 */   
        // RF interface
        input wire [5:0]  rf_addr,  /* probe 45 */ 
        input wire        rf_we,    /* probe 46 */ 
        input wire        rf_we1,   /* probe 48 */
        input wire [7:0]  rf_data,  /* probe 47 */   
        // Outputs
        output wire       o_dbg_step
    );
    
    reg [31:0] execute_req_cnt;
    wire execute_req_cnt_rst;
    wire execute_req_cnt_en;
    
    reg [31:0] ram_trace_0 [0:1024];
    reg [31:0] ram_trace_1 [0:1024];
    reg [31:0] ram_trace_2 [0:1024];
    reg [31:0] ram_trace_3 [0:1024];
    
    reg [31:0] trace_0;
    reg [31:0] trace_1;
    reg [31:0] trace_2;
    reg [31:0] trace_3;
    
    reg [31:0] trace_0_buf;
    reg [31:0] trace_1_buf;
    reg [31:0] trace_2_buf;
    reg [31:0] trace_3_buf;
    
    reg [1:0] resume_bit;
    reg [1:0] execute_bit;
    reg [1:0] halt_bit;
    reg [255:0] trace_chain;
    
    wire [9:0] trace_addr;
    
    reg capture;
    
    always @(posedge i_clk)
        if (execute_req_cnt_rst) begin
            resume_bit = 2'b00;
            execute_bit = 2'b00;
            halt_bit = 2'b00;
            trace_chain <= 256'd0;
            capture <= 1'b1;
        end
        else if (execute_req_cnt_en) begin
            resume_bit <= {resume_bit[0], dbg_cpu_resume_req};
            execute_bit <= {execute_bit[0], dbg_cpu_execute_req};
            halt_bit <= {halt_bit[0], dbg_cpu_halt_req};
            
            if (capture && (resume_bit == 2'b01)) capture <= 1'b0;
            
            if (resume_bit == 2'b01)        trace_chain <= {trace_chain[253:0], 2'b01}; // RESUME RISE
//            else if (resume_bit == 2'b10)   trace_chain <= {trace_chain[251:0], 4'b0010}; // RESUME FALL
            else if (execute_bit == 2'b01)  trace_chain <= {trace_chain[253:0], 2'b10}; // EXECUTE RISE
//            else if (execute_bit == 2'b10)  trace_chain <= {trace_chain[251:0], 4'b0100}; // EXECUTE FALL
            else if (halt_bit == 2'b01)     trace_chain <= {trace_chain[253:0], 2'b11}; // HALT RISE
//            else if (halt_bit == 2'b10)     trace_chain <= {trace_chain[251:0], 4'b0110}; // HALT FALL
         
        end
    
    always @(posedge dbg_cpu_execute_req or posedge execute_req_cnt_rst) begin
        if (execute_req_cnt_rst) execute_req_cnt <= 32'd0;
        else if (execute_req_cnt_en && capture) execute_req_cnt <= execute_req_cnt + 1'b1;
    end
    
    always @(posedge i_clk) begin
        trace_0_buf <= 32'd0;
        trace_1_buf <= 32'd0;
        trace_2_buf <= 32'd0;
        trace_3_buf <= 32'd0;
    
        if (execute_req_cnt_en && dbg_cpu_execute_req && capture) begin
            ram_trace_0[execute_req_cnt[9:0]] <= trace_0_buf;
            ram_trace_1[execute_req_cnt[9:0]] <= trace_1_buf;
            ram_trace_2[execute_req_cnt[9:0]] <= trace_2_buf;
            ram_trace_3[execute_req_cnt[9:0]] <= trace_3_buf;
        end
        
        trace_0 <= ram_trace_0[trace_addr];
        trace_1 <= ram_trace_1[trace_addr];
        trace_2 <= ram_trace_2[trace_addr];
        trace_3 <= ram_trace_3[trace_addr];
        
    end
    
    vio_0 vpins(
        .clk            (i_clk      ),
        .probe_in0      (trace_0    ),
        .probe_in1      (trace_1    ),
        .probe_in2      (trace_2    ),
        .probe_in3      (trace_3    ),
        .probe_in4      (trace_chain),
        .probe_out0     (o_dbg_step ),
        .probe_out1     ({execute_req_cnt_rst, execute_req_cnt_en}),
        .probe_out2     (trace_addr )
    );
        
    ila_0 analyzer (
        .clk        (i_clk              ),
        .probe0     (jtag_trst          ),
        .probe1     (jtag_tck           ),
        .probe2     (jtag_tdi           ),
        .probe3     (jtag_tdo           ),
        .probe4     (jtag_tms           ),
        .probe5     (dmi_req_valid      ),
        .probe6     (dmi_req_ready      ),
        .probe7     (dmi_req_address    ),
        .probe8     (dmi_req_data       ),
        .probe9     (dmi_req_op         ),
        .probe10    (dm_maddr           ),
        .probe11    (dm_rden            ),
        .probe12    (dm_wren            ),
        .probe13    (ibus_adr           ),
        .probe14    (ibus_cyc           ),
        .probe15    (ibus_rdt           ),
        .probe16    (ibus_ack           ),
        .probe17    (dbg_dcsr_step      ),
        .probe18    (dbg_dcsr_en        ),
        .probe19    (dbg_cpu_process    ),
        .probe20    (dbg_cpu_reset      ),
        .probe21    (dbg_cpu_halt_req   ),
        .probe22    (dbg_cpu_halt_ack   ),
        .probe23    (dbg_cpu_resume_req ),
        .probe24    (dbg_cpu_resume_ack ),
        .probe25    (dbg_cpu_execute_req),
        .probe26    (dbg_cpu_execute_ack),
        .probe27    (dm_probuf0         ),
        .probe28    (dm_probuf1         ),
        .probe29    (dm_probuf2         ),
        .probe30    (dm_probuf3         ),
        .probe31    (dmi_rsp_valid      ),
        .probe32    (dmi_rsp_ready      ),
        .probe33    (dmi_rsp_data       ),
        .probe34    (dmi_rsp_op         ),
        .probe35    (execute_req_cnt    ),
        .probe36    (dm_databuf         ),
        .probe37    (sbus_adr           ),
        .probe38    (sbus_dat           ),
        .probe39    (sbus_sel           ),
        .probe40    (sbus_we            ),
        .probe41    (sbus_cyc           ),
        .probe42    (sbus_rdt           ),
        .probe43    (sbus_ack           ),
        .probe44    (dbg_misa_en        ),
        .probe45    (rf_addr            ),
        .probe46    (rf_we              ),
        .probe47    (rf_data            ),
        .probe48    (rf_we1             )
   );
   
endmodule
