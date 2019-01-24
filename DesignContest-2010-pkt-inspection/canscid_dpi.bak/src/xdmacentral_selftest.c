/* $Id: xdmacentral_selftest.c,v 1.1 2010/03/30 15:12:42 Administrator Exp $ */
/******************************************************************************
*
*       XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
*       AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
*       SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
*       OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
*       APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
*       THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
*       AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
*       FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
*       WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
*       IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
*       REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
*       INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
*       FOR A PARTICULAR PURPOSE.
*
*       (c) Copyright 2004-2008 Xilinx Inc.
*       All rights reserved.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xdmacentral_selftest.c
*
* Contains a diagnostic self-test function for the XDmaCentral driver.
*
* See xdmacentral.h for more information.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- ------------------------------------------------------
* 1.00a xd   03/12/04 First release
* 1.00b xd   01/13/05 Modified to support both OPB Central DMA and PLB
*                     Central DMA.
* 1.10b mta  03/21/07 Updated to new coding style
* 1.11a sv   01/21/08 Updated for supporting unaligned transfers
* </pre>
*
*****************************************************************************/

/***************************** Include Files ********************************/

#include "xstatus.h"
#include "xdmacentral.h"

/************************** Constant Definitions ****************************/

#define XDMC_SELFTEST_BUFSIZE 16 /**< size of transfer test buffer in bytes */

/**************************** Type Definitions ******************************/

/***************** Macros (Inline Functions) Definitions ********************/

/************************** Variable Definitions ****************************/

/*
 * Source buffer and Destination buffer for self-test purpose.
 */
static u8 SrcBuffer[XDMC_SELFTEST_BUFSIZE];
static u8 DestBuffer[XDMC_SELFTEST_BUFSIZE];

/************************** Function Prototypes *****************************/


/*****************************************************************************/
/**
*
* Run a self-test on the driver/device. The test resets the device, starts a
* DMA transfer, compares the contents of destination buffer and source
* buffer after the DMA transfer is finished, and resets the device again
* before the function returns.
*
* Note that this is a destructive test in that resets of the device are
* performed. Please refer to the device specification for the device status
* after the reset operation.
*
* If the hardware system is not built correctly, this function may never
* return to the caller.
*
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return
*		- XST_SUCCESS if the DMA transfer could get finished and the
*		contents of destination buffer were the same as the
*		source buffer after the transfer.
*		- XST_FAILURE if a Bus error occurred or the contents of the
*		destination buffer were different from the source buffer after
*		the transfer was finished.
*
* @note		None.
*
******************************************************************************/
int XDmaCentral_SelfTest(XDmaCentral * InstancePtr)
{
	u32 Index;
	u32 RegValue;
	u8 *SrcPtr;
	u8 *DestPtr;

	/*
	 * Assert the argument
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Initialize the source buffer bytes with a pattern and the
	 * the destination buffer bytes to zero.
	 */
	SrcPtr = (u8 *) SrcBuffer;
	DestPtr = (u8 *) DestBuffer;

	for (Index = 0; Index < XDMC_SELFTEST_BUFSIZE; Index++) {
		SrcPtr[Index] = Index;
		DestPtr[Index] = 0;
	}

	/*
	 * Reset the device to get it back to its default state
	 */
	XDmaCentral_Reset(InstancePtr);

	/* Setup the DMA Control register to be:
	 *	- Source address incrementing
	 *	- Destination address incrementing
	 */
	XDmaCentral_SetControl(InstancePtr,
				XDMC_DMACR_SOURCE_INCR_MASK |
				XDMC_DMACR_DEST_INCR_MASK);

	/*
	 * Flush the Data Cache in the case the Data Cache is enabled.
	 */
	XCACHE_FLUSH_DCACHE_RANGE(&SrcBuffer,  XDMC_SELFTEST_BUFSIZE);
	XCACHE_FLUSH_DCACHE_RANGE(&DestBuffer, XDMC_SELFTEST_BUFSIZE);

	/*
	 * Start the DMA transfer.
	 */
	XDmaCentral_Transfer(InstancePtr, (void *) SrcBuffer,
			     (void *) DestBuffer, XDMC_SELFTEST_BUFSIZE);

	/*
	 * Wait until the DMA transfer is done
	 */
	do {
		/*
		 * Poll DMA status register
		 */
		RegValue = XDmaCentral_GetStatus(InstancePtr);
	}
	while ((RegValue & XDMC_DMASR_BUSY_MASK) == XDMC_DMASR_BUSY_MASK);


	/*
	 * If Bus error occurs, reset the device and return the error code.
	 */
	if (RegValue & XDMC_DMASR_BUS_ERROR_MASK) {
		XDmaCentral_Reset(InstancePtr);
		return XST_FAILURE;
	}

	/*
	 * DMA transfer is completely successful, check the destination buffer.
	 */
	for (Index = 0; Index < XDMC_SELFTEST_BUFSIZE; Index++) {
		if (DestPtr[Index] != SrcPtr[Index]) {
			/*
			 * Destination buffer's contents are different from the
			 * source buffer. Reset the device again and return
			 * error code.
			 */
			XDmaCentral_Reset(InstancePtr);
			return XST_FAILURE;
		}
	}

	/*
	 * Destination buffer's contents are the same as the source buffer
	 * Reset the device again and return success code.
	 */
	XDmaCentral_Reset(InstancePtr);

	return XST_SUCCESS;
}


