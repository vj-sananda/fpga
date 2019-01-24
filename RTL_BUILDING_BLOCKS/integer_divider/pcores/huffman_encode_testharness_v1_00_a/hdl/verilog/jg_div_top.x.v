// Command line: conv.prl -o LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/jg_div_top.x.v -makedeps\
//                LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/jg_div_top.x.v.prereqs -vdefines var/VDEFINES -vincdirs\
//                var/VINCDIRS LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/jg_div_top.x.vpp_out -mc -md -dy .\
//                -macrospec LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/lib/verilog/conv_macro_specs.yaml +define+ABV=ABV
// Working dir: /proj/jg_users/arch/bkwan/jg_DIVIDER/simenv/build/jg_1r
// Revision: 1.56 
// Source file: LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/jg_div_top.x.vpp_out
// 1 LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/jg_div_top.x
//=======================================================================
//                     Jaguar RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2010 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: jg_div_top.x.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change$
//=======================================================================
// Module Description:
//=======================================================================


`timescale 1ns/1ns


module jg_div_top(
CCLK,
SSE,
al_is_DivIssue1_8,
Dividend_hi,
Dividend_lo,
Divisor,
al_is_Div8Divh1_8,
al_is_SignedMulDiv1_8,
al_is_DualResMulDiv1_8,
al_is_ResEnable1_8,
DivBubble_6,
DivDestTag_6,
DivPrnV_6,
DivPrn_6,
DivResBus_9,
DivFlags_9,
DivError_9,
MostDivBusy_9
);

input         CCLK;                // core clock
input         SSE;                 // scan clock for scan flop slave latch

input         al_is_DivIssue1_8;   // Divide op issued in _8

input  [63:0] Dividend_hi;         // dividend, upper 64 bits 
input  [63:0] Dividend_lo;         // dividend, lower 64 bits 
input  [63:0] Divisor;             // divisor 

input         al_is_Div8Divh1_8;          // div8/divh/idiv8/idivh op
input         al_is_SignedMulDiv1_8;      // signed divide op (idiv8/idivl/idivh)
input         al_is_DualResMulDiv1_8;     // double-op divides (divl/divh/idivl/idivh)
input   [3:0] al_is_ResEnable1_8;         // dest enables. 0: bits 7:0; 1: bits 15:8; 2: 31:0; 3: 63:32

output        DivBubble_6;          // divider result is in effective _6 of ALU scheduler, result will mux into ALU in _9

// these are needed in order to run simulation in full chip
output [5:0]  DivDestTag_6;
output        DivPrnV_6;
output [5:0]  DivPrn_6;

output [63:0] DivResBus_9;          // Divider Result Bus

output [5:0]  DivFlags_9;           // Divider Result Flags
output        DivError_9;           // Divider Fault (divide by zero or quotient too large)

output        MostDivBusy_9;

// Begin nets auto-declared by conv.prl
// End nets auto-declared by conv.prl






// glue logic

reg al_is_DivIssue1_8_d1;
always @(posedge CCLK)
  begin
    if (SSE)
      al_is_DivIssue1_8_d1 <= 1'b0;
    else
      al_is_DivIssue1_8_d1 <= al_is_DivIssue1_8;
  end

reg al_is_DivIssue1_8_d2;
always @(posedge CCLK)
  begin
    if (SSE)
      al_is_DivIssue1_8_d2 <= 1'b0;
    else
      al_is_DivIssue1_8_d2 <= al_is_DivIssue1_8_d1;
  end




reg al_is_DualResMulDiv1_8_d1;
always @(posedge CCLK)
  begin
    if (SSE)
      al_is_DualResMulDiv1_8_d1 <= 1'b0;
    else
      al_is_DualResMulDiv1_8_d1 <= al_is_DualResMulDiv1_8; 
  end

reg al_is_DualResMulDiv1_8_d2;
always @(posedge CCLK)
  begin
    if (SSE)
      al_is_DualResMulDiv1_8_d2 <= 1'b0;
    else
      al_is_DualResMulDiv1_8_d2 <= al_is_DualResMulDiv1_8_d1; 
  end


// input operands for JG divider

wire [63:0] JG_AOp;
assign JG_AOp[63:0] = (al_is_DivIssue1_8    &  al_is_DualResMulDiv1_8 & al_is_Div8Divh1_8) ? Divisor[63:0] :       // non-8-bit, divisor
                      (al_is_DivIssue1_8_d1 &  al_is_DualResMulDiv1_8_d1)                  ? Dividend_lo[63:0] :   // non-8-bit, lower half of dividend
                      (al_is_DivIssue1_8_d1 & ~al_is_DualResMulDiv1_8)                     ? Divisor[63:0] :       // 8-bit, divisor
                      64'bx; 

wire [63:0] JG_BOp;
assign JG_BOp[63:0] = (al_is_DivIssue1_8_d1 &  al_is_DualResMulDiv1_8_d1)                  ? Dividend_hi[63:0] :   // non-8-bit, upper half of dividend
                      (al_is_DivIssue1_8_d1 & ~al_is_DualResMulDiv1_8)                     ? Dividend_lo[63:0] :   // 8-bit, dividend (no upper half ne
                      64'bx; 





// **************************************************************************

// JG Integer Divider

ex_div ex_div(
              .CCLK(CCLK),
              .SDO(),
              .SDI(1'b0), 
              .SSE(SSE),
              
              .FR_Abort_11(1'b0),

              .DivIssue_8(al_is_DivIssue1_8), 
              .DivLateCancel_8(1'b0),

              .Div8Divh_8(al_is_Div8Divh1_8),
              .SignedMulDiv_8(al_is_SignedMulDiv1_8),
              .DualResMulDiv_8(al_is_DualResMulDiv1_8),
              .AHighSwap_8(1'b0),
              .ResEnable_8(al_is_ResEnable1_8[3:0]),

              .EX_ResBus0_10(64'b0),
              .EX_ResBus1_10(64'b0),
              .EX_DcResBus_12(64'b0),
              
              .AFwd9AL0_8(1'b0),  // guarantee to select AOp_9 and BOp_9 
              .AFwd9AL1_8(1'b0), 
              .AFwdP4LS_8(1'b0), 
              .AFwdHi_8(1'b0),
              .BFwd9AL0_8(1'b0),
              .BFwd9AL1_8(1'b0),
              .BFwdP4LS_8(1'b0),  
              .BFwdHi_8(1'b0),
            
              .ResTag_8(6'b0),
              .Prn_8(6'b0),
              .PrnV_8(1'b0),

              .AOp_9(JG_AOp[63:0]),
              .BOp_9(JG_BOp[63:0]),

              .MulBubbleNoLateCancel_6(1'b0),
              
              .DivBubble_6(DivBubble_6),
              .DivDestTag_6(DivDestTag_6[5:0]),
              .DivPrnV_6(DivPrnV_6),
              .DivPrn_6(DivPrn_6[5:0]),

              .DivResBus_9(DivResBus_9[63:0]),
              .DivFlags_9(DivFlags_9[5:0]),      // 6 bits, only AF bit is used for div (from KOS?) 
              .DivError_9(DivError_9),

              .MostDivBusy_9(MostDivBusy_9)
              );

// **************************************************************************






endmodule


`ifdef VCS_SIM

