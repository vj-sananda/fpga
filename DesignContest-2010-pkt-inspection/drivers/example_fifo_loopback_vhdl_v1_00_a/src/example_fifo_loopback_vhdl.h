//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/example_fifo_loopback_vhdl_v1_00_a/src/example_fifo_loopback_vhdl.h
// Version:           1.00.a
// Description:       example_fifo_loopback_vhdl Driver Header File
// Date:              Tue Mar 30 10:52:59 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef EXAMPLE_FIFO_LOOPBACK_VHDL_H
#define EXAMPLE_FIFO_LOOPBACK_VHDL_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 * -- SLV_REG8 : user logic slave module register 8
 * -- SLV_REG9 : user logic slave module register 9
 * -- SLV_REG10 : user logic slave module register 10
 * -- SLV_REG11 : user logic slave module register 11
 * -- SLV_REG12 : user logic slave module register 12
 * -- SLV_REG13 : user logic slave module register 13
 * -- SLV_REG14 : user logic slave module register 14
 * -- SLV_REG15 : user logic slave module register 15
 * -- SLV_REG16 : user logic slave module register 16
 * -- SLV_REG17 : user logic slave module register 17
 * -- SLV_REG18 : user logic slave module register 18
 * -- SLV_REG19 : user logic slave module register 19
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET (0x00000000)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG0_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000000)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG1_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000004)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG2_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000008)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG3_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG4_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000010)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG5_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000014)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG6_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000018)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG7_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG8_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000020)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG9_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000024)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG10_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000028)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG11_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG12_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000030)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG13_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000034)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG14_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000038)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG15_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x0000003C)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG16_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000040)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG17_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000044)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG18_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x00000048)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG19_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_USER_SLV_SPACE_OFFSET + 0x0000004C)

/**
 * Interrupt Controller Space Offsets
 * -- INTR_DISR  : device (peripheral) interrupt status register
 * -- INTR_DIPR  : device (peripheral) interrupt pending register
 * -- INTR_DIER  : device (peripheral) interrupt enable register
 * -- INTR_DIIR  : device (peripheral) interrupt id (priority encoder) register
 * -- INTR_DGIER : device (peripheral) global interrupt enable register
 * -- INTR_ISR   : ip (user logic) interrupt status register
 * -- INTR_IER   : ip (user logic) interrupt enable register
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET (0x00000100)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DISR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000000)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DIPR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000004)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DIER_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000008)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DIIR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000018)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DGIER_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPISR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPIER_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

/**
 * Interrupt Controller Masks
 * -- INTR_TERR_MASK : transaction error
 * -- INTR_DPTO_MASK : data phase time-out
 * -- INTR_IPIR_MASK : ip interrupt requeset
 * -- INTR_RFDL_MASK : read packet fifo deadlock interrupt request
 * -- INTR_WFDL_MASK : write packet fifo deadlock interrupt request
 * -- INTR_IID_MASK  : interrupt id
 * -- INTR_GIE_MASK  : global interrupt enable
 * -- INTR_NOPEND    : the DIPR has no pending interrupts
 */
#define INTR_TERR_MASK (0x00000001UL)
#define INTR_DPTO_MASK (0x00000002UL)
#define INTR_IPIR_MASK (0x00000004UL)
#define INTR_RFDL_MASK (0x00000020UL)
#define INTR_WFDL_MASK (0x00000040UL)
#define INTR_IID_MASK (0x000000FFUL)
#define INTR_GIE_MASK (0x80000000UL)
#define INTR_NOPEND (0x80)

/**
 * Read Packet FIFO Register/Data Space Offsets
 * -- RDFIFO_RST  : read packet fifo reset register
 * -- RDFIFO_SR   : read packet fifo status register
 * -- RDFIFO_DATA : read packet fifo data
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_REG_SPACE_OFFSET (0x00000200)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_RST_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_SR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_DATA_SPACE_OFFSET (0x00000300)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_DATA_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * Read Packet FIFO Masks
 * -- RDFIFO_EMPTY_MASK : read packet fifo empty condition
 * -- RDFIFO_AE_MASK    : read packet fifo almost empty condition
 * -- RDFIFO_DL_MASK    : read packet fifo deadlock condition
 * -- RDFIFO_SCL_MASK   : read packet fifo occupancy scaling enabled
 * -- RDFIFO_WIDTH_MASK : read packet fifo encoded data port width
 * -- RDFIFO_OCC_MASK   : read packet fifo occupancy
 * -- RDFIFO_RESET      : read packet fifo reset
 */
#define RDFIFO_EMPTY_MASK (0x80000000UL)
#define RDFIFO_AE_MASK (0x40000000UL)
#define RDFIFO_DL_MASK (0x20000000UL)
#define RDFIFO_SCL_MASK (0x10000000UL)
#define RDFIFO_WIDTH_MASK (0x0E000000UL)
#define RDFIFO_OCC_MASK (0x01FFFFFFUL)
#define RDFIFO_RESET (0x0000000A)

