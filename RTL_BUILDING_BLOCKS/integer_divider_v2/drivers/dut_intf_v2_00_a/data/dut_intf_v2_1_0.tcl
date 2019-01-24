##############################################################################
## Filename:          E:\work\FPGA_PROJECTS\BLOCKS\integer_divider_v2/drivers/dut_intf_v2_00_a/data/dut_intf_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Fri Dec 10 17:42:26 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "dut_intf" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
