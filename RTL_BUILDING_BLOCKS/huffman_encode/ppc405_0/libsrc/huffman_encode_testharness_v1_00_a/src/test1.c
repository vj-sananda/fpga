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
#define LOOP_COUNT 10000000
#define EOS 0x1f 

XStatus HUFFMAN_ENCODE_TESTHARNESS_Test1(void * baseaddr_p)
{
  int huffman_code[] = { 
    0x4,  //3'b100
    0x1e, //5'b11110,
    0xc,  //4'b1100,
    0x5,  //3'b101,
    0x0,  //2'b00,
    0xd,  //4'b1101,
    0xe,  //4'b1110,
    0x1,  //2'b01,
    0x1f  //5'b11111
  } ;

  int huffman_code_length[] = {
    3,//A
    5,//B
    4,//C
    3,//D
    2,//E
    4,//F
    4,//G
    2,//H
    5 //EOS-End Of Stream
  } ;

  int exp_buf[NUM];
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

   Xuint32 obuf[NUM] ;

   Xuint32 odata = 0;
   int k;
   int num_packed_words = 0;
   int i_cnt = 0;

   XASSERT_NONVOID(baseaddr_p != XNULL);
   baseaddr = (Xuint32) baseaddr_p;

   xil_printf("******************************\n\r");
   xil_printf("* User Huffman Encoder Test1\n\r");
   xil_printf("******************************\n\n\r");

   odata = 0;
   bits_available = 32 ;
   idata_next = 0 ;
   idata_shifted = 0 ;
   
   idata = huffman_code[0] ;
   idata_length = huffman_code_length[0] ;
   exp_value_offset = 0;
   
   unsigned int lfsr = 1;
   
  for ( k=0;k<LOOP_COUNT;k++) {
    j = 0;
    num_packed_words = 0;
    i_cnt = lfsr % NUM + 1;
  //  i_cnt = NUM ;

    if ( !(k % 1000) && k != 0 ) 
      xil_printf("Loop Count = %d, NUM = %d \n\r",k,i_cnt);

    HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg0(baseaddr,0);
    HUFFMAN_ENCODE_TESTHARNESS_mWriteSlaveReg1(baseaddr,0);

    for (i=1; i <= i_cnt; i++) {

      lfsr = (lfsr >> 1) ^ (-(signed int)(lfsr & 1) & 0xd0000001u); /* taps 32 31 29 1 */
      
      //if ( idx >=8 ) idx =0 ;
      idx = lfsr % 8 ; //Randomly generate 0 thru 7
      if ( i == i_cnt ) idx = 8;//Set EOS

      idata        = huffman_code[idx];
      idata_length = huffman_code_length[idx];
      HUFFMAN_ENCODE_TESTHARNESS_mWriteToFIFO(baseaddr, idx);
      idx++;
      
      mask    = 0xffffffff >> ( 32 - idata_length ) ;
      tmpdata = idata & mask ;

      //    idata = tmpdata ;
      //printf("idata = 0x%x, len = %d, mask = 0x%x, tmpdata = 0x%x\n",
      //     idata,idata_length,mask,tmpdata);

      if ( bits_available == 32 ) {
	odata  |= tmpdata ;
	bits_available -= idata_length ;
	if ( tmpdata == EOS ) {
	  odata <<= 27 ;
	    exp_buf[j++] = odata ;

	    num_packed_words++;
	    odata = 0;
	    bits_available = 32;
	}
      }
      else
	if ( bits_available > idata_length ) {
	  odata <<= idata_length ;
	  odata  |= tmpdata ;	
	  bits_available -= idata_length ;
	  if ( tmpdata == EOS ) {
	    odata <<= bits_available ;
	    exp_buf[j++] = odata ;

	    num_packed_words++;
	    odata = 0;
	    bits_available = 32;
	  }
	}
	else 
	  if ( bits_available < idata_length) {
	    odata <<= bits_available ;
	    idata_shifted = tmpdata >> ( idata_length - bits_available);
	    odata |= idata_shifted;
	    //printf ("packed data[-] = 0x%08x\n", odata );
	    exp_buf[j++] = odata ;

	    num_packed_words++;
	    idata_next = tmpdata & (~( 0xffffffff << (idata_length-bits_available)));
	    odata = 0;
	    odata |= idata_next ;
	    bits_available = 32 - (idata_length-bits_available);
	    if ( tmpdata == EOS ) {
	    odata <<= bits_available ;
	      exp_buf[j++] = odata ;

	      num_packed_words++;
	      odata = 0;
	      bits_available = 32;
	    }
	  }
	  else 
	    if ( bits_available == idata_length ) {
	      odata <<= idata_length ;
	      odata  |= tmpdata ;	
	      //printf ("packed data[A] = 0x%08x\n", odata);	    
	      exp_buf[j++] = odata ;

	      num_packed_words++;
	      odata = 0;
	      bits_available = 32 ;
	    }
    }

    for ( i=0 ; i < j ;i++) {

//       Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadFIFOOccupancy(baseaddr);
//       xil_printf(" Packet FIFO occupancy = %d\n\r",Reg32Value);
      
      //Read Result
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

      Reg32Value = HUFFMAN_ENCODE_TESTHARNESS_mReadFromFIFO(baseaddr);
      //      xil_printf(" Result = %d \n\r", Reg32Value);

      if ( Reg32Value == exp_buf[i] ) 
	//if ( Reg32Value == exp_value_offset  )
    ;//  	xil_printf("PASS[%d]: Encoded Value = 0x%x\n\r",i, Reg32Value );
      else {
	    xil_printf("FAIL: Encoded Value = 0x%x (Exp = 0x%x)\n\r", Reg32Value, exp_buf[i]);
	    xil_printf("******* DIAG FAILED *******\n");
	    return XST_FAILURE;
      }

      exp_value_offset++ ;
      if ( exp_value_offset > 7 ) exp_value_offset = 0;
      
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

  }//for (k)

   xil_printf("   - END OF TEST \n\n\r");

   return XST_SUCCESS;
}
