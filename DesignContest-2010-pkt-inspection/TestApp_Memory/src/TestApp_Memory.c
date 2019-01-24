/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * Xilinx EDK 10.1.03 EDK_K_SP3.6
 *
 * This file is a sample test application
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * XPS project when you run the "Generate Libraries" menu item
 * in XPS.
 *
 * Your XPS project directory is at:
 *    E:\work\FPGA_PROJECTS\ML509\ml509_dma\
 */


// Located in: microblaze_0/include/xparameters.h
#include "xparameters.h"

#include "stdio.h"
#include "stdlib.h"
#include "xutil.h"
#include "xdmacentral.h"
#include "my_dma_test.h"


/* Definitions for peripheral DMA */
#define CENTRAL_DMA_ID XPAR_XPS_CENTRAL_DMA_0_DEVICE_ID
#define CENTRAL_DMA_BASEADDR XPAR_XPS_CENTRAL_DMA_0_BASEADDR

static XDmaCentral DmaCentralInst;
static XDmaCentral_Config *DMAConfigPtr;

//====================================================

int main (void) {
   /*
    * Enable and initialize cache
    */
   #if XPAR_MICROBLAZE_0_USE_ICACHE
//      microblaze_init_icache_range(0, XPAR_MICROBLAZE_0_CACHE_BYTE_SIZE);
  //    microblaze_enable_icache();
      microblaze_disable_icache();
   #endif

   #if XPAR_MICROBLAZE_0_USE_DCACHE
    //  microblaze_init_dcache_range(0, XPAR_MICROBLAZE_0_DCACHE_BYTE_SIZE);
      //microblaze_enable_dcache();
      microblaze_disable_dcache();
   #endif

   print("-- Entering main() --\r\n");
   /* Testing MPMC Memory (DDR_SDRAM)*/
   {
      XStatus status;

	  Xuint32 * ddr_buffer32 = (Xuint32 *)malloc( sizeof(Xuint32)*1024);
	  
      print("Starting MemoryTest for DDR_SDRAM:\r\n");
      print("  Running 32-bit test...");
      //status = XUtil_MemoryTest32((Xuint32*)XPAR_DDR_SDRAM_MPMC_BASEADDR, 1024, 0xAAAA5555, XUT_ALLMEMTESTS);
      status = XUtil_MemoryTest32(ddr_buffer32, 1024, 0xAAAA5555, XUT_ALLMEMTESTS);
      if (status == XST_SUCCESS) {
         print("PASSED!\r\n");
      }
      else {
         print("FAILED!\r\n");
      }
      
   }

   /* 
    * MemoryTest routine will not be run for the memory at 
    * 0x00000000 (dlmb_cntlr)
    * because it is being used to hold a part of this application program
    */
    Xuint16 DeviceId = CENTRAL_DMA_ID; 
  XStatus status;
  
  //Lookup the DMA configuration information
  DMAConfigPtr = XDmaCentral_LookupConfig(DeviceId);
  
  /* Initialize the dma instance */
  status = XDmaCentral_CfgInitialize(&DmaCentralInst, DMAConfigPtr, DMAConfigPtr->BaseAddress);
        if (status == XST_SUCCESS) {
         print("XDmaCentral_CfgInitialize PASSED!\r\n");
      }
      else {
         print("XDmaCentral_CfgInitialize FAILED!\r\n");
      }
  // THIS RETURNS SUCCESS
	
	Xuint32 size = 40*1024*1024 ;
	Xuint8 * src_ptr = (Xuint8 *)malloc( sizeof(Xuint8)*size);
	Xuint8 * dest_ptr = (Xuint8 *)malloc( sizeof(Xuint8)*size);

	//status = XDmaCentral_SelfTest(&DmaCentralInst);
	status = my_dma_test(&DmaCentralInst,src_ptr,dest_ptr,size);

      if (status == XST_SUCCESS) {
         printf("my_dma_test(%d Bytes) PASSED!\r\n",size);
      }
      else {
         printf("my_dma_test(%d Bytes) FAILED!\r\n",size);
      }
  
  print("-- Exiting main() --\r\n");
   return 0;
}

