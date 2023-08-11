# Compile
do {tb_compile.do}

# Elaborate
do {tb_elaborate.do}

# Simulate
vsim -lib xil_defaultlib tb_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

restart -force -nowave
vsim -t 1ns
config wave -signalnamewidth 2

#add wave -divider -height 30 "SYSTEM"
#add wave -group system -color white -divider -height 30 "INPUT"
#add wave -group system -color white -radix unsigned sim:/tb/
#add wave -group system -color white -radix hex      sim:/tb/
#add wave -group system -color white -radix bin      sim:/tb/

add wave -radix binary sim:/tb/wb_clk

#================================================================================================================== SERVANT
#add wave -divider -height 30 "SERVANT"
add wave -group SERVANT -radix binary sim:/tb/wb_clk
add wave -group SERVANT -radix binary sim:/tb/wb_rstn
add wave -group SERVANT -radix binary sim:/tb/q

#================================================================================================================== Arbiter
#add wave -divider -height 30 "Arbiter"
add wave -group Arbiter -group dbus_rq -radix unsigned 	sim:/tb/udt/arbiter/i_wb_cpu_dbus_adr
add wave -group Arbiter -group dbus_rq -radix hex 		sim:/tb/udt/arbiter/i_wb_cpu_dbus_dat
add wave -group Arbiter -group dbus_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_cpu_dbus_sel
add wave -group Arbiter -group dbus_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_cpu_dbus_we
add wave -group Arbiter -group dbus_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_cpu_dbus_cyc
add wave -group Arbiter -group dbus_rq -radix hex 		sim:/tb/udt/arbiter/o_wb_cpu_dbus_rdt
add wave -group Arbiter -group dbus_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_cpu_dbus_ack

add wave -group Arbiter -color yellow -group ibus_rq -radix unsigned sim:/tb/udt/arbiter/i_wb_cpu_ibus_adr
add wave -group Arbiter -color yellow -group ibus_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_cpu_ibus_cyc
add wave -group Arbiter -color yellow -group ibus_rq -radix hex 	sim:/tb/udt/arbiter/o_wb_cpu_ibus_rdt
add wave -group Arbiter -color yellow -group ibus_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_cpu_ibus_ack

add wave -group Arbiter -color white -group mem_rq -radix unsigned 	sim:/tb/udt/arbiter/o_wb_cpu_adr
add wave -group Arbiter -color white -group mem_rq -radix hex 	    sim:/tb/udt/arbiter/o_wb_cpu_dat
add wave -group Arbiter -color white -group mem_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_cpu_sel
add wave -group Arbiter -color white -group mem_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_cpu_we
add wave -group Arbiter -color white -group mem_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_cpu_cyc
add wave -group Arbiter -color white -group mem_rq -radix hex 	    sim:/tb/udt/arbiter/i_wb_cpu_rdt
add wave -group Arbiter -color white -group mem_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_cpu_ack

add wave -group Arbiter -color white -group dm_rq -radix unsigned 	sim:/tb/udt/arbiter/o_wb_dm_adr
add wave -group Arbiter -color white -group dm_rq -radix hex 	    sim:/tb/udt/arbiter/o_wb_dm_dat
add wave -group Arbiter -color white -group dm_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_dm_sel
add wave -group Arbiter -color white -group dm_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_dm_we
add wave -group Arbiter -color white -group dm_rq -radix binary 	sim:/tb/udt/arbiter/o_wb_dm_cyc
add wave -group Arbiter -color white -group dm_rq -radix hex 	    sim:/tb/udt/arbiter/i_wb_dm_rdt
add wave -group Arbiter -color white -group dm_rq -radix binary 	sim:/tb/udt/arbiter/i_wb_dm_ack


#================================================================================================================== Mux
add wave -group servant_mux -radix binary sim:/tb/udt/servant_mux/i_clk
add wave -group servant_mux -radix binary sim:/tb/udt/servant_mux/i_rst

add wave -group servant_mux -group cpu -color yellow -radix hex      sim:/tb/udt/servant_mux/i_wb_cpu_adr
add wave -group servant_mux -group cpu -color yellow -radix unsigned sim:/tb/udt/servant_mux/i_wb_cpu_dat
add wave -group servant_mux -group cpu -color yellow -radix binary   sim:/tb/udt/servant_mux/i_wb_cpu_sel
add wave -group servant_mux -group cpu -color yellow -radix binary   sim:/tb/udt/servant_mux/i_wb_cpu_we
add wave -group servant_mux -group cpu -color yellow -radix binary   sim:/tb/udt/servant_mux/i_wb_cpu_cyc
add wave -group servant_mux -group cpu -color yellow -radix unsigned sim:/tb/udt/servant_mux/o_wb_cpu_rdt
add wave -group servant_mux -group cpu -color yellow -radix binary   sim:/tb/udt/servant_mux/o_wb_cpu_ack

