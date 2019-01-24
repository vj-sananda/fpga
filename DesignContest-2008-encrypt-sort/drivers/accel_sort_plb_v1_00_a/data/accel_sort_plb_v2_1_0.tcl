##############################################################################
##
## ***************************************************************************
## **                                                                       **
## ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
## **                                                                       **
## ** You may copy and modify these files for your own internal use solely  **
## ** with Xilinx programmable logic devices and Xilinx EDK system or       **
## ** create IP modules solely for Xilinx programmable logic devices and    **
## ** Xilinx EDK system. No rights are granted to distribute any files      **
## ** unless they are distributed in Xilinx programmable logic devices.     **
## **                                                                       **
## ***************************************************************************
##
##############################################################################
## Filename:          F:\fpga\proj\DesignContest08_vjs_64bit\drivers\accel_sort_plb_v1_00_a\data\accel_sort_plb_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon May 02 09:49:11 2005 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "accel_sort_plb" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
