
#include <cstdio>
#define NUM 500
#define LOOP_COUNT 20
#define EOS 0x1f 

int main()
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

  char exp_buf[NUM];
  char exp_value_offset ;
  int j = 0;
  int idx = 0;

   int     Index;
   int     i ;
   int baseaddr;
   int  Reg8Value;
   int Reg16Value;
   int Reg32Value;

   int idata, idata_length ;
   int tmpdata ;
   int mask ;

   int bits_available = 32 ;

   int idata_next = 0; 
   int idata_shifted = 0 ;

   int obuf[NUM] ;

   int odata = 0;
   int k;

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

    //    if ( !(k % 1000) && k != 0 ) 
    //      printf("Loop Count = %d \n\r",k);

    for (i=1; i <= NUM; i++) {

      lfsr = (lfsr >> 1) ^ (-(signed int)(lfsr & 1) & 0xd0000001u); /* taps 32 31 29 1 */
      
      //if ( idx >=8 ) idx =0 ;
      idx = lfsr % 8 ; //Randomly generate 0 thru 7
      if ( i==NUM ) idx = 8;//Set EOS
      exp_buf[j++] = idx ;

      idata = huffman_code[idx];
      idata_length = huffman_code_length[idx];
      printf ( "idx = %d\n", idx);
      idx++;

      //    ibuf_length[i] = (random() % 8) + 1;
      //    ibuf_length[i] *= 4 ;
      //    ibuf[i] = random() & (0xffffffff >> (32 - ibuf_length[i]));
      
      //   idata = ibuf[i];
      //    idata_length = ibuf_length[i];
      
      mask    = 0xffffffff >> ( 32 - idata_length ) ;
      tmpdata = idata & mask ;

      //    idata = tmpdata ;
      //printf("idata = 0x%x, len = %d, mask = 0x%x, tmpdata = 0x%x\n",
      //idata,idata_length,mask,tmpdata);
      if ( bits_available == 32 ) {
	odata  |= tmpdata ;
	bits_available -= idata_length ;
	if ( tmpdata == EOS ) {
	  odata <<= 27 ;
	  printf ("packed data[E] = 0x%08x\n", odata );
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
	    printf ("packed data[E] = 0x%08x\n", odata );
	    odata = 0;
	    bits_available = 32;
	  }
	}
	else 
	  if ( bits_available < idata_length) {
	    odata <<= bits_available ;
	    idata_shifted = tmpdata >> ( idata_length - bits_available);
	    odata |= idata_shifted;
	    printf ("packed data[-] = 0x%08x\n", odata );
	    idata_next = tmpdata & (~( 0xffffffff << (idata_length-bits_available)));
	    odata = 0;
	    odata |= idata_next ;
	    bits_available = 32 - (idata_length-bits_available);
	    if ( tmpdata == EOS ) {
	    odata <<= bits_available ;
	      printf ("packed data[E] = 0x%08x\n", odata );
	      odata = 0;
	      bits_available = 32;
	    }
	  }
	  else 
	    if ( bits_available == idata_length ) {
	      odata <<= idata_length ;
	      odata  |= tmpdata ;	
	      printf ("packed data[A] = 0x%08x\n", odata);
	      odata = 0;
	      bits_available = 32 ;
	    }
    }

  }//for (k)

  return 0;
}
