module servant
(
 input  wire wb_clk,
 input  wire wb_rstn,
 // GPIO
 output wire q,
 // JTAG
 input  wire i_jtag_trst,
 input  wire i_jtag_tck,
 input  wire i_jtag_tdi,
 output wire o_jtag_tdo,
 input  wire i_jtag_tms,
 // Flash control
 output wire o_flash_SCK,
 output wire o_flash_CSn,
 output wire o_flash_MOSI,
 input  wire i_flash_MISO
);

   parameter memfile = "blinky.hex";
   parameter memsize = 8192;
   parameter reset_strategy = "MINI";
   parameter with_csr = 1;
   parameter [0:0] compress = 1;
   parameter [0:0] align = compress;

   wire 	timer_irq;

   wire [31:0] 	wb_ibus_adr;
   wire 	    wb_ibus_cyc;
   wire [31:0] 	wb_ibus_rdt;
   wire 	    wb_ibus_ack;

   wire [31:0] 	wb_dbus_adr;
   wire [31:0] 	wb_dbus_dat;
   wire [3:0] 	wb_dbus_sel;
   wire 	    wb_dbus_we;
   wire 	    wb_dbus_cyc;
   wire [31:0] 	wb_dbus_rdt;
   wire 	    wb_dbus_ack;

   wire [31:0] 	wb_dmem_adr;
   wire [31:0] 	wb_dmem_dat;
   wire [3:0] 	wb_dmem_sel;
   wire 	    wb_dmem_we;
   wire 	    wb_dmem_cyc;
   wire [31:0] 	wb_dmem_rdt;
   wire 	    wb_dmem_ack;

   wire [31:0] 	wb_flash_adr;
   wire [31:0] 	wb_flash_dat;
   wire [3:0] 	wb_flash_sel;
   wire 	    wb_flash_we;
   wire 	    wb_flash_cyc;
   wire [31:0] 	wb_flash_rdt;
   wire 	    wb_flash_ack;
   
   wire [31:0] 	wb_mem_adr;
   wire [31:0] 	wb_mem_dat;
   wire [3:0] 	wb_mem_sel;
   wire 	    wb_mem_we;
   wire 	    wb_mem_cyc;
   wire [31:0] 	wb_mem_rdt;
   wire 	    wb_mem_ack;
   
   // Debug Module Interface (DMI) -- Request
   wire        dmi_req_valid;
   wire        dmi_req_ready;
   wire [5:0]  dmi_req_address;
   wire [31:0] dmi_req_data;
   wire [1:0]  dmi_req_op;
   
   // Debug Module Interface (DMI) -- Response
   wire        dmi_rsp_valid;
   wire        dmi_rsp_ready;
   wire [31:0] dmi_rsp_data;
   wire [1:0]  dmi_rsp_op;
   
   // Debug module wishbone interface
   wire [31:0] 	wb_dm_adr;
   wire [31:0] 	wb_dm_dat;
   wire [3:0] 	wb_dm_sel;
   wire 	    wb_dm_we;
   wire 	    wb_dm_cyc;
   wire [31:0] 	wb_dm_rdt;
   wire 	    wb_dm_ack;
   
   wire 	wb_gpio_dat;
   wire 	wb_gpio_we;
   wire 	wb_gpio_cyc;
   wire 	wb_gpio_rdt;

   wire [31:0] 	wb_timer_dat;
   wire 	    wb_timer_we;
   wire 	    wb_timer_cyc;
   wire [31:0] 	wb_timer_rdt;

   wire w_dbg_halt;
   wire w_dbg_reset;
   wire w_dbg_process;
   
   wire wb_rst = !wb_rstn;
   
   wire [1:0]   o_dbg_csr_addr;
   wire         o_dbg_csr_out;
   wire         o_dbg_csr_dcsr_en;
   wire         o_dbg_csr_cnt8;
       
   wire dbg_execute_ack;
   wire dbg_halt_ack;
   
   wire mo_debug_step;
   
   wire [31:0] dm_databuf;
   wire o_dbg_csr_misa_en;
   
   wire         o_dbg_step;
   
   wire [6:0]   o_dbg_rf_waddr;
   wire         o_dbg_rf_we;
   wire [7:0]   o_dbg_rf_wdata;
   wire [6:0]   o_dbg_rf_raddr;
   wire [7:0]   o_dbg_rf_rdata;
   wire         o_dbg_rf_re;
   
   wire [5:0]   o_dbg_rf_w1addr;
   wire         o_dbg_rf_w1wren;
   wire [5:0]   o_dbg_rf_r1addr;
   wire [5:0]   o_dbg_rf_w0addr;
   wire         o_dbg_rf_w0wren; 
   wire [5:0]   o_dbg_rf_r0addr;
    
   servant_arbiter arbiter
   (
       // from CPU
      .i_wb_cpu_dbus_adr (wb_dmem_adr),
      .i_wb_cpu_dbus_dat (wb_dmem_dat),
      .i_wb_cpu_dbus_sel (wb_dmem_sel),
      .i_wb_cpu_dbus_we  (wb_dmem_we ),
      .i_wb_cpu_dbus_cyc (wb_dmem_cyc),
      .o_wb_cpu_dbus_rdt (wb_dmem_rdt),
      .o_wb_cpu_dbus_ack (wb_dmem_ack),
      // from CPU
      .i_wb_cpu_ibus_adr (wb_ibus_adr),
      .i_wb_cpu_ibus_cyc (wb_ibus_cyc),
      .o_wb_cpu_ibus_rdt (wb_ibus_rdt),
      .o_wb_cpu_ibus_ack (wb_ibus_ack),
      // to DM
      .o_wb_dm_adr       (wb_dm_adr ),
      .o_wb_dm_dat       (wb_dm_dat ),
      .o_wb_dm_sel       (wb_dm_sel ),
      .o_wb_dm_we        (wb_dm_we  ),
      .o_wb_dm_cyc       (wb_dm_cyc ),
      .i_wb_dm_rdt       (wb_dm_rdt ),
      .i_wb_dm_ack       (wb_dm_ack ),
      // to RAM
      .o_wb_cpu_adr      (wb_mem_adr ),
      .o_wb_cpu_dat      (wb_mem_dat ),
      .o_wb_cpu_sel      (wb_mem_sel ),
      .o_wb_cpu_we       (wb_mem_we  ),
      .o_wb_cpu_cyc      (wb_mem_cyc ),
      .i_wb_cpu_rdt      (wb_mem_rdt ),
      .i_wb_cpu_ack      (wb_mem_ack )
   );

   servant_mux servant_mux (
      .i_clk        (wb_clk         ),
      .i_rst        (wb_rst         ),
       // From CPU
      .i_wb_cpu_adr (wb_dbus_adr    ),
      .i_wb_cpu_dat (wb_dbus_dat    ),
      .i_wb_cpu_sel (wb_dbus_sel    ),
      .i_wb_cpu_we  (wb_dbus_we     ),
      .i_wb_cpu_cyc (wb_dbus_cyc    ),
      .o_wb_cpu_rdt (wb_dbus_rdt    ),
      .o_wb_cpu_ack (wb_dbus_ack    ),
      // To RAM
      .o_wb_mem_adr (wb_dmem_adr    ),
      .o_wb_mem_dat (wb_dmem_dat    ),
      .o_wb_mem_sel (wb_dmem_sel    ),
      .o_wb_mem_we  (wb_dmem_we     ),
      .o_wb_mem_cyc (wb_dmem_cyc    ),
      .i_wb_mem_rdt (wb_dmem_rdt    ),
      // To GPIO
      .o_wb_gpio_dat (wb_gpio_dat   ),
      .o_wb_gpio_we  (wb_gpio_we    ),
      .o_wb_gpio_cyc (wb_gpio_cyc   ),
      .i_wb_gpio_rdt (wb_gpio_rdt   ),
      // To timer
      .o_wb_timer_dat (wb_timer_dat ),
      .o_wb_timer_we  (wb_timer_we  ),
      .o_wb_timer_cyc (wb_timer_cyc ),
      .i_wb_timer_rdt (wb_timer_rdt ),
      // To SPI Programmer
      .o_wb_flash_adr (wb_flash_adr ),
      .o_wb_flash_dat (wb_flash_dat ),
      .o_wb_flash_sel (wb_flash_sel ),
      .o_wb_flash_we  (wb_flash_we  ),
      .o_wb_flash_cyc (wb_flash_cyc ),
      .i_wb_flash_rdt (wb_flash_rdt )      
   );

   servant_ram #(
       .memfile (memfile),
       .depth (memsize)
   ) ram (
      // Wishbone interface
      .i_wb_clk (wb_clk             ),
      .i_wb_rst (wb_rst             ),
//      .i_wb_adr (wb_mem_adr[$clog2(memsize)-1:2]),
      .i_wb_adr (wb_mem_adr[31:2]   ),
      .i_wb_cyc (wb_mem_cyc         ),
      .i_wb_we  (wb_mem_we          ),
      .i_wb_sel (wb_mem_sel         ),
      .i_wb_dat (wb_mem_dat         ),
      .o_wb_rdt (wb_mem_rdt         ),
      .o_wb_ack (wb_mem_ack         )
    );

    servant_timer #(
	    .RESET_STRATEGY (reset_strategy),
	    .WIDTH (32)
    ) timer (
	    .i_clk    (wb_clk      ),
	    .i_rst    (wb_rst      ),
	    .o_irq    (timer_irq   ),
	    .i_wb_cyc (wb_timer_cyc),
	    .i_wb_we  (wb_timer_we ),
	    .i_wb_dat (wb_timer_dat),
	    .o_wb_dat (wb_timer_rdt)
    );


    
   servant_gpio gpio (
      .i_wb_clk (wb_clk     ),
      .i_wb_dat (wb_gpio_dat),
      .i_wb_we  (wb_gpio_we ),
      .i_wb_cyc (wb_gpio_cyc),
      .o_wb_rdt (wb_gpio_rdt),
      .o_gpio   (q          )
   );

   serv_rf_top
     #(.RESET_PC (32'h0000_0000))
   cpu
     (
      .clk          (wb_clk         ),
      .i_rst        (wb_rst         ),
      // Interrupts
      .i_timer_irq  (1'b0),
      // Instruction bus
      .o_ibus_adr   (wb_ibus_adr    ),
      .o_ibus_cyc   (wb_ibus_cyc    ),
      .i_ibus_rdt   (wb_ibus_rdt    ),
      .i_ibus_ack   (wb_ibus_ack    ),
      // Data bus
      .o_dbus_adr   (wb_dbus_adr    ),
      .o_dbus_dat   (wb_dbus_dat    ),
      .o_dbus_sel   (wb_dbus_sel    ),
      .o_dbus_we    (wb_dbus_we     ),
      .o_dbus_cyc   (wb_dbus_cyc    ),
      .i_dbus_rdt   (wb_dbus_rdt    ),
      .i_dbus_ack   (wb_dbus_ack    ),
      // Debug interface
      .i_dbg_halt   (w_dbg_halt     ),
      .i_dbg_reset  (w_dbg_reset    ),
      .o_dbg_process(w_dbg_process  ),
      .o_dbg_step       (o_dbg_step     ),
      
      .o_dbg_rf_waddr   (o_dbg_rf_waddr ),
      .o_dbg_rf_we      (o_dbg_rf_we    ),
      .o_dbg_rf_wdata   (o_dbg_rf_wdata ),
      .o_dbg_rf_raddr   (o_dbg_rf_raddr ),
      .o_dbg_rf_rdata   (o_dbg_rf_rdata ),
      .o_dbg_rf_re      (o_dbg_rf_re ),
      .o_dbg_rf_w0addr  (o_dbg_rf_w0addr ),
      .o_dbg_rf_w0wren  (o_dbg_rf_w0wren ),
      .o_dbg_rf_r0addr  (o_dbg_rf_r0addr ),
      .o_dbg_rf_w1addr  (o_dbg_rf_w1addr),
      .o_dbg_rf_w1wren  (o_dbg_rf_w1wren),
      .o_dbg_rf_r1addr  (o_dbg_rf_r1addr ),
      .o_dbg_csr_addr   (o_dbg_csr_addr),
      .o_dbg_csr_out    (o_dbg_csr_out),
      .o_dbg_csr_dcsr_en(o_dbg_csr_dcsr_en),
      .o_dbg_csr_cnt8   (o_dbg_csr_cnt8),
      .o_dbg_csr_misa_en(o_dbg_csr_misa_en),
      .mo_dbg_step      (mo_debug_step)     
     );
        
    // SPI Programmer
    flash_controller serv_flash(
        // Wishbone slave
        .i_wb_clk   (wb_clk       ),
        .i_wb_rst   (wb_rst       ),
        .i_wb_adr   (wb_flash_adr ),
        .i_wb_dat   (wb_flash_dat ),
        .i_wb_sel   (wb_flash_sel ),
        .i_wb_we    (wb_flash_we  ),
        .i_wb_cyc   (wb_flash_cyc ),
        .o_wb_rdt   (wb_flash_rdt ),
        .o_wb_ack   (             ),
        // SPI
        .SCK        (o_flash_SCK  ),
        .CS_n       (o_flash_CSn  ),
        .MOSI       (o_flash_MOSI ),
        .MISO       (i_flash_MISO )
    );
    
    wire [31:0] debug0;
    wire [2:0] dm_ctrl_state;
    
    wire [31:0] dbg_probuf0;
    wire [31:0] dbg_probuf1;
    wire [31:0] dbg_probuf2;
    wire [31:0] dbg_probuf3;
    wire        dbg_rden;
    wire        dbg_wren;
    wire [1:0]  dbg_maddr;
    wire        dbg_resume_req;
    wire        dbg_execute_req;
    
    wire        dbg_dm_ctrl_busy;
    wire [2:0]  dbg_dm_ctrl_cmderr; 
    wire        dbg_resume_ack;
    
    // Debug Transport Module (DTM)
    debug_dtm serv_dtm(
        // global control
        .i_clk              (wb_clk         ),
        .i_rst              (wb_rst         ),
        // jtag connection
        .i_trst             (i_jtag_trst    ),
        .i_tck              (i_jtag_tck     ), 
        .i_tdi              (i_jtag_tdi     ),
        .o_tdo              (o_jtag_tdo     ),
        .i_tms              (i_jtag_tms     ),
        // Debug Module Interface (DMI) -- Request
        .o_dmi_req_valid    (dmi_req_valid  ),
        .i_dmi_req_ready    (dmi_req_ready  ),
        .o_dmi_req_address  (dmi_req_address),
        .o_dmi_req_data     (dmi_req_data   ),
        .o_dmi_req_op       (dmi_req_op     ),
        // Debug Module Interface (DMI) -- Response
        .i_dmi_rsp_valid    (dmi_rsp_valid  ),
        .o_dmi_rsp_ready    (dmi_rsp_ready  ),
        .i_dmi_rsp_data     (dmi_rsp_data   ),
        .i_dmi_rsp_op       (dmi_rsp_op     )
    );
    
    // Debug Module (DM)
    debug_dm serv_dm(
        // Global control
        .i_clk              (wb_clk         ),
        .i_rst              (wb_rst         ),
        .i_cpu_debug        (w_dbg_process  ), // cpu in debug mode
        // Debug Module Interface (DMI) - Request
        .i_dmi_req_valid    (dmi_req_valid  ),
        .o_dmi_req_ready    (dmi_req_ready  ),
        .i_dmi_req_address  (dmi_req_address),
        .i_dmi_req_op       (dmi_req_op     ),
        .i_dmi_req_data     (dmi_req_data   ),
        // Debug Module Interface (DMI) - Response
        .o_dmi_rsp_valid    (dmi_rsp_valid  ),
        .i_dmi_rsp_ready    (dmi_rsp_ready  ),
        .o_dmi_rsp_data     (dmi_rsp_data   ),
        .o_dmi_rsp_op       (dmi_rsp_op     ),
        // Wishbone bus slave interface
        .i_sbus_adr         (wb_dm_adr      ),
        .i_sbus_dat         (wb_dm_dat      ),
        .i_sbus_sel         (wb_dm_sel      ),
        .i_sbus_we          (wb_dm_we       ),
        .i_sbus_cyc         (wb_dm_cyc      ),
        .o_sbus_rdt         (wb_dm_rdt      ),
        .o_sbus_ack         (wb_dm_ack      ),
        // CPU control
        .o_cpu_ndmrst       (w_dbg_reset    ),
        .o_cpu_req_halt     (w_dbg_halt     ),
        // Debug
        .dbg_0              (debug0         ),
        .dbg_1              (dm_ctrl_state  ),
        .dbg_probuf0        (dbg_probuf0    ),
        .dbg_probuf1        (dbg_probuf1    ),
        .dbg_probuf2        (dbg_probuf2    ),
        .dbg_probuf3        (dbg_probuf3    ),
        .dbg_dm_databuf     (dm_databuf     ),
        .dbg_rden           (dbg_rden       ),
        .dbg_wren           (dbg_wren       ),
        .dbg_maddr          (dbg_maddr      ),
        .dbg_resume_req     (dbg_resume_req ),
        .dbg_resume_ack     (dbg_resume_ack ), 
        .dbg_execute_req    (dbg_execute_req), 
        .dbg_execute_ack    (dbg_execute_ack ),
        .dbg_halt_ack       (dbg_halt_ack ),   
        .dbg_dm_ctrl_busy   (dbg_dm_ctrl_busy ),
        .dbg_dm_ctrl_cmderr (dbg_dm_ctrl_cmderr),
        .dbg_autoexec_rd    (dbg_autoexec_rd),
        .dbg_autoexec_wr    (dbg_autoexec_wr)
          
    );

    debugger my_debugger (
        .i_clk              (wb_clk ),
        // JTAG
        .jtag_trst          (i_jtag_trst ),        /* probe 0 */ 
        .jtag_tck           (i_jtag_tck  ),         /* probe 1 */
        .jtag_tdi           (i_jtag_tdi  ),         /* probe 2 */
        .jtag_tdo           (o_jtag_tdo  ),         /* probe 3 */
        .jtag_tms           (i_jtag_tms  ),         /* probe 4 */
        // DMI request
        .dmi_req_valid      (dmi_req_valid  ),    /* probe 5 */
        .dmi_req_ready      (dmi_req_ready  ),    /* probe 6 */
        .dmi_req_address    (dmi_req_address),    /* probe 7 */
        .dmi_req_data       (dmi_req_data   ),    /* probe 8 */
        .dmi_req_op         (dmi_req_op     ),    /* probe 9 */
        .dmi_rsp_valid      (dmi_rsp_valid  ),    /* probe 31 */
        .dmi_rsp_ready      (dmi_rsp_ready  ),    /* probe 32 */
        .dmi_rsp_data       (dmi_rsp_data   ),    /* probe 33 */
        .dmi_rsp_op         (dmi_rsp_op     ),    /* probe 34 */
        // DM
        .dm_maddr           (dbg_maddr ),         /* probe 10 */
        .dm_rden            (dbg_rden  ),         /* probe 11 */
        .dm_wren            (dbg_wren  ),         /* probe 12 */
        .dm_probuf0         (dbg_probuf0 ),       /* probe 27 */
        .dm_probuf1         (dbg_probuf1 ),       /* probe 28 */
        .dm_probuf2         (dbg_probuf2 ),       /* probe 29 */
        .dm_probuf3         (dbg_probuf3 ),       /* probe 30 */
        .dm_databuf         (dm_databuf ),        /* probe 36 */
        .dm_ctrl_state      (dm_ctrl_state),
        .dm_ctrl_busy       (dbg_dm_ctrl_busy ),
        .dm_ctrl_err        (dbg_dm_ctrl_cmderr ),
        // Instruction fetch
        .ibus_adr           (wb_ibus_adr ),         /* probe 13 */
        .ibus_cyc           (wb_ibus_cyc ),         /* probe 14 */
        .ibus_rdt           (wb_ibus_rdt ),         /* probe 15 */
        .ibus_ack           (wb_ibus_ack ),         /* probe 16 */
        // Debug signal 
        .dbg_dcsr_step      (o_dbg_step         ),    /* probe 17 */
        .dbg_dcsr_en        (o_dbg_csr_dcsr_en  ),      /* probe 18 */
        .dbg_misa_en        (o_dbg_csr_misa_en ),
        .dbg_cpu_process    (w_dbg_process      ),  /* probe 19 */
        .dbg_cpu_reset      (w_dbg_reset        ),    /* probe 20 */
        .dbg_cpu_halt_req   (w_dbg_halt         ), /* probe 21 */
        .dbg_cpu_halt_ack   (dbg_halt_ack       ), /* probe 22 */
        .dbg_cpu_resume_req (dbg_resume_req     ),   /* probe 23 */
        .dbg_cpu_resume_ack (dbg_resume_ack     ),   /* probe 24 */
        .dbg_cpu_execute_req(dbg_execute_req    ),  /* probe 25 */
        .dbg_cpu_execute_ack(dbg_execute_ack    ),  /* probe 26 */
        .dbg_autoexec_rd    (dbg_autoexec_rd),
        .dbg_autoexec_wr    (dbg_autoexec_wr),
        // Sbus
        .sbus_adr           (wb_dm_adr  ),
        .sbus_dat           (wb_dm_dat  ),
        .sbus_sel           (wb_dm_sel  ),
        .sbus_we            (wb_dm_we   ),
        .sbus_cyc           (wb_dm_cyc  ),
        .sbus_rdt           (wb_dm_rdt  ),
        .sbus_ack           (wb_dm_ack  ),
        // RF interface
        .rf_waddr           (o_dbg_rf_waddr ),
        .rf_we              (o_dbg_rf_we    ),
        .rf_wdata           (o_dbg_rf_wdata ),
        .rf_raddr           (o_dbg_rf_raddr ),
        .rf_rdata           (o_dbg_rf_rdata ),
        .rf_re              (o_dbg_rf_re    ),
        .rf_w0addr          (o_dbg_rf_w0addr),
        .rf_w0wren          (o_dbg_rf_w0wren),
        .rf_r0addr          (o_dbg_rf_r0addr),
        .rf_w1addr          (o_dbg_rf_w1addr),
        .rf_w1wren          (o_dbg_rf_w1wren),
        .rf_r1addr          (o_dbg_rf_r1addr),
        // Debug memory
        .mem_adr            (wb_mem_adr ),
        .mem_dat            (wb_mem_dat ),
        .mem_cyc            (wb_mem_cyc ),
        .mem_we             (wb_mem_we  ),
        // Outputs
        .o_dbg_step         (mo_debug_step      )
    );
       
endmodule
