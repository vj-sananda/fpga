/* $Id: xdmacentral_l.h,v 1.1.2.1 2008/02/13 05:23:03 svemula Exp $ */
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
* @file xdmacentral_l.h
*
* This header file contains identifiers and basic driver functions (or
* macros) that can be used to access the Central DMA device.
*
* @note
*
* All provided functions are for basic register access and do not provide a lot
* of error detection to minimize the overhead in these functions.
* The caller is expected to understand the impact of a function call based
* upon the current state of the Central DMA.
* <br><br>
* Refer to the device specifications and xdmacentral.h for more information
* about this driver and the device.
*
* <pre>
*
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -------------------------------------------------------
* 1.00a xd   03/11/04 First release.
* 1.00b xd   01/13/05 Modified to support both OPB Central DMA and PLB
*                     Central DMA.
* 1.10b mta  03/21/07 Updated to new coding style
* 1.11a sv   01/21/08 Updated for supporting unaligned transfers
*
* </pre>
*
*****************************************************************************/
#ifndef XDMACENTRAL_L_H_ /* Prevent circular inclusions */
#define XDMACENTRAL_L_H_ /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files ********************************/

#include "xbasic_types.h"
#include "xio.h"

/************************** Constant Definitions ****************************/

/**
 * The following constants provide access to each of the registers of the
 * Central DMA device.
 */
#define XDMC_RST_OFFSET		0x00	/**< Reset register */
#define XDMC_DMACR_OFFSET	0x04	/**< DMA Control register */
#define XDMC_SA_OFFSET		0x08	/**< Source Address register */
#define XDMC_DA_OFFSET		0x0C	/**< Destination Address register */
#define XDMC_LENGTH_OFFSET	0x10	/**< Length register */
#define XDMC_DMASR_OFFSET	0x14	/**< DMA Status register */
#define XDMC_ISR_OFFSET		0x2C	/**< Interrupt Status register */
#define XDMC_IER_OFFSET		0x30	/**< Interrupt Enable register */

/**
 * Central DMA Reset register mask(s)
 */
#define XDMC_RST_MASK 0x0000000A	/**< Value used to reset the device */

/**
 * The following constants provide access to the bit fields of the DMA Control
 * register (DMACR). Multiple constants could be "OR"ed together and written
 * to the DMACR.
 */
#define XDMC_DMACR_SOURCE_INCR_MASK 0x80000000 /**<Increment source address */
#define XDMC_DMACR_DEST_INCR_MASK   0x40000000 /**<Increment dest address  */


/**
 * The following constants which are the bit fields of the DMA Control
 * register (DMACR) are provided for backward compatabilty, so that
 * users can use their older applications with this core and driver.
 */
#define XDMC_DMACR_DATASIZE_8_MASK  0x00000000
#define XDMC_DMACR_DATASIZE_4_MASK  0x00000000
#define XDMC_DMACR_DATASIZE_2_MASK  0x00000000
#define XDMC_DMACR_DATASIZE_1_MASK  0x00000000
#define XDMC_DMACR_DATASIZE_MASK    0x00000000


/**
 * The following constants provide access to the bit fields of the DMA Status
 * register (DMASR)
 */
#define XDMC_DMASR_BUSY_MASK	     0x80000000 /**< Device is busy */
#define XDMC_DMASR_BUS_ERROR_MASK    0x40000000 /**< Bus error occurred */

/**
 * The following constants provide access to the bit fields of the DMA Status
 * register (DMASR) are provided for backward compatabilty, so that
 * users can use their older applications with this core and driver.
 */
#define XDMC_DMASR_BUS_TIMEOUT_MASK  0x00000000

/**
 * The following constants provide access to the bit fields of the Interrupt
 * Status register (ISR) and the Interrupt Enable register (IER), bit masks
 * match for both registers such that they are named IXR
 */
#define XDMC_IXR_DMA_DONE_MASK	   0x00000001	 /**< DMA operation done  */
#define XDMC_IXR_DMA_ERROR_MASK	   0x00000002	 /**< DMA operation error */


/**************************** Type Definitions ******************************/


/***************** Macros (Inline Functions) Definitions ********************/

#define XDmaCentral_In32  XIo_In32
#define XDmaCentral_Out32 XIo_Out32

/****************************************************************************/
/**
*
* Read a register of the Central DMA. This macro provides register access to
* all registers using the register offsets defined above.
*
* @param	BaseAddress contains the base address of the device.
* @param	RegOffset is the offset of the register to read.
*
* @return	The contents of the register.
*
* @note		C-style Signature:
*		u32 XDmaCentral_mReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define XDmaCentral_mReadReg(BaseAddress, RegOffset) \
		XDmaCentral_In32((BaseAddress) + (RegOffset))

/****************************************************************************/
/**
*
* Write a register of the Central DMA. This macro provides register access to
* all registers using the register offsets defined above.
*
* @param	BaseAddress contains the base address of the device.
* @param	RegOffset is the offset of the register to write.
* @param	Data is the value to write to the register.
*
* @return	None.
*
* @note		C-style Signature:
*		void XDmaCentral_mWriteReg(u32 BaseAddress, u32 RegOffset,
*						u32 Data)
*
******************************************************************************/
#define XDmaCentral_mWriteReg(BaseAddress, RegOffset, Data) \
		XDmaCentral_Out32((BaseAddress) + (RegOffset), (Data))


/************************** Function Prototypes *****************************/

#ifdef __cplusplus
}
#endif

#endif /* End of protection macro. */
