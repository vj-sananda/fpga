module enable_reg (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   clk, rst, en, din
   );

   input clk,rst;

   input en;

   output [31:0] q;

   input [31:0]  din;

   reg [31:0] 	 q_rd,q_wd;

   wire [31:0] 	 q = q_rd;
   
   always @(posedge clk)
     if (rst)
       q_rd <= 0;
     else
       q_rd <= q_wd ;


   always @*
     begin
	q_wd = q_rd;

	if ( en )
	  q_wd = din;
     end
   

endmodule // enable_reg
