/* $Id: xdmacentral_sinit.c,v 1.1.2.1 2008/02/13 05:23:03 svemula Exp $ */
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
*       (c) Copyright 2008 Xilinx Inc.
*       All rights reserved.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xdmacentral_sinit.c
*
* This file contains the implementation of the XDmaCentral driver's static
* initialization functionality.
*
* @note		None.
*
* <pre>
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.11a sv   02/07/08 First release
*
* </pre>
*
******************************************************************************/

/***************************** Include Files *********************************/
#include "xparameters.h"
#include "xdmacentral.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

extern XDmaCentral_Config XDmaCentral_ConfigTable[];

/*****************************************************************************/
/**
*
* Lookup the device configuration based on the unique device ID. The table
* XDmaCentral_ConfigTable contains the configuration info for each device
* in the system.
*
* @param 	DeviceId is the unique device ID of the device being looked up.
*
* @return	A pointer to the configuration table entry corresponding to the
*		given device ID, or NULL if no match is found.
*
* @note		None.
*
******************************************************************************/
XDmaCentral_Config *XDmaCentral_LookupConfig(u16 DeviceId)
{
	XDmaCentral_Config *CfgPtr = NULL;
	u32 Index;

	for (Index = 0; Index < XPAR_XDMACENTRAL_NUM_INSTANCES; Index++) {
		if (XDmaCentral_ConfigTable[Index].DeviceId == DeviceId) {
			CfgPtr = &XDmaCentral_ConfigTable[Index];
			break;
		}
	}

	return CfgPtr;
}


/****************************************************************************/
/**
*
* Initialize a specific XDmaCentral instance. This function must be called
* prior to using a Central DMA device. Initialization of a device includes
* looking up the configuration for the given device instance, initializing
* the instance structure, and resetting the device such that it is in a known
* state.
*
* @param	InstancePtr is a pointer to the XDmaCentral instance to be
*		worked on.
* @param	DeviceId is the unique id of the device controlled by this
		XDmaCentral instance.
*
* @return
* 		- XST_SUCCESS if everything initializes as expected.
* 		- XST_DEVICE_NOT_FOUND if the requested device is not found
*
* @note		None.
*
*****************************************************************************/
int XDmaCentral_Initialize(XDmaCentral * InstancePtr, u16 DeviceId)
{
	int Status;
	XDmaCentral_Config *ConfigPtr;

	/*
	 * Assert validates the input arguments
	 */
	XASSERT_NONVOID(InstancePtr != NULL);

	/*
	 * Lookup the device configuration. Use this configuration info below
	 * when initializing this device.
	 */
	ConfigPtr = XDmaCentral_LookupConfig(DeviceId);
	if (ConfigPtr == (XDmaCentral_Config *) NULL) {
		InstancePtr->IsReady = 0;
		return XST_DEVICE_NOT_FOUND;
	}


	Status = XDmaCentral_CfgInitialize(InstancePtr, ConfigPtr,
						ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

