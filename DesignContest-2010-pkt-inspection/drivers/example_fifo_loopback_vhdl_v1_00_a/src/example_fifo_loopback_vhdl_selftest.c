//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/example_fifo_loopback_vhdl_v1_00_a/src/example_fifo_loopback_vhdl_selftest.c
// Version:           1.00.a
// Description:       Contains a diagnostic self-test function for the example_fifo_loopback_vhdl driver
// Date:              Tue Mar 30 10:52:59 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "example_fifo_loopback_vhdl.h"

/************************** Constant Definitions ***************************/


/************************** Variable Definitions ****************************/


/************************** Function Definitions ***************************/

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
XStatus EXAMPLE_FIFO_LOOPBACK_VHDL_SelfTest(void * baseaddr_p)
{
  int     Index;
  Xuint32 baseaddr;
  Xuint8  Reg8Value;
  Xuint16 Reg16Value;
  Xuint32 Reg32Value;
  
  /*
   * Check and get the device address
   */
  XASSERT_NONVOID(baseaddr_p != XNULL);
  baseaddr = (Xuint32) baseaddr_p;

  xil_printf("******************************\n\r");
  xil_printf("* User Peripheral Self Test\n\r");
  xil_printf("******************************\n\n\r");

  /*
   * Write to user logic slave module register(s) and read back
   */
  xil_printf("User logic slave module test...\n\r");
  xil_printf("   - write 1 to slave register 0 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg0(baseaddr, 0, 1);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg0(baseaddr, 0);
  xil_printf("   - read %d from register 0 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 1 )
  {
    xil_printf("   - slave register 0 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 2 to slave register 1 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg1(baseaddr, 0, 2);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg1(baseaddr, 0);
  xil_printf("   - read %d from register 1 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 2 )
  {
    xil_printf("   - slave register 1 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 3 to slave register 2 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg2(baseaddr, 0, 3);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg2(baseaddr, 0);
  xil_printf("   - read %d from register 2 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 3 )
  {
    xil_printf("   - slave register 2 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 4 to slave register 3 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg3(baseaddr, 0, 4);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg3(baseaddr, 0);
  xil_printf("   - read %d from register 3 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 4 )
  {
    xil_printf("   - slave register 3 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 5 to slave register 4 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg4(baseaddr, 0, 5);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg4(baseaddr, 0);
  xil_printf("   - read %d from register 4 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 5 )
  {
    xil_printf("   - slave register 4 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 6 to slave register 5 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg5(baseaddr, 0, 6);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg5(baseaddr, 0);
  xil_printf("   - read %d from register 5 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 6 )
  {
    xil_printf("   - slave register 5 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 7 to slave register 6 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg6(baseaddr, 0, 7);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg6(baseaddr, 0);
  xil_printf("   - read %d from register 6 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 7 )
  {
    xil_printf("   - slave register 6 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 8 to slave register 7 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg7(baseaddr, 0, 8);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg7(baseaddr, 0);
  xil_printf("   - read %d from register 7 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 8 )
  {
    xil_printf("   - slave register 7 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 9 to slave register 8 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg8(baseaddr, 0, 9);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg8(baseaddr, 0);
  xil_printf("   - read %d from register 8 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 9 )
  {
    xil_printf("   - slave register 8 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 10 to slave register 9 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg9(baseaddr, 0, 10);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg9(baseaddr, 0);
  xil_printf("   - read %d from register 9 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 10 )
  {
    xil_printf("   - slave register 9 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 11 to slave register 10 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg10(baseaddr, 0, 11);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg10(baseaddr, 0);
  xil_printf("   - read %d from register 10 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 11 )
  {
    xil_printf("   - slave register 10 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 12 to slave register 11 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg11(baseaddr, 0, 12);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg11(baseaddr, 0);
  xil_printf("   - read %d from register 11 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 12 )
  {
    xil_printf("   - slave register 11 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 13 to slave register 12 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg12(baseaddr, 0, 13);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg12(baseaddr, 0);
  xil_printf("   - read %d from register 12 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 13 )
  {
    xil_printf("   - slave register 12 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 14 to slave register 13 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg13(baseaddr, 0, 14);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg13(baseaddr, 0);
  xil_printf("   - read %d from register 13 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 14 )
  {
    xil_printf("   - slave register 13 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 15 to slave register 14 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg14(baseaddr, 0, 15);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg14(baseaddr, 0);
  xil_printf("   - read %d from register 14 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 15 )
  {
    xil_printf("   - slave register 14 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 16 to slave register 15 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg15(baseaddr, 0, 16);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg15(baseaddr, 0);
  xil_printf("   - read %d from register 15 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 16 )
  {
    xil_printf("   - slave register 15 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 17 to slave register 16 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg16(baseaddr, 0, 17);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg16(baseaddr, 0);
  xil_printf("   - read %d from register 16 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 17 )
  {
    xil_printf("   - slave register 16 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 18 to slave register 17 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg17(baseaddr, 0, 18);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg17(baseaddr, 0);
  xil_printf("   - read %d from register 17 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 18 )
  {
    xil_printf("   - slave register 17 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 19 to slave register 18 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg18(baseaddr, 0, 19);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg18(baseaddr, 0);
  xil_printf("   - read %d from register 18 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 19 )
  {
    xil_printf("   - slave register 18 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - write 20 to slave register 19 word 0\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteSlaveReg19(baseaddr, 0, 20);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadSlaveReg19(baseaddr, 0);
  xil_printf("   - read %d from register 19 word 0\n\r", Reg32Value);
  if ( Reg32Value != (Xuint32) 20 )
  {
    xil_printf("   - slave register 19 word 0 write/read failed\n\r");
    return XST_FAILURE;
  }
  xil_printf("   - slave register write/read passed\n\n\r");

  /*
   * Write to the Write Packet FIFO and read back from the Read Packet FIFO
   */
  xil_printf("Packet FIFO test...\n\r");
  xil_printf("   - reset write packet FIFO to initial state\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mResetWriteFIFO(baseaddr);
  xil_printf("   - reset read packet FIFO to initial state \n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mResetReadFIFO(baseaddr);
  xil_printf("   - push data to write packet FIFO\n\r");
  for ( Index = 0; Index < 4; Index++ )
  {
    xil_printf("     0x%08x", Index*1+1);
    EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteToFIFO(baseaddr, 0, Index*1+1);
    xil_printf("\n\r");
  }
  xil_printf("   - write packet FIFO is %s\n\r", ( EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteFIFOFull(baseaddr) ? "full" : "not full" ));
  xil_printf("   - pop data out from read packet FIFO\n\r");
  for ( Index = 0; Index < 4; Index++ )
  {
    Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFromFIFO(baseaddr, 0);
    xil_printf("     0x%08x", Reg32Value);
    if ( Reg32Value != (Xuint32) Index*1+1 )
    {
      xil_printf("\n\r");
      xil_printf("   - unexpected value read from read packet FIFO\n\r");
      xil_printf("   - write/read packet FIFO failed\n\r");
      EXAMPLE_FIFO_LOOPBACK_VHDL_mResetWriteFIFO(baseaddr);
      EXAMPLE_FIFO_LOOPBACK_VHDL_mResetReadFIFO(baseaddr);
      return XST_FAILURE;
    }
    xil_printf("\n\r");
  }
  xil_printf("   - read packet FIFO is %s\n\r", ( EXAMPLE_FIFO_LOOPBACK_VHDL_mReadFIFOEmpty(baseaddr) ? "empty" : "not empty" ));
  EXAMPLE_FIFO_LOOPBACK_VHDL_mResetWriteFIFO(baseaddr);
  EXAMPLE_FIFO_LOOPBACK_VHDL_mResetReadFIFO(baseaddr);
  xil_printf("   - write/read packet FIFO passed \n\n\r");

  /*
   * Enable all possible interrupts and clear interrupt status register(s)
   */
  xil_printf("Interrupt controller test...\n\r");
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPISR_OFFSET);
  xil_printf("   - IP (user logic) interrupt status : 0x%08x\n\r", Reg32Value);
  xil_printf("   - clear IP (user logic) interrupt status register\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPISR_OFFSET, Reg32Value);
  Reg32Value = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DISR_OFFSET);
  xil_printf("   - Device (peripheral) interrupt status : 0x%08x\n\r", Reg32Value);
  xil_printf("   - clear Device (peripheral) interrupt status register\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DISR_OFFSET, Reg32Value);
  xil_printf("   - enable all possible interrupt(s)\n\r");
  EXAMPLE_FIFO_LOOPBACK_VHDL_EnableInterrupt(baseaddr_p);
  xil_printf("   - write/read interrupt register passed\n\n\r");

  return XST_SUCCESS;
}
