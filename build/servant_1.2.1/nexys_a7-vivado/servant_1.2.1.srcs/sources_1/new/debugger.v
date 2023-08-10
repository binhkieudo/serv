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
        // Instruction fetch
        input wire [31:0] ibus_adr,         /* probe 13 */
        input wire        ibus_cyc,         /* probe 14 */
        input wire 	      ibus_rdt,         /* probe 15 */
        input wire 	      ibus_ack,         /* probe 16 */
        // Debug signal 
        input wire        dbg_dcsr_step,    /* probe 17 */
        input wire        dbg_dcsr_en,      /* probe 18 */
        input wire        dbg_cpu_process,  /* probe 19 */
        input wire        dbg_cpu_reset,    /* probe 20 */
        input wire        dbg_cpu_halt_req, /* probe 21 */
        input wire        dbg_cpu_halt_ack, /* probe 22 */
        input wire        dbg_cpu_resume_req,   /* probe 23 */
        input wire        dbg_cpu_resume_ack,   /* probe 24 */
        input wire        dbg_cpu_execute_req,  /* probe 25 */
        input wire        dbg_cpu_execute_ack,  /* probe 26 */
        // Outputs
        output wire       o_dbg_step
    );
    
    vio_0 vpins(
        .clk            (i_clk      ),
        .probe_out0     (o_dbg_step )
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
        .probe34    (dmi_rsp_op         )
   );
   
endmodule
