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
## Filename:          F:\fpga\proj\huffman_encode\drivers\huffman_encode_testharness_v1_00_a\data\huffman_encode_testharness_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon Apr 25 16:41:21 2005 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "huffman_encode_testharness" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