add wave -group servant_mux -group mem -color white -radix hex        sim:/tb/udt/servant_mux/o_wb_mem_adr
add wave -group servant_mux -group mem -color white -radix unsigned   sim:/tb/udt/servant_mux/o_wb_mem_dat
add wave -group servant_mux -group mem -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_mem_sel
add wave -group servant_mux -group mem -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_mem_we
add wave -group servant_mux -group mem -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_mem_cyc
add wave -group servant_mux -group mem -color white -radix unsigned   sim:/tb/udt/servant_mux/i_wb_mem_rdt

add wave -group servant_mux -group gpio -color cyan -radix hex        sim:/tb/udt/servant_mux/o_wb_gpio_dat
add wave -group servant_mux -group gpio -color cyan -radix hex        sim:/tb/udt/servant_mux/o_wb_gpio_we
add wave -group servant_mux -group gpio -color cyan -radix hex        sim:/tb/udt/servant_mux/o_wb_gpio_cyc
add wave -group servant_mux -group gpio -color cyan -radix hex        sim:/tb/udt/servant_mux/i_wb_gpio_rdt

add wave -group servant_mux -group timer -color pink -radix hex       sim:/tb/udt/servant_mux/o_wb_timer_dat
add wave -group servant_mux -group timer -color pink -radix hex       sim:/tb/udt/servant_mux/o_wb_timer_we
add wave -group servant_mux -group timer -color pink -radix hex       sim:/tb/udt/servant_mux/o_wb_timer_cyc
add wave -group servant_mux -group timer -color pink -radix hex       sim:/tb/udt/servant_mux/i_wb_timer_rdt

add wave -group servant_mux -group flash -color white -radix hex        sim:/tb/udt/servant_mux/o_wb_flash_adr
add wave -group servant_mux -group flash -color white -radix unsigned   sim:/tb/udt/servant_mux/o_wb_flash_dat
add wave -group servant_mux -group flash -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_flash_sel
add wave -group servant_mux -group flash -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_flash_we
add wave -group servant_mux -group flash -color white -radix binary     sim:/tb/udt/servant_mux/o_wb_flash_cyc
add wave -group servant_mux -group flash -color white -radix unsigned   sim:/tb/udt/servant_mux/i_wb_flash_rdt

#================================================================================================================== Ram
#add wave -divider -height 30 "Ram"
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/i_wb_clk
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/i_wb_rst
add wave -group servant_ram -color white -radix unsigned  sim:/tb/udt/ram/i_wb_adr
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/i_wb_cyc
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/i_wb_we
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/i_wb_sel
add wave -group servant_ram -color white -radix hex       sim:/tb/udt/ram/i_wb_dat
add wave -group servant_ram -color white -radix hex       sim:/tb/udt/ram/o_wb_rdt
add wave -group servant_ram -color white -radix binary    sim:/tb/udt/ram/o_wb_ack

#================================================================================================================== SERV
#add wave -divider -height 30 "SERV"
add wave -group serv -radix binary sim:/tb/udt/cpu/clk
add wave -group serv -radix binary sim:/tb/udt/cpu/i_rst

add wave -group serv -group ibus -radix hex  	    sim:/tb/udt/cpu/o_ibus_adr
add wave -group serv -group ibus -radix unsigned  	sim:/tb/ibus_address
add wave -group serv -group ibus -radix binary 	    sim:/tb/udt/cpu/o_ibus_cyc
add wave -group serv -group ibus -radix hex 		sim:/tb/udt/cpu/i_ibus_rdt
add wave -group serv -group ibus -radix binary 	    sim:/tb/udt/cpu/i_ibus_ack

add wave -group serv -group dbus -color yellow -radix unsigned  	sim:/tb/udt/cpu/o_dbus_adr
add wave -group serv -group dbus -color yellow -radix hex 		sim:/tb/udt/cpu/o_dbus_dat
add wave -group serv -group dbus -color yellow -radix binary 	sim:/tb/udt/cpu/o_dbus_sel
add wave -group serv -group dbus -color yellow -radix binary 	sim:/tb/udt/cpu/o_dbus_we
add wave -group serv -group dbus -color yellow -radix binary 	sim:/tb/udt/cpu/o_dbus_cyc
add wave -group serv -group dbus -color yellow -radix hex 		sim:/tb/udt/cpu/i_dbus_rdt
add wave -group serv -group dbus -color yellow -radix binary 	sim:/tb/udt/cpu/i_dbus_ack

add wave -group serv -group debug -color white -radix binary 	sim:/tb/udt/cpu/i_dbg_halt
add wave -group serv -group debug -color white -radix binary 	sim:/tb/udt/cpu/i_dbg_reset
add wave -group serv -group debug -color white -radix binary 	sim:/tb/udt/cpu/o_dbg_process

#================================================================================================================== SERV_CPU
#add wave -divider -height 30 "SERV_CPU"
add wave -group serv -group serv_cpu -radix binary sim:/tb/udt/cpu/cpu/clk
add wave -group serv -group serv_cpu -radix binary sim:/tb/udt/cpu/cpu/i_rst
add wave -group serv -group serv_cpu -radix binary sim:/tb/udt/cpu/cpu/i_timer_irq