/**
 * Write Packet FIFO Register/Data Space Offsets
 * -- WRFIFO_RST  : write packet fifo reset register
 * -- WRFIFO_SR   : write packet fifo status register
 * -- WRFIFO_DATA : write packet fifo data
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_REG_SPACE_OFFSET (0x00000400)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_RST_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_SR_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_DATA_SPACE_OFFSET (0x00000500)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_DATA_OFFSET (EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

/**
 * Write Packet FIFO Masks
 * -- WRFIFO_FULL_MASK  : write packet fifo full condition
 * -- WRFIFO_AF_MASK    : write packet fifo almost full condition
 * -- WRFIFO_DL_MASK    : write packet fifo deadlock condition
 * -- WRFIFO_SCL_MASK   : write packet fifo vacancy scaling enabled
 * -- WRFIFO_WIDTH_MASK : write packet fifo encoded data port width
 * -- WRFIFO_DREP_MASK  : write packet fifo DRE present
 * -- WRFIFO_VAC_MASK   : write packet fifo vacancy
 * -- WRFIFO_RESET      : write packet fifo reset
 */
#define WRFIFO_FULL_MASK (0x80000000UL)
#define WRFIFO_AF_MASK (0x40000000UL)
#define WRFIFO_DL_MASK (0x20000000UL)
#define WRFIFO_SCL_MASK (0x10000000UL)
#define WRFIFO_WIDTH_MASK (0x0E000000UL)
#define WRFIFO_DREP_MASK (0x01000000UL)
#define WRFIFO_VAC_MASK (0x00FFFFFFUL)
#define WRFIFO_RESET (0x0000000A)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a EXAMPLE_FIFO_LOOPBACK_VHDL register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a EXAMPLE_FIFO_LOOPBACK_VHDL register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from EXAMPLE_FIFO_LOOPBACK_VHDL user logic slave registers.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg10(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG10_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg11(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG11_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg12(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG12_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg13(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG13_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg14(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG14_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg15(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG15_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg16(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG16_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg17(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG17_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg18(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG18_OFFSET) + (RegOffset), (Xuint32)(Value))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg19(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG19_OFFSET) + (RegOffset), (Xuint32)(Value))

#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG0_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG1_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG2_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG3_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg4(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG4_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg5(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG5_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg6(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG6_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg7(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG7_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg8(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG8_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg9(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG9_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg10(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG10_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg11(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG11_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg12(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG12_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg13(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG13_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg14(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG14_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg15(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG15_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg16(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG16_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg17(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG17_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg18(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG18_OFFSET) + (RegOffset))
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg19(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_SLV_REG19_OFFSET) + (RegOffset))

/**
 *
 * Reset read packet FIFO of EXAMPLE_FIFO_LOOPBACK_VHDL to its initial state.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXAMPLE_FIFO_LOOPBACK_VHDL_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_RST_OFFSET), RDFIFO_RESET)

/**
 *
 * Check status of EXAMPLE_FIFO_LOOPBACK_VHDL read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFIFOOccupancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK)

/**
 *
 * Read 32 bit data from EXAMPLE_FIFO_LOOPBACK_VHDL read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * @param   DataOffset is the offset from the data port to read from.
 *
 * @return  Data is the data from the read packet FIFO.
 *
 * @note
 * C-style signature:
 * 	Xuint32 EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFromFIFO(Xuint32 BaseAddress, unsigned DataOffset)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFromFIFO(BaseAddress, DataOffset) \
 	XIo_In32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_RDFIFO_DATA_OFFSET) + (DataOffset))

/**
 *
 * Reset write packet FIFO of EXAMPLE_FIFO_LOOPBACK_VHDL to its initial state.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXAMPLE_FIFO_LOOPBACK_VHDL_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_RST_OFFSET), WRFIFO_RESET)

/**
 *
 * Check status of EXAMPLE_FIFO_LOOPBACK_VHDL write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteFIFOVacancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK)

/**
 *
 * Write 32 bit data to EXAMPLE_FIFO_LOOPBACK_VHDL write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * @param   DataOffset is the offset from the data port to write to.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteToFIFO(Xuint32 BaseAddress, unsigned DataOffset, Xuint32 Data)
 *
 */
#define EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteToFIFO(BaseAddress, DataOffset, Data) \
 	XIo_Out32((BaseAddress) + (EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_DATA_OFFSET) + (DataOffset), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Enable all possible interrupts from EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @param   baseaddr_p is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EXAMPLE_FIFO_LOOPBACK_VHDL_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EXAMPLE_FIFO_LOOPBACK_VHDL_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL instance to be worked on.
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
XStatus EXAMPLE_FIFO_LOOPBACK_VHDL_SelfTest(void * baseaddr_p);

#endif // EXAMPLE_FIFO_LOOPBACK_VHDL_H
