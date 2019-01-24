//////////////////////////////////////////////////////////////////////////////
//
// ***************************************************************************
// **                                                                       **
// ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** You may copy and modify these files for your own internal use solely  **
// ** with Xilinx programmable logic devices and Xilinx EDK system or       **
// ** create IP modules solely for Xilinx programmable logic devices and    **
// ** Xilinx EDK system. No rights are granted to distribute any files      **
// ** unless they are distributed in Xilinx programmable logic devices.     **
// **                                                                       **
// ***************************************************************************
//
//////////////////////////////////////////////////////////////////////////////
// Filename:          F:\fpga\proj\DesignContest08_vjs_64bit\drivers\accel_sort_plb_v1_00_a\src\accel_sort_plb.c
// Version:           1.00.a
// Description:       accel_sort_plb Driver Source File
// Date:              Mon May 02 09:49:11 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "accel_sort_plb.h"

/************************** Function Definitions ***************************/

/**
 *
 * Write/Read value to/from ACCEL_SORT_PLB user logic slave registers.
 *
 * @param   baseaddr_p is the base address of the ACCEL_SORT_PLB device.
 * @param   data is a point to a given Xuint64 structure for fetching or storing value.
 *
 * @return  None.
 *
 * @note    data should be allocated by the caller.
 *
 */
void ACCEL_SORT_PLB_WriteSlaveReg0(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG0_OFFSET, data->Upper);
  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG0_OFFSET+0x4, data->Lower);
}

void ACCEL_SORT_PLB_WriteSlaveReg1(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG1_OFFSET, data->Upper);
  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG1_OFFSET+0x4, data->Lower);
}

void ACCEL_SORT_PLB_WriteSlaveReg2(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG2_OFFSET, data->Upper);
  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG2_OFFSET+0x4, data->Lower);
}

void ACCEL_SORT_PLB_WriteSlaveReg3(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG3_OFFSET, data->Upper);
  XIo_Out32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG3_OFFSET+0x4, data->Lower);
}


void ACCEL_SORT_PLB_ReadSlaveReg0(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  data->Upper = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG0_OFFSET);
  data->Lower = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG0_OFFSET+0x4);
}

void ACCEL_SORT_PLB_ReadSlaveReg1(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  data->Upper = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG1_OFFSET);
  data->Lower = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG1_OFFSET+0x4);
}

void ACCEL_SORT_PLB_ReadSlaveReg2(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  data->Upper = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG2_OFFSET);
  data->Lower = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG2_OFFSET+0x4);
}

void ACCEL_SORT_PLB_ReadSlaveReg3(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  data->Upper = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG3_OFFSET);
  data->Lower = XIo_In32(baseaddr+ACCEL_SORT_PLB_SLAVE_REG3_OFFSET+0x4);
}

/**
 *
 * Read data from ACCEL_SORT_PLB read packet FIFO module.
 *
 * @param   baseaddr_p is the base address of the ACCEL_SORT_PLB device.
 * @param   data is a point to a given Xuint64 structure for fetching or storing value.
 *
 * @return  None.
 *
 * @note    data should be allocated by the caller.
 *
 */
void ACCEL_SORT_PLB_ReadFromFIFO(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  data->Upper = XIo_In32(baseaddr+ACCEL_SORT_PLB_RDFIFO_DATA_OFFSET);
  data->Lower = XIo_In32(baseaddr+ACCEL_SORT_PLB_RDFIFO_DATA_OFFSET+0x4);
}

/**
 *
 * Write data to ACCEL_SORT_PLB write packet FIFO module.
 *
 * @param   baseaddr_p is the base address of the ACCEL_SORT_PLB device.
 * @param   data is a point to a given Xuint64 structure for fetching or storing value.
 *
 * @return  None.
 *
 * @note    data should be allocated by the caller.
 *
 */
void ACCEL_SORT_PLB_WriteToFIFO(void * baseaddr_p, Xuint64 * data)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  XIo_Out32(baseaddr+ACCEL_SORT_PLB_WRFIFO_DATA_OFFSET, data->Upper);
  XIo_Out32(baseaddr+ACCEL_SORT_PLB_WRFIFO_DATA_OFFSET+0x4, data->Lower);
}

