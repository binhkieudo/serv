
/*
 * TLM remoteport glue
 *
 * Copyright (c) 2016 Xilinx Inc
 * Written by Edgar E. Iglesias
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
#include "remote_port_tlm_sc_defines.h"

class REMOTEPORT_SC_API remoteport_tlm_memory_master
	: public sc_core::sc_module, public remoteport_tlm_dev
{
public:
	tlm_utils::simple_initiator_socket<remoteport_tlm_memory_master> sk;

        remoteport_tlm_memory_master(sc_core::sc_module_name name)
		: sc_core::sc_module(name)
	{
	}
	void cmd_write(struct rp_pkt &pkt, bool can_sync, unsigned char *data, size_t len);
	void cmd_read(struct rp_pkt &pkt, bool can_sync);
	void tie_off(void);

private:
	tlm_utils::simple_target_socket<remoteport_tlm_memory_master> *tieoff_sk;

	sc_core::sc_time rp_bus_access(struct rp_pkt &pkt,
                                   bool can_sync,
                                   tlm::tlm_command cmd,
                                   unsigned char *data, size_t len);
    void dummy_b_transport(tlm::tlm_generic_payload& trans, sc_core::sc_time& t);
};


