#include "dma_intr_handler.h"

//----------------------------------------------------
// INTERRUPT HANDLER FUNCTION
//----------------------------------------------------
// Turn off timer
// Print out processing rate
// Print out canscid counts
//---------------------------------------------------
void dma_intr_handler(void * arg_ptr )
{
  XDmaIntrArgs * ArgPtr = (XDmaIntrArgs *)arg_ptr ;
  u32 idx ;

  //We entered the dma handler on processing being done
  //so shut off timer
  endTiming();
  printf("Shut off timer, in intr handler after streaming (DMA done)\r\n");

  Xuint32 IpStatus;
  XDmaCentral * InstancePtr = ArgPtr->DmaPtr ;
  IpStatus = XDmaCentral_InterruptStatusGet(InstancePtr);

  //DMA done
  //  if (IpStatus & XDMC_IXR_DMA_DONE_MASK ){
  //printf("dma_intr_handler::DMA DONE\r\n");
  //  }

  if (IpStatus & XDMC_IXR_DMA_ERROR_MASK ){
    printf("dma_intr_handler::DMA ERROR\r\n");
  }

  Xuint32 Kraaken_Dpi_Baseaddr = XPAR_KRAAKEN_DPI_0_BASEADDR ;
  Xuint32 data[255];

  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_all_pkts );
  data[count_all_pkts]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ALL_0 );
  data[count_ALL_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);
  

  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ALL_1 );
  data[count_ALL_1]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);
  

  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ALL_2 );
  data[count_ALL_2]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);

  
  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ALL_3 );
  data[count_ALL_3]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ALL_4 );
  data[count_ALL_4]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_finger_0 );
  data[count_finger_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);
  

  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_ftp_0 );
  data[count_ftp_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);

  
  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_http_0 );
  data[count_http_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_imap_0 );
  data[count_imap_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_netbios_0 );
  data[count_netbios_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_nntp_0 );
  data[count_nntp_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_pop3_0 );
  data[count_pop3_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_rlogin_0 );
  data[count_rlogin_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_smtp_0 );
  data[count_smtp_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_telnet_0 );
  data[count_telnet_0]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_finger );
  data[count_CATEGORY_finger]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_ftp );
  data[count_CATEGORY_ftp]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_http );
  data[count_CATEGORY_http]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_imap );
  data[count_CATEGORY_imap]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_netbios );
  data[count_CATEGORY_netbios]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_nntp );
  data[count_CATEGORY_nntp]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_pop3 );
  data[count_CATEGORY_pop3]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_rlogin );
  data[count_CATEGORY_rlogin]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_smtp );
  data[count_CATEGORY_smtp]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET, count_CATEGORY_telnet );
  data[count_CATEGORY_telnet]= KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG3_OFFSET);


  u32 uncateg_susp_pkts = 
    data[count_ALL_0]+data[count_ALL_1]+ data[count_ALL_2] + data[count_ALL_3] + data[count_ALL_4];

  u32 total_categorized_pkts = 
    data[count_CATEGORY_finger]+data[count_CATEGORY_ftp]+data[count_CATEGORY_http]+data[count_CATEGORY_imap]+
    data[count_CATEGORY_netbios]+data[count_CATEGORY_nntp]+data[count_CATEGORY_pop3]+data[count_CATEGORY_rlogin]+
    data[count_CATEGORY_smtp]+data[count_CATEGORY_telnet];

  printf ("Total Pkts processed = %d\r\n", data[count_all_pkts]);
  printf ("Total Suspicious Pkts  = %d\r\n",
	  data[count_finger_0]+data[count_ftp_0]+data[count_http_0]+data[count_imap_0]+
	  data[count_netbios_0]+data[count_nntp_0]+data[count_pop3_0]+data[count_rlogin_0]+
	  data[count_smtp_0]+data[count_telnet_0]+uncateg_susp_pkts);
  
  printf ("Total streams of each cateogry:\r\n");
  printf ("finger:  %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_finger],data[count_finger_0]);
  printf ("ftp:     %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_ftp],data[count_ftp_0]);
  printf ("http:    %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_http],data[count_http_0]);
  printf ("imap:    %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_imap],data[count_imap_0]);
  printf ("netbios: %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_netbios],data[count_netbios_0]);
  printf ("nntp:    %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_nntp],data[count_nntp_0]);
  printf ("pop3:    %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_pop3],data[count_pop3_0]);
  printf ("rlogin:  %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_rlogin],data[count_rlogin_0]);
  printf ("smtp:    %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_smtp],data[count_smtp_0]);
  printf ("telnet:  %8d \t(suspicious packets: %d)\r\n", data[count_CATEGORY_telnet],data[count_telnet_0]);


  printf ("Uncategorized   suspicious packets: %d\r\n", uncateg_susp_pkts);

  //printf ("Total Uncategorized pkts:\r\n= Total pkts(%d) - Total categorized pkts(%d) = %d\r\n",
  //	  data[count_all_pkts],total_categorized_pkts,data[count_all_pkts]-total_categorized_pkts);

  double proc_time = getProcessingTime();
  printf("Total processing time: %lf seconds\r\n", proc_time);

  //Compute using number of Dwords loaded, consistent with benchmark
  //Dwords * 32 * ratio of tag overhead (32/40)
  int input_size_in_bits = ArgPtr->size * 32 * 32 /40  ;//8 bits of tag overhead

  // Note: Speed calculations use 1,000 instead of 1,024. 
  // This is apparently a common misconception.
  double proc_rate = ((double) input_size_in_bits) / 1000000 / proc_time;

  printf("Input size in bits: %d\r\n", input_size_in_bits);
  printf("Average processing rate: %.6lf Mb/s\n", proc_rate);
  if ( proc_rate > 500 )
    printf("SUCCESS: Design Exceeded Required Processing rate\r\n");

  XDmaCentral_InterruptClear(InstancePtr, XDMC_IXR_DMA_DONE_MASK);
}
