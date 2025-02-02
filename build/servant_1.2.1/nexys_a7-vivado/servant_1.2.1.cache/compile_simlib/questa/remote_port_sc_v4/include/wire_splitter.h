
/*
 * A wire splitter useful to fan-out signals.
 *
 * Copyright (c) 2018 Xilinx Inc.
 * Written by Edgar E. Iglesias.
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
#include "systemc"

SC_MODULE(wire_splitter) {
private:
	void work() {
		int i;
		bool v = in.read();

		/* Drive the input signal onto all outputs.  */
		for (i = 0; i < out.size(); i++) {
			out[i].write(v);
		}
	}
public:
	sc_core::sc_in<bool> in;
	sc_core::sc_vector<sc_core::sc_out<bool> > out;

	wire_splitter(sc_core::sc_module_name name, int nr_out) :
			sc_core::sc_module(name), out("out", nr_out) {
		SC_METHOD(work);
		sensitive << in;
	}
	SC_HAS_PROCESS(wire_splitter);
};


