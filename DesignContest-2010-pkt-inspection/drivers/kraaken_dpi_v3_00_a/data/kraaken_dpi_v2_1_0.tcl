##############################################################################
## Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/kraaken_dpi_v3_00_a/data/kraaken_dpi_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Tue Mar 30 01:01:21 2010 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "kraaken_dpi" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
