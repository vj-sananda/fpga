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
// Filename:          F:\fpga\proj\DesignContest08_vjs_64bit\drivers\accel_sort_plb_v1_00_a\src\accel_sort_plb.h
// Version:           1.00.a
// Description:       accel_sort_plb Driver Header File
// Date:              Mon May 02 09:49:11 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef ACCEL_SORT_PLB_H
#define ACCEL_SORT_PLB_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLAVE_REG0 : user logic slave module register 0
 * -- SLAVE_REG1 : user logic slave module register 1
 * -- SLAVE_REG2 : user logic slave module register 2
 * -- SLAVE_REG3 : user logic slave module register 3
 */
#define ACCEL_SORT_PLB_USER_SLAVE_SPACE_OFFSET (0x00000000)
#define ACCEL_SORT_PLB_SLAVE_REG0_OFFSET (ACCEL_SORT_PLB_USER_SLAVE_SPACE_OFFSET + 0x00000000)
#define ACCEL_SORT_PLB_SLAVE_REG1_OFFSET (ACCEL_SORT_PLB_USER_SLAVE_SPACE_OFFSET + 0x00000008)
#define ACCEL_SORT_PLB_SLAVE_REG2_OFFSET (ACCEL_SORT_PLB_USER_SLAVE_SPACE_OFFSET + 0x00000010)
#define ACCEL_SORT_PLB_SLAVE_REG3_OFFSET (ACCEL_SORT_PLB_USER_SLAVE_SPACE_OFFSET + 0x00000018)

/**
 * IPIF Reset Mask
 * -- IPIF_RESET       : software reset
 */
#define IPIF_RESET (0x0000000A)

/**
 * IPIF Read Packet FIFO Register/Data Space Offsets
 * -- RDFIFO_RST   : read packet fifo reset register
 * -- RDFIFO_MIR   : read packet fifo module identification register
 * -- RDFIFO_SR    : read packet fifo status register
 * -- RDFIFO_DATA  : read packet fifo data
 */
#define ACCEL_SORT_PLB_IPIF_RDFIFO_REG_SPACE_OFFSET (0x00000100)
#define ACCEL_SORT_PLB_RDFIFO_RST_OFFSET (ACCEL_SORT_PLB_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define ACCEL_SORT_PLB_RDFIFO_MIR_OFFSET (ACCEL_SORT_PLB_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define ACCEL_SORT_PLB_RDFIFO_SR_OFFSET (ACCEL_SORT_PLB_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define ACCEL_SORT_PLB_IPIF_RDFIFO_DATA_SPACE_OFFSET (0x00000200)
#define ACCEL_SORT_PLB_RDFIFO_DATA_OFFSET (ACCEL_SORT_PLB_IPIF_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * IPIF Read Packet FIFO Masks
 * -- RDFIFO_EMPTY_MASK : read packet fifo empty condition
 * -- RDFIFO_AE_MASK    : read packet fifo almost empty condition
 * -- RDFIFO_DL_MASK    : read packet fifo deadlock condition
 * -- RDFIFO_SCL_MASK   : read packet fifo occupancy scaling enabled
 * -- RDFIFO_WIDTH_MASK : read packet fifo encoded data port width
 * -- RDFIFO_OCC_MASK   : read packet fifo occupancy
 */
#define RDFIFO_EMPTY_MASK (0x80000000UL)
#define RDFIFO_AE_MASK (0x40000000UL)
#define RDFIFO_DL_MASK (0x20000000UL)
#define RDFIFO_SCL_MASK (0x10000000UL)
#define RDFIFO_WIDTH_MASK (0x0E000000UL)
#define RDFIFO_OCC_MASK (0x01FFFFFFUL)

/**
 * IPIF Write Packet FIFO Register/Data Space Offsets
 * -- WRFIFO_RST   : write packet fifo reset register
 * -- WRFIFO_MIR   : write packet fifo module identification register
 * -- WRFIFO_SR    : write packet fifo status register
 * -- WRFIFO_DATA  : write packet fifo data
 */
