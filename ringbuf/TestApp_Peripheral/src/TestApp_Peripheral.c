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
 * Xilinx EDK 9.1.02 EDK_J_SP2.4
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
 *    C:\work\ringbuf\
 */


// Located in: microblaze_0/include/xparameters.h
#include "xparameters.h"

#include "stdio.h"

#include "uartlite_header.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "gpio_header.h"
#include "xemac.h"
#include "emac_header.h"

//====================================================

int main (void) {


   /*
    * Enable and initialize cache
    */
   #if XPAR_MICROBLAZE_0_USE_ICACHE
      microblaze_init_icache_range(0, XPAR_MICROBLAZE_0_CACHE_BYTE_SIZE);
      microblaze_enable_icache();
   #endif

   #if XPAR_MICROBLAZE_0_USE_DCACHE
      microblaze_init_dcache_range(0, XPAR_MICROBLAZE_0_DCACHE_BYTE_SIZE);
      microblaze_enable_dcache();
   #endif

   print("-- Entering main() --\r\n");


   {
      XStatus status;
      
      print("\r\nRunning UartLiteSelfTestExample() for debug_module...\r\n");
      status = UartLiteSelfTestExample(XPAR_DEBUG_MODULE_DEVICE_ID);
      if (status == 0) {
         print("UartLiteSelfTestExample PASSED\r\n");
      }
      else {
         print("UartLiteSelfTestExample FAILED\r\n");
      }
   }

   /*
    * Peripheral SelfTest will not be run for RS232_DTE
    * because it has been selected as the STDOUT device
    */



   {
      XStatus status;
      
      print("\r\nRunning UartLiteSelfTestExample() for RS232_DCE...\r\n");
      status = UartLiteSelfTestExample(XPAR_RS232_DCE_DEVICE_ID);
      if (status == 0) {
         print("UartLiteSelfTestExample PASSED\r\n");
      }
      else {
         print("UartLiteSelfTestExample FAILED\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioOutputExample() for LEDs_6Bit...\r\n");

      status = GpioOutputExample(XPAR_LEDS_6BIT_DEVICE_ID,6);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioOutputExample() for LEDs_1Bit...\r\n");

      status = GpioOutputExample(XPAR_LEDS_1BIT_DEVICE_ID,1);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioInputExample() for DIP_Switches_4Bit...\r\n");

      Xuint32 DataRead;
      
      status = GpioInputExample(XPAR_DIP_SWITCHES_4BIT_DEVICE_ID, &DataRead);
      
      if (status == 0) {
         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
      }
      else {
         print("GpioInputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioInputExample() for Buttons_3Bit...\r\n");

      Xuint32 DataRead;
      
      status = GpioInputExample(XPAR_BUTTONS_3BIT_DEVICE_ID, &DataRead);
      
      if (status == 0) {
         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
      }
      else {
         print("GpioInputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioOutputExample() for Character_LCD_2x16...\r\n");

      status = GpioOutputExample(XPAR_CHARACTER_LCD_2X16_DEVICE_ID,7);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioOutputExample() for J4_IO_4Bit...\r\n");

      status = GpioOutputExample(XPAR_J4_IO_4BIT_DEVICE_ID,4);
      
      if (status == 0) {
         print("GpioOutputExample PASSED.\r\n");
      }
      else {
         print("GpioOutputExample FAILED.\r\n");
      }
   }


   {
      Xuint32 status;
      
      print("\r\nRunning GpioInputExample() for Rotary_Encoder...\r\n");

      Xuint32 DataRead;
      
      status = GpioInputExample(XPAR_ROTARY_ENCODER_DEVICE_ID, &DataRead);
      
      if (status == 0) {
         xil_printf("GpioInputExample PASSED. Read data:0x%X\r\n", DataRead);
      }
      else {
         print("GpioInputExample FAILED.\r\n");
      }
   }


   {
      XStatus status;
      
      print("\r\nRunning EmacPolledExample() for Ethernet_MAC...\r\n");
      status = EmacPolledExample(XPAR_ETHERNET_MAC_DEVICE_ID);
      if (status == 0) {
         print("EmacPolledExample PASSED\r\n");
      }
      else {
         print("EmacPolledExample FAILED\r\n");
      }
   }
   /*
    * Disable cache and reinitialize it so that other
    * applications can be run with no problems
    */
   #if XPAR_MICROBLAZE_0_USE_DCACHE
      microblaze_disable_dcache();
      microblaze_init_dcache_range(0, XPAR_MICROBLAZE_0_DCACHE_BYTE_SIZE);
   #endif

   #if XPAR_MICROBLAZE_0_USE_ICACHE
      microblaze_disable_icache();
      microblaze_init_icache_range(0, XPAR_MICROBLAZE_0_CACHE_BYTE_SIZE);
   #endif


   print("-- Exiting main() --\r\n");
   return 0;
}

