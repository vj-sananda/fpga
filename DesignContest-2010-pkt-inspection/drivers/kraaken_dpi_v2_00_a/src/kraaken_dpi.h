//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/kraaken_dpi_v2_00_a/src/kraaken_dpi.h
// Version:           2.00.a
// Description:       kraaken_dpi Driver Header File
// Date:              Tue Mar 30 00:45:02 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef KRAAKEN_DPI_H
#define KRAAKEN_DPI_H

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
 */
#define KRAAKEN_DPI_USER_SLV_SPACE_OFFSET (0x00000000)
#define KRAAKEN_DPI_SLV_REG0_OFFSET (KRAAKEN_DPI_USER_SLV_SPACE_OFFSET + 0x00000000)
#define KRAAKEN_DPI_SLV_REG1_OFFSET (KRAAKEN_DPI_USER_SLV_SPACE_OFFSET + 0x00000004)
#define KRAAKEN_DPI_SLV_REG2_OFFSET (KRAAKEN_DPI_USER_SLV_SPACE_OFFSET + 0x00000008)
#define KRAAKEN_DPI_SLV_REG3_OFFSET (KRAAKEN_DPI_USER_SLV_SPACE_OFFSET + 0x0000000C)

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
#define KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET (0x00000100)
#define KRAAKEN_DPI_INTR_DISR_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000000)
#define KRAAKEN_DPI_INTR_DIPR_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000004)
#define KRAAKEN_DPI_INTR_DIER_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000008)
#define KRAAKEN_DPI_INTR_DIIR_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000018)
#define KRAAKEN_DPI_INTR_DGIER_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define KRAAKEN_DPI_INTR_IPISR_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define KRAAKEN_DPI_INTR_IPIER_OFFSET (KRAAKEN_DPI_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

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
 * Write Packet FIFO Register/Data Space Offsets
 * -- WRFIFO_RST  : write packet fifo reset register
 * -- WRFIFO_SR   : write packet fifo status register
 * -- WRFIFO_DATA : write packet fifo data
 */
#define KRAAKEN_DPI_WRFIFO_REG_SPACE_OFFSET (0x00000200)
#define KRAAKEN_DPI_WRFIFO_RST_OFFSET (KRAAKEN_DPI_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define KRAAKEN_DPI_WRFIFO_SR_OFFSET (KRAAKEN_DPI_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define KRAAKEN_DPI_WRFIFO_DATA_SPACE_OFFSET (0x00000300)
#define KRAAKEN_DPI_WRFIFO_DATA_OFFSET (KRAAKEN_DPI_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
 * Write a value to a KRAAKEN_DPI register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void KRAAKEN_DPI_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define KRAAKEN_DPI_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a KRAAKEN_DPI register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 KRAAKEN_DPI_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define KRAAKEN_DPI_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from KRAAKEN_DPI user logic slave registers.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void KRAAKEN_DPI_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 KRAAKEN_DPI_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define KRAAKEN_DPI_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (KRAAKEN_DPI_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define KRAAKEN_DPI_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (KRAAKEN_DPI_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define KRAAKEN_DPI_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (KRAAKEN_DPI_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define KRAAKEN_DPI_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (KRAAKEN_DPI_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))

#define KRAAKEN_DPI_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (KRAAKEN_DPI_SLV_REG0_OFFSET) + (RegOffset))
#define KRAAKEN_DPI_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (KRAAKEN_DPI_SLV_REG1_OFFSET) + (RegOffset))
#define KRAAKEN_DPI_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (KRAAKEN_DPI_SLV_REG2_OFFSET) + (RegOffset))
#define KRAAKEN_DPI_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (KRAAKEN_DPI_SLV_REG3_OFFSET) + (RegOffset))

/**
 *
 * Reset write packet FIFO of KRAAKEN_DPI to its initial state.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void KRAAKEN_DPI_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define KRAAKEN_DPI_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(KRAAKEN_DPI_WRFIFO_RST_OFFSET), WRFIFO_RESET)

/**
 *
 * Check status of KRAAKEN_DPI write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool KRAAKEN_DPI_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 KRAAKEN_DPI_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define KRAAKEN_DPI_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(KRAAKEN_DPI_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define KRAAKEN_DPI_mWriteFIFOVacancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(KRAAKEN_DPI_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK)

/**
 *
 * Write 32 bit data to KRAAKEN_DPI write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the KRAAKEN_DPI device.
 * @param   DataOffset is the offset from the data port to write to.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void KRAAKEN_DPI_mWriteToFIFO(Xuint32 BaseAddress, unsigned DataOffset, Xuint32 Data)
 *
 */
#define KRAAKEN_DPI_mWriteToFIFO(BaseAddress, DataOffset, Data) \
 	XIo_Out32((BaseAddress) + (KRAAKEN_DPI_WRFIFO_DATA_OFFSET) + (DataOffset), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Enable all possible interrupts from KRAAKEN_DPI device.
 *
 * @param   baseaddr_p is the base address of the KRAAKEN_DPI device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void KRAAKEN_DPI_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the KRAAKEN_DPI device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void KRAAKEN_DPI_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the KRAAKEN_DPI instance to be worked on.
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
XStatus KRAAKEN_DPI_SelfTest(void * baseaddr_p);

#endif // KRAAKEN_DPI_H
