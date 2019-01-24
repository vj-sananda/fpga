#include "huffman_encode_testharness.h"

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

#define NUM 500
#define LOOP_COUNT 1
#define EOS 0x1f 

XStatus HUFFMAN_ENCODE_TESTHARNESS_Test1(void * baseaddr_p)
{

  char exp_value_offset ;
  int j = 0;
  int idx = 0;

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

   Xuint32 odata = 0;
   int k;
   int num_packed_words = 0;
   int i_cnt = 0;

   XASSERT_NONVOID(baseaddr_p != XNULL);
   baseaddr = (Xuint32) baseaddr_p;

   xil_printf("******************************\n\r");
   xil_printf("* Integer Divider Test1\n\r");
   xil_printf("******************************\n\n\r");

   odata = 0;
   
   unsigned int lfsr = 1;
   unsigned char dividend ;
   unsigned char divisor ;
  for ( k=0;k<LOOP_COUNT;k++) {

    if ( !(k % 1000) && k != 0 ) 
      xil_printf("Loop Count = %d, NUM = %d \n\r",k,i_cnt);

    HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg0(baseaddr,0);
    HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg1(baseaddr,0);

    lfsr = (lfsr >> 1) ^ (-(signed int)(lfsr & 1) & 0xd0000001u); /* taps 32 31 29 1 */
    lfsr = ~lfsr ;
    xil_printf(" lfsr = 0x%x \n\r", lfsr);

    dividend = (lfsr % 256) + 1 ;
    lfsr >>= 16 ;

    xil_printf(" lfsr>>16 = 0x%x \n\r", lfsr);
    divisor = (lfsr % dividend) + 1;
    
    xil_printf(" Dividend = %d , Divisor = %d \n\r", dividend , divisor);
      
    idata = (dividend << 8) | divisor ;

    HUFFMAN_ENCODE_TESTHARNESS_mWriteToFIFO(baseaddr, idata);
      

    //       Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOOccupancy(baseaddr);
    //       xil_printf(" Packet FIFO occupancy = %d\n\r",Reg32Value);
      
    //Read Result
    /*
      while ( HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOEmpty(baseaddr) ) {
	xil_printf("   - read packet FIFO is empty \n\r");
	
	xil_printf("Encoded %d values into %d packed dwords\n\r",
		   i_cnt,j);       
	       
	Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg0(baseaddr);
	xil_printf("** Number of Pops   = %d\n\r",Reg32Value);
	       
	Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg1(baseaddr);
 	xil_printf("** Number of Pushes = %d\n\r",Reg32Value);       
	
	return XST_FAILURE ;
      }
    */

    while ( HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOEmpty(baseaddr) ) {
      xil_printf("   - read packet FIFO is empty \n\r");
    }

    Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadFromFIFO(baseaddr);
    xil_printf(" Result = %d , Quotient = %d, Remainder = %d\n\r",
	       Reg32Value,Reg32Value & 0x0ff, (Reg32Value >> 8) & 0x0ff);

    /*
      if ( Reg32Value == exp_buf[i] ) 
      //if ( Reg32Value == exp_value_offset  )
      ;//  	xil_printf("PASS[%d]: Encoded Value = 0x%x\n\r",i, Reg32Value );
      else {
      xil_printf("FAIL: Encoded Value = 0x%x (Exp = 0x%x)\n\r", Reg32Value, exp_buf[i]);
	xil_printf("******* DIAG FAILED *******\n");
	return XST_FAILURE;
	}
      */
    
    /*
      xil_printf("Encoded %d values into %d packed dwords\n\r",
      i_cnt,j);       

      Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg0(baseaddr);
      xil_printf("** Number of Pops   = %d\n\r",Reg32Value);
      
      Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadSlaveReg1(baseaddr);
      xil_printf("** Number of Pushes = %d\n\r",Reg32Value);  
	  */
    
    // else
    //xil_printf("PASS: Packed Data = 0x%x \n\r",Reg32Value);
  }

   xil_printf("   - END OF TEST \n\n\r");

   return XST_SUCCESS;
}
