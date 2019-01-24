/* $Id: xdmacentral.c,v 1.1.2.1 2008/02/13 05:23:03 svemula Exp $ */
/*****************************************************************************
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
*****************************************************************************/
/****************************************************************************/
/**
*
* @file xdmacentral.c
*
* This file contains the driver API functions that can be used to access
* the Central DMA device.
*
* Please refer to the xdmacentral.h header file for more information about
* this driver.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- --------------------------------------------------------
* 1.00a xd   03/11/04 First release
* 1.00b xd   01/13/05 Modified to support both OPB Central DMA and PLB
*                     Central DMA.
* 1.00b mta  03/21/07 Modified to support Central DMA on PLB bus.
* 1.10b mta  03/21/07 Updated to new coding style
* 1.11a sv   01/21/08 Updated for supporting unaligned transfers.
*		      Added the function XDmaCentral_CfgInitialize,
*		      for removing the dependency on the static config table and
*		      xparameters.h from the driver initialization
* </pre>
*
*****************************************************************************/

/***************************** Include Files ********************************/
#include "xdmacentral.h"

/************************** Constant Definitions ****************************/


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/


/************************** Function Prototypes *****************************/


/************************** Variable Definitions ****************************/

extern XDmaCentral_Config XDmaCentral_ConfigTable[];

/*****************************************************************************/
/**
*
* Initialize a specific XDmaCentral instance. This function must be called
* prior to using a Central DMA device. Initialization of the device includes
* initializing the instance structure, and resetting the device such that it is
* in a known state.
*
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
* @param	DmaCentralCfgPtr points to the XDmaCentral device configuration
*		structure.
* @param	EffectiveAddr is the device base address in the virtual memory
*		address space. If the address translation is not used then the
*		physical address is passed.
*		Unexpected errors may occur if the address mapping is changed
*		after this function is invoked.
*
* @return
* 		- XST_SUCCESS if initialization is successful.
*
* @note		None
*
******************************************************************************/
int XDmaCentral_CfgInitialize(XDmaCentral * InstancePtr,
				XDmaCentral_Config *DmaCentralCfgPtr,
				u32 EffectiveAddr)
{

	/*
	 * Verify that each of the inputs are valid.
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(DmaCentralCfgPtr != NULL);

	/*
	 * Set some default values.
	 */
	InstancePtr->IsReady = FALSE;

	/*
	 * Initialize the instance structure with device configuration data.
	 */
	InstancePtr->DmaConfig.BaseAddress = DmaCentralCfgPtr->BaseAddress;
	InstancePtr->DmaConfig.DeviceId = DmaCentralCfgPtr->DeviceId;

	/*
	 * Indicate the instance is now ready to use, initialized without error.
	 */
	InstancePtr->IsReady = XCOMPONENT_IS_READY;

	/*
	 * Reset the device such that it is in a known state.
	 */
	XDmaCentral_Reset(InstancePtr);

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
*
* Force a software reset to occur in the device.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return	None.
*
* @note		This function is a destructive operation such that it should not
*		be called while a DMA transfer is ongoing. Please read the
*		device specification for the device status after this reset
*		operation is executed.
*
******************************************************************************/
void XDmaCentral_Reset(XDmaCentral * InstancePtr)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_VOID(InstancePtr != NULL);
	XASSERT_VOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Write the reset value to the reset register
	 */
	XDmaCentral_mWriteReg(InstancePtr->DmaConfig.BaseAddress,
				XDMC_RST_OFFSET, XDMC_RST_MASK);
}

/****************************************************************************/
/**
*
* Set the contents of DMA Control register. Use the XDMC_DMACR_* constants
* defined in xdmacentral_l.h to create the bit-mask to be written to the
* register.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
* @param	Mask is the 32-bit value to write to the DMA Control register.
*		Use the defines XDMC_DMACR_* defined in xdmacentral_l.h.
*
* @return	None.
*
* @note		None
*
*****************************************************************************/
void XDmaCentral_SetControl(XDmaCentral * InstancePtr, u32 Mask)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_VOID(InstancePtr != NULL);
	XASSERT_VOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Write the mask to the DMA Control register
	 */
	XDmaCentral_mWriteReg(InstancePtr->DmaConfig.BaseAddress,
				XDMC_DMACR_OFFSET, Mask);
}

