/*-----------------------------------------------------------------------------
//     $Date: 2004/07/31 23:46:47 $
//     $RCSfile: eabi.S,v $
//-----------------------------------------------------------------------------
//
// Copyright (c) 2004 Xilinx, Inc.  All rights reserved. 
// 
// Xilinx, Inc. 
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
// COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS 
// ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
// STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
// IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
// FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION. 
// XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
// THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
// ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
// FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
// AND FITNESS FOR A PARTICULAR PURPOSE.
//
//---------------------------------------------------------------------------*/

	.file	"eabi.S"
	.section ".text"

	 .section ".got2","aw"
	.align	2
.LCTOC1 = .

/* Table of addresses */
.Lsda = .-.LCTOC1
	.long _SDA_BASE_	/* read/write small data area */

.Lsda2 = .-.LCTOC1
	.long _SDA2_BASE_	/* read-only small data area */

	.text

	.global __eabi
__eabi:	
	lis	11,.LCTOC1@h		/* load address of .LCTOC1 */
	ori	11,11,.LCTOC1@l
	lwz	13,.Lsda(11)		/* load r13 with _SDA_BASE_ address */
	lwz	2,.Lsda2(11)		/* load r2 with _SDA2_BASE_ address */

#ifndef __cplusplus			/* initialization for C++ ? */
	blr				/* no -> return to main */
#else
	.extern atexit
	.extern __atexit
	
	lis	0,atexit@h		/* set up __atexit in eabi-ctors.c */
	ori	0,0,atexit@l
	lis	11,__atexit@h
	ori	11,11,__atexit@l
	stw	0,0(11)
	
	b __do_global_ctors		/* yes -> global constructors */
	trap				/* should never get here */


	.global __init
__init:	blr
	
	.global __fini
__fini:	blr

#endif