add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_rf_rreq
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_rf_wreq
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/i_rf_ready
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_wen0
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix unsigned 	sim:/tb/udt/cpu/cpu/o_wreg0
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_wdata0
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix unsigned 	sim:/tb/udt/cpu/cpu/o_rreg0
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/i_rdata0
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_wen1
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix unsigned 	sim:/tb/udt/cpu/cpu/o_wreg1
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/o_wdata1
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix unsigned 	sim:/tb/udt/cpu/cpu/o_rreg1
add wave -group serv -group serv_cpu -group rf_if -color yellow -radix binary 	sim:/tb/udt/cpu/cpu/i_rdata1

add wave -group serv -group serv_cpu -group ibus -color white -radix unsigned sim:/tb/udt/cpu/cpu/o_ibus_adr
add wave -group serv -group serv_cpu -group ibus -color white -radix binary 	 sim:/tb/udt/cpu/cpu/o_ibus_cyc
add wave -group serv -group serv_cpu -group ibus -color white -radix binary 	 sim:/tb/udt/cpu/cpu/i_ibus_rdt
add wave -group serv -group serv_cpu -group ibus -color white -radix binary 	 sim:/tb/udt/cpu/cpu/i_ibus_ack

add wave -group serv -group serv_cpu -group dbus -color cyan -radix unsigned sim:/tb/udt/cpu/cpu/o_dbus_adr
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/o_dbus_dat
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/o_dbus_sel
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/o_dbus_we
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/o_dbus_cyc
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/i_dbus_rdt
add wave -group serv -group serv_cpu -group dbus -color cyan -radix binary 	sim:/tb/udt/cpu/cpu/i_dbus_ack

#================================================================================================================== SERV_CPU_DECODE
#add wave -divider -height 30 "SERV_CPU_DECODE"
add wave -group serv_cpu -group serv_decode -radix binary sim:/tb/udt/cpu/cpu/decode/clk
add wave -group serv_cpu -group serv_decode -radix binary sim:/tb/udt/cpu/cpu/decode/i_rst
add wave -group serv_cpu -group serv_decode -radix hex    sim:/tb/udt/cpu/cpu/decode/i_wb_rdt
add wave -group serv_cpu -group serv_decode -radix binary sim:/tb/udt/cpu/cpu/decode/i_wb_en
add wave -group serv_cpu -group serv_decode -radix binary sim:/tb/udt/cpu/cpu/decode/i_cnt_done

add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_bne_or_bge
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_cond_branch
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_dbus_en
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_e_op
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_ebreak
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_branch_op
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_shift_op
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_slt_or_branch
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_rd_op
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_sh_right
add wave -group serv_cpu -group serv_decode -group to_state -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_two_stage_op

add wave -group serv_cpu -group serv_decode -group to_bufreg -color white -radix binary sim:/tb/udt/cpu/cpu/decode/o_bufreg_rs1_en
add wave -group serv_cpu -group serv_decode -group to_bufreg -color white -radix binary sim:/tb/udt/cpu/cpu/decode/o_bufreg_imm_en
add wave -group serv_cpu -group serv_decode -group to_bufreg -color white -radix binary sim:/tb/udt/cpu/cpu/decode/o_bufreg_clr_lsb
add wave -group serv_cpu -group serv_decode -group to_bufreg -color white -radix binary sim:/tb/udt/cpu/cpu/decode/o_bufreg_sh_signed
add wave -group serv_cpu -group serv_decode -group to_bufreg -color white -radix binary sim:/tb/udt/cpu/cpu/decode/o_op_b_source

add wave -group serv_cpu -group serv_decode -group to_ctrl -color cyan -radix binary sim:/tb/udt/cpu/cpu/decode/o_ctrl_jal_or_jalr
add wave -group serv_cpu -group serv_decode -group to_ctrl -color cyan -radix binary sim:/tb/udt/cpu/cpu/decode/o_ctrl_utype
add wave -group serv_cpu -group serv_decode -group to_ctrl -color cyan -radix binary sim:/tb/udt/cpu/cpu/decode/o_ctrl_pc_rel
add wave -group serv_cpu -group serv_decode -group to_ctrl -color cyan -radix binary sim:/tb/udt/cpu/cpu/decode/o_ctrl_mret
add wave -group serv_cpu -group serv_decode -group to_ctrl -color cyan -radix binary sim:/tb/udt/cpu/cpu/decode/o_ctrl_dret

