//============== RISC-V DM =============
// DM configurations
localparam DM_BASE      = 32'h3ffff800;
localparam DM_SIZE      = 32'd256; // debug ROM address space size in bytes
localparam DM_CODE_BASE = 32'h3ffff800;
localparam DM_PBUF_BASE = 32'h3ffff840;
localparam DM_DATA_BASE = 32'h3ffff880;
localparam DM_SREG_BASE = 32'h3ffff8c0;
// park loop entry points - these need to be sync with the OCD firmware (sw/ocd-firmware/park_loop.S)
localparam DM_EXC_ENTRY  = DM_CODE_BASE + 0;
localparam DM_LOOP_ENTRY = DM_CODE_BASE + 8;
localparam DM_NSCRATCH   = 4'b0001; // number of dscratch registers in CPU
localparam DM_DATASIZE   = 4'b0001; // number of data registers in memory/CSR space
localparam DM_DATAADDR   = DM_DATA_BASE[11:0];
localparam DM_DATAACCESS = 1'b1;
    
// CPU Bus Interface
localparam HI_ABB = 31; // high address boundary bit
localparam LO_ABB = 8;
    
// Status and Control registers
localparam SREG_HALT_ACK      = 0;  // CPU is halted in debug mode and waits in loop
localparam SREG_RESUME_REQ    = 8;  // DM request CPU to resume
localparam SREG_RESUME_ACK    = 8;  // CPU starts resuming
localparam SREG_EXECUTE_REQ   = 16; // DM requests to execute program buffer
localparam SREG_EXECUTE_ACK   = 16; // CPU starts to execute program buffer
localparam SREG_EXCEPTION_ACK = 24; // CPU has detected an exception

// DMI operations
localparam DMI_OP_NOP     = 2'b00;
localparam DMI_OP_READ    = 2'b01;
localparam DMI_OP_WRITE   = 2'b10;
localparam DMI_OP_RESERVE = 2'B11;
               
// DMI registers
localparam DMI_ADDR_DATA0       = {2'b00, 4'b0100};
localparam DMI_ADDR_DMCONTROL   = {2'b01, 4'b0000};
localparam DMI_ADDR_DMSTATUS    = {2'b01, 4'b0001};
localparam DMI_ADDR_HARTINFO    = {2'b01, 4'b0010};
localparam DMI_ADDR_ABSTRACTS   = {2'b01, 4'b0110};
localparam DMI_ADDR_COMMAND     = {2'b01, 4'b0111};
localparam DMI_ADDR_ABSRACTAUTO = {2'b01, 4'b1000};
localparam DMI_ADDR_NEXTDM      = {2'b01, 4'b1101};
localparam DMI_ADDR_PROGBUF0    = {2'b10, 4'b0000};
localparam DMI_ADDR_PROGBUF1    = {2'b10, 4'b0001};
localparam DMI_ADDR_SBCS        = {2'b11, 4'b1000};
    
// RISC-V Instruction           
localparam INSTR_NOP    = 32'h00000013; // NOP
localparam INSTR_LW     = 32'h00002003; // lw zero, 0(zero)
localparam INSTR_SW     = 32'h00002023; // sw zero, 0(zero)
localparam INSTR_EBREAK = 32'h00100073; // ebreak