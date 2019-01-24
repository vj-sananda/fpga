##############################################################################
## Filename:          E:\work\FPGA_PROJECTS\BLOCKS\integer_divider_v2/drivers/plb_dut_intf_v1_00_a/data/plb_dut_intf_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Fri Dec 10 12:23:33 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "plb_dut_intf" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
