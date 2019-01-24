`timescale 1ns/1ns

//-----------------------------------------------------------
//Dual port RAM
//port 1: read and write
//port 2: read only
//Tested by synthesizing using Xilinx XST, BLOCKRAM inferred
//----------------------------------------------------------

module dpmem (/*AUTOARG*/
   // Outputs
   dout1, dout2,
   // Inputs
   clk1, clk2, din1, addr1, addr2, wr1
   ) ;

   parameter dwidth = 8 ;//data bus width
   parameter awidth = 8 ;//addr bus width
   parameter size   = 256 ;//Size of memory array
   
   input clk1 ;
   input clk2 ;
   
   input [ dwidth-1 : 0] din1 ;
   input [ awidth-1 : 0] addr1 ;
   input [ awidth-1 : 0] addr2 ;      
   input 		 wr1 ;
   
   output [ dwidth-1 : 0] dout1 ;
   output [ dwidth-1 : 0] dout2 ;   

   wire [ dwidth-1 : 0]  din1 ;   
   reg [dwidth-1 : 0] 	  mem [ size-1:0 ] ;
   reg [dwidth-1 : 0] 	  dout1 ;
   reg [dwidth-1 : 0] 	  dout2 ;   
   
   always @(posedge clk1)
     if (wr1 === 1'b1)
       mem[addr1] <= din1 ;
     else
       dout1 <= mem[addr1];

   always @(posedge clk2)   
       dout2 <= mem[addr2] ;

endmodule
   
