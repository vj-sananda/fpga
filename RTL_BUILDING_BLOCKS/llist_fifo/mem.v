`timescale 1ns/1ns

module mem (/*AUTOARG*/
   // Outputs
   dout, 
   // Inputs
   clk, din, addr, wr
   ) ;

   parameter dwidth = 8 ;//data bus width
   parameter awidth = 8 ;//addr bus width
   parameter size   = 256 ;//Size of memory array
   
   input clk ;
   input [ dwidth-1 : 0] din ;
   input [ awidth-1 : 0] addr ;   
   input 		 wr ;
   
   output [ dwidth-1 : 0] dout ;

   wire [ dwidth-1 : 0]  din ;   
   reg [dwidth-1 : 0] 	  mem [ size-1:0 ] ;
   reg [dwidth-1 : 0] 	  dout ;
   
   always @(posedge clk)
     if (wr === 1'b1)
       mem[addr] <= din ;
     else
       dout <= mem[addr] ;

endmodule
   