/****************************************************************************/
/**
*
* Get the contents of DMA Control register. Use the XDMC_DMACR_* constants
* defined in xdmacentral_l.h to interpret the value.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return	A 32-bit value representing the contents of DMA Control
*		register.
*
* @note		None.
*
*****************************************************************************/
u32 XDmaCentral_GetControl(XDmaCentral * InstancePtr)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Read the DMA Control register
	 */
	return XDmaCentral_mReadReg(InstancePtr->DmaConfig.BaseAddress,
				    XDMC_DMACR_OFFSET);
}

/****************************************************************************/
/**
*
* Get the contents of the DMA Status register. Use the XDMC_DMASR_* constants
* defined in xdmacentral_l.h to interpret the value.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return	A 32-bit value representing the contents of the Status register.
*
* @note		None
*
*
*****************************************************************************/
u32 XDmaCentral_GetStatus(XDmaCentral * InstancePtr)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Read the DMA Status register
	 */
	return XDmaCentral_mReadReg(InstancePtr->DmaConfig.BaseAddress,
				    XDMC_DMASR_OFFSET);
}


/****************************************************************************/
/**
*
* Get the contents of the Source Address register.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return	A 32-bit value representing the contents of the Source Address
*		register.
*
* @note		None.
*
*****************************************************************************/
u32 XDmaCentral_GetSrcAddress(XDmaCentral * InstancePtr)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Read the DMA Source Address register
	 */
	return XDmaCentral_mReadReg(InstancePtr->DmaConfig.BaseAddress,
					XDMC_SA_OFFSET);
}


/****************************************************************************/
/**
*
* Get the contents of the Destination Address register.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
*
* @return	A 32-bit value representing the contents of the Destination
*		Address register.
*
* @note	 	None.
*
*****************************************************************************/
u32 XDmaCentral_GetDestAddress(XDmaCentral * InstancePtr)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	/*
	 * Read the DMA Destination Address register
	 */
	return XDmaCentral_mReadReg(InstancePtr->DmaConfig.BaseAddress,
					XDMC_DA_OFFSET);
}


/****************************************************************************/
/**
*
* This function starts the DMA transferring data from a memory source
* to a memory destination. This function only starts the operation and returns
* before the operation may be completed. If the interrupt is enabled, an
* interrupt will be generated when the operation is completed, otherwise it is
* necessary to poll the Status register to determine when it is completed. It is
* the responsibility of the caller to determine when the operation is completed
* by handling the generated interrupt or polling the DMA Status register. (See
* XDmaCentral_GetStatus())
*
* @param	InstancePtr is a pointer to the XDmaCentral instance.
* @param	SourcePtr contains a pointer to the source memory where the data
*		is to be transferred from.
* @param	DestinationPtr contains a pointer to the destination memory
*		where the data is to be transferred to.
* @param	ByteCount contains the number of bytes to transfer during the
*		DMA operation.
*
* @return	None.
*
* @note		It is the responsibility of the caller to ensure that the cache
*		is flushed and invalidated both before the DMA operation is
*		started and after the DMA operation completes if the memory
*		pointed to is  cached. The caller must also ensure that the
*		pointers contain physical address rather than a virtual address
*		if address translation is being used.
*		<br><br>
*		The caller is also responsible for setting up the device by
*		writing the correct value to the Control register of the device
*		before this function is called.
*
*****************************************************************************/
void XDmaCentral_Transfer(XDmaCentral * InstancePtr,  void *SourcePtr,
				void *DestinationPtr, u32 ByteCount)
{
	/*
	 * Assert the arguments
	 */
	XASSERT_VOID(InstancePtr != NULL);
	XASSERT_VOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);
	XASSERT_VOID(SourcePtr != DestinationPtr);

	/*
	 * Setup the Source Address and Destination Address registers for the
	 * transfer.
	 */
	XDmaCentral_mWriteReg(InstancePtr->DmaConfig.BaseAddress,
				XDMC_SA_OFFSET, (u32) SourcePtr);

	XDmaCentral_mWriteReg(InstancePtr->DmaConfig.BaseAddress,
				XDMC_DA_OFFSET, (u32) DestinationPtr);

	/*
	 * Start the DMA transfer to copy from the source buffer to the
	 * destination buffer by writing the length to the Length register.
	 */
	XDmaCentral_mWriteReg(InstancePtr->DmaConfig.BaseAddress,
				XDMC_LENGTH_OFFSET, ByteCount);
}