add wave -group serv_cpu -group serv_decode -group to_alu -color pink -radix binary sim:/tb/udt/cpu/cpu/decode/o_alu_sub
add wave -group serv_cpu -group serv_decode -group to_alu -color pink -radix binary sim:/tb/udt/cpu/cpu/decode/o_alu_bool_op
add wave -group serv_cpu -group serv_decode -group to_alu -color pink -radix binary sim:/tb/udt/cpu/cpu/decode/o_alu_cmp_eq
add wave -group serv_cpu -group serv_decode -group to_alu -color pink -radix binary sim:/tb/udt/cpu/cpu/decode/o_alu_cmp_sig
add wave -group serv_cpu -group serv_decode -group to_alu -color pink -radix binary sim:/tb/udt/cpu/cpu/decode/o_alu_rd_sel

add wave -group serv_cpu -group serv_decode -group to_mem_if -color coral -radix binary sim:/tb/udt/cpu/cpu/decode/o_mem_cmd
add wave -group serv_cpu -group serv_decode -group to_mem_if -color coral -radix binary sim:/tb/udt/cpu/cpu/decode/o_mem_signed
add wave -group serv_cpu -group serv_decode -group to_mem_if -color coral -radix binary sim:/tb/udt/cpu/cpu/decode/o_mem_word
add wave -group serv_cpu -group serv_decode -group to_mem_if -color coral -radix binary sim:/tb/udt/cpu/cpu/decode/o_mem_half

add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_addr
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_mstatus_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_mie_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_mcause_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_misa_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_mhartid_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_dcsr_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_source
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_d_sel
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_csr_imm_en
add wave -group serv_cpu -group serv_decode -group to_csr -color magenta -radix binary sim:/tb/udt/cpu/cpu/decode/o_mtval_pc

add wave -group serv_cpu -group serv_decode -group to_immdec -color plum -radix binary sim:/tb/udt/cpu/cpu/decode/o_immdec_ctrl
add wave -group serv_cpu -group serv_decode -group to_immdec -color plum -radix binary sim:/tb/udt/cpu/cpu/decode/o_immdec_en

add wave -group serv_cpu -group serv_decode -group to_rf_if -color snow -radix binary sim:/tb/udt/cpu/cpu/decode/o_rd_mem_en
add wave -group serv_cpu -group serv_decode -group to_rf_if -color snow -radix binary sim:/tb/udt/cpu/cpu/decode/o_rd_csr_en
add wave -group serv_cpu -group serv_decode -group to_rf_if -color snow -radix binary sim:/tb/udt/cpu/cpu/decode/o_rd_alu_en

add wave -group serv_cpu -group serv_decode -group dbg_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/i_dbg_halt
add wave -group serv_cpu -group serv_decode -group dbg_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/i_dbg_step
add wave -group serv_cpu -group serv_decode -group dbg_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_dbg_process
add wave -group serv_cpu -group serv_decode -group dbg_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_dbg_delay

add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/funct3
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/imm30
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/imm25
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/opcode
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op20
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op21
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op22
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op26
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op27
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op29
add wave -group serv_cpu -group serv_decode -group internal -group opcode -color white -radix binary sim:/tb/udt/cpu/cpu/decode/op31

add wave -group serv_cpu -group serv_decode -group internal -group debug  -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/enter_debug
add wave -group serv_cpu -group serv_decode -group internal -group debug  -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/i_dbg_halt
add wave -group serv_cpu -group serv_decode -group internal -group debug  -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/i_dbg_step
add wave -group serv_cpu -group serv_decode -group internal -group debug  -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_dbg_process
add wave -group serv_cpu -group serv_decode -group internal -group debug  -color yellow -radix binary sim:/tb/udt/cpu/cpu/decode/o_dbg_delay

#================================================================================================================== SERV_CPU_STATE
#add wave -divider -height 30 "SERV_CPU_STATE"
add wave -group serv_cpu -group serv_state -radix binary sim:/tb/udt/cpu/cpu/state/i_clk
add wave -group serv_cpu -group serv_state -radix binary sim:/tb/udt/cpu/cpu/state/i_rst

add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_new_irq
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_alu_cmp
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_init
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt_en
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt0to3
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt12to31
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt11to31
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt0
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt1
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt2
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt3
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt7
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_cnt_done
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_bufreg_en
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_ctrl_pc_en
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_ctrl_jump
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_ctrl_trap
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_ctrl_misalign
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_sh_done
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_sh_done_r
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/o_mem_bytecnt
add wave -group serv_cpu -group serv_state -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/state/i_mem_misalign

add wave -group serv_cpu -group serv_state -group external -color white -radix binary sim:/tb/udt/cpu/cpu/state/o_dbus_cyc
add wave -group serv_cpu -group serv_state -group external -color white -radix binary sim:/tb/udt/cpu/cpu/state/i_dbus_ack
add wave -group serv_cpu -group serv_state -group external -color white -radix binary sim:/tb/udt/cpu/cpu/state/o_ibus_cyc
add wave -group serv_cpu -group serv_state -group external -color white -radix binary sim:/tb/udt/cpu/cpu/state/i_ibus_ack

