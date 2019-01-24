#ifndef __sortrecord_hw_plb_h__
#define __sortrecord_hw_plb_h__

#include "recordio_tc.h"
#include "xparameters.h"
#include "accel_sort_plb.h"
#include "msort.h"

void sortrecord_hw_global_key( const unsigned char * gkey ) ;

void sortrecord_hw_plb(unsigned pwr) ;

void write_record_into_fifo( RECORD * r , void * baseaddr_p) ;

void read_record_from_fifo( RECORD * r , void * baseaddr_p) ;

#endif
