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
// Filename:          F:\fpga\proj\huffman_decode\drivers\huffman_decoder_v1_00_a\src\huffman_decoder.h
// Version:           1.00.a
// Description:       huffman_decoder Driver Header File
// Date:              Fri Apr 22 16:41:35 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef HUFFMAN_DECODER_H
#define HUFFMAN_DECODER_H

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
#define HUFFMAN_DECODER_USER_SLAVE_SPACE_OFFSET (0x00000000)
#define HUFFMAN_DECODER_SLAVE_REG0_OFFSET (HUFFMAN_DECODER_USER_SLAVE_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_DECODER_SLAVE_REG1_OFFSET (HUFFMAN_DECODER_USER_SLAVE_SPACE_OFFSET + 0x00000004)

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
#define HUFFMAN_DECODER_IPIF_RDFIFO_REG_SPACE_OFFSET (0x00000100)
#define HUFFMAN_DECODER_RDFIFO_RST_OFFSET (HUFFMAN_DECODER_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_DECODER_RDFIFO_MIR_OFFSET (HUFFMAN_DECODER_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_DECODER_RDFIFO_SR_OFFSET (HUFFMAN_DECODER_IPIF_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define HUFFMAN_DECODER_IPIF_RDFIFO_DATA_SPACE_OFFSET (0x00000200)
#define HUFFMAN_DECODER_RDFIFO_DATA_OFFSET (HUFFMAN_DECODER_IPIF_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
#define HUFFMAN_DECODER_IPIF_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define HUFFMAN_DECODER_WRFIFO_RST_OFFSET (HUFFMAN_DECODER_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_DECODER_WRFIFO_MIR_OFFSET (HUFFMAN_DECODER_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define HUFFMAN_DECODER_WRFIFO_SR_OFFSET (HUFFMAN_DECODER_IPIF_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define HUFFMAN_DECODER_IPIF_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define HUFFMAN_DECODER_WRFIFO_DATA_OFFSET (HUFFMAN_DECODER_IPIF_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
 * Write a value to a HUFFMAN_DECODER register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_DECODER_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define HUFFMAN_DECODER_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a HUFFMAN_DECODER register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_DECODER_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define HUFFMAN_DECODER_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read value to/from HUFFMAN_DECODER user logic slave registers.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_DECODER_mReadSlaveRegn(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mWriteSlaveReg0(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_DECODER_SLAVE_REG0_OFFSET), (Xuint32)(Value))
#define HUFFMAN_DECODER_mWriteSlaveReg1(BaseAddress, Value) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_DECODER_SLAVE_REG1_OFFSET), (Xuint32)(Value))

#define HUFFMAN_DECODER_mReadSlaveReg0(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_DECODER_SLAVE_REG0_OFFSET))
#define HUFFMAN_DECODER_mReadSlaveReg1(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_DECODER_SLAVE_REG1_OFFSET))

/**
 *
 * Reset read packet FIFO of HUFFMAN_DECODER to its initial state.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_DECODER_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(HUFFMAN_DECODER_RDFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of HUFFMAN_DECODER read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool HUFFMAN_DECODER_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 HUFFMAN_DECODER_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_DECODER_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define HUFFMAN_DECODER_mReadFIFOOccupancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_DECODER_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK) == RDFIFO_OCC_MASK)

/**
 *
 * Read data from HUFFMAN_DECODER read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 *
 * @return  Data is the data from the read packet FIFO.
 *
 * @note    None.
 *
 * C-style signature:
 * 	Xuint32 HUFFMAN_DECODER_mReadFromFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mReadFromFIFO(BaseAddress) \
 	XIo_In32((BaseAddress) + (HUFFMAN_DECODER_RDFIFO_DATA_OFFSET))

/**
 *
 * Reset write packet FIFO of HUFFMAN_DECODER to its initial state.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_DECODER_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(HUFFMAN_DECODER_WRFIFO_RST_OFFSET), IPIF_RESET)

/**
 *
 * Check status of HUFFMAN_DECODER write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 *
 * @return  Status is the result of status checking.
 *
 * @note    None.
 *
 * C-style signature:
 * 	bool HUFFMAN_DECODER_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 HUFFMAN_DECODER_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define HUFFMAN_DECODER_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_DECODER_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define HUFFMAN_DECODER_mWriteFIFOVacancy(BaseAddress) \
 	((XIo_In32((BaseAddress)+(HUFFMAN_DECODER_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK) == WRFIFO_VAC_MASK)

/**
 *
 * Write data to HUFFMAN_DECODER write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the HUFFMAN_DECODER device.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note    None.
 *
 * C-style signature:
 * 	void HUFFMAN_DECODER_mWriteToFIFO(Xuint32 BaseAddress, Xuint32 Data)
 *
 */
#define HUFFMAN_DECODER_mWriteToFIFO(BaseAddress, Data) \
 	XIo_Out32((BaseAddress) + (HUFFMAN_DECODER_WRFIFO_DATA_OFFSET), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the HUFFMAN_DECODER instance to be worked on.
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
XStatus HUFFMAN_DECODER_SelfTest(void * baseaddr_p);

#endif // HUFFMAN_DECODER_H
