//////////////////////////////////////////////////////////////////////////////
// Filename:          E:\work\FPGA_PROJECTS\ML509\ml509_dpi/drivers/example_fifo_loopback_vhdl_v1_00_a/src/example_fifo_loopback_vhdl.c
// Version:           1.00.a
// Description:       example_fifo_loopback_vhdl Driver Source File
// Date:              Tue Mar 30 10:52:59 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////


/***************************** Include Files *******************************/

#include "example_fifo_loopback_vhdl.h"

/************************** Function Definitions ***************************/

/**
 *
 * Enable all possible interrupts from EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @param   baseaddr_p is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EXAMPLE_FIFO_LOOPBACK_VHDL_EnableInterrupt(void * baseaddr_p)
{
  Xuint32 baseaddr;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Enable all interrupt source from user logic.
   */
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPIER_OFFSET, 0x00000001);

  /*
   * Enable all possible interrupt sources from device.
   */
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DIER_OFFSET,
    INTR_TERR_MASK
    | INTR_DPTO_MASK
    | INTR_IPIR_MASK
    | INTR_RFDL_MASK
    | INTR_WFDL_MASK
    );

  /*
   * Set global interrupt enable.
   */
  EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DGIER_OFFSET, INTR_GIE_MASK);
}

/**
 *
 * Example interrupt controller handler for EXAMPLE_FIFO_LOOPBACK_VHDL device.
 * This is to show example of how to toggle write back ISR to clear interrupts.
 *
 * @param   baseaddr_p is the base address of the EXAMPLE_FIFO_LOOPBACK_VHDL device.
 *
 * @return  None.
 *
 * @note    None.
 *
 */
void EXAMPLE_FIFO_LOOPBACK_VHDL_Intr_DefaultHandler(void * baseaddr_p)
{
  Xuint32 baseaddr;
  Xuint32 IntrStatus;
Xuint32 IpStatus;
  baseaddr = (Xuint32) baseaddr_p;

  /*
   * Get status from Device Interrupt Status Register.
   */
  IntrStatus = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_DISR_OFFSET);

  xil_printf("Device Interrupt! DISR value : 0x%08x \n\r", IntrStatus);

  /*
   * Verify the source of the interrupt is the user logic and clear the interrupt
   * source by toggle write baca to the IP ISR register.
   */
  if ( (IntrStatus & INTR_IPIR_MASK) == INTR_IPIR_MASK )
  {
    xil_printf("User logic interrupt! \n\r");
    IpStatus = EXAMPLE_FIFO_LOOPBACK_VHDL_mReadReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPISR_OFFSET);
    EXAMPLE_FIFO_LOOPBACK_VHDL_mWriteReg(baseaddr, EXAMPLE_FIFO_LOOPBACK_VHDL_INTR_IPISR_OFFSET, IpStatus);
  }

}

