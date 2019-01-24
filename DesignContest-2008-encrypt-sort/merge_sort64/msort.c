#include "msort.h"

extern RECORD   db[MAXRECORD];

RECORD   PlainTxtdb[MAXRECORD];
RECORD   Mergeddb[MAXRECORD];

void decryptdb( unsigned pwr ) {
  unsigned i;
  unsigned record_key[4]={0,0,0,0};
  unsigned maxrecord = (1 << pwr);

  for (i=0; i<maxrecord; i++) {

    getkey(i, record_key);

    PlainTxtdb[i].f1 = db[i].f1 ^ record_key[0];
    PlainTxtdb[i].f2 = db[i].f2 ^ record_key[1];
    PlainTxtdb[i].f3 = db[i].f3 ^ record_key[2];
    PlainTxtdb[i].f4 = db[i].f4 ^ record_key[3];
  }
}

void copydb( RECORD src[], RECORD dst[], int num_rec) {
  int i ;
  
  for (i=0;i<num_rec;i++) {
    dst[i].f1 = src[i].f1;
    dst[i].f2 = src[i].f2;
    dst[i].f3 = src[i].f3;
    dst[i].f4 = src[i].f4;
  }

}

void encryptdb(unsigned pwr) {
  unsigned i;
  unsigned record_key[4]={0,0,0,0};
  unsigned maxrecord = (1 << pwr);

  for (i=0; i<maxrecord; i++) {

    getkey(i, record_key);

    db[i].f1 = PlainTxtdb[i].f1 ^ record_key[0];
    db[i].f2 = PlainTxtdb[i].f2 ^ record_key[1];
    db[i].f3 = PlainTxtdb[i].f3 ^ record_key[2];
    db[i].f4 = PlainTxtdb[i].f4 ^ record_key[3];
  }
}

void readrecord_plain(RECORD *r, unsigned idx) {
  unsigned record_key[4];
  assert(r != 0);
  assert(idx < MAXRECORD);

  r->f1 = PlainTxtdb[idx].f1;
  r->f2 = PlainTxtdb[idx].f2;
  r->f3 = PlainTxtdb[idx].f3;
  r->f4 = PlainTxtdb[idx].f4;
}

void writerecord_plain(RECORD *r, unsigned idx) {
  unsigned record_key[4];
  assert(r != 0);
  assert(idx < MAXRECORD);

  PlainTxtdb[idx].f1 = r->f1;
  PlainTxtdb[idx].f2 = r->f2;
  PlainTxtdb[idx].f3 = r->f3;
  PlainTxtdb[idx].f4 = r->f4;
}

//Returns 1 if idx1 < idx2
//Returns 0 if idx1 > idx2
int comparerecord_plain(unsigned idx1, unsigned idx2) {
  RECORD r1, r2;
  readrecord_plain(&r1, idx1);
  readrecord_plain(&r2, idx2);
  return comparerecord_atomic(&r1,&r2);
}

int comparerecord_atomic( RECORD * r1, RECORD * r2) {
  unsigned r ;

  if ( (r1->f1) >  (r2->f1)) r = 0; 
  else if (((r1->f1) == (r2->f1)) && 
           ((r1->f2)  > (r2->f2))) r = 0; 
  else if (((r1->f1) == (r2->f1)) && 
           ((r1->f2) == (r2->f2)) && 
			  ((r1->f3)  > (r2->f3))) r = 0; 
  else if (((r1->f1) == (r2->f1)) && 
           ((r1->f2) == (r2->f2)) && 
			  ((r1->f3) == (r2->f3)) && 
			  ((r1->f4)  > (r2->f4))) r = 0; 
  else r = 1;
  return r;
}

void swaprecord_plain(unsigned idx1, unsigned idx2) {
  RECORD r1, r2;
  readrecord_plain(&r1, idx1);
  readrecord_plain(&r2, idx2);
  writerecord_plain(&r2, idx1);
  writerecord_plain(&r1, idx2);
}

void printdb( RECORD A[], int startidx, int endidx ) {

  int i;

  for (i=startidx; i<=endidx; i++) {

    xil_printf("%6d::", i);
    xil_printf("%8x ",A[i].f1);
    xil_printf("%8x ",A[i].f2);
    xil_printf("%8x ",A[i].f3);
    xil_printf("%8x \n\r",A[i].f4);
  }
  
}

