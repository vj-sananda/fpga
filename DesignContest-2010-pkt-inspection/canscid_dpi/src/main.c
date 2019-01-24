
// Located in: microblaze_0/include/xparameters.h
#include "xparameters.h"

#include "stdio.h"
#include "stdlib.h"
#include "xutil.h"
#include "xdmacentral.h"
#include "dma_intr_handler.h"
#include "my_timer.h"

// Set the packet Data pointer to a given location. 
//XMD will set the memory at this location to the test data.
Xuint32 * PACKET_DATA_PTR = (Xuint32 *)0x98000000;

#define NUMBER_OF_DWORDS_IN_PACKET_QUEUE  1638400

/* Definitions for peripheral DMA */
#define CENTRAL_DMA_ID XPAR_XPS_CENTRAL_DMA_0_DEVICE_ID
#define CENTRAL_DMA_BASEADDR XPAR_XPS_CENTRAL_DMA_0_BASEADDR

static XDmaCentral DmaCentralInst;
static XDmaCentral_Config *DMAConfigPtr;

//====================================================

int main (void) {

#if XPAR_MICROBLAZE_0_USE_ICACHE
  microblaze_disable_icache();
#endif

#if XPAR_MICROBLAZE_0_USE_DCACHE
  microblaze_disable_dcache();
#endif

  Xuint16 DeviceId = CENTRAL_DMA_ID; 
  XStatus status;
  u32 * DestPtr;

  //Lookup the DMA configuration information
  DMAConfigPtr = XDmaCentral_LookupConfig(DeviceId);
  
  /* Initialize the dma instance */
  status = XDmaCentral_CfgInitialize(&DmaCentralInst, DMAConfigPtr, DMAConfigPtr->BaseAddress);
  if (status != XST_SUCCESS) 
    print("XDmaCentral_CfgInitialize FAILED!\r\n");

  XDmaCentral * InstancePtr = &DmaCentralInst;
  u32 Index;
  u32 RegValue;
  u32 IntStatus = 0;
  u32 DmaTransferSizeInBytes ;
  u32 PktCnt ;
  u32 WatchDogTimeout ;

  Xuint32 Kraaken_Dpi_Baseaddr = XPAR_KRAAKEN_DPI_0_BASEADDR ;

  u32 DwordsInPacketQueue = 1638400;
  DmaTransferSizeInBytes =  DwordsInPacketQueue * 4 ;

  // Assert the argument
  XASSERT_NONVOID(InstancePtr != NULL);
  XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

  XDmaIntrArgs * IntrArgs = (XDmaIntrArgs *)malloc(sizeof(XDmaIntrArgs));
  IntrArgs->DmaPtr = InstancePtr ;
  IntrArgs->Status = &IntStatus ;
  IntrArgs->size = NUMBER_OF_DWORDS_IN_PACKET_QUEUE;

  //----------------------------------------------------
  // REGISTER INTERRUPT HANDLER
  //----------------------------------------------------
  printf("  - Registering interrupt handler\r\n");
  XIntc_RegisterHandler(XPAR_XPS_INTC_0_BASEADDR,
			XPAR_XPS_INTC_0_XPS_CENTRAL_DMA_0_IP2INTC_IRPT_INTR,
			dma_intr_handler,
			(void *)IntrArgs) ;
  //----------------------------------------------------

  //----------------------------------------------------
  // ENABLE INTERRUPTS
  //----------------------------------------------------
  printf("  - Enabling interrupts\r\n");

  // Enable INTC interrupts
  XIntc_mMasterEnable(XPAR_XPS_INTC_0_BASEADDR);
  XIntc_mEnableIntr(XPAR_XPS_INTC_0_BASEADDR,
		    XPAR_XPS_CENTRAL_DMA_0_IP2INTC_IRPT_MASK);

  // Enable Microblaze interrupts
  microblaze_enable_interrupts();

  //Reset the device to get it back to its default state
  XDmaCentral_Reset(InstancePtr);

  // Enable dma interrupts
  XDmaCentral_InterruptEnableSet(InstancePtr, 
				 XDMC_IXR_DMA_DONE_MASK | XDMC_IXR_DMA_ERROR_MASK );

  //To only incement src , as in DDR to PLB SLAVE FIFO transfer
  XDmaCentral_SetControl(InstancePtr,
			 XDMC_DMACR_SOURCE_INCR_MASK );

  //Set Number of dataword to accumulate
  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG1_OFFSET, 100);

  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG0_OFFSET, 1);
  //KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG0_OFFSET, 0x80000000);

  Xuint32 Reg_Read_Data;

  //Start Timer then start the DMA transfer.
  //The size is in bytes, it is size*4
  DestPtr = (u32 *)(XPAR_KRAAKEN_DPI_0_BASEADDR+KRAAKEN_DPI_WRFIFO_DATA_OFFSET );
  printf("Start timer, start Packet streaming (DMA)\r\n");
  startTiming();
	
  XDmaCentral_Transfer(InstancePtr, (void *) PACKET_DATA_PTR,
		       (void *) DestPtr, DmaTransferSizeInBytes);

  //loop waiting for dma done interrupt
  while(1) {
  }

   return 0;
}