#define ACCEL_SORT_PLB_IPIF_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define ACCEL_SORT_PLB_WRFIFO_RST_OFFSET (ACCEL_SORT_PLB_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define ACCEL_SORT_PLB_WRFIFO_MIR_OFFSET (ACCEL_SORT_PLB_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define ACCEL_SORT_PLB_WRFIFO_SR_OFFSET (ACCEL_SORT_PLB_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define ACCEL_SORT_PLB_IPIF_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define ACCEL_SORT_PLB_WRFIFO_DATA_OFFSET (ACCEL_SORT_PLB_IPIF_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * IPIF Write Packet FIFO Masks
 * -- WRFIFO_FULL_MASK  : write packet fifo full condition
 * -- WRFIFO_AF_MASK    : write packet fifo almost full condition
 * -- WRFIFO_DL_MASK    : write packet fifo deadlock condition
 * -- WRFIFO_SCL_MASK   : write packet fifo vacancy scaling enabled
 * -- WRFIFO_WIDTH_MASK : write packet fifo encoded data port width
 * -- WRFIFO_VAC_MASK   : write packet fifo vacancy
 */
#define WRFIFO_FULL_MASK (0x80000000UL)
#define WRFIFO_AF_MASK (0x40000000UL)
#define WRFIFO_DL_MASK (0x20000000UL)
#define WRFIFO_SCL_MASK (0x10000000UL)
#define WRFIFO_WIDTH_MASK (0x0E000000UL)
#define WRFIFO_VAC_MASK (0x01FFFFFFUL)

/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a ACCEL_SORT_PLB register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void ACCEL_SORT_PLB_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define ACCEL_SORT_PLB_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a ACCEL_SORT_PLB register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 ACCEL_SORT_PLB_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define ACCEL_SORT_PLB_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Reset read packet FIFO of ACCEL_SORT_PLB to its initial state.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void ACCEL_SORT_PLB_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define ACCEL_SORT_PLB_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(ACCEL_SORT_PLB_RDFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of ACCEL_SORT_PLB read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool ACCEL_SORT_PLB_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 ACCEL_SORT_PLB_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define ACCEL_SORT_PLB_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(ACCEL_SORT_PLB_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define ACCEL_SORT_PLB_mReadFIFOOccupancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(ACCEL_SORT_PLB_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK) == RDFIFO_OCC_MASK)

/**
 *
 * Reset write packet FIFO of ACCEL_SORT_PLB to its initial state.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void ACCEL_SORT_PLB_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define ACCEL_SORT_PLB_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(ACCEL_SORT_PLB_WRFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of ACCEL_SORT_PLB write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the ACCEL_SORT_PLB device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool ACCEL_SORT_PLB_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 ACCEL_SORT_PLB_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define ACCEL_SORT_PLB_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(ACCEL_SORT_PLB_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define ACCEL_SORT_PLB_mWriteFIFOVacancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(ACCEL_SORT_PLB_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK) == WRFIFO_VAC_MASK)

/************************** Function Prototypes ****************************/


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
void ACCEL_SORT_PLB_WriteSlaveReg0(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_WriteSlaveReg1(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_WriteSlaveReg2(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_WriteSlaveReg3(void * baseaddr_p, Xuint64 * data);

void ACCEL_SORT_PLB_ReadSlaveReg0(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_ReadSlaveReg1(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_ReadSlaveReg2(void * baseaddr_p, Xuint64 * data);
void ACCEL_SORT_PLB_ReadSlaveReg3(void * baseaddr_p, Xuint64 * data);
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
void ACCEL_SORT_PLB_ReadFromFIFO(void * baseaddr_p, Xuint64 * data);
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
void ACCEL_SORT_PLB_WriteToFIFO(void * baseaddr_p, Xuint64 * data);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the ACCEL_SORT_PLB instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus ACCEL_SORT_PLB_SelfTest(void * baseaddr_p);

#endif // ACCEL_SORT_PLB_H