void sort_gap(int startidx, int blocksize) {

  unsigned i, swapped = 1, gap;
  gap = blocksize * 10 / 13;
 
  while ((gap > 1) || (swapped)) {
    swapped = 0;
    if (gap > 1) {
      gap = gap * 10 / 13;
      gap = (gap == 10) ? 11 : gap;
      gap = (gap ==  9) ? 11 : gap;
    }
    for (i=startidx; (i + gap) <= startidx+blocksize-1; i++)
      if (comparerecord_plain(i+gap, i)) {
        swaprecord_plain(i,i+gap);
        swapped = 1;
      }
  }

}

/*
Will create MAXRECORD/blocksize regions,
each of which are individually sorted
in ascending order
Lowest in lower indexes
*/
void block_sort(int blocksize, unsigned pwr) {
  int i;
  unsigned maxrecord = (1 << pwr);
  for (i=0;i<=maxrecord-1;i += blocksize) {
    sort_gap(i,blocksize);
  }
}

void sortrecord_blockmerge(unsigned pwr) {

  decryptdb(pwr);

  block_sort(BLOCKSIZE,pwr);

  merge_all_sorted_blocks(BLOCKSIZE,pwr);

  //  printdb(PlainTxtdb, 0, MAXRECORD-1);

  encryptdb(pwr);
}

void merge_all_sorted_blocks(int blocksize, unsigned pwr) {

  int i,j;
  int current_blocksize = blocksize ;
  int num_passes;
  int itr=0;
  unsigned maxrecord = (1 << pwr);

  do {
    itr++;
    num_passes = maxrecord/(2*current_blocksize) ;

    //Number of blocks to merge
    for(j=0;j<num_passes*2;j+=2) {
      if ( itr % 2 ) {
	merge_block( PlainTxtdb,j*current_blocksize,(j+1)*current_blocksize-1,
		     PlainTxtdb,(j+1)*current_blocksize,(j+2)*current_blocksize-1,
		     Mergeddb,j*current_blocksize,(j+2)*current_blocksize-1
		     );
	//	xil_printf("====>itr %d\n\r",itr);
	//	printdb(Mergeddb,0,maxrecord-1);
      }
      else {
	merge_block( Mergeddb,j*current_blocksize,(j+1)*current_blocksize-1,
		     Mergeddb,(j+1)*current_blocksize,(j+2)*current_blocksize-1,
		     PlainTxtdb,j*current_blocksize,(j+2)*current_blocksize-1
		     );
	//	xil_printf("====>itr %d\n\r",itr);
	//	printdb(PlainTxtdb,0,maxrecord-1);
      }
    }


    current_blocksize = current_blocksize*2 ;
  } while( current_blocksize < maxrecord ) ;

  //Odd number of iterations, result will be in Mergeddb
  //else in PlainTxtdb
  if ( itr % 2 )
    copydb(Mergeddb,PlainTxtdb,maxrecord);

}

void merge_block ( RECORD  A[], int start_a_ptr, int end_a_ptr,
		   RECORD  B[], int start_b_ptr, int end_b_ptr,
		   RECORD  M[], int start_m_ptr, int end_m_ptr
		   ) {

  int m_ptr = start_m_ptr;
  int a_ptr = start_a_ptr;
  int b_ptr = start_b_ptr;

  //While (A not empty and B not empty )
  while( (end_a_ptr >= a_ptr) && (end_b_ptr >= b_ptr) ) {

    assert( a_ptr <= end_a_ptr  );
    assert( b_ptr <= end_b_ptr  );

    //xil_printf("a_ptr=%d, b_ptr=%d\n\r",a_ptr,b_ptr);

    if ( comparerecord_atomic(A+a_ptr,B+b_ptr) ) {
      assert( m_ptr <= end_m_ptr );
      M[m_ptr++] = A[a_ptr];
      a_ptr++;
    }
    else {
      assert( m_ptr <= end_m_ptr );
      M[m_ptr++] = B[b_ptr];
      b_ptr++;
    }
    //xil_printf("M[%d] = %d\n\r",m_ptr-1,M[m_ptr-1]);
  }

  while((end_a_ptr >= a_ptr)) {
    assert( a_ptr <= end_a_ptr );
    assert( m_ptr <= end_m_ptr );
    M[m_ptr++] = A[a_ptr++];
  }

  while((end_b_ptr >= b_ptr)) {
    assert( b_ptr <= end_b_ptr );
    assert( m_ptr <= end_m_ptr );
    M[m_ptr++] = B[b_ptr++];
  }
  
}
