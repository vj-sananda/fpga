module jg_add_fpga(/*AUTOARG*/
   // Outputs
   quotient, remainder, DivResult, 
   // Inputs
   CCLK, Dividend_hi, Dividend_lo, Divisor, SSE, i_valid
   );
   
   input			CCLK;			// To dut of jg_div_top.v
   input [63:0]		Dividend_hi;		// To dut of jg_div_top.v
   input [63:0]		Dividend_lo;		// To dut of jg_div_top.v
   input [63:0]		Divisor;		// To dut of jg_div_top.v
   input			SSE;			// To dut of jg_div_top.v
//   input			al_is_Div8Divh1_8;	// To dut of jg_div_top.v
   input			i_valid ;	// To dut of jg_div_top.v
//   input			al_is_DualResMulDiv1_8;	// To dut of jg_div_top.v
//   input [3:0] 			al_is_ResEnable1_8;	// To dut of jg_div_top.v
//   input			al_is_SignedMulDiv1_8;	// To dut of jg_div_top.v

   output [7:0] quotient ;
   output [7:0] remainder ;
   output 	DivResult ;
   
   reg [7:0] quotient ;
   reg [7:0] remainder ;
   reg 	     DivResult ;

   always @(posedge CCLK)
     if (SSE)
       DivResult <= 0;
     else
       begin
	  DivResult <= 0;	
	  if (i_valid)
	    begin
	       {remainder,quotient} <= Dividend_lo + Divisor ;
	       DivResult <= 1;
	    end
       end
   
endmodule

