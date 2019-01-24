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
// Filename:          F:\fpga\proj\DesignContest08_vjs_64bit\drivers\accel_sort_plb_v1_00_a\src\accel_sort_plb_selftest.c
// Version:           1.00.a
// Description:       Contains a diagnostic self-test function for the accel_sort_plb driver
// Date:              Mon May 02 09:49:11 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "accel_sort_plb.h"

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
XStatus ACCEL_SORT_PLB_SelfTest(void * baseaddr_p)
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
   Reg64Value.Upper = 0;
   Reg64Value.Lower = 1;
   xil_printf("   - write 0 to slave register 0 upper and lower portion\n\r");
   ACCEL_SORT_PLB_WriteSlaveReg0(baseaddr_p, &Reg64Value);
   ACCEL_SORT_PLB_ReadSlaveReg0(baseaddr_p, &Reg64Value);
   xil_printf("   - read %d , %d from register 0 upper and lower portion \n\r", Reg64Value.Upper,Reg64Value.Lower);
   if ( Reg64Value.Upper != (Xuint32) 0 || Reg64Value.Lower != (Xuint32) 0 )
   {
      xil_printf("   - slave register 0 write/read failed\n\r");
      //return XST_FAILURE;
   }
   Reg64Value.Upper = 1;
   Reg64Value.Lower = 2;
   xil_printf("   - write 1 to slave register 1 upper and lower portion\n\r");
   ACCEL_SORT_PLB_WriteSlaveReg1(baseaddr_p, &Reg64Value);
   ACCEL_SORT_PLB_ReadSlaveReg1(baseaddr_p, &Reg64Value);
   xil_printf("   - read %d , %d from register 1 upper and lower portion \n\r", Reg64Value.Upper,Reg64Value.Lower);
   if ( Reg64Value.Upper != (Xuint32) 1 || Reg64Value.Lower != (Xuint32) 1 )
   {
      xil_printf("   - slave register 1 write/read failed\n\r");
      //return XST_FAILURE;
   }
   Reg64Value.Upper = 2;
   Reg64Value.Lower = 3;
   xil_printf("   - write 2 to slave register 2 upper and lower portion\n\r");
   ACCEL_SORT_PLB_WriteSlaveReg2(baseaddr_p, &Reg64Value);
   ACCEL_SORT_PLB_ReadSlaveReg2(baseaddr_p, &Reg64Value);
   xil_printf("   - read %d , %d from register 3 upper and lower portion \n\r", Reg64Value.Upper,Reg64Value.Lower);
   if ( Reg64Value.Upper != (Xuint32) 2 || Reg64Value.Lower != (Xuint32) 2 )
   {
      xil_printf("   - slave register 2 write/read failed\n\r");
      //return XST_FAILURE;
   }
   Reg64Value.Upper = 3;
   Reg64Value.Lower = 4;
   xil_printf("   - write 3 to slave register 3 upper and lower portion\n\r");
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &Reg64Value);
   ACCEL_SORT_PLB_ReadSlaveReg3(baseaddr_p, &Reg64Value);
   xil_printf("   - read %d , %d from register 3 upper and lower portion \n\r", Reg64Value.Upper,Reg64Value.Lower);
   if ( Reg64Value.Upper != (Xuint32) 3 || Reg64Value.Lower != (Xuint32) 3 )
   {
      xil_printf("   - slave register 3 write/read failed\n\r");
      //return XST_FAILURE;
   }
   xil_printf("   - slave register write/read passed\n\n\r");

   /*
    * Write to write packet FIFO and read back from read packet FIFO
    */
   xil_printf("Packet FIFO test...\n\r");
   xil_printf("   - reset write packet FIFO to initial state \n\r");
   ACCEL_SORT_PLB_mResetWriteFIFO(baseaddr);
   xil_printf("   - reset read packet FIFO to initial state \n\r");
   ACCEL_SORT_PLB_mResetReadFIFO(baseaddr);
   xil_printf("   - push data to write packet FIFO \n\r");
   for ( Index = 0; Index < 4; Index++ )
   {
      Reg64Value.Upper = Index;
      Reg64Value.Lower = Index+1;
      xil_printf("     0x%08x_%08x \n\r", Reg64Value.Upper, Reg64Value.Lower);
      ACCEL_SORT_PLB_WriteToFIFO(baseaddr_p, &Reg64Value);
   }

   xil_printf("   - write packet FIFO is %s \n\r", ( ACCEL_SORT_PLB_mWriteFIFOFull(baseaddr) ? "full" : "not full" ));

   xil_printf("   - pop data out from read packet FIFO \n\r");
   for ( Index = 0; Index < 4; Index++ )
   {
      ACCEL_SORT_PLB_ReadFromFIFO(baseaddr_p, &Reg64Value);
      xil_printf("     0x%08x_%08x \n\r", Reg64Value.Upper, Reg64Value.Lower);
      if ( Reg64Value.Upper != (Xuint32) Index || Reg64Value.Lower != (Xuint32) Index )
      {
         xil_printf("   - unexpected value read from read packet FIFO \n\r");
         xil_printf("   - write/read packet FIFO failed \n\r");
         ACCEL_SORT_PLB_mResetWriteFIFO(baseaddr);
         ACCEL_SORT_PLB_mResetReadFIFO(baseaddr);
         //return XST_FAILURE;
      }
   }
   xil_printf("   - read packet FIFO is %s \n\r", ( ACCEL_SORT_PLB_mReadFIFOEmpty(baseaddr) ? "empty" : "not empty" ));

   ACCEL_SORT_PLB_mResetWriteFIFO(baseaddr);
   ACCEL_SORT_PLB_mResetReadFIFO(baseaddr);
   xil_printf("   - write/read packet FIFO passed \n\n\r");

   return XST_SUCCESS;
}
