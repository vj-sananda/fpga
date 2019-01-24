#include "accel_sort_util.h"

/*
   Set of util to load global key, start index, reset index etc
 */

//Use 64 bit register writes
XStatus set_global_key(void * baseaddr_p, const unsigned char * key)
{
   Xuint64  data ;
   data.Upper = 0;

   data.Lower = key[0]<<24 | key[1]<<16 | key[2]<<8 | key[3] ;
   ACCEL_SORT_PLB_WriteSlaveReg2(baseaddr_p, &data);
   data.Lower=0x80000001;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 

   data.Lower = key[4]<<24 | key[5]<<16 | key[6]<<8 | key[7] ;
   ACCEL_SORT_PLB_WriteSlaveReg2(baseaddr_p, &data);
   data.Lower=0x80000002;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 

   data.Lower = key[8]<<24 | key[9]<<16 | key[10]<<8 | key[11] ;
   ACCEL_SORT_PLB_WriteSlaveReg2(baseaddr_p, &data);
   data.Lower=0x80000003;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 

   data.Lower = key[12]<<24 | key[13]<<16 | key[14]<<8 | key[15] ;
   ACCEL_SORT_PLB_WriteSlaveReg2(baseaddr_p, &data);
   data.Lower=0x80000004;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 

   return XST_SUCCESS;
}

XStatus get_global_key(void * baseaddr_p)
{
   Xuint64  data ;
   data.Upper = 0;
   Xuint32  key[4];

   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x40000001;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_ReadSlaveReg2(baseaddr_p, &data);
   key[0]=data.Lower;

   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x40000002;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_ReadSlaveReg2(baseaddr_p, &data);
   key[1]=data.Lower;

   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x40000003;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_ReadSlaveReg2(baseaddr_p, &data);
   key[2]=data.Lower;

   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x40000004;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   data.Lower=0x00000008;
   ACCEL_SORT_PLB_WriteSlaveReg3(baseaddr_p, &data); 
   ACCEL_SORT_PLB_ReadSlaveReg2(baseaddr_p, &data);
   key[3]=data.Lower;

   xil_printf("Global_Key = 0x%08x%08x%08x%08x\n\r",
	      key[0],key[1],key[2],key[3] );

   return XST_SUCCESS;
}

XStatus set_start_index(void * baseaddr_p, unsigned int index )
{
   Xuint64  data ;

   data.Upper = 0;
   data.Lower = index;
   ACCEL_SORT_PLB_WriteSlaveReg1(baseaddr_p,&data );

   return XST_SUCCESS;
}

XStatus get_start_index(void * baseaddr_p)
{
   Xuint64  data ;

   ACCEL_SORT_PLB_ReadSlaveReg1(baseaddr_p,&data );
   xil_printf("Start Index = 0x%x%x\n\r",data.Upper,data.Lower);

   return XST_SUCCESS;
}

XStatus write_control_reg(void * baseaddr_p, unsigned int idata)
{
   Xuint64 data ;
   
   data.Upper = 0;
   data.Lower = idata ;

   ACCEL_SORT_PLB_WriteSlaveReg0(baseaddr_p, &data);

  return XST_SUCCESS;
}


XStatus get_control_reg(void * baseaddr_p)
{
   Xuint64 data ;

   ACCEL_SORT_PLB_WriteSlaveReg0(baseaddr_p, &data);
   xil_printf("Control Reg = 0x%x%x\n\r",data.Upper,data.Lower);

  return XST_SUCCESS;
}
