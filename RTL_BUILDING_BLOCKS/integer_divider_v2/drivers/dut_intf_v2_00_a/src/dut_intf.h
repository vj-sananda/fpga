//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\BLOCKS\integer_divider_v2/drivers/dut_intf_v2_00_a/src/dut_intf.h
// Version:           2.00.a
// Description:       dut_intf Driver Header File
// Date:              Fri Dec 10 17:42:26 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#ifndef DUT_INTF_H
#define DUT_INTF_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xio.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 */
#define DUT_INTF_USER_SLV_SPACE_OFFSET (0x00000000)
#define DUT_INTF_SLV_REG0_OFFSET (DUT_INTF_USER_SLV_SPACE_OFFSET + 0x00000000)
#define DUT_INTF_SLV_REG1_OFFSET (DUT_INTF_USER_SLV_SPACE_OFFSET + 0x00000004)

/**
 * Read Packet FIFO Register/Data Space Offsets
 * -- RDFIFO_RST  : read packet fifo reset register
 * -- RDFIFO_SR   : read packet fifo status register
 * -- RDFIFO_DATA : read packet fifo data
 */
#define DUT_INTF_RDFIFO_REG_SPACE_OFFSET (0x00000100)
#define DUT_INTF_RDFIFO_RST_OFFSET (DUT_INTF_RDFIFO_REG_SPACE_OFFSET + 0x00000000)
#define DUT_INTF_RDFIFO_SR_OFFSET (DUT_INTF_RDFIFO_REG_SPACE_OFFSET + 0x00000004)
#define DUT_INTF_RDFIFO_DATA_SPACE_OFFSET (0x00000200)
#define DUT_INTF_RDFIFO_DATA_OFFSET (DUT_INTF_RDFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
#define DUT_INTF_WRFIFO_REG_SPACE_OFFSET (0x00000300)
#define DUT_INTF_WRFIFO_RST_OFFSET (DUT_INTF_WRFIFO_REG_SPACE_OFFSET + 0x00000000)
#define DUT_INTF_WRFIFO_SR_OFFSET (DUT_INTF_WRFIFO_REG_SPACE_OFFSET + 0x00000004)
#define DUT_INTF_WRFIFO_DATA_SPACE_OFFSET (0x00000400)
#define DUT_INTF_WRFIFO_DATA_OFFSET (DUT_INTF_WRFIFO_DATA_SPACE_OFFSET + 0x00000000)

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
 * Write a value to a DUT_INTF register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DUT_INTF_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define DUT_INTF_mWriteReg(BaseAddress, RegOffset, Data) \
 	XIo_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a DUT_INTF register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 DUT_INTF_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DUT_INTF_mReadReg(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from DUT_INTF user logic slave registers.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void DUT_INTF_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 DUT_INTF_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define DUT_INTF_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DUT_INTF_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define DUT_INTF_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	XIo_Out32((BaseAddress) + (DUT_INTF_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))

#define DUT_INTF_mReadSlaveReg0(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DUT_INTF_SLV_REG0_OFFSET) + (RegOffset))
#define DUT_INTF_mReadSlaveReg1(BaseAddress, RegOffset) \
 	XIo_In32((BaseAddress) + (DUT_INTF_SLV_REG1_OFFSET) + (RegOffset))

/**
 *
 * Reset read packet FIFO of DUT_INTF to its initial state.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DUT_INTF_mResetReadFIFO(Xuint32 BaseAddress)
 *
 */
#define DUT_INTF_mResetReadFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(DUT_INTF_RDFIFO_RST_OFFSET), RDFIFO_RESET)

/**
 *
 * Check status of DUT_INTF read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool DUT_INTF_mReadFIFOEmpty(Xuint32 BaseAddress)
 * 	Xuint32 DUT_INTF_mReadFIFOOccupancy(Xuint32 BaseAddress)
 *
 */
#define DUT_INTF_mReadFIFOEmpty(BaseAddress) \
 	((XIo_In32((BaseAddress)+(DUT_INTF_RDFIFO_SR_OFFSET)) & RDFIFO_EMPTY_MASK) == RDFIFO_EMPTY_MASK)
#define DUT_INTF_mReadFIFOOccupancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(DUT_INTF_RDFIFO_SR_OFFSET)) & RDFIFO_OCC_MASK)

/**
 *
 * Read 32 bit data from DUT_INTF read packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 * @param   DataOffset is the offset from the data port to read from.
 *
 * @return  Data is the data from the read packet FIFO.
 *
 * @note
 * C-style signature:
 * 	Xuint32 DUT_INTF_mReadFromFIFO(Xuint32 BaseAddress, unsigned DataOffset)
 *
 */
#define DUT_INTF_mReadFromFIFO(BaseAddress, DataOffset) \
 	XIo_In32((BaseAddress) + (DUT_INTF_RDFIFO_DATA_OFFSET) + (DataOffset))

/**
 *
 * Reset write packet FIFO of DUT_INTF to its initial state.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DUT_INTF_mResetWriteFIFO(Xuint32 BaseAddress)
 *
 */
#define DUT_INTF_mResetWriteFIFO(BaseAddress) \
 	XIo_Out32((BaseAddress)+(DUT_INTF_WRFIFO_RST_OFFSET), WRFIFO_RESET)

/**
 *
 * Check status of DUT_INTF write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 *
 * @return  Status is the result of status checking.
 *
 * @note
 * C-style signature:
 * 	bool DUT_INTF_mWriteFIFOFull(Xuint32 BaseAddress)
 * 	Xuint32 DUT_INTF_mWriteFIFOVacancy(Xuint32 BaseAddress)
 *
 */
#define DUT_INTF_mWriteFIFOFull(BaseAddress) \
 	((XIo_In32((BaseAddress)+(DUT_INTF_WRFIFO_SR_OFFSET)) & WRFIFO_FULL_MASK) == WRFIFO_FULL_MASK)
#define DUT_INTF_mWriteFIFOVacancy(BaseAddress) \
 	(XIo_In32((BaseAddress)+(DUT_INTF_WRFIFO_SR_OFFSET)) & WRFIFO_VAC_MASK)

/**
 *
 * Write 32 bit data to DUT_INTF write packet FIFO module.
 *
 * @param   BaseAddress is the base address of the DUT_INTF device.
 * @param   DataOffset is the offset from the data port to write to.
 * @param   Data is the value to be written to write packet FIFO.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void DUT_INTF_mWriteToFIFO(Xuint32 BaseAddress, unsigned DataOffset, Xuint32 Data)
 *
 */
#define DUT_INTF_mWriteToFIFO(BaseAddress, DataOffset, Data) \
 	XIo_Out32((BaseAddress) + (DUT_INTF_WRFIFO_DATA_OFFSET) + (DataOffset), (Xuint32)(Data))

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the DUT_INTF instance to be worked on.
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
XStatus DUT_INTF_SelfTest(void * baseaddr_p);

#endif // DUT_INTF_H
