# Amazon FPGA Hardware Development Kit
#
# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#    http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions and
# limitations under the License.

#post opt calls


set sdp_script_dir [file dirname [info script]]

if {[info exist FAAS_CL_DIR] eq 0} {
	if {[info exist ::env(FAAS_CL_DIR)]} {
		set FAAS_CL_DIR $::env(FAAS_CL_DIR)
	} else {
		::tclapp::xilinx::faasutils::make_faas -force -bypass_drcs -partial
#		send_msg_id "opt_design_post 0-1" ERROR "FAAS_CL_DIR environment varaiable not set, please run the proc 'aws::make_faas_setup' at the Vivado TCL command prompt"
	}
}

source ${sdp_script_dir}/apply_debug_constraints_hlx.tcl
set_param hd.clockRoutingWireReduction false 
set timestamp $::env(timestamp)
write_checkpoint -force $FAAS_CL_DIR/build/checkpoints/${timestamp}.SH_CL.post_opt.dcp