add wave -group serv_cpu -group serv_state -group rf_if -color cyan -radix binary sim:/tb/udt/cpu/cpu/state/o_rf_rreq
add wave -group serv_cpu -group serv_state -group rf_if -color cyan -radix binary sim:/tb/udt/cpu/cpu/state/o_rf_wreq
add wave -group serv_cpu -group serv_state -group rf_if -color cyan -radix binary sim:/tb/udt/cpu/cpu/state/i_rf_ready
add wave -group serv_cpu -group serv_state -group rf_if -color cyan -radix binary sim:/tb/udt/cpu/cpu/state/o_rf_rd_en

add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_bne_or_bge
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_cond_branch
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_dbus_en
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_two_stage_op
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_branch_op
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_shift_op
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_sh_right
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_slt_or_branch
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_e_op
add wave -group serv_cpu -group serv_state -group control -color pink -radix binary sim:/tb/udt/cpu/cpu/state/i_rd_op

add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt0to3
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt12to31
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt0
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt1
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt2
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt3
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt4
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt6
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt7
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt8
add wave -group serv_cpu -group serv_state -group count -color yellow -radix unsigned sim:/tb/udt/cpu/cpu/state/o_cnt30

#================================================================================================================== SERV_CPU_CTRL
#add wave -divider -height 30 "SERV_CPU_CTRL"
add wave -group serv_cpu -group serv_ctrl -radix binary sim:/tb/udt/cpu/cpu/ctrl/clk
add wave -group serv_cpu -group serv_ctrl -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_rst

add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_pc_en
add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_cnt12to31
add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_cnt0
add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_cnt1
add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_cnt2
add wave -group serv_cpu -group serv_ctrl -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_cnt3

add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_jump
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_jal_or_jalr
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_utype
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_pc_rel
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_trap
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_ebreak
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_halt
add wave -group serv_cpu -group serv_ctrl -group control -color white -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_iscomp

add wave -group serv_cpu -group serv_ctrl -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_imm
add wave -group serv_cpu -group serv_ctrl -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_buf
add wave -group serv_cpu -group serv_ctrl -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/ctrl/i_csr_pc
add wave -group serv_cpu -group serv_ctrl -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/ctrl/o_rd
add wave -group serv_cpu -group serv_ctrl -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/ctrl/o_bad_pc

add wave -group serv_cpu -group serv_ctrl -group external -color pink -radix hex sim:/tb/udt/cpu/cpu/ctrl/o_ibus_adr
add wave -group serv_cpu -group serv_ctrl -group external -color pink -radix hex sim:/tb/udt/cpu/cpu/ctrl/o_ibus_nxtadr

#================================================================================================================== SERV_CPU_RF_IF
#add wave -divider -height 30 "SERV_CPU_RF_IF"
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_cnt_en
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_cnt_11to31
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_wen0
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/o_wreg0
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_wdata0
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/o_rreg0
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rdata0
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_wen1
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/o_wreg1
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_wdata1
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/o_rreg1
add wave -group serv_cpu -group serv_rf_if -group rf_if -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rdata1

add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_trap
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_ebreak
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_mret
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_mepc
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_pcnext
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_mtval_pc
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_bufreg_q
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_bad_pc
add wave -group serv_cpu -group serv_rf_if -group trap_if -color yellow -radix binary sim:/tb/udt/cpu/cpu/rf_if/o_csr_pc

add wave -group serv_cpu -group serv_rf_if -group csr_wport -color white -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_csr_en
add wave -group serv_cpu -group serv_rf_if -group csr_wport -color white -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/i_csr_addr
add wave -group serv_cpu -group serv_rf_if -group csr_wport -color white -radix binary sim:/tb/udt/cpu/cpu/rf_if/i_csr

add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rd_wen
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/i_rd_waddr
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_ctrl_rd
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_alu_rd
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rd_alu_en
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_csr_rd
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rd_csr_en
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_mem_rd
add wave -group serv_cpu -group serv_rf_if -group rd_wport -color cyan -radix binary   sim:/tb/udt/cpu/cpu/rf_if/i_rd_mem_en

add wave -group serv_cpu -group serv_rf_if -group rs_rport -color pink -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/i_rs1_raddr
add wave -group serv_cpu -group serv_rf_if -group rs_rport -color pink -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_rs1
add wave -group serv_cpu -group serv_rf_if -group rs_rport -color pink -radix unsigned sim:/tb/udt/cpu/cpu/rf_if/i_rs2_raddr
add wave -group serv_cpu -group serv_rf_if -group rs_rport -color pink -radix binary   sim:/tb/udt/cpu/cpu/rf_if/o_rs2

add wave -group serv_cpu -group serv_rf_if -group csr_rport -color coral -radix binary sim:/tb/udt/cpu/cpu/rf_if/o_csr

#================================================================================================================== SERV_CPU_MEM_IF
#add wave -divider -height 30 "SERV_CPU_MEM_IF"
add wave -group serv_cpu -group serv_mem_if -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_clk
add wave -group serv_cpu -group serv_mem_if -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_rst

