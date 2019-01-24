#ifndef __DMA_INTR_HANDLER__
#define __DMA_INTR_HANDLER__

#include "my_timer.h"
#include "kraaken_dpi.h"
#include "xstatus.h"
#include "xdmacentral.h"
#include "xintc.h"
#include "stdio.h"
#include "stdlib.h"
#include "canscid_count_defines.h"

//Struct to pass as an arg to handler
//if need be
typedef struct {
  XDmaCentral * DmaPtr ;
  u32 * Status ;
  u32 * SrcPtr ;
  u32 * DestPtr ;
  u32 size ;
} XDmaIntrArgs ;

//----------------------------------------------------
// INTERRUPT HANDLER FUNCTION
//----------------------------------------------------
void dma_intr_handler(void * arg_ptr ) ;

#endif
