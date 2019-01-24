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
// Filename:          F:\fpga\proj\huffman_encode\drivers\huffman_encode_testharness_v1_00_a\src\huffman_encode_testharness.h
// Version:           1.00.a
// Description:       huffman_encode_testharness Driver Header File
// Date:              Mon Apr 25 16:41:21 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef HUFFMAN_ENCODE_TESTHARNESS_H
#define HUFFMAN_ENCODE_TESTHARNESS_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLAVE_REG0 : user logic slave module register 0
 * -- SLAVE_REG1 : user logic slave module register 1
 */
#define HUFFMAN_ENCODE_TESTHARNESS_USER_SLAVE_SPACE_OFFSET (0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG0_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_USER_SLAVE_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG1_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_USER_SLAVE_SPACE_OFFSET + 0x00000004)

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
#define HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_REG_SPACE_OFFSET (0x00000100)
#define HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_RST_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_MIR_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_SR_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_DATA_SPACE_OFFSET (0x00000200)
#define HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_DATA_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
#define HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_RST_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_MIR_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_SR_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_DATA_OFFSET (HUFFMAN_ENCODE_TESTHARNESS_IPIF_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
 * Write a value to a HUFFMAN_ENCODE_TESTHARNESS register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_ENCODE_TESTHARNESS_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a HUFFMAN_ENCODE_TESTHARNESS register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_ENCODE_TESTHARNESS_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read value to/from HUFFMAN_ENCODE_TESTHARNESS user logic slave registers.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveRegn(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg0(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG0_OFFSET), (Xuint32)(Value))
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg1(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG1_OFFSET), (Xuint32)(Value))

#define HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg0(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG0_OFFSET))
#define HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg1(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_SLAVE_REG1_OFFSET))

/**
 *
 * Reset read packet FIFO of HUFFMAN_ENCODE_TESTHARNESS to its initial state.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_ENCODE_TESTHARNESS_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of HUFFMAN_ENCODE_TESTHARNESS read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOOccupancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK) == RDFIFO_OCC_MASK)

/**
 *
 * Read data from HUFFMAN_ENCODE_TESTHARNESS read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 *
 * @return  Data is the data from the read packet FIFO.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_ENCODE_TESTHARNESS_mReadFromFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mReadFromFIFO(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_RDFIFO_DATA_OFFSET))

/**
 *
 * Reset write packet FIFO of HUFFMAN_ENCODE_TESTHARNESS to its initial state.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_ENCODE_TESTHARNESS_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of HUFFMAN_ENCODE_TESTHARNESS write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool HUFFMAN_ENCODE_TESTHARNESS_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 HUFFMAN_ENCODE_TESTHARNESS_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteFIFOVacancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK) == WRFIFO_VAC_MASK)

/**
 *
 * Write data to HUFFMAN_ENCODE_TESTHARNESS write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_ENCODE_TESTHARNESS device.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_ENCODE_TESTHARNESS_mWriteToFIFO(Xuint32 BaseAddress, Xuint32 Data)
 *
 */
#define HUFFMAN_ENCODE_TESTHARNESS_mWriteToFIFO(BaseAddress, Data) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_ENCODE_TESTHARNESS_WRFIFO_DATA_OFFSET), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the HUFFMAN_ENCODE_TESTHARNESS instance to be worked on.
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
XStatus HUFFMAN_ENCODE_TESTHARNESS_SelfTest(void * baseaddr_p);

#endif // HUFFMAN_ENCODE_TESTHARNESS_H
