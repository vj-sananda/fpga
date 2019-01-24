//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/kraaken_dpi_v3_00_a/src/kraaken_dpi.c
// Version:           3.00.a
// Description:       kraaken_dpi Driver Source File
// Date:              Tue Mar 30 01:01:21 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "kraaken_dpi.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from KRAAKEN_DPI device.
 *
 * @param   baseaddr_p is the base address of the KRAAKEN_DPI device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void KRAAKEN_DPI_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  KRAAKEN_DPI_mWriteReg(baseaddr, KRAAKEN_DPI_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Enable all possible interrupt sources from device.
   */
  KRAAKEN_DPI_mWriteReg(baseaddr, KRAAKEN_DPI_INTR_DIER_OFFSET,
    INTR_TERR_MASK
    | INTR_DPTO_MASK
    | INTR_IPIR_MASK
    | INTR_WFDL_MASK
    );

  /*
   * Set global interrupt enable.
   */
  KRAAKEN_DPI_mWriteReg(baseaddr, KRAAKEN_DPI_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for KRAAKEN_DPI device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the KRAAKEN_DPI device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void KRAAKEN_DPI_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Get status from Device Interrupt Status Register.
   */
  IntrStatus = KRAAKEN_DPI_mReadReg(baseaddr, KRAAKEN_DPI_INTR_DISR_OFFSET);

  xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

  /*
   * Verify the source of the interrupt is the user logic and clear the interrupt
   * source by toggle write baca to the IP ISR register.
   */
  if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = KRAAKEN_DPI_mReadReg(baseaddr, KRAAKEN_DPI_INTR_IPISR_OFFSET);
    KRAAKEN_DPI_mWriteReg(baseaddr, KRAAKEN_DPI_INTR_IPISR_OFFSET, IpStatus);
  }

}

