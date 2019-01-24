module enable_reg2 (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   clk, rst, en, din
   );

   input clk,rst;

   input en;

   output [31:0] q;

   input [31:0]  din;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [31:0]		q;
   // End of automatics

   /*AUTOWIRE*/
   
   always @(posedge clk)
     if (rst)
       q <= 0;
     else
       if ( en )
	 q <= din;

endmodule // enable_reg
