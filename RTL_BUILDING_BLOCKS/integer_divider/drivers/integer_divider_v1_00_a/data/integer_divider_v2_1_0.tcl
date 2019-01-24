##############################################################################
## Filename:          E:\work\FPGA_PROJECTS\BLOCKS\integer_divider/drivers/integer_divider_v1_00_a/data/integer_divider_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Wed Dec 08 17:22:22 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "integer_divider" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
