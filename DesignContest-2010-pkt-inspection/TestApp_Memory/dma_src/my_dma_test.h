#ifndef _my_dma_test_h_
#define _my_dma_test_h_

#include "xstatus.h"
#include "xdmacentral.h"
#include "xintc.h"
#include "stdio.h"
#include "stdlib.h"

int my_dma_test(XDmaCentral * InstancePtr, u8 * SrcPtr, u8 * DestPtr, u32 size );

#endif
