// Command line: conv.prl -o LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/hs32_div_top.x.v -makedeps\
//                LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/hs32_div_top.x.v.prereqs -vdefines var/VDEFINES\
//                -vincdirs var/VINCDIRS LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/hs32_div_top.x.vpp_out -mc -md\
//                -dy . -macrospec LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/lib/verilog/conv_macro_specs.yaml\
//                +define+ABV=ABV
// Working dir: /proj/jg_users/arch/bkwan/jg_DIVIDER/simenv/build/jg_1r
// Revision: 1.56 
// Source file: LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/hs32_div_top.x.vpp_out
// 1 LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/hs32_div_top.x
//================================================================================================================================
//
// Copyright (c) 2010 by Advanced Micro Devices, Inc.
//
// This file is protected by Federal Copyright Law, with all rights reserved. No part of this file may be reproduced, stored in a
// retrieval system, translated, transcribed, or transmitted, in any  form, or by any means manual, electric, electronic, 
// mechanical, electro-magnetic, chemical, optical, or otherwise, without prior explicit written permission from Advanced Micro
// Devices, Inc.
//
//================================================================================================================================



module hs32_div_top(
CCLK,
SSE,
al_is_DivIssue1_8,
al_is_Div8Divh1_8,
al_is_SignedMulDiv1_8,
al_is_DualResMulDiv1_8,
al_is_ResEnable1_8,
Dividend_hi,
Dividend_lo,
Divisor,
AttemptDivSteal2_6,
AttemptDivSteal1_6,
DivError_8,
DivResBus_8
);


input         CCLK;
input         SSE;

input         al_is_DivIssue1_8;   // Divide op issued in _8

input         al_is_Div8Divh1_8;          // div8/divh/idiv8/idivh op
input         al_is_SignedMulDiv1_8;      // signed divide op (idiv8/idivl/idivh)
input         al_is_DualResMulDiv1_8;     // double-op divides (divl/divh/idivl/idivh)
input [3:0]   al_is_ResEnable1_8;         // dest enables. 0: bits 7:0; 1: bits 15:8; 2: 31:0; 3: 63:32
 
input [63:0]  Dividend_hi;
input [63:0]  Dividend_lo;
input [63:0]  Divisor;

	   

 
output        AttemptDivSteal2_6; 
output        AttemptDivSteal1_6;
            
output        DivError_8;	    

output [63:0] DivResBus_8;

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


// input operands for HS32 divider
wire [63:0] HS32_AOp;
assign HS32_AOp[63:0] = (al_is_DivIssue1_8_d2 & ~al_is_DivIssue1_8_d1 & al_is_DualResMulDiv1_8_d2) ? Divisor[63:0] :       // non-8-bit, divisor
                        (al_is_DivIssue1_8    &  al_is_DualResMulDiv1_8 & al_is_Div8Divh1_8)       ? Dividend_lo[63:0] :   // non-8-bit, lower half of 
                        (al_is_DivIssue1_8_d1 & ~al_is_DualResMulDiv1_8_d1 & al_is_Div8Divh1_8)    ? Divisor[63:0] :       // 8-bit, divisor
                        64'bx; 

wire [63:0] HS32_BOp;
assign HS32_BOp[63:0] = (al_is_DivIssue1_8    &  al_is_DualResMulDiv1_8 & al_is_Div8Divh1_8)       ? Dividend_hi[63:0] :   // non-8-bit, upper half of 
                        (al_is_DivIssue1_8_d1 & ~al_is_DualResMulDiv1_8_d1 & al_is_Div8Divh1_8)    ? Dividend_lo[63:0] :   // 8-bit, dividend (no upper
                        64'bx; 



// Issue signals for HS32 divider
wire HS32_DivIssue2_7;
assign HS32_DivIssue2_7 = al_is_DivIssue1_8 & ~al_is_DivIssue1_8_d1;

wire HS32_DivIssue1_7;
assign HS32_DivIssue1_7 = ~al_is_DivIssue1_8 &  al_is_DivIssue1_8_d1 & al_is_DualResMulDiv1_8_d1; 



// **************************************************************************

// HS32 Integer Divider

DIV ex_div_hs32 (

// CLOCK
// =====
.ExIReset(SSE),
.CCLK05(CCLK),
.FR_Abort_5(1'b0),

// EX -> EXDIV
// ===========
.DivIssue1_7(HS32_DivIssue1_7),
.DivIssue2_7(HS32_DivIssue2_7),

.ExuAFwdM1_8(6'b100000),  // guarantee to select Ex*Op*_8
.ExuBFwdM1_8(6'b100000),
.ExuAFwdM2_8(6'b100000),
.ExuBFwdM2_8(6'b100000),

.EX_ResBus0_9(64'b0),
.EX_ResBus1_9(64'b0),
.EX_ResBus2_9(64'b0),
.DC_ResBusA_11(64'b0),
.DC_ResBusB_11(64'b0),

.ExuAOp1_8(HS32_AOp[63:0]),
.ExuAOp2_8(HS32_AOp[63:0]),

.ExuBOp2_8(HS32_BOp[63:0]),

.ResTag2_7(5'b0),

.EXLateCancelA_11(1'b0),
.EXLateCancelB_11(1'b0),

.ExuCbvsResEnable_7(al_is_ResEnable1_8[3:0]),

.DivCbvsSignedDiv2_7(al_is_SignedMulDiv1_8),
.DivCbvsDualResDiv2_7(al_is_DualResMulDiv1_8),

.ExuCbvsAHighSwap2_7(1'b0),

.FpuSteal2_6(1'b0),
.MulSteal1_6(1'b0),

// EXDIV Outputs
// =============
.DivStatePostscaleOrBroadcastRemainder(),
.DivCancel_8(),

.AttemptDivSteal2_6(AttemptDivSteal2_6),     // Attempt signals sent out to save the AND gate with the fpu and mul steal signals  (these will just be ORd with th
.AttemptDivSteal1_6(AttemptDivSteal1_6),

.DivError_8(DivError_8),

.DivDestTag(),
.DivResBus_8(DivResBus_8[63:0]),
.DivFlags_8()
);



endmodule

