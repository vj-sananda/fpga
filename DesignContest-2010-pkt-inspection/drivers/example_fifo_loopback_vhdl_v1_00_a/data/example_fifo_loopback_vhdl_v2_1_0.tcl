##############################################################################
## Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/example_fifo_loopback_vhdl_v1_00_a/data/example_fifo_loopback_vhdl_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Tue Mar 30 10:52:59 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "example_fifo_loopback_vhdl" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