module tb;
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			CCLK;			// To dut of jg_div_top.v
   reg [63:0]		Dividend_hi;		// To dut of jg_div_top.v
   reg [63:0]		Dividend_lo;		// To dut of jg_div_top.v
   reg [63:0]		Divisor;		// To dut of jg_div_top.v
   reg			SSE;			// To dut of jg_div_top.v
   reg			al_is_Div8Divh1_8;	// To dut of jg_div_top.v
   reg			al_is_DivIssue1_8;	// To dut of jg_div_top.v
   reg			al_is_DualResMulDiv1_8;	// To dut of jg_div_top.v
   reg [3:0]		al_is_ResEnable1_8;	// To dut of jg_div_top.v
   reg			al_is_SignedMulDiv1_8;	// To dut of jg_div_top.v
   // End of automatics


   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			DivBubble_6;		// From dut of jg_div_top.v
   wire [5:0]		DivDestTag_6;		// From dut of jg_div_top.v
   wire			DivError_9;		// From dut of jg_div_top.v
   wire [5:0]		DivFlags_9;		// From dut of jg_div_top.v
   wire			DivPrnV_6;		// From dut of jg_div_top.v
   wire [5:0]		DivPrn_6;		// From dut of jg_div_top.v
   wire [63:0]		DivResBus_9;		// From dut of jg_div_top.v
   wire			MostDivBusy_9;		// From dut of jg_div_top.v
   // End of automatics

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

   initial CCLK = 0;
   always #5 CCLK = ~CCLK ;

   initial $fsdbDumpvars;
   
   initial
     begin
	SSE = 1;

	Dividend_hi = 0;
	Dividend_lo = 16'hfd;	
	Divisor = 8'hd;
	al_is_DivIssue1_8 = 0 ;

	al_is_Div8Divh1_8 = 1 ;
	al_is_SignedMulDiv1_8 = 0;

	al_is_DualResMulDiv1_8 = 0;
	al_is_ResEnable1_8 = 1;//1 => 8 bit divisor
	
	tick(5);
	SSE = 0;
     end

   integer i, j;
   integer exp_quotient, exp_remainder;
   
   initial
     begin
	wait(~SSE);
	tick(2);
	al_is_DivIssue1_8 <= 1;
	tick(1);
	al_is_DivIssue1_8 <= 0;
	wait(result_valid[2]);

	for(i=1;i<256;i=i+1)
	  for(j=1;j<256;j=j+1)	  
	    begin
	       tick(1);
	       al_is_DivIssue1_8 <= 1;
	       Dividend_lo <= i & 8'hff;
	       Divisor <= j & 8'hff;
	       tick(1);
	       al_is_DivIssue1_8 <= 0;
	       wait(result_valid[2]);
	       exp_quotient = i/j;
	       exp_remainder = i % j;
	       tick(2);
	       if ( quotient != exp_quotient &&
		    remainder != exp_remainder )
		 $display("FAIL:%d / %d = %d (Exp=%d), Rem=%d (Exp=%d)",
			  Dividend_lo,Divisor,quotient,exp_quotient,
			  remainder,exp_remainder);
	    end

	tick(10);
	$finish;
     end // initial begin
   
   task tick;
      input [31:0] num;
      begin
	 repeat(num) @(posedge CCLK);
      end
   endtask // tick


   
   always @(posedge CCLK)
     begin
	result_valid[0] <= DivBubble_6;
	result_valid[1] <= result_valid[0];	     	
	result_valid[2] <= result_valid[1];
     end

   jg_div_top dut(/*AUTOINST*/
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
		  .al_is_Div8Divh1_8	(al_is_Div8Divh1_8),
		  .al_is_SignedMulDiv1_8(al_is_SignedMulDiv1_8),
		  .al_is_DualResMulDiv1_8(al_is_DualResMulDiv1_8),
		  .al_is_ResEnable1_8	(al_is_ResEnable1_8[3:0]));
   

endmodule
`endif
