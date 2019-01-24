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
// Filename:          F:\fpga\proj\edk_shift_add_mult\drivers\shift_add_mult_gasket_v1_00_a\src\shift_add_mult_gasket_selftest.c
// Version:           1.00.a
// Description:       Contains a diagnostic self-test function for the shift_add_mult_gasket driver
// Date:              Sun Apr 17 16:39:42 2005 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "vlcpacker_test_harness.h"

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
 * @param   baseaddr_p is the base address of the VLCPACKER_TEST_HARNESS instance to be worked on.
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

#define NUM 500
#define LOOP_COUNT 10000000

XStatus VLCPACKER_TEST_HARNESS_Test1(void * baseaddr_p)
{
   int     Index;
   int     i ;
   Xuint32 baseaddr;
   Xuint8  Reg8Value;
   Xuint16 Reg16Value;
   Xuint32 Reg32Value;

   Xuint32 idata, idata_length ;
   Xuint32 tmpdata ;
   Xuint32 mask ;

   Xuint32 bits_available = 32 ;

   Xuint32 idata_next = 0; 
   Xuint32 idata_shifted = 0 ;

   Xuint32 obuf[NUM] ;

   Xuint32 odata = 0;
   int j;
   int k;

   XASSERT_NONVOID(baseaddr_p != XNULL);
   baseaddr = (Xuint32) baseaddr_p;

   xil_printf("******************************\n\r");
   xil_printf("* User Test1\n\r");
   xil_printf("******************************\n\n\r");

   odata = 0;
   bits_available = 32 ;
   idata_next = 0 ;
   idata_shifted = 0 ;
   idata = 1 ;
   idata_length = 4 ;

  for ( k=0;k<LOOP_COUNT;k++) {
   j = 0;

   if ( !(k % 1000) && k != 0 ) 
   xil_printf("Loop Count = %d \n\r",k);

  for ( i=0;i<NUM;i++) {

    mask = 0xffffffff >> ( 32 - idata_length ) ;
	tmpdata = idata & mask ;

    VLCPACKER_TEST_HARNESS_mWriteToFIFO(baseaddr, tmpdata);
    VLCPACKER_TEST_HARNESS_mWriteToFIFO(baseaddr, idata_length-1);//in vlcpacker length is encoded as len-1
    
    idata_shifted = tmpdata << (32 - bits_available );
    odata |= idata_shifted ;

    if ( bits_available > idata_length ) {
      bits_available -= idata_length ;
    }
    else if ( bits_available < idata_length ) {
      //Output odata
     // printf ("packed data[%d] = 0x%x\n", j,odata );
      obuf[j++] = odata ;
      odata = 0;

      idata_next = tmpdata >> bits_available ;
      bits_available = 32 - (idata_length-bits_available) ;
      odata |= idata_next ;
    }
    else if (bits_available == idata_length) {
      //Output odata
      //printf ("packed data[%d] = 0x%x\n", j,odata);
      obuf[j++] = odata ;
      bits_available = 32 ;
      odata = 0;
    }

    idata = idata + 1 ;
    idata_length = idata_length + 1 ;
    if ( idata_length > 32 ) idata_length = 1 ;

  }

	//xil_printf("Number of packed data = %d \n\r",j);	

  //Read Result
   for ( i = 0; i < j; i++ )
   {
     while ( VLCPACKER_TEST_HARNESS_mReadFIFOEmpty(baseaddr) ) {
       xil_printf("   - read packet FIFO is empty \n\r");       
     }
     
      Reg32Value = VLCPACKER_TEST_HARNESS_mReadFromFIFO(baseaddr);
      //      xil_printf(" Result = %d \n\r", Reg32Value);

      if ( Reg32Value != obuf[i] ) {
	     xil_printf("FAIL: Packed Data = 0x%x (Exp = 0x%x)\n\r", Reg32Value,obuf[i]);
		 return 1;
	  }
    // else
	//xil_printf("PASS: Packed Data = 0x%x \n\r",Reg32Value);
   }

  }//for (k)

   xil_printf("   - END OF TEST \n\n\r");

   return XST_SUCCESS;
}
