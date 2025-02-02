
/*  (c) Copyright 2014 - 2019 Xilinx, Inc. All rights reserved.

 This file contains confidential and proprietary information
 of Xilinx, Inc. and is protected under U.S. and
 international copyright and other intellectual property
 laws.

 DISCLAIMER
 This disclaimer is not a license and does not grant any
 rights to the materials distributed herewith. Except as
 otherwise provided in a valid license issued to you by
 Xilinx, and to the maximum extent permitted by applicable
 law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 (2) Xilinx shall not be liable (whether in contract or tort,
 including negligence, or under any other theory of
 liability) for any loss or damage of any kind or nature
 related to, arising under or in connection with these
 materials, including for any direct, or any indirect,
 special, incidental, or consequential loss or damage
 (including loss of data, profits, goodwill, or any type of
 loss or damage suffered as a result of any action brought
 by a third party) even if such damage or loss was
 reasonably foreseeable or Xilinx had been advised of the
 possibility of the same.

 CRITICAL APPLICATIONS
 Xilinx products are not designed or intended to be fail-
 safe, or for use in any application requiring fail-safe
 performance, such as life-support or safety devices or
 systems, Class III medical devices, nuclear facilities,
 applications related to the deployment of airbags, or any
 other applications that could lead to death, personal
 injury, or severe property or environmental damage
 (individually and collectively, "Critical
 Applications"). Customer assumes the sole risk and
 liability of any use of Xilinx products in Critical
 Applications, subject only to applicable laws and
 regulations governing limitations on product liability.

 THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 PART OF THIS FILE AT ALL TIMES.                       */

#include<iostream>
#include "debug_manager.h"
#ifdef __cplusplus
#define FUNC_DECL  extern "C"
#else
#define FUNC_DECL
#endif

FUNC_DECL
char* get_variable_name(uint64_t& addr, uint64_t& valid_addr);
//Notes::std::map<address,size>
FUNC_DECL
std::map<uint64_t, unsigned int> get_valid_address_map();
FUNC_DECL
//Notes::std::map<address,size>
std::map<uint64_t, unsigned int> get_invalid_address_map();
FUNC_DECL
void set_valid_address_map(uint64_t& addr, unsigned int& size);
FUNC_DECL
void set_invalid_address_map(uint64_t& addr, unsigned int& size);
FUNC_DECL
bool is_valid_address_range(uint64_t& addr, unsigned int& size);
FUNC_DECL
void
populate_kernelArgs_info(
		std::map<uint64_t, std::pair<std::string, unsigned int>> kernelInfo);
FUNC_DECL
void
set_environment(std::string name, std::string value);
FUNC_DECL
std::string
get_env_config(std::string name);
#define DEBUG_MANAGER (debug_manager::getInstance())


