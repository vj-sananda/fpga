//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dma/drivers/dpi_verilog_v1_00_a/src/dpi_verilog.h
// Version:           1.00.a
// Description:       dpi_verilog Driver Header File
// Date:              Tue Mar 02 16:37:10 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef DPI_VERILOG_H
#define DPI_VERILOG_H

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
#define DPI_VERILOG_USER_SLV_SPACE_OFFSET (0x00000000)
#define DPI_VERILOG_SLV_REG0_OFFSET (DPI_VERILOG_USER_SLV_SPACE_OFFSET + 0x00000000)
#define DPI_VERILOG_SLV_REG1_OFFSET (DPI_VERILOG_USER_SLV_SPACE_OFFSET + 0x00000004)
#define DPI_VERILOG_SLV_REG2_OFFSET (DPI_VERILOG_USER_SLV_SPACE_OFFSET + 0x00000008)
#define DPI_VERILOG_SLV_REG3_OFFSET (DPI_VERILOG_USER_SLV_SPACE_OFFSET + 0x0000000C)

/**
 * Software Reset Space Register Offsets
 * -- RST : software reset register
 */
#define DPI_VERILOG_SOFT_RST_SPACE_OFFSET (0x00000100)
#define DPI_VERILOG_RST_REG_OFFSET (DPI_VERILOG_SOFT_RST_SPACE_OFFSET + 0x00000000)

/**
 * Software Reset Masks
 * -- SOFT_RESET : software reset
 */
#define SOFT_RESET (0x0000000A)

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
#define DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET (0x00000200)
#define DPI_VERILOG_INTR_DISR_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000000)
#define DPI_VERILOG_INTR_DIPR_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000004)
#define DPI_VERILOG_INTR_DIER_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000008)
#define DPI_VERILOG_INTR_DIIR_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000018)
#define DPI_VERILOG_INTR_DGIER_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x0000001C)
#define DPI_VERILOG_INTR_IPISR_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000020)
#define DPI_VERILOG_INTR_IPIER_OFFSET (DPI_VERILOG_INTR_CNTRL_SPACE_OFFSET + 0x00000028)

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
#define DPI_VERILOG_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define DPI_VERILOG_WRFIFO_RST_OFFSET (DPI_VERILOG_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define DPI_VERILOG_WRFIFO_SR_OFFSET (DPI_VERILOG_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define DPI_VERILOG_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define DPI_VERILOG_WRFIFO_DATA_OFFSET (DPI_VERILOG_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
 * Write a value to a DPI_VERILOG register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DPI_VERILOG_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define DPI_VERILOG_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a DPI_VERILOG register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 DPI_VERILOG_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DPI_VERILOG_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from DPI_VERILOG user logic slave registers.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void DPI_VERILOG_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 DPI_VERILOG_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DPI_VERILOG_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DPI_VERILOG_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DPI_VERILOG_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DPI_VERILOG_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DPI_VERILOG_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DPI_VERILOG_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DPI_VERILOG_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DPI_VERILOG_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))

#define DPI_VERILOG_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DPI_VERILOG_SLV_REG0_OFFSET) + (RegOffset))
#define DPI_VERILOG_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DPI_VERILOG_SLV_REG1_OFFSET) + (RegOffset))
#define DPI_VERILOG_mReadSlaveReg2(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DPI_VERILOG_SLV_REG2_OFFSET) + (RegOffset))
#define DPI_VERILOG_mReadSlaveReg3(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DPI_VERILOG_SLV_REG3_OFFSET) + (RegOffset))

/**
 *
 * Reset DPI_VERILOG via software.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DPI_VERILOG_mReset(Xuint32 BaseAddress)
 *
 */
#define DPI_VERILOG_mReset(BaseAddress) \
 	XIo_Out32((BaseAddress)+(DPI_VERILOG_RST_REG_OFFSET), SOFT_RESET)

/**
 *
 * Reset write packet FIFO of DPI_VERILOG to its initial state.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DPI_VERILOG_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define DPI_VERILOG_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(DPI_VERILOG_WRFIFO_RST_OFFSET), WRFIFO_RESET)

/**
 *
 * Check status of DPI_VERILOG write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool DPI_VERILOG_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 DPI_VERILOG_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define DPI_VERILOG_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(DPI_VERILOG_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define DPI_VERILOG_mWriteFIFOVacancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(DPI_VERILOG_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK)

/**
 *
 * Write 32 bit data to DPI_VERILOG write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DPI_VERILOG device.
 * @param   DataOffset is the offset from the data port to write to.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DPI_VERILOG_mWriteToFIFO(Xuint32 BaseAddress, unsigned DataOffset, Xuint32 Data)
 *
 */
#define DPI_VERILOG_mWriteToFIFO(BaseAddress, DataOffset, Data) \
 	XIo_Out32((BaseAddress) + (DPI_VERILOG_WRFIFO_DATA_OFFSET) + (DataOffset), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Enable all possible interrupts from DPI_VERILOG device.
 *
 * @param   baseaddr_p is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DPI_VERILOG_EnableInterrupt(void * baseaddr_p);

/**
 *
 * Example interrupt controller handler.
 *
 * @param   baseaddr_p is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DPI_VERILOG_Intr_DefaultHandler(void * baseaddr_p);

/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the DPI_VERILOG instance to be worked on.
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
XStatus DPI_VERILOG_SelfTest(void * baseaddr_p);

#endif // DPI_VERILOG_H
