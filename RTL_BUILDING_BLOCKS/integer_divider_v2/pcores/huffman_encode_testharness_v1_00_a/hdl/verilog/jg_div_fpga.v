module jg_div_fpga(/*AUTOARG*/
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

   wire 			al_is_DivIssue1_8 = i_valid;

   wire			DivBubble_6;		// From dut of jg_div_top.v
   wire [5:0]		DivDestTag_6;		// From dut of jg_div_top.v
   wire			DivError_9;		// From dut of jg_div_top.v
   wire [5:0]		DivFlags_9;		// From dut of jg_div_top.v
   wire			DivPrnV_6;		// From dut of jg_div_top.v
   wire [5:0]		DivPrn_6;		// From dut of jg_div_top.v
   wire [63:0]		DivResBus_9;		// From dut of jg_div_top.v
   wire			MostDivBusy_9;		// From dut of jg_div_top.v

   output [7:0] quotient ;
   output [7:0] remainder ;
   output 	DivResult ;
   
   reg result_valid [0:2];		  
   reg [7:0] quotient ;
   reg [7:0] remainder ;
   reg 	     DivResult ;

   always @(posedge CCLK)
     begin
	DivResult <= result_valid[2];
	
	if ( result_valid[2] )
	  begin
	     quotient <= DivResBus_9[7:0];
	     remainder <= DivResBus_9[15:8];
	  end
	else
	  begin
	     quotient <= 0;
	     remainder <= 0;
	  end	     
       end

   always @(posedge CCLK)
     begin
	result_valid[0] <= DivBubble_6;
	result_valid[1] <= result_valid[0];	     	
	result_valid[2] <= result_valid[1];
     end

   jg_div_top dut(
		  // Outputs
		  .DivBubble_6		(DivBubble_6),
		  .DivDestTag_6		(DivDestTag_6[5:0]),
		  .DivPrnV_6		(DivPrnV_6),
		  .DivPrn_6		(DivPrn_6[5:0]),
		  .DivResBus_9		(DivResBus_9[63:0]),
		  .DivFlags_9		(DivFlags_9[5:0]),
		  .DivError_9		(DivError_9),
		  .MostDivBusy_9	(MostDivBusy_9),
		  // Inputs
		  .CCLK			(CCLK),
		  .SSE			(SSE),
		  .al_is_DivIssue1_8	(al_is_DivIssue1_8),
		  .Dividend_hi		(Dividend_hi[63:0]),
		  .Dividend_lo		(Dividend_lo[63:0]),
		  .Divisor		(Divisor[63:0]),
		  .al_is_Div8Divh1_8	(1'b1),
		  .al_is_SignedMulDiv1_8(1'b0),
		  .al_is_DualResMulDiv1_8(1'b0),
		  .al_is_ResEnable1_8	(4'b1));
   
endmodule

