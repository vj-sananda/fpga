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
// Filename:          F:\fpga\proj\huffman_decode\drivers\huffman_decoder_v1_00_a\src\huffman_decoder_selftest.c
// Version:           1.00.a
// Description:       Contains a diagnostic self-test function for the huffman_decoder driver
// Date:              Fri Apr 22 16:41:35 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "huffman_decoder.h"

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
XStatus HUFFMAN_DECODER_SelfTest(void * baseaddr_p)
{
   int     Index;
   Xuint32 baseaddr;
   Xuint8  Reg8Value;
   Xuint16 Reg16Value;
   Xuint32 Reg32Value;
   Xuint64 Reg64Value;

   /*
    * Assert the argument
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
   xil_printf("   - write 0 to slave register 0\n\r");
   HUFFMAN_DECODER_mWriteSlaveReg0(baseaddr, 0);
   Reg32Value = HUFFMAN_DECODER_mReadSlaveReg0(baseaddr);
   xil_printf("   - read %d from register 0\n\r", Reg32Value);
   if ( Reg32Value != (Xuint32) 0 )
   {
      xil_printf("   - slave register 0 write/read failed\n\r");
      return XST_FAILURE;
   }
   xil_printf("   - write 1 to slave register 1\n\r");
   HUFFMAN_DECODER_mWriteSlaveReg1(baseaddr, 1);
   Reg32Value = HUFFMAN_DECODER_mReadSlaveReg1(baseaddr);
   xil_printf("   - read %d from register 1\n\r", Reg32Value);
   if ( Reg32Value != (Xuint32) 1 )
   {
      xil_printf("   - slave register 1 write/read failed\n\r");
      return XST_FAILURE;
   }
   xil_printf("   - slave register write/read passed\n\n\r");

   /*
    * Write to write packet FIFO and read back from read packet FIFO
    */
   xil_printf("Packet FIFO test...\n\r");
   xil_printf("   - reset write packet FIFO to initial state \n\r");
   HUFFMAN_DECODER_mResetWriteFIFO(baseaddr);
   xil_printf("   - reset read packet FIFO to initial state \n\r");
   HUFFMAN_DECODER_mResetReadFIFO(baseaddr);
   xil_printf("   - push data to write packet FIFO \n\r");
   for ( Index = 0; Index < 4; Index++ )
   {
      xil_printf("     0x%08x \n\r", Index);
      HUFFMAN_DECODER_mWriteToFIFO(baseaddr, Index);
   }
   xil_printf("   - write packet FIFO is %s \n\r", ( HUFFMAN_DECODER_mWriteFIFOFull(baseaddr) ? "full" : "not full" ));
   Reg32Value = HUFFMAN_DECODER_mWriteFIFOVacancy(baseaddr);
   xil_printf("   - number of entries is %s %d \n\r", ( Reg32Value == (Xuint32) 4 ? "expected" : "unexpected" ), Reg32Value);
   xil_printf("   - pop data out from read packet FIFO \n\r");
   for ( Index = 0; Index < 4; Index++ )
   {
      Reg32Value = HUFFMAN_DECODER_mReadFromFIFO(baseaddr);
      xil_printf("     0x%08x \n\r", Reg32Value);
      if ( Reg32Value != (Xuint32) Index )
      {
         xil_printf("   - unexpected value read from read packet FIFO \n\r");
         xil_printf("   - write/read packet FIFO failed \n\r");
         HUFFMAN_DECODER_mResetWriteFIFO(baseaddr);
         HUFFMAN_DECODER_mResetReadFIFO(baseaddr);
         return XST_FAILURE;
      }
   }
   xil_printf("   - read packet FIFO is %s \n\r", ( HUFFMAN_DECODER_mReadFIFOEmpty(baseaddr) ? "empty" : "not empty" ));
   Reg32Value = HUFFMAN_DECODER_mReadFIFOOccupancy(baseaddr);
   xil_printf("   - number of entries is %s %d \n\r", ( Reg32Value == (Xuint32) 0 ? "expected" : "unexpected" ), Reg32Value);
   HUFFMAN_DECODER_mResetWriteFIFO(baseaddr);
   HUFFMAN_DECODER_mResetReadFIFO(baseaddr);
   xil_printf("   - write/read packet FIFO passed \n\n\r");

   return XST_SUCCESS;
}
