//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dma/drivers/dpi_verilog_v1_00_a/src/dpi_verilog.c
// Version:           1.00.a
// Description:       dpi_verilog Driver Source File
// Date:              Tue Mar 02 16:37:10 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "dpi_verilog.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from DPI_VERILOG device.
 *
 * @param   baseaddr_p is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DPI_VERILOG_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  DPI_VERILOG_mWriteReg(baseaddr, DPI_VERILOG_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Enable all possible interrupt sources from device.
   */
  DPI_VERILOG_mWriteReg(baseaddr, DPI_VERILOG_INTR_DIER_OFFSET,
    INTR_TERR_MASK
    | INTR_DPTO_MASK
    | INTR_IPIR_MASK
    | INTR_WFDL_MASK
    );

  /*
   * Set global interrupt enable.
   */
  DPI_VERILOG_mWriteReg(baseaddr, DPI_VERILOG_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for DPI_VERILOG device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the DPI_VERILOG device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void DPI_VERILOG_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Get status from Device Interrupt Status Register.
   */
  IntrStatus = DPI_VERILOG_mReadReg(baseaddr, DPI_VERILOG_INTR_DISR_OFFSET);

  xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

  /*
   * Verify the source of the interrupt is the user logic and clear the interrupt
   * source by toggle write baca to the IP ISR register.
   */
  if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = DPI_VERILOG_mReadReg(baseaddr, DPI_VERILOG_INTR_IPISR_OFFSET);
    DPI_VERILOG_mWriteReg(baseaddr, DPI_VERILOG_INTR_IPISR_OFFSET, IpStatus);
  }

}