add wave -group serv_cpu -group serv_mem_if -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_bytecnt
add wave -group serv_cpu -group serv_mem_if -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_lsb
add wave -group serv_cpu -group serv_mem_if -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/mem_if/o_byte_valid
add wave -group serv_cpu -group serv_mem_if -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/mem_if/o_misalign

add wave -group serv_cpu -group serv_mem_if -group control -color white -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_signed
add wave -group serv_cpu -group serv_mem_if -group control -color white -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_word
add wave -group serv_cpu -group serv_mem_if -group control -color white -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_half

add wave -group serv_cpu -group serv_mem_if -group data -color cyan -radix binary   sim:/tb/udt/cpu/cpu/mem_if/i_bufreg2_q
add wave -group serv_cpu -group serv_mem_if -group data -color cyan -radix binary   sim:/tb/udt/cpu/cpu/mem_if/o_rd

add wave -group serv_cpu -group serv_mem_if -group ext_if -color pink -radix binary   sim:/tb/udt/cpu/cpu/mem_if/o_wb_sel

#================================================================================================================== BUF_REG2
#add wave -divider -height 30 "BUF_REG2"
add wave -group serv_cpu -group serv_bufreg2 -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_clk
add wave -group serv_cpu -group serv_bufreg2 -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_rst

add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_en
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_init
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_cnt_done
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_lsb
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_byte_valid
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/o_sh_done
add wave -group serv_cpu -group serv_bufreg2 -group state -color yellow -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/o_sh_done_r

add wave -group serv_cpu -group serv_bufreg2 -group control -color white -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_op_b_sel
add wave -group serv_cpu -group serv_bufreg2 -group control -color white -radix binary   sim:/tb/udt/cpu/cpu/bufreg2/i_shift_op

add wave -group serv_cpu -group serv_bufreg2 -group data -color cyan -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/i_rs2
add wave -group serv_cpu -group serv_bufreg2 -group data -color cyan -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/i_imm
add wave -group serv_cpu -group serv_bufreg2 -group data -color cyan -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/o_op_b
add wave -group serv_cpu -group serv_bufreg2 -group data -color cyan -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/o_q

add wave -group serv_cpu -group serv_bufreg2 -group data -color yellow -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/o_dat
add wave -group serv_cpu -group serv_bufreg2 -group data -color yellow -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/i_load
add wave -group serv_cpu -group serv_bufreg2 -group data -color yellow -radix hex   sim:/tb/udt/cpu/cpu/bufreg2/i_dat

#================================================================================================================== SERV_CPU_CSR
#add wave -divider -height 30 "SERV_CPU_CSR"
add wave -group serv_cpu -group serv_csr -radix binary sim:/tb/udt/cpu/cpu/csr/i_clk
add wave -group serv_cpu -group serv_csr -radix binary sim:/tb/udt/cpu/cpu/csr/i_rst
add wave -group serv_cpu -group serv_csr -radix binary sim:/tb/udt/cpu/cpu/csr/i_dbg_halt
add wave -group serv_cpu -group serv_csr -radix binary sim:/tb/udt/cpu/cpu/csr/i_dbg_reset

add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_init
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_en
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt0to3
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt2
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt3
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt4
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt6
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt7
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt8
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt30
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_cnt_done
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_mem_op
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_mtip
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/i_trap
add wave -group serv_cpu -group serv_csr -group state -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/o_new_irq

add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_e_op
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_ebreak
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mem_cmd
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mstatus_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mie_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mcause_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_misa_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mhartid_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_dcsr_en
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_csr_source
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_mret
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_dret
add wave -group serv_cpu -group serv_csr -group control -color white -radix binary sim:/tb/udt/cpu/cpu/csr/i_csr_d_sel

add wave -group serv_cpu -group serv_csr -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/csr/i_rf_csr_out
add wave -group serv_cpu -group serv_csr -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/csr/o_csr_in
add wave -group serv_cpu -group serv_csr -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/csr/i_csr_imm
add wave -group serv_cpu -group serv_csr -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/csr/i_rs1
add wave -group serv_cpu -group serv_csr -group data -color cyan -radix binary sim:/tb/udt/cpu/cpu/csr/o_q

add wave -group serv_cpu -group serv_csr -group internal -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/dcsr_step
add wave -group serv_cpu -group serv_csr -group internal -color yellow -radix binary sim:/tb/udt/cpu/cpu/csr/mstatus_mie

#================================================================================================================== SERV_RF_IF
#add wave -divider -height 30 "SERV_RF_IF"
add wave -group serv -group serv_rf_if -radix binary sim:/tb/udt/cpu/rf_ram_if/i_clk
add wave -group serv -group serv_rf_if -radix binary sim:/tb/udt/cpu/rf_ram_if/i_rst

