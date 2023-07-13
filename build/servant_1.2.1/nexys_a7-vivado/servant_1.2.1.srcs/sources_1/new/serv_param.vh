//============== RISC-V opcodes ===================
localparam OPCODE_SYSTEM 7'b1110011; // system/csr access

//============== RISC-V funct3  ===================
// system/csr
localparam FUNCT3_ENV    = 3'b000; // ecall, ebreak, mret, wfi
localparam FUNCT3_CSRRW  = 3'b001; // csr r/w
localparam FUNCT3_CSRRS  = 3'b010; // csr read & set
localparam FUNCT3_CSRRC  = 3'b011; // csr read & clear
localparam FUNCT3_CSRIL  = 3'b100; // undefined/illegal
localparam FUNCT3_CSRRWI = 3'b101; // csr r/w immediate
localparam FUNCT3_CSRRSI = 3'b110; // csr read & set immediate
localparam FUNCT3_CSRRCI = 3'b111; // csr read & clear immediate

//============== RISC-V funct12 ===================
// system
localparam FUNCT12_ECALL  = 12'h000; // ecall
localparam FUNCT12_EBREAK = 12'h001; // ebreak
localparam FUNCT12_WFI    = 12'h105; // wfi
localparam FUNCT12_MRET   = 12'h302; // mret
localparam FUNCT12_DRET   = 12'h7b2; // dret

//============== RISC-V CSR Addresses =============
/*rw*/ localparam CSR_ZERO      = 12'h000;

// machine trap setup
/*rw*/ localparam CSR_MSTATUS   = 12'h300; 
/*rw*/    // mie  : global IRQ enable
/*rw*/    // mpie : previous global IRQ enable
/*rw*/    // mpp  : machine previous privilege mode
/*rw*/    // mprv : effective privilege level for machine-mode load/stores
/*rw*/    // tw   : do not allow user mode to execute WFI instruction when set
/*ro*/ localparam CSR_MISA      = 12'h301; // 
/*rw*/ localparam CSR_MIE       = 12'h304; 
/*rw*/    // msi : machine software interrupt enable
/*rw*/    // mei : machine external interrupt enable
/*rw*/    // mti : machine timer interrupt enable
/*rw*/    // firq[15:0] : fast interrupt enable
/*rw*/ localparam CSR_MTVEC     = 12'h305; // [XLEN-1:2] : machine trap-handler base address

// machine trap handling
/*rw*/ localparam CSR_MSCRATCH  = 12'h340; // [XLEN-1:0] : machine scratch register
/*wo*/ localparam CSR_MEPC      = 12'h341; // [XLEN-1:0] : machine exception PC
/*rw*/ localparam CSR_MCAUSE    = 12'h342; 
/*rw*/     // [5:0] : machine trap cause
/*rw*/ localparam CSR_MTVAL     = 12'h343; // [XLEN-1:0] : machine bad address or instruction
/*wo*/ localparam CSR_MIP       = 12'h344; 
/*wo*/     // firq_nclr[15:0]: clear pending FIRQ (active-low)

// trigger module registers
localparam CSR_TSELECT   = 12'h7a0; // not use
/*rw*/ localparam CSR_TDATA1    = 12'h7a1; 
    // exe    : enable (match) trigger
    // action : enter debug mode / ebreak exception when trigger fires
    // dmode  : set to ignore tdata* CSR access from machine-mode
    // rd     : trigger register read-back 
/*rw*/ localparam CSR_TDATA2    = 12'h7a2; // [XLEN-1:0] address-match register
localparam CSR_TDATA3    = 12'h7a3; // not use
localparam CSR_TINFO     = 12'h7a4; // not use
localparam CSR_TCONTROL  = 12'h7a5; // not use
localparam CSR_MCONTEXT  = 12'h7a8; // not use
localparam CSR_SCONTEX   = 12'h7aa; // not use

// debug module registers
/*rw*/ localparam CSR_DCSR      = 12'h7b0;
    // ebreakm      : behavior of ebreak instruction in m-mode
    // ebreaku      : behavior of ebreak instruction in u-mode (not impelemented)
    // step         : single-step mode
    // prv          : current privilege level when entering debug mode (not implemented
    // cause[2:0]   : why was debug mode entered
    // rd[XLEN-1:0] : debug mode control and status register
/*wo*/ localparam CSR_DPC       = 12'h7b1; // [XLEN-1:0] : mode program counter, 
                                    // store next pc before enter debug mode
/*rw*/ localparam CSR_DSCRATCH0 = 12'h7b2; // [XLEN-1:0] : debug mode scratch register 0

// machine information register
/*ro*/ localparam CSR_MHARTID   = 12'hf14; // [XLEN-1:0] : HART_ID
