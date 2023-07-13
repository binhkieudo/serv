
/*
 * TLM remoteport glue
 *
 * Copyright (c) 2013 Xilinx Inc
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

#ifndef _REMOTE_PORT_H_
#define _REMOTE_PORT_H_

#include "remote_port_tlm_sc_defines.h"

extern "C" {
#include "remote_port_proto.h"
}
;

class remoteport_packet {
public:
	union {
		struct rp_pkt *pkt;
		uint8_t *u8;
	};
	size_t data_offset;
	size_t size;

	remoteport_packet(void);
	void alloc(size_t size);
};

class remoteport_tlm;

class remoteport_tlm_dev {
public:
	unsigned int dev_id;
	remoteport_tlm *adaptor;

	virtual void cmd_write(struct rp_pkt &pkt, bool can_sync,
			unsigned char *data, size_t len) {
	}
	;
	virtual void cmd_read(struct rp_pkt &pkt, bool can_sync) {
	}
	;
	virtual void cmd_interrupt(struct rp_pkt &pkt, bool can_sync) {
	}
	;
	virtual void tie_off(void) {
	}
	;
	sc_core::sc_event m_dev_ev;
};

#define RP_MAX_DEVS 512
class remoteport_tlm_impl;
class REMOTEPORT_SC_API remoteport_tlm: public sc_core::sc_module {
public:
	sc_core::sc_in<bool> rst;

	SC_HAS_PROCESS (remoteport_tlm);
	remoteport_tlm(sc_core::sc_module_name name, int fd, const char *sk_descr);

	void register_dev(unsigned int dev_id, remoteport_tlm_dev *dev);
	virtual void tie_off(void);

	/* Public to devs.  */
	struct rp_peer_state peer;
	uint32_t rp_pkt_id;

	bool rp_process(bool sync);
	ssize_t rp_read(void *rbuf, size_t count);
	ssize_t rp_write(const void *wbuf, size_t count);
	int64_t rp_map_time(sc_core::sc_time t);
	void account_time(int64_t rp_time_ns);

	tlm_utils::tlm_quantumkeeper m_qk;

	remoteport_packet pkt_tx;
	remoteport_packet pkt_tx_slave;
	remoteport_packet pkt_rx;

	remoteport_tlm_impl* rpt_impl_ptr;
	int fd;
private:
	remoteport_tlm_dev *devs[RP_MAX_DEVS];
	const char *sk_descr;
	unsigned char *pktbuf_data;
    bool connection_live;
	/* Socket.  */

	void rp_say_hello(void);
	void rp_cmd_hello(struct rp_pkt &pkt);
	void rp_cmd_sync(struct rp_pkt &pkt, bool can_sync);
	void process(void);

protected:
	~remoteport_tlm();
};
#endif

