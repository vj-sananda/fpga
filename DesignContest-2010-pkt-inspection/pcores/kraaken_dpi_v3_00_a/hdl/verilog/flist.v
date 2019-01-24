//Freelist module
//Just a single port memory with rd and write pointers.
`timescale 1ns/1ps

module flist(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   clk, rst, wr, rd, din
   );

   input clk, rst;

   input          wr ;
   input          rd ;
   input  [5:0]  din ;
   output [5:0] dout ;
   
   reg [5:0] mem [0:63];
   reg [5:0] wr_ptr ;
   reg [5:0] rd_ptr ;

   /*AUTOWIRE*/
   wire [5:0] din ;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [5:0]		dout;
   // End of automatics
   
   always @(posedge clk or posedge rst)
     if ( rst )
       begin
	  wr_ptr <= 0;
	  rd_ptr <= 0;
       end
     else
       begin
	if ( wr )
	  begin
	     mem[wr_ptr] <= din ;
	     wr_ptr <= wr_ptr + 1;
	  end
	  
	if ( rd )
	  begin
	     dout <= mem[rd_ptr];
	     rd_ptr <= rd_ptr + 1 ;
	  end
       end // else: !if( rst )
   
endmodule // flist
