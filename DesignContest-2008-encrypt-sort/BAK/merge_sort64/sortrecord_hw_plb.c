#include "sortrecord_hw_plb.h"

extern RECORD   db[MAXRECORD];
extern RECORD   PlainTxtdb[MAXRECORD];
extern RECORD   Mergeddb[MAXRECORD];

void sortrecord_hw_plb(const unsigned char * gkey) {
  int num_fifo_fills ;
  int i ,j;
  int records_per_fill ;
  RECORD r ;
  set_global_key( XPAR_ACCEL_SORT_PLB_0_BASEADDR, gkey);

  //get_global_key(XPAR_ACCEL_SORT_PLB_0_BASEADDR );

  set_start_index( XPAR_ACCEL_SORT_PLB_0_BASEADDR, 0);

  //get_start_index(XPAR_ACCEL_SORT_PLB_0_BASEADDR );

  //Enable zero_key bit and no compare
  //write_control_reg( XPAR_ACCEL_SORT_PLB_0_BASEADDR, 0x7 );

  //  get_control_reg(XPAR_ACCEL_SORT_PLB_0_BASEADDR );

  num_fifo_fills = MAXRECORD/64 ;
  if ( num_fifo_fills == 0 ) num_fifo_fills =1 ;
  
  if ( MAXRECORD < 64 ) records_per_fill = MAXRECORD ;
  else records_per_fill = 64 ;

  //Loop to decrypt and blocksort records 2 at a time
  for ( i=0;i<num_fifo_fills;i++) {

    for( j=0; j<records_per_fill; j++ ) {

      r.f1 = db[ i*records_per_fill + j ].f1;
      r.f2 = db[ i*records_per_fill + j ].f2;
      r.f3 = db[ i*records_per_fill + j ].f3;
      r.f4 = db[ i*records_per_fill + j ].f4;

      write_record_into_fifo( &r, (void *)XPAR_ACCEL_SORT_PLB_0_BASEADDR);
    }

    for( j=0; j<records_per_fill; j++ ) {

      while ( ACCEL_SORT_PLB_mReadFIFOEmpty(XPAR_ACCEL_SORT_PLB_0_BASEADDR) ) {
	xil_printf("**** read fifo empty ********\n\r");
      }

      read_record_from_fifo( &r, (void *)XPAR_ACCEL_SORT_PLB_0_BASEADDR) ;

      PlainTxtdb[ i*records_per_fill + j ].f1 = r.f1;
      PlainTxtdb[ i*records_per_fill + j ].f2 = r.f2;
      PlainTxtdb[ i*records_per_fill + j ].f3 = r.f3;
      PlainTxtdb[ i*records_per_fill + j ].f4 = r.f4;
    }
  }//for i

  //Now invoke pure software mergesort
  //blocksize is 2.
  merge_all_sorted_blocks(BLOCKSIZE);

  //printdb( PlainTxtdb, 0,MAXRECORD-1);

  //Encryption pass
  set_start_index( XPAR_ACCEL_SORT_PLB_0_BASEADDR, 0);

  //Reset index
  write_control_reg( XPAR_ACCEL_SORT_PLB_0_BASEADDR, 0x2 );

  //enable no compare bit
  write_control_reg( XPAR_ACCEL_SORT_PLB_0_BASEADDR, 0x1 );
  
  //Loop to encrypt and write out result data
  for ( i=0;i<num_fifo_fills;i++) {
    for( j=0; j<records_per_fill; j++ ) {

      r.f1 = PlainTxtdb[ i*records_per_fill + j ].f1;
      r.f2 = PlainTxtdb[ i*records_per_fill + j ].f2;
      r.f3 = PlainTxtdb[ i*records_per_fill + j ].f3;
      r.f4 = PlainTxtdb[ i*records_per_fill + j ].f4;

      write_record_into_fifo( &r, (void *)XPAR_ACCEL_SORT_PLB_0_BASEADDR);
    }

    for( j=0; j<records_per_fill; j++ ) {
      read_record_from_fifo( &r, (void *)XPAR_ACCEL_SORT_PLB_0_BASEADDR ) ;

      db[ i*records_per_fill + j ].f1 = r.f1 ;
      db[ i*records_per_fill + j ].f2 = r.f2 ;
      db[ i*records_per_fill + j ].f3 = r.f3 ;
      db[ i*records_per_fill + j ].f4 = r.f4 ;
    }
  }//for i
}

void write_record_into_fifo( RECORD * r , void * baseaddr_p) {
  Xuint64 data ;
  
  data.Upper = r->f1 ;
  data.Lower = r->f2 ;
  //Write fifo with r->f1, r->f2
  ACCEL_SORT_PLB_WriteToFIFO(baseaddr_p, &data);
  
  //Write fifo with r->f3,r->f4
  data.Upper = r->f3 ;
  data.Lower = r->f4 ;
  ACCEL_SORT_PLB_WriteToFIFO(baseaddr_p, &data);
}


void read_record_from_fifo( RECORD * r , void * baseaddr_p) {
  Xuint64 data ;

  //Read fifo with r.f1 ,r->f2
  ACCEL_SORT_PLB_ReadFromFIFO(baseaddr_p, &data);
  r->f1 = data.Upper ;
  r->f2 = data.Lower ;

  //Read fifo with r.f3 ,r->f4
  ACCEL_SORT_PLB_ReadFromFIFO(baseaddr_p, &data);
  r->f3 = data.Upper ;
  r->f4 = data.Lower ;
}

