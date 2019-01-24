#ifndef __accel_sort_util_h__
#define __accel_sort_util_h__

#include "accel_sort_plb.h"

/**
   Set of util to load global key, start index, reset index etc
 */

XStatus set_global_key(void * baseaddr_p, const unsigned char * key);

XStatus set_start_index(void * baseaddr_p, unsigned int index );

XStatus write_control_reg(void * baseaddr_p, unsigned int data);

XStatus get_control_reg(void * baseaddr_p) ;

XStatus get_start_index(void * baseaddr_p) ;

XStatus get_global_key(void * baseaddr_p) ;

#endif
