#ifndef _my_dma_test_h_
#define _my_dma_test_h_

#include "xstatus.h"
#include "xdmacentral.h"
#include "xintc.h"
#include "stdio.h"
#include "stdlib.h"

int dma_test(XDmaCentral * InstancePtr, u32 * SrcPtr, u32 * DestPtr, u32 size );

#endif