add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_rreq
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_wreq
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/o_ready
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_wen0
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix unsigned 	sim:/tb/udt/cpu/rf_ram_if/i_wreg0
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_wdata0
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix unsigned 	sim:/tb/udt/cpu/rf_ram_if/i_rreg0
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/o_rdata0
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_wen1
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix unsigned 	sim:/tb/udt/cpu/rf_ram_if/i_wreg1
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/i_wdata1
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix unsigned 	sim:/tb/udt/cpu/rf_ram_if/i_rreg1
add wave -group serv -group serv_rf_if -group serv_ctrl -color yellow -radix binary 	sim:/tb/udt/cpu/rf_ram_if/o_rdata1

add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix unsigned  sim:/tb/udt/cpu/rf_ram_if/o_waddr
add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix hex 	sim:/tb/udt/cpu/rf_ram_if/o_wdata
add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix binary    sim:/tb/udt/cpu/rf_ram_if/o_wen
add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix unsigned  sim:/tb/udt/cpu/rf_ram_if/o_raddr
add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix binary    sim:/tb/udt/cpu/rf_ram_if/o_ren
add wave -group serv -group serv_rf_if -group ram_ctrl -color white -radix hex 	sim:/tb/udt/cpu/rf_ram_if/i_rdata

#================================================================================================================== SERV_RF_RAM
#add wave -divider -height 30 "SERV_RF_RAM"
add wave -group serv -group serv_rf_ram -radix binary 	sim:/tb/udt/cpu/rf_ram/i_clk
add wave -group serv -group serv_rf_ram -radix unsigned 	sim:/tb/udt/cpu/rf_ram/i_waddr
#add wave -group serv -group serv_rf_ram -radix unsigned 	sim:/tb/udt/cpu/rf_ram/half_waddr
add wave -group serv -group serv_rf_ram -radix hex 		sim:/tb/udt/cpu/rf_ram/i_wdata
add wave -group serv -group serv_rf_ram -radix binary 	sim:/tb/udt/cpu/rf_ram/i_wen
add wave -group serv -group serv_rf_ram -radix unsigned 	sim:/tb/udt/cpu/rf_ram/i_raddr
#add wave -group serv -group serv_rf_ram -radix unsigned 	sim:/tb/udt/cpu/rf_ram/half_raddr
add wave -group serv -group serv_rf_ram -radix binary 	sim:/tb/udt/cpu/rf_ram/i_ren
add wave -group serv -group serv_rf_ram -radix hex 		sim:/tb/udt/cpu/rf_ram/o_rdata
add wave -group serv -group serv_rf_ram -radix hex 		sim:/tb/udt/cpu/rf_ram/memory

#================================================================================================================== DTM
#add wave -divider -height 30 "DTM"
add wave -group dtm -radix binary 	sim:/tb/udt/serv_dtm/i_clk
add wave -group dtm -radix binary 	sim:/tb/udt/serv_dtm/i_rst

add wave -group dtm -group jtag -color yellow -radix binary sim:/tb/udt/serv_dtm/i_trst
add wave -group dtm -group jtag -color yellow -radix binary sim:/tb/udt/serv_dtm/i_tck
add wave -group dtm -group jtag -color yellow -radix binary sim:/tb/udt/serv_dtm/i_tdi
add wave -group dtm -group jtag -color yellow -radix binary sim:/tb/udt/serv_dtm/o_tdo
add wave -group dtm -group jtag -color yellow -radix binary sim:/tb/udt/serv_dtm/i_tms

add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/o_dmi_req_valid
add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/i_dmi_req_ready
add wave -group dtm -group dmi -color white -radix hex    sim:/tb/udt/serv_dtm/o_dmi_req_address
add wave -group dtm -group dmi -color white -radix hex    sim:/tb/udt/serv_dtm/o_dmi_req_data
add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/o_dmi_req_op
add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/i_dmi_rsp_valid
add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/o_dmi_rsp_ready
add wave -group dtm -group dmi -color white -radix hex    sim:/tb/udt/serv_dtm/i_dmi_rsp_data
add wave -group dtm -group dmi -color white -radix binary sim:/tb/udt/serv_dtm/i_dmi_rsp_op

#================================================================================================================== DM
#add wave -divider -height 30 "DM"
add wave -group dm -radix binary 	sim:/tb/udt/serv_dm/i_clk
add wave -group dm -radix binary 	sim:/tb/udt/serv_dm/i_rst

add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/i_dmi_req_valid
add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/o_dmi_req_ready
add wave -group dm -group dmi -color yellow -radix hex    sim:/tb/udt/serv_dm/i_dmi_req_address
add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/i_dmi_req_op
add wave -group dm -group dmi -color yellow -radix hex    sim:/tb/udt/serv_dm/i_dmi_req_data
add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/o_dmi_rsp_valid
add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/i_dmi_rsp_ready
add wave -group dm -group dmi -color yellow -radix hex    sim:/tb/udt/serv_dm/o_dmi_rsp_data
add wave -group dm -group dmi -color yellow -radix binary sim:/tb/udt/serv_dm/o_dmi_rsp_op

