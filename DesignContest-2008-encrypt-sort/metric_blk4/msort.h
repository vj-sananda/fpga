#ifndef __msort_h__
#define __msort_h__

#include "recordio_tc.h"
#include "aes_core.h"
#include <assert.h>
#include <stdio.h>

#define BLOCKSIZE 4

void precompute_keys(const unsigned char *gkey) ;

void precompute_key_for_idx(unsigned idx) ;

void decryptdb(unsigned pwr) ;

void copydb( RECORD src[], RECORD dst[], int num_rec) ;

void encryptdb(unsigned pwr) ;

void readrecord_plain(RECORD *r, unsigned idx) ;

void writerecord_plain(RECORD *r, unsigned idx) ;

int comparerecord_plain(unsigned idx1, unsigned idx2) ;

void swaprecord_plain(unsigned idx1, unsigned idx2) ;

void printdb( RECORD A[], int startidx, int endidx ) ;

void sort_gap(int startidx, int blocksize) ;

void block_sort(int blocksize,unsigned pwr) ;

void sortrecord_blockmerge(unsigned pwr) ;

int merge_all_sorted_blocks(int blocksize,unsigned pwr) ;

void merge_block ( RECORD  A[], int start_a_ptr, int end_a_ptr,
		   RECORD  B[], int start_b_ptr, int end_b_ptr,
		   RECORD  M[], int start_m_ptr, int end_m_ptr
		   ) ;

#endif