add wave -group dm -group wb -color white -radix hex    sim:/tb/udt/serv_dm/i_sbus_adr
add wave -group dm -group wb -color white -radix hex    sim:/tb/udt/serv_dm/i_sbus_dat
add wave -group dm -group wb -color white -radix binary sim:/tb/udt/serv_dm/i_sbus_sel
add wave -group dm -group wb -color white -radix binary sim:/tb/udt/serv_dm/i_sbus_we
add wave -group dm -group wb -color white -radix binary sim:/tb/udt/serv_dm/i_sbus_cyc
add wave -group dm -group wb -color white -radix hex    sim:/tb/udt/serv_dm/o_sbus_rdt
add wave -group dm -group wb -color white -radix binary sim:/tb/udt/serv_dm/o_sbus_ack

add wave -group dm -group cpu -color cyan -radix binary sim:/tb/udt/serv_dm/i_cpu_debug
add wave -group dm -group cpu -color cyan -radix binary sim:/tb/udt/serv_dm/o_cpu_ndmrst
add wave -group dm -group cpu -color cyan -radix binary sim:/tb/udt/serv_dm/o_cpu_req_halt

add wave -group dm -group internal -group read_side -color yellow -radix binary sim:/tb/udt/serv_dm/acc_en
add wave -group dm -group internal -group read_side -color yellow -radix binary sim:/tb/udt/serv_dm/rden
add wave -group dm -group internal -group read_side -color yellow -radix binary sim:/tb/udt/serv_dm/wren
add wave -group dm -group internal -group read_side -color yellow -radix binary sim:/tb/udt/serv_dm/maddr
add wave -group dm -group internal -group read_side -color yellow -radix binary sim:/tb/udt/serv_dm/i_sbus_adr[3:2]

add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_halt_ack
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_resume_req
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_resume_ack
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_execute_req
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_execute_ack
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_exception_ack
add wave -group dm -group internal -group dci -color white -radix binary sim:/tb/udt/serv_dm/dci_data_we
add wave -group dm -group internal -group dci -color white -radix hex    sim:/tb/udt/serv_dm/dci_wdata
add wave -group dm -group internal -group dci -color white -radix hex    sim:/tb/udt/serv_dm/dci_rdata

add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/cpu_progbuf0
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/cpu_progbuf1
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/cpu_progbuf2
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/cpu_progbuf3
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/prog_buf0
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/prog_buf1
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/prog_buf2
add wave -group dm -group internal -group buffer -color yellow -radix hex sim:/tb/udt/serv_dm/prog_buf3

add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_dmcontrol_ndmreset
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_dmcontrol_dmactive
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_abstractauto_autoexecdata
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_abstractauto_autoexecprogbuf
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_progbuf0
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_progbuf1
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_command
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_halt_req
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_resume_req
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_reset_ack
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_wr_acc_err
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_rd_acc_err
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_clr_acc_err
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_autoexec_wr
add wave -group dm -group internal -group dm_reg -color white -radix hex sim:/tb/udt/serv_dm/dm_reg_autoexec_rd

add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_busy
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_ldsw_progbuf
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_pbuf_en
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_illegal_state
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_illegal_cmd
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_cmderr
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_hart_halted
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_hart_resume_req
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_hart_resume_ack
add wave -group dm -group internal -group dm_ctrl -color yellow -radix hex sim:/tb/udt/serv_dm/dm_ctrl_hart_reset

#================================================================================================================== FLASH
#add wave -divider -height 30 "FLASH"
add wave -group flash -radix binary 	sim:/tb/udt/serv_flash/i_wb_clk
add wave -group flash -radix binary 	sim:/tb/udt/serv_flash/i_wb_rst

add wave -group flash -group wb -color yellow -radix hex 	sim:/tb/udt/serv_flash/i_wb_adr
add wave -group flash -group wb -color yellow -radix hex 	sim:/tb/udt/serv_flash/i_wb_dat
add wave -group flash -group wb -color yellow -radix binary 	sim:/tb/udt/serv_flash/i_wb_sel
add wave -group flash -group wb -color yellow -radix binary 	sim:/tb/udt/serv_flash/i_wb_we
add wave -group flash -group wb -color yellow -radix binary 	sim:/tb/udt/serv_flash/i_wb_cyc
add wave -group flash -group wb -color yellow -radix hex 	sim:/tb/udt/serv_flash/o_wb_rdt
add wave -group flash -group wb -color yellow -radix binary 	sim:/tb/udt/serv_flash/o_wb_ack

add wave -group flash -group spi -color white -radix binary 	sim:/tb/udt/serv_flash/SCK
add wave -group flash -group spi -color white -radix binary 	sim:/tb/udt/serv_flash/CS_n
add wave -group flash -group spi -color white -radix binary 	sim:/tb/udt/serv_flash/MOSI
add wave -group flash -group spi -color white -radix binary 	sim:/tb/udt/serv_flash/MISO

view wave
view structure
view signals

run -all
