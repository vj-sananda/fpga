//================================================================================================================================
//
// $RCSfile: rtl_exdiv.v,v $
//
// $Revision: 1.1 $
// $Date: 2010/12/08 22:14:14 $
// $Author: vsananda $
// $State: Exp $
// $Locker:  $
//
// Copyright (c) 2002 by Advanced Micro Devices, Inc.
//
// This file is protected by Federal Copyright Law, with all rights reserved. No part of this file may be reproduced, stored in a
// retrieval system, translated, transcribed, or transmitted, in any  form, or by any means manual, electric, electronic, 
// mechanical, electro-magnetic, chemical, optical, or otherwise, without prior explicit written permission from Advanced Micro
// Devices, Inc.
//
//================================================================================================================================

//================================================================================================================================
// SEARCH TAGS
//
//   <Module Description>
//   <Abbreviations>
//   <Verilog Reg Declarations>
//   <Interface Assertions>
//   <Clock & Reset Logic>
//================================================================================================================================

//================================================================================================================================
// <Module Description>
//
// Typical non-8-bit divides:
// |    7        |   8      |   9         |   10     |    11    |    12    |    13     //   13 + n  |  14+n     |  15+n     | 16+n      | 17+n
// | DivIssue2_7 | Get      | Prep for    | prescale | Prep for | prescale | Iterate   // Iterate   | generate  | broadcast | postscale | broadcast
// |             | dividend | prescale    | dividend | prescale | divisor  | n cycles  //           | remainder | quotient  | remainder | remainder
// |             |          | dividend    |          | divisor  |          |           //           |           |           |           |
// |             |          |             | Get      |          |          |           // Steal     |           | Steal     |           |
// |             |          | DivIssue1_7 | Divisor  |          |          |           // Bus 2 for |           | Bus 1 for |           |
// |             |          |             |          |          |          |           // quotient  |           | remainder |           |
//
// Typical 8-bit divides:
// |    7        |   8      |   9         |   10     |    11    |    12    |    13     //   13 + n  |  14+n     |  15+n     | 16+n      | 17+n
// | DivIssue2_7 | Get      | Prep for    | prescale | Prep for | prescale | Iterate   // Iterate   | generate  | doesnt    | postscale | broadcast
// |             | dividend | prescale    | dividend | prescale | divisor  | n cycles  //           | remainder | broadcast | remainder | remainder
// |             |          | dividend    |          | divisor  |          |           //           |           | quotient  |           | (and quotient)
// |             |          |             |          |          |          |           //           |           | Steal     |           |
// |             |          |             |          |          |          |           //           |           | Bus 1 for |           |
// |             |          |             |          |          |          |           //           |           | remainder |           |
//
// Divide by zero:
// |    7        |   8      |   9         |   10     |    11    |    12    |  13       |  14       |    15     |    16     |    17     |
// | DivIssue2_7 | Get      | Prep for    | prescale | Prep for | prescale | pause     | gen       | broadcast | postscale | broadcast |
// |             | dividend | prescale    | dividend | prescale | divisor  | for       | remainder | quotient  | remainder | remainder |
// |             |          | dividend    |          | divisor  |          | steal     |           |           |           |           |
// |             |          |             |          |          |          | Steal     | really    | broadcast | dont care | dont care |
// |             |          |             |          |          |          | Bus 1 for | does      | div error |           |           |
// |             |          |             |          |          |          | div error | nothing   |           |           |           |
//
//
// --------------------------------------------------------------------------------------------------------------------------------------------
//
// Divider description:
// 
// This integer divider is a 2 bit per cycle SRT divider with a hardware frontend prescaler.  
// Upon receiving an operand, the divider spends a cycle calculating a shift amount used to left shift
// the leading 1 or 0 into a given position.  This is referred to as PrescaleCount below.  The next
// cycle is the shift (Prescale).  In all types of divided, the dividend is prescaled first followed by 
// the divisor.  During the divisor prescaling, the number of iterations is calculated (basically difference in number
// of dividend and divisor bits divided by two).  Then begins the iteration.  Each iteration step generates a
// partial remainder that is composed of a redundant (sum and carry) representation in the lower bits with a fully
// added 6-bit representation in the most significant bits.  Its this 6 bit result that is the lookup into the 
// table that selects what we do the next iteration.  Each iteration we take the partial remainder (2 operands)
// and either add or subtract 0,1,2, or 3 times the divisor (represented as two more operands of +/-divisor and +/-(2*divisor)
// These four operands go to a 4:2 compressor, the lower bits of which represent the redundant least significant bits of the
// partial remainder.  The upper bits are further added together.  These values are flopped and prepared for the next cycle.
// As you can see, since the lower bits of the partial remainder are held in redundant (sum and carry) format, there could
// be a carryout that adds one to the upper bits and thus change where we would lookup in the table.  However, the
// table is designed with one purpose: to ensure that after each iteration, the partial remainder is less than or equal in
// magnitude to the divisor.  There is enough overlap in the entries of the table that if we get into the situation
// when the lower bits would have added one to the upper bits, we'd still fulfill the requirement that the partial remainder
// is equal to or less than the divisor.  
// Each cycle we left shift (multiply by 4) the partial remainder and generate 2 bits of quotient.  The quotient bits
// shift and adjust a group of registers that calculate the quotient Q, Q+1 and Q-1.  Based upon the need for a fixup,
// the final quotient will be selected from one of these three.  
// After iterating, we examine the partial remainder and must perform a fixup in various situations:
//  1) the remainder sign must equal the dividend sign, if not, add or subtract a divisor to achieve this (and appropriately select
//	Q+1 or Q-1 as the final quotient.
//  2) the remainder must be less than the divisor.  There are times when the remainder equals the divisor in magnitude, and
//      so we must add or subtract divisor in such cases (implying that the final remainder will be zero).  
// After fixing the remainder, we are left with a normalized (left shifted) remainder and thus must postscale it.
// For this step we transfer the remainder to another register and reuse the prescaler (left shifter) to effectively
// right shift it.  At that point we are done.
//
// The divider, like the popcnt block and FP, must announce that it will steal the EX result bus and jam
// the result into the generated bubble.  FP and multiplier steals get precedence over the divider and the divider
// will wait patiently, attempt to steal the bus each cycle until it succeeds.  In the case of the divides requiring
// two results on two registers, it broadcasts the quotient first followed by the remainder.
//
// Divide op specification:
//              quot:rem,    src1,    src2
// F6 /6   DIV  AL:AH,       AX,      reg/mem
// F7 /6   DIV  *AX:*DX,     *DX:*AX, reg/mem
// F6 /7   IDIV AL:AH,       AX,      reg/mem
// F7 /7   IDIV *AX:*DX,     *DX:*AX, reg/mem
// 
//                HighA Rd/Wr  RegA             Rd/Wr  RegB         Rd/Wr RegC                Flg0 R/W   FlgZ R/W  FlgZAPS R/W
//                    -  ---   --------------    ---   ---   -----------  ---------           --------   --------  -----------
// F6 /x (single):
// UC_OP_(I)DIV8      1  1/0   reg/mem8(base)    1/1   EAX    ~reg-reg/0  sib(index)             /0         /0         /1
// 
// F7 /x (double):
// UC_OP_(I)DIVL      0  1/0   reg/mem(base )    0/1   EAX    ~reg-reg/0  sib(index)             /0         /0         /1
// UC_OP_(I)DIVH      0  1/0   EAX               1/1   EDX           0/0  sib(index)             /0         /0         /1
//
//
// Divide Issue mechanism:
// Since some divides are single ops (slot2 only), and others are double ops (slot1 and 2), we are forcing all
// divides to issue their slot2 op first.  This relieves the possibility of separate divides from slot1 and slot2
// issuing concurrently and requiring a mechanism to prioritize.  Additionally, by limiting the number of operand 
// flops in the divider, we require the slot1 op to issue at least 2 cycles after the slot2 op.  As such, 
// any late cancel of slot1 data doesnt have the opportunity to cancel the fact that the slot2 op issued (slot2's
// op has at that point been dropped out of the reservation station).  No big deal, you'd think, just wait
// around until the valid data finally does come from LS.  The thing is LS can get in a special situation that
// requires the memory op to be nonspeculative (if the read is uncacheable or causes a protection fault).
// In that case, if the divide was not the oldest divide, we would be hardlocked.  
// So, we need a mechanism to handle the issuing of divides correctly.  First, slot1 informs slot2 
// of the oldest, ready divide (not late cancelled) via a valid bit and dest tag.  If the other operands are ready in slot2 and the divider
// isnt busy, slot2 will issue its op and xmit the issued dest tag back to slot1.  Slot 1 will match the dest tag
// to complete the readiness and issue of the corresponding op.  
//

// NOTE: We never get memory data on the B Bus.  The forwarding muxes depend on this assumption.
//
// NOTE: the memory data in the F7 (double) case needs to be in the low position.  This is due
// to an endcase with respect to LS.  If the memory op is in slot 2, and has a TLB miss that requires
// the op to be nonspeculative, it will never match since the FR commit pointer will point to slot 1
// and not slot2 - so LS never matches and calls it nonspeculative.  so we always miss.  Therefore,
// ensuring the memory data to be in slot 1 prevents this.  This is unique to the double F7 divide
// since they must issue together (fastpath doubles dont have this problem since they can issue and
// complete separately.  the commit pointer will move from the low half to the high half after the low
// completes.)
//
// NOTE: Was originally going with allowing non-8-bit divides to issue slot1 first.  This causes problems
// with the issue of slot2 in that an 8-bit divide that becomes ready before the corresponding non-8-bit slot 2 divide
// issues can issue instead and goof the whole thing up.  Would need a new mechanism to prevent that.
// It is simpler to just force the slot2 op to issue first.  DivBusy would then always prevent any other slot2 op from issuing.
//
//
// NOTE: This divider doesnt optimize special cases like:
//  1) obvious quotient too large
//  2) divide by zero
//  3) dividend equals zero 
//  4) divisor equals one
//  Most performance comes from just moving divide from ucode to fastpath.  Exception cases like #1 and #2 are probably very uncommon.
//  A dividend of zero already skips the iteration step, so there's not much to gain there.  A divisor of one may save
//  a significant number of iteration steps, but based on the average number of quotient bits, its probably not too big.  Certainly
//  some performance can be improved with these optimizations, but its probably negligible and probably not worth the complexity and
//  potential bugginess.
//================================================================================================================================
// TESTED:
//
//================================================================================================================================
//  Divide state description:
//
// cycle:
// 1) DIVStateIdle
//      for 8-bit divides, the dividend and divisor are both received here.  otherwise, only dividend is received.
//      XH <= BOpBus2[63:0]                      (dividend)
//       D <= AOpBus2[15:8] or [7:0]             (divisor for 8-bit (I)DIV)
//      XL <= 8 bit divide ? 64'b0 : AOpBus2_8[63:0]  (lower half of dividend for non-8-bit divides)
//      CH <= 62'b0;
//      goto DIVStatePrescaleCountDividend
// 
// 2) DIVStatePrescaleCountDividend
//    ShiftAmtD[6:0] <= PrescaleCount (XH:XL)   (
//    XL <= XL << 48 or 32.   concatentate dividend for 16 and 32 bit divides (effectively remove unneeded bits between dividend halves in upper XL)
//    (detect divisor=0)
//    goto DIVStatePrescaleDividend
// 
// 3) DIVStatePrescaleDividend
//      D  <= XL << ShiftAmtD[6:0]             if non-8-bit divide (to transport temporarily to D while capturing divisor in XL)
//      XH <= XH,XL << ShiftAmtD[6:0]          upper prescaled dividend in XH
//      XL <= 8 bit divide? D : AOpBus1_8      move divisor into XL to prepare to prescale
//      initialize Q, QM, QP
//      goto DIVStatePrescaleCountDivisor if DivIssue1_8 and it isnt canceled
// 
// 4) DIVStatePrescaleCountDivisor
//    ShiftAmtX[6:0] <= PrescaleCount (XL)
//    goto DIVStatePauseForSteal if divisor is zero, else DIVStatePrescaleDivisor
//    
// 5) DIVStatePrescaleDivisor
//      D <= XL << ShiftAmtX
//      XH <= {XH, D} << 1  (extra 1-bit left shift if we detect an odd number of quotient bits (to make it even)
//      XL <= D << 1 or 0   (extra 1-bit left shift if we detect an odd number of quotient bits, also to return lower dividend back to XL
//      Determine divisor lookup bits
//      Determine # of iterations
//      goto DIVStatePauseForSteal if # of iterations = 0, else DIVStateIterate
// 
// 6) DIVStateIterate
// 
//    top 6 bits of XH & divisor bits (in XH) select from table
// 	value of q.  
//    a 2-bit left shifted Sum (XH) and Carry (CH), +-2D and +-D (or zero) go to 4:2 compressor
//    Upper bits are added
// 
//    XH and CH[63:0] <= ({XH[63:0] << 1'b1}  +  Mux2D[63:0]  +  MuxD[63:0]
//    top 6 bits of XH are full CPA
// 
//    previous value of Q, QM, and QP, with some logic generate new quotient bits shifted
// 	into QP, XL, and QM flops next clock edge
//    XL <= XL<<2
//     Q <= Q bits
//    QM <= QM bits
//    QP <= QP bits
// 
// 
// at this point:
// XH = dividend
// upper bits of XH = upper bits of partial remainder
// lower bits of XH = Sum bits that form partial remainder with CH
// CH = carry bits that form partial remainder with XH
// XL = dividend bits to right of XH that shift into XH
// Q, QM, QP = quotient value, plus1 and minus1
// 
//    If IterateDone, signal steal (for non-8-bit divides)
//    goto DIVStateGenRemainder
// 
// 7) DIVStatePauseForSteal
// 
//    Signal AttemptSteal1
//    goto DIVStateGenRemainder
// 8) DIVStateGenRemainder
//    XL <= Add sum and carry to get final remainder (XH + CH)
//    D <= ~D or D  (conditionally 1s complement divisor in preparation for remainder fixup)
//    FinalRemainderIsZero <= XH+CH==0
//    FinalRemainderIsDivisor <= XH+CH==+/-D
//    ReattemptSteal1 if the Mulitplier got priority last cycle and assserted MulSteal1
//    goto DIVStateBroadcastQuotient
//
// 9) DIVStateBroadcastQuotient
//    Determine FixupNeeded
//    DivRes = merge data with Q, QM, or QP (quotient)
//    XH <= all ones or zeros (to Sign extend remainder)
//    XL <= if (fixup needed) Remainder + D
//    ShiftAmt <= Number of divisor bits (prepare to postscale the remainder)
//    Continue to ReattemptSteal if the multiplier keeps getting priority with MulSteal1
//    stay here until we successfully jam the quotient (non-8-bit divides only)
//    signal AttemptSteal2
//    goto DIVStatePostscaleRemainder if the steal attempt was successful (no FpuSteal2)
// 
// 10) DIVStatePostscaleRemainder
//     XH <=  XL << ShiftAmt (postscale remainder)
//     goto DIVStateBroadcastRemainder
//
// 11) DIVStateBroadcastRemainder
//     DivRes = merge data with XH (remainder)
//     goto DIVStateIdle
//
//================================================================================================================================
// TODO:
//  1) area is flop constrained - look to remove flops
//  2) Clark proposed overloading the O or Z tags with the tag of the last divide to be dispatched.  This becomes a
// new dependency that forces the divides to execute in order.  It would prevent the problem with slot1 issueing first as
// described above.  Need to research whether we think we can do this.  Proposal, in slot2 set dependency on O Flag based upon
// the reg or mem data in slot1, bus A.  This means adding a mux in the OTag and Valid path to EXSLICE.  The ATag and valid
// would go to this mux.  Since ATag and valid are from the FR macro, they are half cycle paths and timing may be tight
// Implementation will review.  With this feature, we dont need the ExuDivReady logic.  (Still need the RsvMatchDiv logic
// on ready to ensure that only corresponding divides in slot1 issue after their partner in slot2.  TODO: research this further
//
//================================================================================================================================
// <Abbreviations>
//   
// Clo = Count Leading Ones
// Clz = Count Leading Zeros
// Ctz = Count Trailing Zeros
//
//================================================================================================================================

`timescale 1ps/1ps


`define DATA 63:0
`define RESFLAG_OSZAPC  5:0

`include "uc_field.d"
`include "ex_div.d"



//*******************
// Integer Divider
//*******************

module DIV (

// define default clock and edge to use for assertions in this module
// // ova clock posedge CCLK05; 

// CLOCK
// =====
input          ExIReset,
input          CCLK05,
input          FR_Abort_5,

// EX -> EXDIV
// ===========
input          DivIssue1_7,
input          DivIssue2_7,	    
            
input    [5:0] ExuAFwdM1_8,  //forwarding sigs for slot1
input    [5:0] ExuBFwdM1_8,
//! unused ExuBFwdM1_8[2:0]
//! unused ExuBFwdM1_8[5]	    	    
input    [5:0] ExuAFwdM2_8,
input    [5:0] ExuBFwdM2_8,

input  [`DATA] EX_ResBus0_9,
input  [`DATA] EX_ResBus1_9,
input  [`DATA] EX_ResBus2_9,
input  [`DATA] DC_ResBusA_11,
input  [`DATA] DC_ResBusB_11,
      
input  [`DATA] ExuAOp1_8,
input  [`DATA] ExuAOp2_8,
input  [`DATA] ExuBOp2_8,

input    [6:2] ResTag2_7,

input          EXLateCancelA_11,
input          EXLateCancelB_11,
	    // 	    
input    [3:0] ExuCbvsResEnable_7,

input          DivCbvsSignedDiv2_7,
input          DivCbvsDualResDiv2_7,
	    
input          ExuCbvsAHighSwap2_7,
	    
// Need to know if mul or fp or clz, or popcnt are stealing so that Div will deprioritize and try to steal again next cycle
input          FpuSteal2_6,    //steals in 2 cycles
input          MulSteal1_6,    //steals in 2 cycles

	    
// EXDIV Outputs
// =============
output reg         DivStatePostscaleOrBroadcastRemainder,
output reg         DivCancel_8,
	    
output reg         AttemptDivSteal2_6,     // Attempt signals sent out to save the AND gate with the fpu and mul steal signals  (these will just be ORd with them at the ex level)
output reg         AttemptDivSteal1_6,
            
output reg         DivError_8,	    

output reg   [6:2] DivDestTag,
output reg [`DATA] DivResBus_8,
output reg [`RESFLAG_OSZAPC] DivFlags_8

);

// RPL generated variable declaration file
`include "incl/rtl_exdiv.reg"

always @ (posedge CCLK05) DivCancel_9 <= DivCancel_8;
//! unused DivCancel_9

//================================================================================
// Assertions for assumptions by Rusinoff in formal proof of divider:
   
// // ova forbid_bool (DivIssue2_8 & (AttemptDivSteal1_6 | AttemptDivSteal2_6),
//                 "Divider error: cannot attempt to steal result bus while issuing a divide!");

// // ova forbid_bool (DivIssue2_8 & (DivState[3:0] != `DIVStateIdle),
//                 "Divider error: cannot issue divide in slot2 while divider is busy!");

// NOTE: we can get an abort in cycle N, but still see DivIssue1_8 in N+1, even though the state machine is now Idle in N+1 (the
// slice just requires an extra cycle to handle the abort   
// // ova forbid_bool (DivIssue1_8 & ~DivCancel_9 & ~((DivState[3:0] == `DIVStatePrescaleDividend) | (DivState[3:0] == `DIVStatePrescaleCountDivisor)),
//                 "Divider error: cannot issue divide in slot1 in any state but PrescaleDividend or PrescaleCountDivisor (unless we Aborted or reset last cycle!");

// // ova forbid_bool ( DivIssue2_8 & (( DualResDiv2_8 & DivisorSize_8[1:0] == `DivisorSize8) |
//                                  (~DualResDiv2_8 & DivisorSize_8[1:0] != `DivisorSize8)),
//                   "Divider error: DualResDiv2_8 doesnt match size of DivisorSize_8!");
   
//=== Control logic ================================================================================

always @* begin

  // translate ResEnable into old ExuSize form on the way in
  case (ExuCbvsResEnable_7[3:0])
    4'b0001,
    4'b0010 : DivisorSize_7[1:0] = `DivisorSize8;   //  8
    4'b0011 : DivisorSize_7[1:0] = `DivisorSize16;  // 16
    4'b0111 : DivisorSize_7[1:0] = `DivisorSize32;  // 32
    4'b1111 : DivisorSize_7[1:0] = `DivisorSize64;  // 64
    default : DivisorSize_7[1:0] = 2'bx;            //! TRUE_DEFAULT
  endcase

end

always @(posedge CCLK05) begin

// We can get an abort during DivIssue2_7 and we must not start the state machine.  one cycle before and the reservation station is cleared - no issue.  one cycle after and DivCancel handles it
   DivIssue2_8 <= DivIssue2_7 & ~FR_Abort_5;
   DivIssue1_9 <= DivIssue1_8;
   DivIssue1_8 <= DivIssue1_7;

// DivIssue2_7 doesnt arrive early enough to gate these:                  
   SignedDiv2_8       <= DivCbvsSignedDiv2_7;
   DualResDiv2_8      <= DivCbvsDualResDiv2_7;
   AHighSwap2_8       <= ExuCbvsAHighSwap2_7;
   DivisorSize_8[1:0] <= DivisorSize_7[1:0];
   DivDestTag_8[6:2]  <= ResTag2_7[6:2];      

   if (DivIssue2_8) begin
     SignedDiv2       <= SignedDiv2_8;      
     DualResDiv2      <= DualResDiv2_8;     
     DivisorSize[1:0] <= DivisorSize_8[1:0];
     DivDestTag[6:2]  <= DivDestTag_8[6:2];
   end


   //--------------------------------------------------------------------------------
   // DIVIDE STATE MACHINE
   //

// Enable DivState flops if a new divide is coming in, the state machine is busy, or an ExIReset

  if (DivIssue2_8 | (| DivState[3:0]) | ExIReset) begin
   case (1'b1)
     (DivIssue2_8                                                                                                          & ~DivCancel_8) : DivState[3:0] <= `DIVStatePrescaleCountDividend;
// If we have a late cancel, go back to Idle
     ((DivState[3:0] == `DIVStatePrescaleCountDividend) & ~Div2LateCancel_9                                                & ~DivCancel_8) : DivState[3:0] <= `DIVStatePrescaleDividend;
     ((DivState[3:0] == `DIVStatePrescaleDividend)                                                                         & ~DivCancel_8) : DivState[3:0] <= `DIVStatePrescaleCountDivisor;
// if we didnt get a DivIssue1_8 in PrescaleDividend (or we did and it was late cancelled), wait in PrescaleCountDivisor for the data that isnt cancelled
     ((DivState[3:0] == `DIVStatePrescaleCountDivisor) & DualResDiv2  & (~DivIssue1_9 | Div1LateCancel_9)                  & ~DivCancel_8) : DivState[3:0] <= `DIVStatePrescaleCountDivisor;
     ((DivState[3:0] == `DIVStatePrescaleCountDivisor) & ~DivisorZero & ((DivIssue1_9 & ~Div1LateCancel_9) | ~DualResDiv2) & ~DivCancel_8) : DivState[3:0] <= `DIVStatePrescaleDivisor;
     ((DivState[3:0] == `DIVStatePrescaleCountDivisor) &  DivisorZero & ((DivIssue1_9 & ~Div1LateCancel_9) | ~DualResDiv2) & ~DivCancel_8) : DivState[3:0] <= `DIVStatePauseForSteal;
     ((DivState[3:0] == `DIVStatePrescaleDivisor) & (IterationCountNext[6:0] != 7'b0)                                      & ~DivCancel_8) : DivState[3:0] <= `DIVStateIterate;               
     ((DivState[3:0] == `DIVStatePrescaleDivisor) & (IterationCountNext[6:0] == 7'b0)                                      & ~DivCancel_8) : DivState[3:0] <= `DIVStatePauseForSteal;
     ((DivState[3:0] == `DIVStateIterate) & ~IterateDone                                                                   & ~DivCancel_8) : DivState[3:0] <= `DIVStateIterate;
     ((DivState[3:0] == `DIVStateIterate) & IterateDone                                                                    & ~DivCancel_8) : DivState[3:0] <= `DIVStateGenRemainder;
     ((DivState[3:0] == `DIVStatePauseForSteal)                                                                            & ~DivCancel_8) : DivState[3:0] <= `DIVStateGenRemainder;
     ((DivState[3:0] == `DIVStateGenRemainder)                                                                             & ~DivCancel_8) : DivState[3:0] <= `DIVStateBroadcastQuotient;
     ((DivState[3:0] == `DIVStateBroadcastQuotient) & DualResDiv2 & ~DivSteal1_8                                           & ~DivCancel_8) : DivState[3:0] <= `DIVStateBroadcastQuotient;
     ((DivState[3:0] == `DIVStateBroadcastQuotient) & (~DualResDiv2 | DivSteal1_8)                                         & ~DivCancel_8) : DivState[3:0] <= `DIVStatePostscaleRemainder;
     ((DivState[3:0] == `DIVStatePostscaleRemainder)                                                                       & ~DivCancel_8) : DivState[3:0] <= `DIVStateBroadcastRemainder;
     ((DivState[3:0] == `DIVStateBroadcastRemainder) & ~DivSteal2_8                                                        & ~DivCancel_8) : DivState[3:0] <= `DIVStateBroadcastRemainder;
// default for cancels, DivSteal2_8 on BroadcastRemainder, Reset, Div2LateCancel_9 with no immediate issue.  Implementation prefers default to Idle
     default                                                                                                                               : DivState[3:0] <= `DIVStateIdle;       //! TRUE_DEFAULT
   endcase 

   DivStateGenRemainder <= ((DivState[3:0] == `DIVStateIterate) & IterateDone & ~DivCancel_8) | 
			   ((DivState[3:0] == `DIVStatePauseForSteal)         & ~DivCancel_8);
     
   DivStatePostscaleOrBroadcastRemainder <= ((DivState[3:0] == `DIVStateBroadcastQuotient) & (~DualResDiv2 | DivSteal1_8) & ~DivCancel_8) | 
                                            ((DivState[3:0] == `DIVStatePostscaleRemainder) & ~DivCancel_8) | 
			                    ((DivState[3:0] == `DIVStateBroadcastRemainder) & ~DivSteal2_8 & ~DivCancel_8);
     
     
  end //if (DivIssue2_8 | (| DivState[3:0]) | ExIReset) begin


// DivBusy now performed out in EX to fix timing path.
//   DivBusy_8 <= (DivBusy_8 | DivIssue2_7) & 
//		~DivCancel_8 & 					                     // ireset or abort
//		~(Div2LateCancel_9 & ~DivIssue2_7) &	  	                     // late cancel and not an immediate reissue       
//		~((DivState[2:0] == `DIVStateBroadcastRemainder) & DivSteal2_8);    // normal end of divide

end
   

// === DATAPATH ====================================================================================
   
// forwarding muxes
always @* begin
  case (1'b1)
    ExuAFwdM1_8[0] : AOpBus1_8[`DATA] =  EX_ResBus0_9[`DATA];
    ExuAFwdM1_8[1] : AOpBus1_8[`DATA] =  EX_ResBus1_9[`DATA];
    ExuAFwdM1_8[2] : AOpBus1_8[`DATA] =  EX_ResBus2_9[`DATA];
    ExuAFwdM1_8[3] : AOpBus1_8[`DATA] =  DC_ResBusA_11[`DATA];
    ExuAFwdM1_8[4] : AOpBus1_8[`DATA] =  DC_ResBusB_11[`DATA];
    ExuAFwdM1_8[5] : AOpBus1_8[`DATA] =  ExuAOp1_8[`DATA];
    default        : AOpBus1_8[`DATA] =  64'bx;                 //! TRUE_DEFAULT
  endcase
  
  case (1'b1)
    ExuAFwdM2_8[0] : AOpBus2_8[`DATA] =  EX_ResBus0_9[`DATA];
    ExuAFwdM2_8[1] : AOpBus2_8[`DATA] =  EX_ResBus1_9[`DATA];
    ExuAFwdM2_8[2] : AOpBus2_8[`DATA] =  EX_ResBus2_9[`DATA];
    ExuAFwdM2_8[3] : AOpBus2_8[`DATA] =  DC_ResBusA_11[`DATA];
    ExuAFwdM2_8[4] : AOpBus2_8[`DATA] =  DC_ResBusB_11[`DATA];
    ExuAFwdM2_8[5] : AOpBus2_8[`DATA] =  ExuAOp2_8[`DATA];
    default        : AOpBus2_8[`DATA] =  64'bx;           //! TRUE_DEFAULT
  endcase
  
// NOTE: we never get mem data on reg B
  case (1'b1)
    ExuBFwdM2_8[0] : BOpBus2_8[`DATA] =  EX_ResBus0_9[`DATA];
    ExuBFwdM2_8[1] : BOpBus2_8[`DATA] =  EX_ResBus1_9[`DATA];
    ExuBFwdM2_8[2] : BOpBus2_8[`DATA] =  EX_ResBus2_9[`DATA];
    ExuBFwdM2_8[3] : BOpBus2_8[`DATA] =  DC_ResBusA_11[`DATA];
    ExuBFwdM2_8[4] : BOpBus2_8[`DATA] =  DC_ResBusB_11[`DATA];
    ExuBFwdM2_8[5] : BOpBus2_8[`DATA] =  ExuBOp2_8[`DATA];
    default        : BOpBus2_8[`DATA] =  64'bx;              //! TRUE_DEFAULT
  endcase
// memory data only on DivB from slot 2, and hence can only cancel slot 2
  Div1LateCancel_8 = ((ExuAFwdM1_8[3] | ExuBFwdM1_8[3]) & EXLateCancelA_11 & DivIssue1_8) |
                     ((ExuAFwdM1_8[4] | ExuBFwdM1_8[4]) & EXLateCancelB_11 & DivIssue1_8);
   
//DivCancel_8 wipes out everything.  A late cancel from the DC on the slot1 op only stalls the exdiv statemachine
// Div2LateCancel_8 sends us back to idle  a cycle later to fix timing
// NOTE: this is duplicated in EX to make timing on DivBusy.
  Div2LateCancel_8 = ((ExuAFwdM2_8[3] | ExuBFwdM2_8[3]) & EXLateCancelA_11 & DivIssue2_8) |
                     ((ExuAFwdM2_8[4] | ExuBFwdM2_8[4]) & EXLateCancelB_11 & DivIssue2_8);

// Note: if DivCancel_8 changes, refer to DivBusy equation in rtl_ex.v to reset.
  DivCancel_8 = FR_Abort_5 |
		ExIReset;

  case ({DivisorSize_8[1:0], DualResDiv2_8, SignedDiv2_8})
    {`DivisorSize8, 1'b0, 1'b0}  : DividendSign_8 = 1'b0;                              // 8-bit unsigned divide
    {`DivisorSize8, 1'b0, 1'b1}  : DividendSign_8 = BOpBus2_8[15];                     // 8-bit signed divide     
    {`DivisorSize16, 1'b1, 1'b0} : DividendSign_8 = 1'b0;                              // 16-bit unsigned divide
    {`DivisorSize16, 1'b1, 1'b1} : DividendSign_8 = BOpBus2_8[15];                     // 16-bit signed divide     
    {`DivisorSize32, 1'b1, 1'b0} : DividendSign_8 = 1'b0;                              // 32-bit unsigned divide
    {`DivisorSize32, 1'b1, 1'b1} : DividendSign_8 = BOpBus2_8[31];                     // 32-bit signed divide     
    {`DivisorSize64, 1'b1, 1'b0} : DividendSign_8 = 1'b0;                              // 32-bit unsigned divide
    {`DivisorSize64, 1'b1, 1'b1} : DividendSign_8 = BOpBus2_8[63];                     // 63-bit signed divide     
    default                      : DividendSign_8 = 1'bx;                              //! TRUE_DEFAULT
  endcase

  
  case ({DivisorSize[1:0], SignedDiv2})
    {`DivisorSize16, 1'b0} : DivisorSignDualRes_8 = 1'b0;                                        // 16-bit unsigned divide
    {`DivisorSize16, 1'b1} : DivisorSignDualRes_8 = AOpBus1_8[15];                               // 16-bit signed divide     
    {`DivisorSize32, 1'b0} : DivisorSignDualRes_8 = 1'b0;                                        // 32-bit unsigned divide
    {`DivisorSize32, 1'b1} : DivisorSignDualRes_8 = AOpBus1_8[31];                               // 32-bit signed divide     
    {`DivisorSize64, 1'b0} : DivisorSignDualRes_8 = 1'b0;                                        // 32-bit unsigned divide
    {`DivisorSize64, 1'b1} : DivisorSignDualRes_8 = AOpBus1_8[63];                               // 63-bit signed divide     
    default                : DivisorSignDualRes_8 = 1'bx;                                        //! TRUE_DEFAULT
  endcase

  DivisorSign8bit_8 = SignedDiv2_8 ? (AHighSwap2_8 ? AOpBus2_8[15] : AOpBus2_8[7]) :
				     1'b0;

  DivisorSign_8 = DivIssue2_8 ? DivisorSign8bit_8 : DivisorSignDualRes_8;


  case (DivisorSize_8[1:0])
    `DivisorSize8  : MergeDataA_8[63:0] = {48'bx, 8'bx, 8'hFF};                     //used only for signextension of 8-bit divides
    `DivisorSize16 : MergeDataA_8[63:0] = {AOpBus2_8[63:16],      16'hFFFF};
    `DivisorSize32 : MergeDataA_8[63:0] = {AOpBus2_8[63:32],      32'hFFFFFFFF};  //merge data not needed for 32-bit (zero extended) but the FFF... are needed
    `DivisorSize64 : MergeDataA_8[63:0] = {                       64'hFFFFFFFF_FFFFFFFF};
    default        : MergeDataA_8[63:0] = 64'hx;  //! TRUE_DEFAULT
  endcase

end // always @ *

always @(posedge CCLK05) begin


// MergeDataA will hold the merge data for EAX.   
// NOTE: MergeDataA is used to assist in sign extension of the quotient.  The upper bits of MergeDataA will, of course, hold merge data, but the unused lower
// bits will contain a mask that is left shifted 2 bits per iteration.  The result, 111...10...000 shows where the quotient bits will reside.
// Additionally, the transistion point from 1s to 0s shows where theres a potential carryout of QP (should we need to select it and it is all zeros (implying
// we always selected Q=+3 each iteration and Q is all ones, thus QP=Q+1 which is all zeros with a carryout of 1)
//
// for 8-bit divides, we store the quotient result in MergeDataA while we generate the final remainder
// NOTE exception: merged bits of EAX for 8-bit divides is held in MergeDataB (eases mux in RemainderRes)
  if (DivIssue2_8 | (DivState[3:0] != `DIVStateIdle)) begin
    casez ( {DivIssue2_8, DivisorSize[1:0], DivState[3:0]})
      {1'b1, 2'b??, 4'b????}                             : MergeDataA[63:0] <= MergeDataA_8[63:0];

      {1'b0, `DivisorSize8,  `DIVStateIterate}           : MergeDataA[63:0] <= {MergeDataA[63:8],  MergeDataA[5:0],  2'b00};
      {1'b0, `DivisorSize16, `DIVStateIterate}           : MergeDataA[63:0] <= {MergeDataA[63:16], MergeDataA[13:0], 2'b00};
      {1'b0, `DivisorSize32, `DIVStateIterate}           : MergeDataA[63:0] <= {MergeDataA[63:32], MergeDataA[29:0], 2'b00};
      {1'b0, `DivisorSize64, `DIVStateIterate}           : MergeDataA[63:0] <= {MergeDataA[61:0],                    2'b00};
      {1'b0, `DivisorSize8,  `DIVStateBroadcastQuotient} : MergeDataA[63:0] <= {MergeDataA[63:8], Quotient[7:0]};
      default                                            : MergeDataA[63:0] <=  MergeDataA[63:0];    //! TRUE_DEFAULT
     endcase
  end
   
  if (DivIssue2_8) MergeDataB[63:16] <= BOpBus2_8[63:16];      // RDX merge data for non-byte divides, RAX merge data for byte divides

// NOTE: Conceptually, its simpler to think of the design conditionally inverting the Divisor during GenRemainder if Divisor Sign equals RemainderSign
//       The problem with that is that we need to get the sign out of the adder and fan it out across 66 gates to invert it.  This is probably a speedpath
//       since the conditional 1s complement was originally in the same path as the adder originally, but then requested to be retimed to the previous cycle by implementation.
//       As such, we will conditionally invert it if DivisorSign doesnt equal DividendSign but then force zeros on the remainder (in the XL register) if FinalRemainderIsDivisor_d1.

// // ova forbid_bool (DivIssue2_8 & (DivState[3:0] != `DIVStateIdle),
//                 "Issue of Divide from slot2 when divide state machine is not in idle!");
  if ((DivState[3:0] != `DIVStateIdle) | DivIssue2_8) begin
    case (1'b1)
      (DivIssue2_8 & ~DualResDiv2_8)                                                    : D[65:0] <= {D[65:10], AHighSwap2_8 ? AOpBus2_8[15:8] : AOpBus2_8[7:0], 2'b00};
      (DivState[3:0] == `DIVStatePrescaleDividend) & DualResDiv2,
      (DivState[3:0] == `DIVStatePrescaleDivisor)                                       : D[65:0] <= {ShiftResFinal[63:0], 2'b00};
      (DivState[3:0] == `DIVStateGenRemainder)                                          : D[65:0] <= (DivisorSign ^ DividendSign) ? ~D[65:0] : D[65:0];   
      default                                                                           : D[65:0] <= D[65:0];  //! TRUE_DEFAULT
    endcase // case(1'b1)

    case (1'b1)
      DivIssue2_8                                                                 : XH[67:0] <= {4'b0000, BOpBus2_8[63:0]};
      ((DivState[3:0] == `DIVStatePrescaleDividend)), 
       (DivState[3:0] == `DIVStatePostscaleRemainder)                             : XH[67:0] <= { {3{DividendSign}}, ShiftResFinal[128:64]};
      ((DivState[3:0] == `DIVStatePrescaleDivisor) & OddQuotientBits)             : XH[67:0] <= {XH[66:0], (D[65] & DualResDiv2)};  // lower half of dividend was in D during PrescaleDivisor (non-8-bit), for 8-bit shift in a zero.
       (DivState[3:0] == `DIVStateIterate)                                        : XH[67:0] <= {PRem[67:62], Sum[61:0]};     
       (DivState[3:0] == `DIVStateBroadcastQuotient)                              : XH[67:0] <= {68{DividendSign & ~(SignedDiv2 & FinalRemainderIsZero_d1) & ~FinalRemainderIsDivisor_d1}};                   //  to sign extend the remainder during PostscaleRemainder
      default                                                                     : XH[67:0] <= XH[67:0];        //! TRUE_DEFAULT
    endcase

     // bits [65:64] is only to capture the carryout and detect QuotientTooLarge
    case (1'b1)
      (DivIssue2_8 & ~DualResDiv2_8)                                                              : XL[63:0] <= 64'b0;
      (DivIssue2_8 &  DualResDiv2_8)                                                              : XL[63:0] <= AOpBus2_8[63:0];
       (DivState[3:0] == `DIVStatePrescaleConcat) & 
        ((DivisorSize[1:0] == `DivisorSize16) | 
         (DivisorSize[1:0] == `DivisorSize32))                                                    : XL[63:0] <= ShiftResFinal[63:0];
      ((DivState[3:0] == `DIVStatePrescaleDividend) & ~DualResDiv2 )                              : XL[63:0] <= D[65:2];
       DivIssue1_8                                                                                : XL[63:0] <= AOpBus1_8[63:0];
      ((DivState[3:0] == `DIVStatePrescaleDivisor)  &  DualResDiv2 &  OddQuotientBits)            : XL[63:0] <= {D[64:2], 1'b0};
      ((DivState[3:0] == `DIVStatePrescaleDivisor)  &  DualResDiv2 & ~OddQuotientBits)            : XL[63:0] <= D[65:2];
       (DivState[3:0] == `DIVStatePrescaleDivisor)  & ~DualResDiv2,
       (DivState[3:0] == `DIVStateBroadcastQuotient) &  FinalRemainderIsDivisor_d1                : XL[63:0] <= 64'b0;
       (DivState[3:0] == `DIVStateGenRemainder),
       (DivState[3:0] == `DIVStateBroadcastQuotient) &  FixupNeeded & ~FinalRemainderIsDivisor_d1 & ~AlreadyFixedupRemainder 
                                                                                                  : XL[63:0] <= FinalRemainder[65:2];  // prep for postscale remainder
       (DivState[3:0] == `DIVStateIterate)                                                        : XL[63:0] <= {XL[61:0], 2'b00};
      default                                                                                     : XL[63:0] <= XL[63:0];        //! TRUE_DEFAULT
    endcase     

    case (1'b1)
      (DivIssue2_8)                       : CH[61:0] <= 62'b0;           //initialize
      (DivState[3:0] == `DIVStateIterate) : CH[61:0] <= Carry[61:0];
      default                             : CH[61:0] <= CH[61:0];        //! TRUE_DEFAULT
    endcase     
     
    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : Q[66:0] <= CShiftQ ? {Q[64:0], Qkp1[1:0]} : {QM[64:0], Qkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : Q[66:0] <= 67'h0;                                 //to initialize
      default                                      : Q[66:0] <= Q[66:0];        //! TRUE_DEFAULT
    endcase     

    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : QM[66:0] <= CShiftQM ? {QM[64:0], QMkp1[1:0]} : {Q[64:0], QMkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : QM[66:0] <= 67'h7_ffffffff_ffffffff;                                 //to initialize
      default                                      : QM[66:0] <= QM[66:0];        //! TRUE_DEFAULT
    endcase     


    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : QP[66:0] <= CShiftQP[1] ? {QP[64:0], QPkp1[1:0]} : 
                                                                 CShiftQP[0] ? {Q[64:0],  QPkp1[1:0]} : 
                                                                               {QM[64:0], QPkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : QP[66:0] <= 67'h1;
      default                                      : QP[66:0] <= QP[66:0];        //! TRUE_DEFAULT
    endcase     

  end // if ~idle

   if (DivState[3:0] == `DIVStatePrescaleDivisor)
          DivisorLookup[64:63] <= DivisorShiftedLookup[1:0];

   if (DivIssue2_8 | ExIReset)                                  DividendSign <= DividendSign_8 & ~ExIReset;
   if (DivIssue1_8 | (DivIssue2_8 & ~DualResDiv2_8) | ExIReset) DivisorSign  <= DivisorSign_8 & ~ExIReset;

   Div1LateCancel_9 <= Div1LateCancel_8;
   Div2LateCancel_9 <= Div2LateCancel_8;


end

always @* begin
// --------------------------------------------------------------------------------
// Prescale Counter
//
//   This logic will generate the counts used to normalize the dividend and divisor according to spec.
//   It will comprehend the different operations and datasizes.
//
//   Dividend:
//     8-bit:    XH[15:0]
//     16-bit:  {XH[15:0], XL[15:0]}                (NOTE: during Prescale Count stage, the lower bits will be shifted up and adjacent to the XH bits in XL only.  Call this PrescaleConcat)
//     32-bit:  {XH[31:0], XL[31:0]}                (NOTE: during Prescale Count stage, the lower bits will be shifted up and adjacent to the XH bits in XL only.  Call this PrescaleConcat)
//     64-bit:  {XH[63:0], XL[63:0]}
//
//   Divisor:
//     8-bit:    XL[7:0]
//    16-bit:    XL[15:0]
//    32-bit:    XL[31:0]
//    64-bit:    XL[63:0]
//
//   Prescale Rules:
//  
//   Dividend:
//     The register XH[63:0]:XL[63:0] will represent the dividend.  We need to prescale to ensure the dividend is less than the divisor
//     and that we will have an even number of quotient bits.
//
//     After shifting, XH[63:0], XL[63:0] should appear as:
//       For positive dividends:  0.x[ XH[63:0]  ][  XL[63:0]  ]
//       For negative dividends:  1.1[ XH[63:0]  ][  XL[63:0]  ]
//
//       To implement:
//       If unsigned or positive, shift leading 1 into bit position 63 of XH.   (0.01xxx...  =>  XH[63:0], XL[63:0] = 1xxx.....
//         If number of quotient bits is odd, perform an extra 1-bit left shift (0.1xxxx...  =>  XH[63:0], XL[63:0] = xxxx.....
//
//       If negative, shift leading 0 into bit position 62 of XH.               (1.110xxxx... =>  XH[63:0], XL[63:0] = 10xx.....
//         If number of quotient bits is odd, perform an extra 1-bit left shift (1.10xxxxx... =>  XH[63:0], XL[63:0] = 0xxx.....
//
//  NOTE: It is possible to left shift a negative dividend by one bit without violating the rule that it must be less than
//        or equal divisor.  However, this introduces several endcases (when the prescaled dividend equals the prescaled divisor)
//        which I believe adds more risk for little gain.   Specifically, these are the cases:
//   	1) FinalRemainderIsDivisor_d1 can signal falsely in the NoIterate case
//		due to prescaled dividend and divisor -they appear the same, but can still have different # of bits
//
//		really with this change we can truly have finalRemainderIsDivisor_d1 for the negative dividends at 2^n boundry
//		during the noiterate case.  To correctly identify this equality, we need to compare the number of bits as well.
//
//	2) due to our extra leading sign bit in the previous version, we'd never hit the case of select +3
//		each iteration and then needing QP (which will have the overflow bit).  With this
//		change we must now identify it.
//
//	3) also, needed to disable the merge mask on the quotient for the NoIterate case when D=X
//
//	4) some trickyness with dividend of -1  (all Fs)  shiftamt decoding was all zeros which lead to grossly wrong
//		NumDividendBits and quotienttoolarge.  Now shiftamt is same as -2 (all ones) since shifter is only 127 bits max
//		(ignoreing extra shift).  I think this will be okay, but need to rerun - it seems to pass, but still a concern
//
//      5) bug in NumDivisorBits when divisor is -1.  Shouldnt add 1 to ~Clo in this case, so the 1 is not AnyZeroXL*
//
//      The changes I made will be held for reference in BDC:/proj/hs32a_verif_workArea/users/mikeach/hs32/rtl/rtl_exdiv.v.PrescaleNegDivideChange
//
//   Divisor:
//     Divisor will be of the form: +/- 1.xxx
//     The register XL[63:0] will intially hold the divisor for prescaling.  XL[63] will represent the leading 1 above.
//
//     After shifting, XL[63:0] should appears as:   
//        for positive divisors:  XL[63:0] = 1.xxx...
//        for negative divisors:  XL[63:0] = 1.00...00  
//                                XL[63:0] = 0.xxx...  (where xxx... != all zeros)       (this case will require extra 1-bit left shift described below)
//
//     To implement: 
//       If unsigned or positive, shift leading 1 into bit position 63 of XL
//       if negative, shift leading 0 into bit position 62.  If any bit after this leading 0 is 1, do a 1-bit left shift to fixup
//  
//   To do this we need Count Leading Zero logic, Count Leading Ones logic, and Count Trailing Zeros logic.  Alot of this hardware can be shared.
//

// Count Leading Zeros. --------------------------------------------------------------------------------

   casez (XH[63:0])
     64'b1???????_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000000;
     64'b01??????_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000001;     
     64'b001?????_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000010;        
     64'b0001????_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000011;        
     64'b00001???_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000100;
     64'b000001??_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000101;     
     64'b0000001?_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000110;     
     64'b00000001_????????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b000111;     
     64'b00000000_1???????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001000;
     64'b00000000_01??????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001001;     
     64'b00000000_001?????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001010;        
     64'b00000000_0001????_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001011;        
     64'b00000000_00001???_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001100;
     64'b00000000_000001??_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001101;     
     64'b00000000_0000001?_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001110;     
     64'b00000000_00000001_????????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b001111;     
     64'b00000000_00000000_1???????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010000;
     64'b00000000_00000000_01??????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010001;     
     64'b00000000_00000000_001?????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010010;        
     64'b00000000_00000000_0001????_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010011;        
     64'b00000000_00000000_00001???_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010100;
     64'b00000000_00000000_000001??_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010101;     
     64'b00000000_00000000_0000001?_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010110;     
     64'b00000000_00000000_00000001_????????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b010111;     
     64'b00000000_00000000_00000000_1???????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011000;
     64'b00000000_00000000_00000000_01??????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011001;     
     64'b00000000_00000000_00000000_001?????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011010;        
     64'b00000000_00000000_00000000_0001????_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011011;        
     64'b00000000_00000000_00000000_00001???_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011100;
     64'b00000000_00000000_00000000_000001??_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011101;     
     64'b00000000_00000000_00000000_0000001?_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011110;     
     64'b00000000_00000000_00000000_00000001_????????_????????_????????_???????? : ClzXH64[5:0] = 6'b011111;     
     64'b00000000_00000000_00000000_00000000_1???????_????????_????????_???????? : ClzXH64[5:0] = 6'b100000;
     64'b00000000_00000000_00000000_00000000_01??????_????????_????????_???????? : ClzXH64[5:0] = 6'b100001;     
     64'b00000000_00000000_00000000_00000000_001?????_????????_????????_???????? : ClzXH64[5:0] = 6'b100010;        
     64'b00000000_00000000_00000000_00000000_0001????_????????_????????_???????? : ClzXH64[5:0] = 6'b100011;        
     64'b00000000_00000000_00000000_00000000_00001???_????????_????????_???????? : ClzXH64[5:0] = 6'b100100;
     64'b00000000_00000000_00000000_00000000_000001??_????????_????????_???????? : ClzXH64[5:0] = 6'b100101;     
     64'b00000000_00000000_00000000_00000000_0000001?_????????_????????_???????? : ClzXH64[5:0] = 6'b100110;     
     64'b00000000_00000000_00000000_00000000_00000001_????????_????????_???????? : ClzXH64[5:0] = 6'b100111;     
     64'b00000000_00000000_00000000_00000000_00000000_1???????_????????_???????? : ClzXH64[5:0] = 6'b101000;
     64'b00000000_00000000_00000000_00000000_00000000_01??????_????????_???????? : ClzXH64[5:0] = 6'b101001;     
     64'b00000000_00000000_00000000_00000000_00000000_001?????_????????_???????? : ClzXH64[5:0] = 6'b101010;        
     64'b00000000_00000000_00000000_00000000_00000000_0001????_????????_???????? : ClzXH64[5:0] = 6'b101011;        
     64'b00000000_00000000_00000000_00000000_00000000_00001???_????????_???????? : ClzXH64[5:0] = 6'b101100;
     64'b00000000_00000000_00000000_00000000_00000000_000001??_????????_???????? : ClzXH64[5:0] = 6'b101101;     
     64'b00000000_00000000_00000000_00000000_00000000_0000001?_????????_???????? : ClzXH64[5:0] = 6'b101110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000001_????????_???????? : ClzXH64[5:0] = 6'b101111;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_1???????_???????? : ClzXH64[5:0] = 6'b110000;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_01??????_???????? : ClzXH64[5:0] = 6'b110001;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_001?????_???????? : ClzXH64[5:0] = 6'b110010;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_0001????_???????? : ClzXH64[5:0] = 6'b110011;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00001???_???????? : ClzXH64[5:0] = 6'b110100;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_000001??_???????? : ClzXH64[5:0] = 6'b110101;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_0000001?_???????? : ClzXH64[5:0] = 6'b110110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000001_???????? : ClzXH64[5:0] = 6'b110111;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_1??????? : ClzXH64[5:0] = 6'b111000;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_01?????? : ClzXH64[5:0] = 6'b111001;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_001????? : ClzXH64[5:0] = 6'b111010;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_0001???? : ClzXH64[5:0] = 6'b111011;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00001??? : ClzXH64[5:0] = 6'b111100;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_000001?? : ClzXH64[5:0] = 6'b111101;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_0000001? : ClzXH64[5:0] = 6'b111110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001 : ClzXH64[5:0] = 6'b111111;     
     default                                                                     : ClzXH64[5:0] = 6'bxxxxxx;  //! TRUE_DEFAULT
   endcase // casez(XH[63:0])

   casez (XH[31:0])
     32'b1???????_????????_????????_???????? : ClzXH32[4:0] = 5'b00000;
     32'b01??????_????????_????????_???????? : ClzXH32[4:0] = 5'b00001;     
     32'b001?????_????????_????????_???????? : ClzXH32[4:0] = 5'b00010;        
     32'b0001????_????????_????????_???????? : ClzXH32[4:0] = 5'b00011;        
     32'b00001???_????????_????????_???????? : ClzXH32[4:0] = 5'b00100;
     32'b000001??_????????_????????_???????? : ClzXH32[4:0] = 5'b00101;     
     32'b0000001?_????????_????????_???????? : ClzXH32[4:0] = 5'b00110;     
     32'b00000001_????????_????????_???????? : ClzXH32[4:0] = 5'b00111;     
     32'b00000000_1???????_????????_???????? : ClzXH32[4:0] = 5'b01000;
     32'b00000000_01??????_????????_???????? : ClzXH32[4:0] = 5'b01001;     
     32'b00000000_001?????_????????_???????? : ClzXH32[4:0] = 5'b01010;        
     32'b00000000_0001????_????????_???????? : ClzXH32[4:0] = 5'b01011;        
     32'b00000000_00001???_????????_???????? : ClzXH32[4:0] = 5'b01100;
     32'b00000000_000001??_????????_???????? : ClzXH32[4:0] = 5'b01101;     
     32'b00000000_0000001?_????????_???????? : ClzXH32[4:0] = 5'b01110;     
     32'b00000000_00000001_????????_???????? : ClzXH32[4:0] = 5'b01111;     
     32'b00000000_00000000_1???????_???????? : ClzXH32[4:0] = 5'b10000;
     32'b00000000_00000000_01??????_???????? : ClzXH32[4:0] = 5'b10001;     
     32'b00000000_00000000_001?????_???????? : ClzXH32[4:0] = 5'b10010;        
     32'b00000000_00000000_0001????_???????? : ClzXH32[4:0] = 5'b10011;        
     32'b00000000_00000000_00001???_???????? : ClzXH32[4:0] = 5'b10100;
     32'b00000000_00000000_000001??_???????? : ClzXH32[4:0] = 5'b10101;     
     32'b00000000_00000000_0000001?_???????? : ClzXH32[4:0] = 5'b10110;     
     32'b00000000_00000000_00000001_???????? : ClzXH32[4:0] = 5'b10111;     
     32'b00000000_00000000_00000000_1??????? : ClzXH32[4:0] = 5'b11000;
     32'b00000000_00000000_00000000_01?????? : ClzXH32[4:0] = 5'b11001;     
     32'b00000000_00000000_00000000_001????? : ClzXH32[4:0] = 5'b11010;        
     32'b00000000_00000000_00000000_0001???? : ClzXH32[4:0] = 5'b11011;        
     32'b00000000_00000000_00000000_00001??? : ClzXH32[4:0] = 5'b11100;
     32'b00000000_00000000_00000000_000001?? : ClzXH32[4:0] = 5'b11101;     
     32'b00000000_00000000_00000000_0000001? : ClzXH32[4:0] = 5'b11110;     
     32'b00000000_00000000_00000000_00000001 : ClzXH32[4:0] = 5'b11111;     
     default                                 : ClzXH32[4:0] = 5'bxxxxx;  //! TRUE_DEFAULT
   endcase // casez(XH[31:0])
   
   casez (XH[15:0])
     16'b1???????_???????? : ClzXH16[3:0] = 4'b0000;
     16'b01??????_???????? : ClzXH16[3:0] = 4'b0001;     
     16'b001?????_???????? : ClzXH16[3:0] = 4'b0010;        
     16'b0001????_???????? : ClzXH16[3:0] = 4'b0011;        
     16'b00001???_???????? : ClzXH16[3:0] = 4'b0100;
     16'b000001??_???????? : ClzXH16[3:0] = 4'b0101;     
     16'b0000001?_???????? : ClzXH16[3:0] = 4'b0110;     
     16'b00000001_???????? : ClzXH16[3:0] = 4'b0111;     
     16'b00000000_1??????? : ClzXH16[3:0] = 4'b1000;
     16'b00000000_01?????? : ClzXH16[3:0] = 4'b1001;     
     16'b00000000_001????? : ClzXH16[3:0] = 4'b1010;        
     16'b00000000_0001???? : ClzXH16[3:0] = 4'b1011;        
     16'b00000000_00001??? : ClzXH16[3:0] = 4'b1100;
     16'b00000000_000001?? : ClzXH16[3:0] = 4'b1101;     
     16'b00000000_0000001? : ClzXH16[3:0] = 4'b1110;     
     16'b00000000_00000001 : ClzXH16[3:0] = 4'b1111;     
     default               : ClzXH16[3:0] = 4'b0000;  // This can be any value, but must be non-X so that dividends of 8bit divides that are zero will be handled properly and not X-plode
   endcase // casez(XH[15:0])

   casez (XL[63:0])
     64'b1???????_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000000;
     64'b01??????_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000001;     
     64'b001?????_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000010;        
     64'b0001????_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000011;        
     64'b00001???_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000100;
     64'b000001??_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000101;     
     64'b0000001?_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000110;     
     64'b00000001_????????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b000111;     
     64'b00000000_1???????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001000;
     64'b00000000_01??????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001001;     
     64'b00000000_001?????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001010;        
     64'b00000000_0001????_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001011;        
     64'b00000000_00001???_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001100;
     64'b00000000_000001??_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001101;     
     64'b00000000_0000001?_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001110;     
     64'b00000000_00000001_????????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b001111;     
     64'b00000000_00000000_1???????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010000;
     64'b00000000_00000000_01??????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010001;     
     64'b00000000_00000000_001?????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010010;        
     64'b00000000_00000000_0001????_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010011;        
     64'b00000000_00000000_00001???_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010100;
     64'b00000000_00000000_000001??_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010101;     
     64'b00000000_00000000_0000001?_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010110;     
     64'b00000000_00000000_00000001_????????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b010111;     
     64'b00000000_00000000_00000000_1???????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011000;
     64'b00000000_00000000_00000000_01??????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011001;     
     64'b00000000_00000000_00000000_001?????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011010;        
     64'b00000000_00000000_00000000_0001????_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011011;        
     64'b00000000_00000000_00000000_00001???_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011100;
     64'b00000000_00000000_00000000_000001??_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011101;     
     64'b00000000_00000000_00000000_0000001?_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011110;     
     64'b00000000_00000000_00000000_00000001_????????_????????_????????_???????? : ClzXL64[5:0] = 6'b011111;     
     64'b00000000_00000000_00000000_00000000_1???????_????????_????????_???????? : ClzXL64[5:0] = 6'b100000;
     64'b00000000_00000000_00000000_00000000_01??????_????????_????????_???????? : ClzXL64[5:0] = 6'b100001;     
     64'b00000000_00000000_00000000_00000000_001?????_????????_????????_???????? : ClzXL64[5:0] = 6'b100010;        
     64'b00000000_00000000_00000000_00000000_0001????_????????_????????_???????? : ClzXL64[5:0] = 6'b100011;        
     64'b00000000_00000000_00000000_00000000_00001???_????????_????????_???????? : ClzXL64[5:0] = 6'b100100;
     64'b00000000_00000000_00000000_00000000_000001??_????????_????????_???????? : ClzXL64[5:0] = 6'b100101;     
     64'b00000000_00000000_00000000_00000000_0000001?_????????_????????_???????? : ClzXL64[5:0] = 6'b100110;     
     64'b00000000_00000000_00000000_00000000_00000001_????????_????????_???????? : ClzXL64[5:0] = 6'b100111;     
     64'b00000000_00000000_00000000_00000000_00000000_1???????_????????_???????? : ClzXL64[5:0] = 6'b101000;
     64'b00000000_00000000_00000000_00000000_00000000_01??????_????????_???????? : ClzXL64[5:0] = 6'b101001;     
     64'b00000000_00000000_00000000_00000000_00000000_001?????_????????_???????? : ClzXL64[5:0] = 6'b101010;        
     64'b00000000_00000000_00000000_00000000_00000000_0001????_????????_???????? : ClzXL64[5:0] = 6'b101011;        
     64'b00000000_00000000_00000000_00000000_00000000_00001???_????????_???????? : ClzXL64[5:0] = 6'b101100;
     64'b00000000_00000000_00000000_00000000_00000000_000001??_????????_???????? : ClzXL64[5:0] = 6'b101101;     
     64'b00000000_00000000_00000000_00000000_00000000_0000001?_????????_???????? : ClzXL64[5:0] = 6'b101110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000001_????????_???????? : ClzXL64[5:0] = 6'b101111;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_1???????_???????? : ClzXL64[5:0] = 6'b110000;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_01??????_???????? : ClzXL64[5:0] = 6'b110001;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_001?????_???????? : ClzXL64[5:0] = 6'b110010;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_0001????_???????? : ClzXL64[5:0] = 6'b110011;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00001???_???????? : ClzXL64[5:0] = 6'b110100;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_000001??_???????? : ClzXL64[5:0] = 6'b110101;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_0000001?_???????? : ClzXL64[5:0] = 6'b110110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000001_???????? : ClzXL64[5:0] = 6'b110111;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_1??????? : ClzXL64[5:0] = 6'b111000;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_01?????? : ClzXL64[5:0] = 6'b111001;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_001????? : ClzXL64[5:0] = 6'b111010;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_0001???? : ClzXL64[5:0] = 6'b111011;        
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00001??? : ClzXL64[5:0] = 6'b111100;
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_000001?? : ClzXL64[5:0] = 6'b111101;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_0000001? : ClzXL64[5:0] = 6'b111110;     
     64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001 : ClzXL64[5:0] = 6'b111111;     
     default                                                                     : ClzXL64[5:0] = 6'b000000;  // This can be any value, but must be non-X so that dividends that are zero will be handled properly and not X-plode
   endcase // casez(XL[63:0])

   casez (XL[31:0])
     32'b1???????_????????_????????_???????? : ClzXL32[4:0] = 5'b00000;
     32'b01??????_????????_????????_???????? : ClzXL32[4:0] = 5'b00001;     
     32'b001?????_????????_????????_???????? : ClzXL32[4:0] = 5'b00010;        
     32'b0001????_????????_????????_???????? : ClzXL32[4:0] = 5'b00011;        
     32'b00001???_????????_????????_???????? : ClzXL32[4:0] = 5'b00100;
     32'b000001??_????????_????????_???????? : ClzXL32[4:0] = 5'b00101;     
     32'b0000001?_????????_????????_???????? : ClzXL32[4:0] = 5'b00110;     
     32'b00000001_????????_????????_???????? : ClzXL32[4:0] = 5'b00111;     
     32'b00000000_1???????_????????_???????? : ClzXL32[4:0] = 5'b01000;
     32'b00000000_01??????_????????_???????? : ClzXL32[4:0] = 5'b01001;     
     32'b00000000_001?????_????????_???????? : ClzXL32[4:0] = 5'b01010;        
     32'b00000000_0001????_????????_???????? : ClzXL32[4:0] = 5'b01011;        
     32'b00000000_00001???_????????_???????? : ClzXL32[4:0] = 5'b01100;
     32'b00000000_000001??_????????_???????? : ClzXL32[4:0] = 5'b01101;     
     32'b00000000_0000001?_????????_???????? : ClzXL32[4:0] = 5'b01110;     
     32'b00000000_00000001_????????_???????? : ClzXL32[4:0] = 5'b01111;     
     32'b00000000_00000000_1???????_???????? : ClzXL32[4:0] = 5'b10000;
     32'b00000000_00000000_01??????_???????? : ClzXL32[4:0] = 5'b10001;     
     32'b00000000_00000000_001?????_???????? : ClzXL32[4:0] = 5'b10010;        
     32'b00000000_00000000_0001????_???????? : ClzXL32[4:0] = 5'b10011;        
     32'b00000000_00000000_00001???_???????? : ClzXL32[4:0] = 5'b10100;
     32'b00000000_00000000_000001??_???????? : ClzXL32[4:0] = 5'b10101;     
     32'b00000000_00000000_0000001?_???????? : ClzXL32[4:0] = 5'b10110;     
     32'b00000000_00000000_00000001_???????? : ClzXL32[4:0] = 5'b10111;     
     32'b00000000_00000000_00000000_1??????? : ClzXL32[4:0] = 5'b11000;
     32'b00000000_00000000_00000000_01?????? : ClzXL32[4:0] = 5'b11001;     
     32'b00000000_00000000_00000000_001????? : ClzXL32[4:0] = 5'b11010;        
     32'b00000000_00000000_00000000_0001???? : ClzXL32[4:0] = 5'b11011;        
     32'b00000000_00000000_00000000_00001??? : ClzXL32[4:0] = 5'b11100;
     32'b00000000_00000000_00000000_000001?? : ClzXL32[4:0] = 5'b11101;     
     32'b00000000_00000000_00000000_0000001? : ClzXL32[4:0] = 5'b11110;     
     32'b00000000_00000000_00000000_00000001 : ClzXL32[4:0] = 5'b11111;     
     default                                 : ClzXL32[4:0] = 5'b00000;    // This can be any value, but must be non-X so that dividends that are zero will be handled properly and not X-plode
   endcase // casez(XL[31:0])
   
   casez (XL[15:0])
     16'b1???????_???????? : ClzXL16[3:0] = 4'b0000;
     16'b01??????_???????? : ClzXL16[3:0] = 4'b0001;     
     16'b001?????_???????? : ClzXL16[3:0] = 4'b0010;        
     16'b0001????_???????? : ClzXL16[3:0] = 4'b0011;        
     16'b00001???_???????? : ClzXL16[3:0] = 4'b0100;
     16'b000001??_???????? : ClzXL16[3:0] = 4'b0101;     
     16'b0000001?_???????? : ClzXL16[3:0] = 4'b0110;     
     16'b00000001_???????? : ClzXL16[3:0] = 4'b0111;     
     16'b00000000_1??????? : ClzXL16[3:0] = 4'b1000;
     16'b00000000_01?????? : ClzXL16[3:0] = 4'b1001;     
     16'b00000000_001????? : ClzXL16[3:0] = 4'b1010;        
     16'b00000000_0001???? : ClzXL16[3:0] = 4'b1011;        
     16'b00000000_00001??? : ClzXL16[3:0] = 4'b1100;
     16'b00000000_000001?? : ClzXL16[3:0] = 4'b1101;     
     16'b00000000_0000001? : ClzXL16[3:0] = 4'b1110;     
     16'b00000000_00000001 : ClzXL16[3:0] = 4'b1111;     
     default               : ClzXL16[3:0] = 4'b0000;      // This can be any value, but must be non-X so that dividends that are zero will be handled properly and not X-plode
   endcase // casez(XL[15:0])

   casez (XL[7:0])
     8'b1??????? : ClzXL8[2:0] = 3'b000;
     8'b01?????? : ClzXL8[2:0] = 3'b001;     
     8'b001????? : ClzXL8[2:0] = 3'b010;        
     8'b0001???? : ClzXL8[2:0] = 3'b011;        
     8'b00001??? : ClzXL8[2:0] = 3'b100;
     8'b000001?? : ClzXL8[2:0] = 3'b101;     
     8'b0000001? : ClzXL8[2:0] = 3'b110;     
     8'b00000001 : ClzXL8[2:0] = 3'b111;     
     default     : ClzXL8[2:0] = 3'bxxx;  //! TRUE_DEFAULT
   endcase // casez(XL[7:0])

// Count Leading Ones --------------------------------------------------------------------------------.
   
   casez (XH[63:0])
     64'b0???????_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'bxxxxxx;    //this case should never be used by statemachine - negatives always start with 1
     64'b10??????_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000000;     
     64'b110?????_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000001;        
     64'b1110????_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000010;        
     64'b11110???_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000011;
     64'b111110??_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000100;     
     64'b1111110?_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000101;     
     64'b11111110_????????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000110;     
     64'b11111111_0???????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b000111;
     64'b11111111_10??????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001000;     
     64'b11111111_110?????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001001;        
     64'b11111111_1110????_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001010;        
     64'b11111111_11110???_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001011;
     64'b11111111_111110??_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001100;     
     64'b11111111_1111110?_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001101;     
     64'b11111111_11111110_????????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001110;     
     64'b11111111_11111111_0???????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b001111;
     64'b11111111_11111111_10??????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010000;     
     64'b11111111_11111111_110?????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010001;        
     64'b11111111_11111111_1110????_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010010;        
     64'b11111111_11111111_11110???_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010011;
     64'b11111111_11111111_111110??_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010100;     
     64'b11111111_11111111_1111110?_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010101;     
     64'b11111111_11111111_11111110_????????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010110;     
     64'b11111111_11111111_11111111_0???????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b010111;
     64'b11111111_11111111_11111111_10??????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011000;     
     64'b11111111_11111111_11111111_110?????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011001;        
     64'b11111111_11111111_11111111_1110????_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011010;        
     64'b11111111_11111111_11111111_11110???_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011011;
     64'b11111111_11111111_11111111_111110??_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011100;     
     64'b11111111_11111111_11111111_1111110?_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011101;     
     64'b11111111_11111111_11111111_11111110_????????_????????_????????_???????? : CloXH64[5:0] = 6'b011110;     
     64'b11111111_11111111_11111111_11111111_0???????_????????_????????_???????? : CloXH64[5:0] = 6'b011111;
     64'b11111111_11111111_11111111_11111111_10??????_????????_????????_???????? : CloXH64[5:0] = 6'b100000;     
     64'b11111111_11111111_11111111_11111111_110?????_????????_????????_???????? : CloXH64[5:0] = 6'b100001;        
     64'b11111111_11111111_11111111_11111111_1110????_????????_????????_???????? : CloXH64[5:0] = 6'b100010;        
     64'b11111111_11111111_11111111_11111111_11110???_????????_????????_???????? : CloXH64[5:0] = 6'b100011;
     64'b11111111_11111111_11111111_11111111_111110??_????????_????????_???????? : CloXH64[5:0] = 6'b100100;     
     64'b11111111_11111111_11111111_11111111_1111110?_????????_????????_???????? : CloXH64[5:0] = 6'b100101;     
     64'b11111111_11111111_11111111_11111111_11111110_????????_????????_???????? : CloXH64[5:0] = 6'b100110;     
     64'b11111111_11111111_11111111_11111111_11111111_0???????_????????_???????? : CloXH64[5:0] = 6'b100111;
     64'b11111111_11111111_11111111_11111111_11111111_10??????_????????_???????? : CloXH64[5:0] = 6'b101000;     
     64'b11111111_11111111_11111111_11111111_11111111_110?????_????????_???????? : CloXH64[5:0] = 6'b101001;        
     64'b11111111_11111111_11111111_11111111_11111111_1110????_????????_???????? : CloXH64[5:0] = 6'b101010;        
     64'b11111111_11111111_11111111_11111111_11111111_11110???_????????_???????? : CloXH64[5:0] = 6'b101011;
     64'b11111111_11111111_11111111_11111111_11111111_111110??_????????_???????? : CloXH64[5:0] = 6'b101100;     
     64'b11111111_11111111_11111111_11111111_11111111_1111110?_????????_???????? : CloXH64[5:0] = 6'b101101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111110_????????_???????? : CloXH64[5:0] = 6'b101110;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_0???????_???????? : CloXH64[5:0] = 6'b101111;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_10??????_???????? : CloXH64[5:0] = 6'b110000;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_110?????_???????? : CloXH64[5:0] = 6'b110001;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_1110????_???????? : CloXH64[5:0] = 6'b110010;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11110???_???????? : CloXH64[5:0] = 6'b110011;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_111110??_???????? : CloXH64[5:0] = 6'b110100;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_1111110?_???????? : CloXH64[5:0] = 6'b110101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111110_???????? : CloXH64[5:0] = 6'b110110;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_0??????? : CloXH64[5:0] = 6'b110111;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_10?????? : CloXH64[5:0] = 6'b111000;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_110????? : CloXH64[5:0] = 6'b111001;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_1110???? : CloXH64[5:0] = 6'b111010;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11110??? : CloXH64[5:0] = 6'b111011;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_111110?? : CloXH64[5:0] = 6'b111100;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_1111110? : CloXH64[5:0] = 6'b111101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111110 : CloXH64[5:0] = 6'b111110;     
     default                                                                     : CloXH64[5:0] = 6'b111111;  // must be all ones for case of XH[63:0] all ones and XL[63]=0
   endcase // casez(XH[63:0])

   casez (XH[31:0])
     32'b0???????_????????_????????_???????? : CloXH32[4:0] = 5'bxxxxx;    //this case should never be used by statemachine - negatives always start with 1
     32'b10??????_????????_????????_???????? : CloXH32[4:0] = 5'b00000;     
     32'b110?????_????????_????????_???????? : CloXH32[4:0] = 5'b00001;        
     32'b1110????_????????_????????_???????? : CloXH32[4:0] = 5'b00010;        
     32'b11110???_????????_????????_???????? : CloXH32[4:0] = 5'b00011;
     32'b111110??_????????_????????_???????? : CloXH32[4:0] = 5'b00100;     
     32'b1111110?_????????_????????_???????? : CloXH32[4:0] = 5'b00101;     
     32'b11111110_????????_????????_???????? : CloXH32[4:0] = 5'b00110;     
     32'b11111111_0???????_????????_???????? : CloXH32[4:0] = 5'b00111;
     32'b11111111_10??????_????????_???????? : CloXH32[4:0] = 5'b01000;     
     32'b11111111_110?????_????????_???????? : CloXH32[4:0] = 5'b01001;        
     32'b11111111_1110????_????????_???????? : CloXH32[4:0] = 5'b01010;        
     32'b11111111_11110???_????????_???????? : CloXH32[4:0] = 5'b01011;
     32'b11111111_111110??_????????_???????? : CloXH32[4:0] = 5'b01100;     
     32'b11111111_1111110?_????????_???????? : CloXH32[4:0] = 5'b01101;     
     32'b11111111_11111110_????????_???????? : CloXH32[4:0] = 5'b01110;     
     32'b11111111_11111111_0???????_???????? : CloXH32[4:0] = 5'b01111;
     32'b11111111_11111111_10??????_???????? : CloXH32[4:0] = 5'b10000;     
     32'b11111111_11111111_110?????_???????? : CloXH32[4:0] = 5'b10001;        
     32'b11111111_11111111_1110????_???????? : CloXH32[4:0] = 5'b10010;        
     32'b11111111_11111111_11110???_???????? : CloXH32[4:0] = 5'b10011;
     32'b11111111_11111111_111110??_???????? : CloXH32[4:0] = 5'b10100;     
     32'b11111111_11111111_1111110?_???????? : CloXH32[4:0] = 5'b10101;     
     32'b11111111_11111111_11111110_???????? : CloXH32[4:0] = 5'b10110;     
     32'b11111111_11111111_11111111_0??????? : CloXH32[4:0] = 5'b10111;
     32'b11111111_11111111_11111111_10?????? : CloXH32[4:0] = 5'b11000;     
     32'b11111111_11111111_11111111_110????? : CloXH32[4:0] = 5'b11001;        
     32'b11111111_11111111_11111111_1110???? : CloXH32[4:0] = 5'b11010;        
     32'b11111111_11111111_11111111_11110??? : CloXH32[4:0] = 5'b11011;
     32'b11111111_11111111_11111111_111110?? : CloXH32[4:0] = 5'b11100;     
     32'b11111111_11111111_11111111_1111110? : CloXH32[4:0] = 5'b11101;     
     32'b11111111_11111111_11111111_11111110 : CloXH32[4:0] = 5'b11110;     
     default                                 : CloXH32[4:0] = 5'b11111;  // must be all ones for case XH[31:0] all ones and XL[31]=0
   endcase // casez(XH[31:0])
   
   casez (XH[15:0])
     16'b0???????_???????? : CloXH16[3:0] = 4'bxxxx;    //this case should never be used by statemachine - negatives always start with 1
     16'b10??????_???????? : CloXH16[3:0] = 4'b0000;     
     16'b110?????_???????? : CloXH16[3:0] = 4'b0001;        
     16'b1110????_???????? : CloXH16[3:0] = 4'b0010;        
     16'b11110???_???????? : CloXH16[3:0] = 4'b0011;
     16'b111110??_???????? : CloXH16[3:0] = 4'b0100;     
     16'b1111110?_???????? : CloXH16[3:0] = 4'b0101;     
     16'b11111110_???????? : CloXH16[3:0] = 4'b0110;     
     16'b11111111_0??????? : CloXH16[3:0] = 4'b0111;
     16'b11111111_10?????? : CloXH16[3:0] = 4'b1000;     
     16'b11111111_110????? : CloXH16[3:0] = 4'b1001;        
     16'b11111111_1110???? : CloXH16[3:0] = 4'b1010;        
     16'b11111111_11110??? : CloXH16[3:0] = 4'b1011;
     16'b11111111_111110?? : CloXH16[3:0] = 4'b1100;     
     16'b11111111_1111110? : CloXH16[3:0] = 4'b1101;     
     16'b11111111_11111110 : CloXH16[3:0] = 4'b1110;     
     default               : CloXH16[3:0] = 4'b1111;  // Must be all ones to handle XH[15:0] all ones and XL[15]=0
   endcase // casez(XH[15:0])

   casez (XL[63:0])
     64'b0???????_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'bxxxxxx;    //this case should never be used by statemachine - negatives always start with 1
     64'b10??????_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000000;     
     64'b110?????_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000001;        
     64'b1110????_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000010;        
     64'b11110???_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000011;
     64'b111110??_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000100;     
     64'b1111110?_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000101;     
     64'b11111110_????????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000110;     
     64'b11111111_0???????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b000111;
     64'b11111111_10??????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001000;     
     64'b11111111_110?????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001001;        
     64'b11111111_1110????_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001010;        
     64'b11111111_11110???_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001011;
     64'b11111111_111110??_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001100;     
     64'b11111111_1111110?_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001101;     
     64'b11111111_11111110_????????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001110;     
     64'b11111111_11111111_0???????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b001111;
     64'b11111111_11111111_10??????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010000;     
     64'b11111111_11111111_110?????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010001;        
     64'b11111111_11111111_1110????_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010010;        
     64'b11111111_11111111_11110???_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010011;
     64'b11111111_11111111_111110??_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010100;     
     64'b11111111_11111111_1111110?_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010101;     
     64'b11111111_11111111_11111110_????????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010110;     
     64'b11111111_11111111_11111111_0???????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b010111;
     64'b11111111_11111111_11111111_10??????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011000;     
     64'b11111111_11111111_11111111_110?????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011001;        
     64'b11111111_11111111_11111111_1110????_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011010;        
     64'b11111111_11111111_11111111_11110???_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011011;
     64'b11111111_11111111_11111111_111110??_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011100;     
     64'b11111111_11111111_11111111_1111110?_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011101;     
     64'b11111111_11111111_11111111_11111110_????????_????????_????????_???????? : CloXL64[5:0] = 6'b011110;     
     64'b11111111_11111111_11111111_11111111_0???????_????????_????????_???????? : CloXL64[5:0] = 6'b011111;
     64'b11111111_11111111_11111111_11111111_10??????_????????_????????_???????? : CloXL64[5:0] = 6'b100000;     
     64'b11111111_11111111_11111111_11111111_110?????_????????_????????_???????? : CloXL64[5:0] = 6'b100001;        
     64'b11111111_11111111_11111111_11111111_1110????_????????_????????_???????? : CloXL64[5:0] = 6'b100010;        
     64'b11111111_11111111_11111111_11111111_11110???_????????_????????_???????? : CloXL64[5:0] = 6'b100011;
     64'b11111111_11111111_11111111_11111111_111110??_????????_????????_???????? : CloXL64[5:0] = 6'b100100;     
     64'b11111111_11111111_11111111_11111111_1111110?_????????_????????_???????? : CloXL64[5:0] = 6'b100101;     
     64'b11111111_11111111_11111111_11111111_11111110_????????_????????_???????? : CloXL64[5:0] = 6'b100110;     
     64'b11111111_11111111_11111111_11111111_11111111_0???????_????????_???????? : CloXL64[5:0] = 6'b100111;
     64'b11111111_11111111_11111111_11111111_11111111_10??????_????????_???????? : CloXL64[5:0] = 6'b101000;     
     64'b11111111_11111111_11111111_11111111_11111111_110?????_????????_???????? : CloXL64[5:0] = 6'b101001;        
     64'b11111111_11111111_11111111_11111111_11111111_1110????_????????_???????? : CloXL64[5:0] = 6'b101010;        
     64'b11111111_11111111_11111111_11111111_11111111_11110???_????????_???????? : CloXL64[5:0] = 6'b101011;
     64'b11111111_11111111_11111111_11111111_11111111_111110??_????????_???????? : CloXL64[5:0] = 6'b101100;     
     64'b11111111_11111111_11111111_11111111_11111111_1111110?_????????_???????? : CloXL64[5:0] = 6'b101101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111110_????????_???????? : CloXL64[5:0] = 6'b101110;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_0???????_???????? : CloXL64[5:0] = 6'b101111;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_10??????_???????? : CloXL64[5:0] = 6'b110000;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_110?????_???????? : CloXL64[5:0] = 6'b110001;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_1110????_???????? : CloXL64[5:0] = 6'b110010;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11110???_???????? : CloXL64[5:0] = 6'b110011;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_111110??_???????? : CloXL64[5:0] = 6'b110100;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_1111110?_???????? : CloXL64[5:0] = 6'b110101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111110_???????? : CloXL64[5:0] = 6'b110110;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_0??????? : CloXL64[5:0] = 6'b110111;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_10?????? : CloXL64[5:0] = 6'b111000;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_110????? : CloXL64[5:0] = 6'b111001;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_1110???? : CloXL64[5:0] = 6'b111010;        
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11110??? : CloXL64[5:0] = 6'b111011;
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_111110?? : CloXL64[5:0] = 6'b111100;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_1111110? : CloXL64[5:0] = 6'b111101;     
     64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111110 : CloXL64[5:0] = 6'b111110;     
     default                                                                     : CloXL64[5:0] = 6'b111111;  //! TRUE_DEFAULT
   endcase // casez(XL[63:0])

   casez (XL[31:0])
     32'b0???????_????????_????????_???????? : CloXL32[4:0] = 5'bxxxxx;    //this case should never be used by statemachine - negatives always start with 1
     32'b10??????_????????_????????_???????? : CloXL32[4:0] = 5'b00000;     
     32'b110?????_????????_????????_???????? : CloXL32[4:0] = 5'b00001;        
     32'b1110????_????????_????????_???????? : CloXL32[4:0] = 5'b00010;        
     32'b11110???_????????_????????_???????? : CloXL32[4:0] = 5'b00011;
     32'b111110??_????????_????????_???????? : CloXL32[4:0] = 5'b00100;     
     32'b1111110?_????????_????????_???????? : CloXL32[4:0] = 5'b00101;     
     32'b11111110_????????_????????_???????? : CloXL32[4:0] = 5'b00110;     
     32'b11111111_0???????_????????_???????? : CloXL32[4:0] = 5'b00111;
     32'b11111111_10??????_????????_???????? : CloXL32[4:0] = 5'b01000;     
     32'b11111111_110?????_????????_???????? : CloXL32[4:0] = 5'b01001;        
     32'b11111111_1110????_????????_???????? : CloXL32[4:0] = 5'b01010;        
     32'b11111111_11110???_????????_???????? : CloXL32[4:0] = 5'b01011;
     32'b11111111_111110??_????????_???????? : CloXL32[4:0] = 5'b01100;     
     32'b11111111_1111110?_????????_???????? : CloXL32[4:0] = 5'b01101;     
     32'b11111111_11111110_????????_???????? : CloXL32[4:0] = 5'b01110;     
     32'b11111111_11111111_0???????_???????? : CloXL32[4:0] = 5'b01111;
     32'b11111111_11111111_10??????_???????? : CloXL32[4:0] = 5'b10000;     
     32'b11111111_11111111_110?????_???????? : CloXL32[4:0] = 5'b10001;        
     32'b11111111_11111111_1110????_???????? : CloXL32[4:0] = 5'b10010;        
     32'b11111111_11111111_11110???_???????? : CloXL32[4:0] = 5'b10011;
     32'b11111111_11111111_111110??_???????? : CloXL32[4:0] = 5'b10100;     
     32'b11111111_11111111_1111110?_???????? : CloXL32[4:0] = 5'b10101;     
     32'b11111111_11111111_11111110_???????? : CloXL32[4:0] = 5'b10110;     
     32'b11111111_11111111_11111111_0??????? : CloXL32[4:0] = 5'b10111;
     32'b11111111_11111111_11111111_10?????? : CloXL32[4:0] = 5'b11000;     
     32'b11111111_11111111_11111111_110????? : CloXL32[4:0] = 5'b11001;        
     32'b11111111_11111111_11111111_1110???? : CloXL32[4:0] = 5'b11010;        
     32'b11111111_11111111_11111111_11110??? : CloXL32[4:0] = 5'b11011;
     32'b11111111_11111111_11111111_111110?? : CloXL32[4:0] = 5'b11100;     
     32'b11111111_11111111_11111111_1111110? : CloXL32[4:0] = 5'b11101;     
     32'b11111111_11111111_11111111_11111110 : CloXL32[4:0] = 5'b11110;     
     default                                 : CloXL32[4:0] = 5'b11111;  //! TRUE_DEFAULT
   endcase // casez(XL[31:0])
   
   casez (XL[15:0])
     16'b0???????_???????? : CloXL16[3:0] = 4'bxxxx;    //this case should never be used by statemachine - negatives always start with 1
     16'b10??????_???????? : CloXL16[3:0] = 4'b0000;     
     16'b110?????_???????? : CloXL16[3:0] = 4'b0001;        
     16'b1110????_???????? : CloXL16[3:0] = 4'b0010;        
     16'b11110???_???????? : CloXL16[3:0] = 4'b0011;
     16'b111110??_???????? : CloXL16[3:0] = 4'b0100;     
     16'b1111110?_???????? : CloXL16[3:0] = 4'b0101;     
     16'b11111110_???????? : CloXL16[3:0] = 4'b0110;     
     16'b11111111_0??????? : CloXL16[3:0] = 4'b0111;
     16'b11111111_10?????? : CloXL16[3:0] = 4'b1000;     
     16'b11111111_110????? : CloXL16[3:0] = 4'b1001;        
     16'b11111111_1110???? : CloXL16[3:0] = 4'b1010;        
     16'b11111111_11110??? : CloXL16[3:0] = 4'b1011;
     16'b11111111_111110?? : CloXL16[3:0] = 4'b1100;     
     16'b11111111_1111110? : CloXL16[3:0] = 4'b1101;     
     16'b11111111_11111110 : CloXL16[3:0] = 4'b1110;     
     default               : CloXL16[3:0] = 4'b1111;  //! TRUE_DEFAULT
   endcase // casez(XL[15:0])

   casez (XL[7:0])
     8'b0??????? : CloXL8[2:0] = 3'bxxx;    //this case should never be used by statemachine - negatives always start with 1
     8'b10?????? : CloXL8[2:0] = 3'b000;     
     8'b110????? : CloXL8[2:0] = 3'b001;        
     8'b1110???? : CloXL8[2:0] = 3'b010;        
     8'b11110??? : CloXL8[2:0] = 3'b011;
     8'b111110?? : CloXL8[2:0] = 3'b100;     
     8'b1111110? : CloXL8[2:0] = 3'b101;     
     8'b11111110 : CloXL8[2:0] = 3'b110;     
     default     : CloXL8[2:0] = 3'b111;  //! TRUE_DEFAULT
   endcase // casez(XL[7:0])
   
// Count Trailing Zeros. --------------------------------------------------------------------------------

   casez (XL[63:0])
     64'b????????_????????_????????_????????_????????_????????_????????_???????1 : CtzXL64[5:0] = 6'b000000;
     64'b????????_????????_????????_????????_????????_????????_????????_??????10 : CtzXL64[5:0] = 6'b000001;     
     64'b????????_????????_????????_????????_????????_????????_????????_?????100 : CtzXL64[5:0] = 6'b000010;        
     64'b????????_????????_????????_????????_????????_????????_????????_????1000 : CtzXL64[5:0] = 6'b000011;        
     64'b????????_????????_????????_????????_????????_????????_????????_???10000 : CtzXL64[5:0] = 6'b000100;
     64'b????????_????????_????????_????????_????????_????????_????????_??100000 : CtzXL64[5:0] = 6'b000101;     
     64'b????????_????????_????????_????????_????????_????????_????????_?1000000 : CtzXL64[5:0] = 6'b000110;     
     64'b????????_????????_????????_????????_????????_????????_????????_10000000 : CtzXL64[5:0] = 6'b000111;     
     64'b????????_????????_????????_????????_????????_????????_???????1_00000000 : CtzXL64[5:0] = 6'b001000;
     64'b????????_????????_????????_????????_????????_????????_??????10_00000000 : CtzXL64[5:0] = 6'b001001;     
     64'b????????_????????_????????_????????_????????_????????_?????100_00000000 : CtzXL64[5:0] = 6'b001010;        
     64'b????????_????????_????????_????????_????????_????????_????1000_00000000 : CtzXL64[5:0] = 6'b001011;        
     64'b????????_????????_????????_????????_????????_????????_???10000_00000000 : CtzXL64[5:0] = 6'b001100;
     64'b????????_????????_????????_????????_????????_????????_??100000_00000000 : CtzXL64[5:0] = 6'b001101;     
     64'b????????_????????_????????_????????_????????_????????_?1000000_00000000 : CtzXL64[5:0] = 6'b001110;     
     64'b????????_????????_????????_????????_????????_????????_10000000_00000000 : CtzXL64[5:0] = 6'b001111;     
     64'b????????_????????_????????_????????_????????_???????1_00000000_00000000 : CtzXL64[5:0] = 6'b010000;
     64'b????????_????????_????????_????????_????????_??????10_00000000_00000000 : CtzXL64[5:0] = 6'b010001;     
     64'b????????_????????_????????_????????_????????_?????100_00000000_00000000 : CtzXL64[5:0] = 6'b010010;        
     64'b????????_????????_????????_????????_????????_????1000_00000000_00000000 : CtzXL64[5:0] = 6'b010011;        
     64'b????????_????????_????????_????????_????????_???10000_00000000_00000000 : CtzXL64[5:0] = 6'b010100;
     64'b????????_????????_????????_????????_????????_??100000_00000000_00000000 : CtzXL64[5:0] = 6'b010101;     
     64'b????????_????????_????????_????????_????????_?1000000_00000000_00000000 : CtzXL64[5:0] = 6'b010110;     
     64'b????????_????????_????????_????????_????????_10000000_00000000_00000000 : CtzXL64[5:0] = 6'b010111;     
     64'b????????_????????_????????_????????_???????1_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011000;
     64'b????????_????????_????????_????????_??????10_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011001;     
     64'b????????_????????_????????_????????_?????100_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011010;        
     64'b????????_????????_????????_????????_????1000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011011;        
     64'b????????_????????_????????_????????_???10000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011100;
     64'b????????_????????_????????_????????_??100000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011101;     
     64'b????????_????????_????????_????????_?1000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011110;     
     64'b????????_????????_????????_????????_10000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b011111;     
     64'b????????_????????_????????_???????1_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100000;
     64'b????????_????????_????????_??????10_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100001;     
     64'b????????_????????_????????_?????100_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100010;        
     64'b????????_????????_????????_????1000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100011;        
     64'b????????_????????_????????_???10000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100100;
     64'b????????_????????_????????_??100000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100101;     
     64'b????????_????????_????????_?1000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100110;     
     64'b????????_????????_????????_10000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b100111;     
     64'b????????_????????_???????1_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101000;
     64'b????????_????????_??????10_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101001;     
     64'b????????_????????_?????100_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101010;        
     64'b????????_????????_????1000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101011;        
     64'b????????_????????_???10000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101100;
     64'b????????_????????_??100000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101101;     
     64'b????????_????????_?1000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101110;     
     64'b????????_????????_10000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b101111;     
     64'b????????_???????1_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110000;
     64'b????????_??????10_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110001;     
     64'b????????_?????100_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110010;        
     64'b????????_????1000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110011;        
     64'b????????_???10000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110100;
     64'b????????_??100000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110101;     
     64'b????????_?1000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110110;     
     64'b????????_10000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b110111;     
     64'b???????1_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111000;
     64'b??????10_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111001;     
     64'b?????100_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111010;        
     64'b????1000_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111011;        
     64'b???10000_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111100;
     64'b??100000_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111101;     
     64'b?1000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111110;     
     64'b10000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000 : CtzXL64[5:0] = 6'b111111;     
     default                                                                     : CtzXL64[5:0] = 6'bxxxxxx; //! TRUE_DEFAULT
   endcase // casez(XL[63:0])

   casez (XL[31:0])
     32'b????????_????????_????????_???????1 : CtzXL32[4:0] = 5'b00000;
     32'b????????_????????_????????_??????10 : CtzXL32[4:0] = 5'b00001;     
     32'b????????_????????_????????_?????100 : CtzXL32[4:0] = 5'b00010;        
     32'b????????_????????_????????_????1000 : CtzXL32[4:0] = 5'b00011;        
     32'b????????_????????_????????_???10000 : CtzXL32[4:0] = 5'b00100;
     32'b????????_????????_????????_??100000 : CtzXL32[4:0] = 5'b00101;     
     32'b????????_????????_????????_?1000000 : CtzXL32[4:0] = 5'b00110;     
     32'b????????_????????_????????_10000000 : CtzXL32[4:0] = 5'b00111;     
     32'b????????_????????_???????1_00000000 : CtzXL32[4:0] = 5'b01000;
     32'b????????_????????_??????10_00000000 : CtzXL32[4:0] = 5'b01001;     
     32'b????????_????????_?????100_00000000 : CtzXL32[4:0] = 5'b01010;        
     32'b????????_????????_????1000_00000000 : CtzXL32[4:0] = 5'b01011;        
     32'b????????_????????_???10000_00000000 : CtzXL32[4:0] = 5'b01100;
     32'b????????_????????_??100000_00000000 : CtzXL32[4:0] = 5'b01101;     
     32'b????????_????????_?1000000_00000000 : CtzXL32[4:0] = 5'b01110;     
     32'b????????_????????_10000000_00000000 : CtzXL32[4:0] = 5'b01111;     
     32'b????????_???????1_00000000_00000000 : CtzXL32[4:0] = 5'b10000;
     32'b????????_??????10_00000000_00000000 : CtzXL32[4:0] = 5'b10001;     
     32'b????????_?????100_00000000_00000000 : CtzXL32[4:0] = 5'b10010;        
     32'b????????_????1000_00000000_00000000 : CtzXL32[4:0] = 5'b10011;        
     32'b????????_???10000_00000000_00000000 : CtzXL32[4:0] = 5'b10100;
     32'b????????_??100000_00000000_00000000 : CtzXL32[4:0] = 5'b10101;     
     32'b????????_?1000000_00000000_00000000 : CtzXL32[4:0] = 5'b10110;     
     32'b????????_10000000_00000000_00000000 : CtzXL32[4:0] = 5'b10111;     
     32'b???????1_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11000;
     32'b??????10_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11001;     
     32'b?????100_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11010;        
     32'b????1000_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11011;        
     32'b???10000_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11100;
     32'b??100000_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11101;     
     32'b?1000000_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11110;     
     32'b10000000_00000000_00000000_00000000 : CtzXL32[4:0] = 5'b11111;     
     default                                 : CtzXL32[4:0] = 5'bxxxxx; //! TRUE_DEFAULT
   endcase // casez(XL[31:0])
   
   casez (XL[15:0])
     16'b????????_???????1 : CtzXL16[3:0] = 4'b0000;
     16'b????????_??????10 : CtzXL16[3:0] = 4'b0001;     
     16'b????????_?????100 : CtzXL16[3:0] = 4'b0010;        
     16'b????????_????1000 : CtzXL16[3:0] = 4'b0011;        
     16'b????????_???10000 : CtzXL16[3:0] = 4'b0100;
     16'b????????_??100000 : CtzXL16[3:0] = 4'b0101;     
     16'b????????_?1000000 : CtzXL16[3:0] = 4'b0110;     
     16'b????????_10000000 : CtzXL16[3:0] = 4'b0111;     
     16'b???????1_00000000 : CtzXL16[3:0] = 4'b1000;
     16'b??????10_00000000 : CtzXL16[3:0] = 4'b1001;     
     16'b?????100_00000000 : CtzXL16[3:0] = 4'b1010;        
     16'b????1000_00000000 : CtzXL16[3:0] = 4'b1011;        
     16'b???10000_00000000 : CtzXL16[3:0] = 4'b1100;
     16'b??100000_00000000 : CtzXL16[3:0] = 4'b1101;     
     16'b?1000000_00000000 : CtzXL16[3:0] = 4'b1110;     
     16'b10000000_00000000 : CtzXL16[3:0] = 4'b1111;     
     default               : CtzXL16[3:0] = 4'bxxxx; //! TRUE_DEFAULT
   endcase // casez(XL[15:0])

   casez (XL[7:0])
     8'b???????1 : CtzXL8[2:0] = 3'b000;
     8'b??????10 : CtzXL8[2:0] = 3'b001;     
     8'b?????100 : CtzXL8[2:0] = 3'b010;        
     8'b????1000 : CtzXL8[2:0] = 3'b011;        
     8'b???10000 : CtzXL8[2:0] = 3'b100;
     8'b??100000 : CtzXL8[2:0] = 3'b101;     
     8'b?1000000 : CtzXL8[2:0] = 3'b110;     
     8'b10000000 : CtzXL8[2:0] = 3'b111;     
     default     : CtzXL8[2:0] = 3'bxxx; //! TRUE_DEFAULT
   endcase // casez(XL[7:0])

// Any Ones --------------------------------------------------------------------------------

   AnyOneXH64 = (| XH[63:0]);
   AnyOneXH32 = (| XH[31:0]);
   AnyOneXH16 = (| XH[15:0]);
   AnyOneXL64 = (| XL[63:0]);
   AnyOneXL32 = (| XL[31:0]);
   AnyOneXL16 = (| XL[15:0]);
   AnyOneXL8     = (| XL[7:0]);
   
   AnyZeroXH64 = ~(& XH[63:0]);
   AnyZeroXH32 = ~(& XH[31:0]);
   AnyZeroXH16 = ~(& XH[15:0]);   

end

always @* begin   
// Prescale Count generation --------------------------------------------------------------------------------

  SignedNegativeDividend = SignedDiv2 & DividendSign;
  SignedNegativeDivisor  = SignedDiv2 & DivisorSign;

  case ({DivisorSize[1:0], 1'b1})
    {`DivisorSize8,  ~SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = {3'b011, ClzXH16[3:0]};
    {`DivisorSize8,   SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = {3'b011, CloXH16[3:0]};
    {`DivisorSize16, ~SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = AnyOneXH16              ?  {3'b011, ClzXH16[3:0]} : {3'b100, ClzXL16[3:0]};
    {`DivisorSize16,  SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = (AnyZeroXH16 | ~XL[15]) ?  {3'b011, CloXH16[3:0]} : {3'b100, CloXL16[3:0]};
    {`DivisorSize32, ~SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = AnyOneXH32              ?  {2'b01,  ClzXH32[4:0]} : {2'b10,  ClzXL32[4:0]};
    {`DivisorSize32,  SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = (AnyZeroXH32 | ~XL[31]) ?  {2'b01,  CloXH32[4:0]} : {2'b10,  CloXL32[4:0]};
    {`DivisorSize64, ~SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = AnyOneXH64              ?  {1'b0,   ClzXH64[5:0]} : {1'b1,   ClzXL64[5:0]};
    {`DivisorSize64,  SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = (AnyZeroXH64 | ~XL[63]) ?  {1'b0,   CloXH64[5:0]} : {1'b1,   CloXL64[5:0]};
    default                                   : ShiftAmtPrescaleCountDividend[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case ({DivisorSize[1:0], 1'b1})
    {`DivisorSize8,  ~SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {4'b0111, ClzXL8[2:0]};
    {`DivisorSize8,   SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {4'b0111, CloXL8[2:0]};
    {`DivisorSize16, ~SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {3'b011, ClzXL16[3:0]};
    {`DivisorSize16,  SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {3'b011, CloXL16[3:0]};
    {`DivisorSize32, ~SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {2'b01,  ClzXL32[4:0]};
    {`DivisorSize32,  SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {2'b01,  CloXL32[4:0]};
    {`DivisorSize64, ~SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {1'b0,   ClzXL64[5:0]};
    {`DivisorSize64,  SignedNegativeDivisor} : ShiftAmtPrescaleCountDivisor[6:0] = {1'b0,   CloXL64[5:0]};
    default                                  : ShiftAmtPrescaleCountDivisor[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case (DivisorSize_8[1:0])
    `DivisorSize16 : ShiftAmtPrescaleConcatPrep[6:0] = 7'b0110000;
    `DivisorSize32 : ShiftAmtPrescaleConcatPrep[6:0] = 7'b0100000;
    default        : ShiftAmtPrescaleConcatPrep[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

// setup ShiftAmt for postscale remainder:
// NOTE: when we dont iterate, postscaling the remainder must "undo" the dividend prescaling.  The plus one here (in addition to the
//  extra left shift if we didnt do the extra left shift during prescaling) adjusts for the alignment of the prescale result onto XH
//  which is effectively copied back to XL for postscaling.
  case (DivisorSize[1:0])
    `DivisorSize8,
    `DivisorSize16,
    `DivisorSize32,
    `DivisorSize64  : ShiftAmtBroadcastQuotient[6:0] = NoIterate ? (NumDividendBits_d1[6:0] + 7'b1 ): NumDivisorBits_d1[6:0];
    default         : ShiftAmtBroadcastQuotient[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case (1'b1)
    DivIssue2_8                                       : ShiftAmt[6:0] = ShiftAmtPrescaleConcatPrep[6:0];
    (DivState[3:0] == `DIVStatePrescaleCountDividend) : ShiftAmt[6:0] = ShiftAmtPrescaleCountDividend[6:0];
    (DivState[3:0] == `DIVStatePrescaleCountDivisor)  : ShiftAmt[6:0] = ShiftAmtPrescaleCountDivisor[6:0];
    (DivState[3:0] == `DIVStateBroadcastQuotient)     : ShiftAmt[6:0] = ShiftAmtBroadcastQuotient[6:0];
    default                                           : ShiftAmt[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case ({ DivState[3:0], DivisorSize[1:0]})
    {`DIVStatePrescaleCountDivisor, `DivisorSize8}  : NegDivisorAt2NBoundry = SignedDiv2 & DivisorSign & (~CloXL8[2:0] == CtzXL8[2:0]);
    {`DIVStatePrescaleCountDivisor, `DivisorSize16} : NegDivisorAt2NBoundry = SignedDiv2 & DivisorSign & (~CloXL16[3:0] == CtzXL16[3:0]);
    {`DIVStatePrescaleCountDivisor, `DivisorSize32} : NegDivisorAt2NBoundry = SignedDiv2 & DivisorSign & (~CloXL32[4:0] == CtzXL32[4:0]);
    {`DIVStatePrescaleCountDivisor, `DivisorSize64} : NegDivisorAt2NBoundry = SignedDiv2 & DivisorSign & (~CloXL64[5:0] == CtzXL64[5:0]);
    default                                         : NegDivisorAt2NBoundry = 1'b1;  //! TRUE_DEFAULT
  endcase
   
// For signed negative divisors, we need to detect the prescaled divisor of 110.xxyyy, where xx!=2'b00, and yyy==00...00
// This is needed to properly do the 2s complement and generate the correct divisor lookup bits
// we need to identify:
//     Width - (# of leading ones) - (# of trailing zeros) <= 3
// # leading one = clo + 1
// # trailing zeros = ctz
//     Width - (clo + 1) - ctz <= 3
// ~clo = width - 1 - clo                (ones complement)
//  clo = width - 1 - ~clo
//     Width - ((width - 1 - ~clo) + 1) - ctz <= 3
//     ~clo - ctz <= 3
//     ~clo <= ctz + 3
  case (DivisorSize[1:0])
    `DivisorSize8   : FixupDivLookup = SignedDiv2 & DivisorSign & ({1'b0, ~CloXL8[2:0]}  <= ({1'b0, CtzXL8[2:0]}  + 4'b0011));
    `DivisorSize16  : FixupDivLookup = SignedDiv2 & DivisorSign & ({1'b0, ~CloXL16[3:0]} <= ({1'b0, CtzXL16[3:0]} + 5'b00011));
    `DivisorSize32  : FixupDivLookup = SignedDiv2 & DivisorSign & ({1'b0, ~CloXL32[4:0]} <= ({1'b0, CtzXL32[4:0]} + 6'b000011));
    `DivisorSize64  : FixupDivLookup = SignedDiv2 & DivisorSign & ({1'b0, ~CloXL64[5:0]} <= ({1'b0, CtzXL64[5:0]} + 7'b0000011));
    default         : FixupDivLookup = 1'b0; //! TRUE_DEFAULT
  endcase
 


end

//--------------------------------------------------------------------------------
// below effectively converts the lookup bits of the divisor from negative to positive for negative divisors
// DivisorLookup is determined after prescaling
// If the divisor is positive, we simply use the .25 and .5 positions of the divisor for the lookup ([62:61])
// If its negative, we need to do one of three cases:
//   a) Divisor = 11..11000...000 (ie, on 2^n boundry), it is normalized as 1.0000 and our lookup is 2'b00.  This is the same behavior as positive divisors.
//   b) Divisor = 110.xxyyy (where yyy!=0), lookup is ~{xx}
//   c) Divisor = 110.xxyyy (where yyy==0 & xx!=0), lookup is ~{xx} + 1
//
// FixupDivLookup detects case (c).  NegDivisorAt2NBoundry_d1 detects case (a)														

always @* begin
  casez ({ SignedNegativeDivisor, ~NegDivisorAt2NBoundry_d1, FixupDivLookup_d1})
    3'b0_?_?,
    3'b1_0_? : DivisorShiftedLookup[1:0] = ShiftResFinal[62:61];
    3'b1_1_0 : DivisorShiftedLookup[1:0] = ~ShiftResFinal[62:61];
    3'b1_1_1 : DivisorShiftedLookup[1:0] = {(~ShiftResFinal[62] | ~ShiftResFinal[61]), ShiftResFinal[61]} ;
    default  : DivisorShiftedLookup[1:0] = 2'bxx ;				//! TRUE_DEFAULT										
  endcase

//--------------------------------------------------------------------------------
// Number of dividend bits determined during PrescaleDividend.
// Number of divisor bits determined during PrescaleDivisor.
//   We want to calculate the number of dividend bits based upon the size of the dividend and the shift amount.
//   For positive dividends, this is easy: count the number of bits to the leading one (or subtract how much we shifted from the dividend size)
//   Negative dividends can be off by one if we are not on the 2^n boundry.  For example, 4'b1000 can be said to be 4 bits, but 4'b1010 only has 3 significant bits.
//
//   The number of divisor bits is done in a similar manner but must also account for the 2^n boundry case for signed negative
//   divisors.  This is due to the extra shift to properly align the divisor during prescale done via ShiftFixup.
//

//   Those will be considered while generating the number of quotient bits.
  case (DivisorSize[1:0])
    `DivisorSize8  : NumDividendBits[7:0]   = 8'd128 - 8'd64 - {1'b0, ShiftAmt_d1[6:0]};    // 8-bit divides
    `DivisorSize16 : NumDividendBits[7:0]   = 8'd128 - 8'd48 - {1'b0, ShiftAmt_d1[6:0]};    // 16-bit divides
    `DivisorSize32 : NumDividendBits[7:0]   = 8'd128 - 8'd32 - {1'b0, ShiftAmt_d1[6:0]};    // 32-bit divides
    default        : NumDividendBits[7:0]   = 8'd128 -         {1'b0, ShiftAmt_d1[6:0]};    //! TRUE_DEFAULT  // 64-bit divides
  endcase

  NumDivisorBits[6:0]   = 7'd64 - {1'b0, ShiftAmt_d1[5:0]} - {6'b0, (~NegDivisorAt2NBoundry_d1  & SignedDiv2 & DivisorSign)};      // 16, 32, and 64-bit divides


// --------------------------------------------------------------------------------
// Number of Quotient Bits
// Since we iterate at two quotient bits per cycle, its best to require the number of quotient bits to be even  (eases backend fixup)
// We get divisors first, so any extra 1-bit left shift fixup follows:
//
// Calculating the number of quotient bits is simple: subtract the number of divisor bits from the number of dividend bits.
// This value represents the number of quotient bits generated, including leading zeros for positive values or leading ones for negative values.
//
// If we have an odd number of quotient bits, we need to perform an extra 1-bit left shift of the dividend (reducing its size by 1) to make it
// even.

  OddQuotientBits   = (NumDividendBits_d1[0] ^ NumDivisorBits[0]);

// NumQuotientBits4IterCnt* is the number of quotient bits that will be generated by the iteration loop. 
// We need to include +2 due to alignment of dividend (additional zeros (or ones if negative) to the left of the leading one (or zero, if negative).  
// Refer to the dividend alignment to see this.
// Make sure to truncate at zero if the divisor is bigger than dividend.

//NOTE: the implementation could be as: 
//  NumQuotientBits4IterCnt[7:0]   = {8{(NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]})}} &   	(NumDividendBits_d1[7:0] + 
//							 						{2'b0, ShiftAmt_d1[5:0]} + 
//													8'b11000010 +                                                              // -(7'd64) + 2
//													{7'b0, (~NegDivisorAt2NBoundry_d1 & SignedDiv2 & DivisorSign)} -
//													{7'b0, OddQuotientBits});

  NumQuotientBits4IterCnt[7:0]   = (NumDividendBits_d1[7:0]   >= {1'b0, NumDivisorBits[6:0]}) ?  
                                        (NumDividendBits_d1[7:0]   - {1'b0, NumDivisorBits[6:0]} - {7'b0, OddQuotientBits}   + 8'd2) : 8'b0;
//! unused NumQuotientBits4IterCnt[0]

// NumQuotientBits is the raw calculation of the number of quotient bits used to determine quotient too large.  This isnt exact, but the padded sign bits
// in front of the dividend protect us.  
  NumQuotientBits[7:0]   = (NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]}) ?  (NumDividendBits_d1[7:0] - {1'b0, NumDivisorBits[6:0]})   : 8'b0;
//! unused NumQuotientBits[7]
   
// // ova forbid_bool ((DivState[3:0] == `DIVStatePrescaleDivisor) & NumQuotientBits4IterCnt[0],
//                 "NumQuotientBits4IterCnt[0] is not zero!");

  case (1'b1)
    (DivState[3:0] == `DIVStatePrescaleDivisor)       : ShiftFixup = ~NegDivisorAt2NBoundry_d1 & SignedDiv2 & DivisorSign;
    (DivState[3:0] == `DIVStatePrescaleCountDividend) : ShiftFixup = 1'b0;     // force zero during PrescaleConcat
                                                                               // force zero during normal postscale remainder (except when NoIterate to "undo" the prescale)
    (DivState[3:0] == `DIVStatePostscaleRemainder)    : ShiftFixup = NoIterate & ~ShiftFixup_d1;
    default                                           : ShiftFixup = 1'b0; //! TRUE_DEFAULT                   // for PrescaleDividend
  endcase
   
    

// --------------------------------------------------------------------------------

  IterationCountNext[6:0] = (DivState[3:0] == `DIVStatePrescaleDivisor) ? NumQuotientBits4IterCnt[7:1] : (IterationCount[6:0] - 7'b0000001);

  IterateDone = IterationCount[6:0] == 7'd1;
   
			 											
//--------------------------------------------------------------------------------
// DIV ERROR DETECTION:														
  case (DivisorSize[1:0])
    `DivisorSize8  : DividendZero = ~AnyOneXH16;                 // 8-bit divides
    `DivisorSize16 : DividendZero = ~AnyOneXH16 & ~AnyOneXL16;   // 16-bit divides
    `DivisorSize32 : DividendZero = ~AnyOneXH32 & ~AnyOneXL32;   // 32-bit divides
    `DivisorSize64 : DividendZero = ~AnyOneXH64 & ~AnyOneXL64;   // 64-bit divides
    default        : DividendZero = 1'bx;   //! TRUE_DEFAULT
  endcase
   
  case (DivisorSize[1:0])
    `DivisorSize8  : DivisorZero = ~AnyOneXL8;    // 8-bit divides
    `DivisorSize16 : DivisorZero = ~AnyOneXL16;   // 16-bit divides
    `DivisorSize32 : DivisorZero = ~AnyOneXL32;   // 32-bit divides
    `DivisorSize64 : DivisorZero = ~AnyOneXL64;   // 64-bit divides
    default        : DivisorZero = 1'bx;   //! TRUE_DEFAULT
  endcase

														
end
														

always @(posedge CCLK05) begin
  if ((DivState[3:0] == `DIVStatePrescaleCountDividend) | 
      (DivState[3:0] == `DIVStatePrescaleCountDivisor) | 
      (DivIssue2_8) |                                            //for PrescaleConcatPrep
      (DivState[3:0] == `DIVStateBroadcastQuotient)) begin
    ShiftAmt_d1[6:0] <= ShiftAmt[6:0];
  end

  if (DivState[3:0] == `DIVStatePrescaleCountDividend) DividendZero_d1 <= DividendZero;

// NOTE: we could be in PrescaleDividend waiting for the dividend ops to arrive.  as such, NumDividendBits can change
//  since ShiftAmt is preparing to concat.  Only allow NumDivisorBits_d1 to flop on the first cycle of PrescaleDividend
  if ((DivState[3:0] == `DIVStatePrescaleDividend)) NumDividendBits_d1[7:0] <= (NumDividendBits[7:0] & {8{~DividendZero_d1}});

  AlreadyFixedupRemainder <= (DivState[3:0] == `DIVStateBroadcastQuotient);
   

  if (DivState[3:0] == `DIVStatePrescaleCountDivisor)  begin
    NegDivisorAt2NBoundry_d1 <= NegDivisorAt2NBoundry;
    FixupDivLookup_d1        <= FixupDivLookup;
    DivideByZero_d1          <= DivisorZero;
  end

  if (DivState[3:0] == `DIVStatePrescaleDivisor) begin
    NumDivisorBits_d1[6:0]  <= NumDivisorBits[6:0];
    NumQuotientBits_d1[6:0] <= NumQuotientBits[6:0];
  // Need to save whethere we do the extra left shift for odd quotient bits to postscale the remainder correctly for the NoIterate case
    ShiftFixup_d1           <= OddQuotientBits;
  end
   
  if ((DivState[3:0] == `DIVStatePrescaleDivisor) | (DivState[3:0] == `DIVStateIterate)) IterationCount[6:0] <= IterationCountNext[6:0];

  if ((DivState[3:0] == `DIVStatePrescaleCountDivisor) |                  // for Divide by zero non-8b divides
      (DivState[3:0] == `DIVStatePrescaleDivisor)) begin                  // for iteration count for non-8b divides
     IterateOnce <= (IterationCountNext[6:0] == 7'b1);
     NoIterate   <= (IterationCountNext[6:0] == 7'b0);

  end

end														
														
//    
// --------------------------------------------------------------------------------
// Prescalar/Postscalar shifter
//  128 bit shifter, 128 bits wide followed by 1 bit shifter (used for extra left shift to properly normalize negative operands not on 2^n boundries)
//
//  This shifter is used to normalize both dividend and divisor.  In addition it's used to concatenate the low half of a dividend with the high half
//  as we do our prescale count work (only for the 16 and 32 bit divides)

// note: we need the extra bit on the MSB for dividends (on the wide and Hi shifters) since after the normal shift, we can have a 1 in the MSB, then
// the extra shift can come along and shift again (due to odd quotient bits on a positive dividend).  we must capture that.
always @* begin

   ShiftRes[127:0] = {XH[63:0], XL[63:0]} << ShiftAmt_d1[6:0];
   ShiftResFinal[128:0]    = ShiftFixup ? {ShiftRes[127:0], 1'b0} : {DividendSign, ShiftRes[127:0]};

end

always @* begin   
//----------------------------------------------------------------------------------------------------------------------------------------------------------------
// Lookup Table
//      
//NOTE TO IMPLEMENTATION:  DivisorLookup[64:63] is a constant throughout all divide iterations.  To help timing, we could
// take advantage of this.  Your choice how its done.....
// A better picture of this can be found in:
// /home/mikeach/pub/NewDiv-9.pdf
	  
    case ( {XH[66:62], DivisorLookup[64:63]})

//   PRem____Div //   s421.5  dd 
      7'b0111_1__00,
      7'b0111_0__00,
      7'b0110_1__00,
      7'b0110_0__00,
      7'b0101_1__00,
      7'b0101_0__00 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen! 
      7'b0100_1__00,
      7'b0100_0__00,
      7'b0011_1__00,
      7'b0011_0__00,
      7'b0010_1__00 : MuxSel[1:0] = 2'b1_1;  // +3
      7'b0010_0__00,
      7'b0001_1__00 : MuxSel[1:0] = 2'b1_0;  // +2
      7'b0001_0__00,
      7'b0000_1__00 : MuxSel[1:0] = 2'b0_1;  // +1
      7'b0000_0__00,
      7'b1111_1__00,
      7'b1111_0__00 : MuxSel[1:0] = 2'b0_0;  //  0
      7'b1110_1__00,
      7'b1110_0__00 : MuxSel[1:0] = 2'b0_1;  // -1
      7'b1101_1__00,
      7'b1101_0__00 : MuxSel[1:0] = 2'b1_0;  // -2
      7'b1100_1__00,
      7'b1100_0__00,
      7'b1011_1__00,
      7'b1011_0__00,
      7'b1010_1__00 : MuxSel[1:0] = 2'b1_1;  // -3       NOTE: IBM table didnt have this.  Prem can hit here since it can be Trem-1
      7'b1010_0__00,
      7'b1001_1__00,
      7'b1001_0__00,
      7'b1000_1__00,
      7'b1000_0__00 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen!

//------------------------------------------------------------------------------

      7'b0111_1__01,
      7'b0111_0__01,
      7'b0110_1__01,
      7'b0110_0__01 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen! 
      7'b0101_1__01,
      7'b0101_0__01,
      7'b0100_1__01,
      7'b0100_0__01,
      7'b0011_1__01,
      7'b0011_0__01 : MuxSel[1:0] = 2'b1_1;  // +3
      7'b0010_1__01,
      7'b0010_0__01,
      7'b0001_1__01 : MuxSel[1:0] = 2'b1_0;  // +2
      7'b0001_0__01,
      7'b0000_1__01 : MuxSel[1:0] = 2'b0_1;  // +1
      7'b0000_0__01,
      7'b1111_1__01,
      7'b1111_0__01 : MuxSel[1:0] = 2'b0_0;  //  0
      7'b1110_1__01,
      7'b1110_0__01 : MuxSel[1:0] = 2'b0_1;  // -1
      7'b1101_1__01,
      7'b1101_0__01,
      7'b1100_1__01 : MuxSel[1:0] = 2'b1_0;  // -2
      7'b1100_0__01,
      7'b1011_1__01,
      7'b1011_0__01,
      7'b1010_1__01,
      7'b1010_0__01,// : MuxSel[1:0] = 2'b1_1;  // -3
      7'b1001_1__01 : MuxSel[1:0] = 2'b1_1;  // -3         NOTE: IBM table didnt have this.  Prem can hit here since it can be Trem-1 (hit this with 32-bit signed c00af6ae0bf/d0384cf7)
      7'b1001_0__01,
      7'b1000_1__01,
      7'b1000_0__01 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen!

//------------------------------------------------------------------------------
      7'b0111_1__10,
      7'b0111_0__10 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen! 
      7'b0110_1__10,
      7'b0110_0__10,
      7'b0101_1__10,
      7'b0101_0__10,
      7'b0100_1__10,
      7'b0100_0__10 : MuxSel[1:0] = 2'b1_1;  // +3
      7'b0011_1__10,
      7'b0011_0__10,
      7'b0010_1__10 : MuxSel[1:0] = 2'b1_0;  // +2
      7'b0010_0__10,
      7'b0001_1__10,
      7'b0001_0__10,
      7'b0000_1__10 : MuxSel[1:0] = 2'b0_1;  // +1
      7'b0000_0__10,
      7'b1111_1__10,
      7'b1111_0__10 : MuxSel[1:0] = 2'b0_0;  //  0
      7'b1110_1__10,
      7'b1110_0__10,
      7'b1101_1__10 : MuxSel[1:0] = 2'b0_1;  // -1
      7'b1101_0__10,
      7'b1100_1__10,
      7'b1100_0__10,
      7'b1011_1__10 : MuxSel[1:0] = 2'b1_0;  // -2
      7'b1011_0__10,
      7'b1010_1__10,
      7'b1010_0__10,
      7'b1001_1__10,
      7'b1001_0__10,
      7'b1000_1__10 : MuxSel[1:0] = 2'b1_1;  // -3 NOTE: IBM table didnt have this.  Prem can hit here since it can be Trem-1  
      7'b1000_0__10 : MuxSel[1:0] = 2'bx_x;  //assert - cannot happen!

//------------------------------------------------------------------------------
      7'b0111_1__11,
      7'b0111_0__11,
      7'b0110_1__11,
      7'b0110_0__11,
      7'b0101_1__11,
      7'b0101_0__11,
      7'b0100_1__11,
      7'b0100_0__11 : MuxSel[1:0] = 2'b1_1;  // +3
      7'b0011_1__11,
      7'b0011_0__11,
      7'b0010_1__11 : MuxSel[1:0] = 2'b1_0;  // +2
      7'b0010_0__11,
      7'b0001_1__11,
      7'b0001_0__11,
      7'b0000_1__11 : MuxSel[1:0] = 2'b0_1;  // +1
      7'b0000_0__11,
      7'b1111_1__11,
      7'b1111_0__11 : MuxSel[1:0] = 2'b0_0;  //  0
      7'b1110_1__11,
      7'b1110_0__11,
      7'b1101_1__11 : MuxSel[1:0] = 2'b0_1;  // -1
      7'b1101_0__11,
      7'b1100_1__11,
      7'b1100_0__11,
      7'b1011_1__11 : MuxSel[1:0] = 2'b1_0;  // -2
      7'b1011_0__11,
      7'b1010_1__11,
      7'b1010_0__11,
      7'b1001_1__11,
      7'b1001_0__11,
      7'b1000_1__11,
      7'b1000_0__11 : MuxSel[1:0] = 2'b1_1;  // -3    NOTE: Prem can force us to lookup 10111.0, which isnt on this table, but it will alias with 0111.0, which picks 3 (we calculate the sign to be negative elsewhere)
    
      default       : MuxSel[1:0] = 2'bx_x;   //! TRUE_DEFAULT
    endcase

//--------------------------------------------------------------------------------
// Over the course of all our verification, there are several entries in the
// divide table that we've been unable to hit.  There's no theorectical reason
// known why we shouldnt be able to hit them, so the belief is that its just
// very unlikely that we'll hit it randomly.  Maybe over the course of time
// a random test will pick the perfect operands to hit some of these entries.
// The ovas below are designed to fire in the event we hit this jackpot.
// If this happens, the instruction and operands should be recovered and placed in a directed
// test so that we improve coverage going forward.
// This is described in UBTS 191300.

// the missing entries are: 46,50,54,70,74,78
// 0101_1__10
// 0110_0__10
// 0110_1__10
// 1000_1__10
// 1001_0__10
// 1001_1__10

// // ova forbid_bool (( (DivState[3:0] == `DIVStateIterate) &
//                    (({XH[66:62], DivisorLookup[64:63]} == 7'b0101_1__10) | 
//                     ({XH[66:62], DivisorLookup[64:63]} == 7'b0110_0__10) |
//                     ({XH[66:62], DivisorLookup[64:63]} == 7'b0110_1__10) |
//                     ({XH[66:62], DivisorLookup[64:63]} == 7'b1000_1__10) |
//                     ({XH[66:62], DivisorLookup[64:63]} == 7'b1001_0__10) |
//                     ({XH[66:62], DivisorLookup[64:63]} == 7'b1001_1__10))),
//                 "EXDIV: Hit Divide table entry never before hit.  Coverage improvement opportunity - please contact rtl_exdiv.v owner!");

//--------------------------------------------------------------------------------


       //              6      65        54        43        32       21        1
       //            8765.4321098765432109876543210987654321098765431098765432109876543210
       // Divisor:     S1.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // 2*Divisor:  S21.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // XH       :  SS1.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // CH       :  S21.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // 4*XH     : S421.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // 4*CH     :S8421.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // Sum       S8421.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       // Carry:   S68421.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

       // cpa6         S1.xxx
    NegDivisorSel = ~(DivisorSign ^ XH[67]);  // choose the 1 complement of D/2D if the sign of the divisor == sign of the partial remainder
    
    Div2D[68:0] = NegDivisorSel ? {~DivisorSign, ~DivisorSign, ~D[65:0], 1'b1}         : {DivisorSign, DivisorSign, D[65:0], 1'b0};
    DivD[68:0]  = NegDivisorSel ? {~DivisorSign, ~DivisorSign, ~DivisorSign, ~D[65:0]} : {DivisorSign, DivisorSign, DivisorSign,  D[65:0]};

    DivOpA[68:0] = MuxSel[1] ? Div2D[68:0] : 69'b0;
    DivOpB[68:0] = MuxSel[0] ? DivD[68:0]  : 69'b0;

    Inject2 = NegDivisorSel & (MuxSel[1] & MuxSel[0]);       // inject a 1 in the 2s column (effectively adding 2) if both 2d and d operands are negative to complete the 2s complement
    Inject1 = NegDivisorSel & (MuxSel[1] ^ MuxSel[0]);       // inject a 1 to complete the 2's complement if either the 2d or d operands are negative to complete the 2s complement

    DivOpC[68:0] = {XH[66:0], XL[63:62]};
    DivOpD[68:0] = {5'b00000, CH[61:0], Inject2, Inject1};


end

//--------------------------------------------------------------------------------   
// 4:2 CSA - Note: due to the zeros in DivOpD, the upper portions could be 3:2 compressors to help timing.
//
always @* begin

     Si[69]   = 1'b0;		 
     Si[68:0] = DivOpA[68:0] ^ DivOpB[68:0] ^ DivOpC[68:0];
     Ci[69:1] = (DivOpA[68:0] & DivOpB[68:0]) | (DivOpB[68:0] & DivOpC[68:0]) | (DivOpA[68:0] & DivOpC[68:0]);
     Ci[0]    = 1'b0;

     Di[69:0] = {DivOpD[68], DivOpD[68:0]};
		 
     Sum[69:0] = Si[69:0] ^ Ci[69:0] ^ Di[69:0];
     Carry[70:1] = (Si[69:0] & Ci[69:0]) | (Ci[69:0] & Di[69:0]) | (Si[69:0] & Di[69:0]);
     Carry[0] = 1'b0;
end		 
   
//! unused Carry[70]       
always @* begin
  PRem[67:62] = Sum[67:62] + Carry[67:62];
end
   

// Quotient bit generation.
// This divider generates 2 quotient bits per cycle.
// Since the remainder sign must be the same as the dividend sign, the final quotient can be off by one
// If the dividend is positive, but the remainder comes out negative, we need to add a divisor to the remainder and decrement the quotient by one.   
// If the dividend is negative, but the remainder comes out positive, we need to subtract a divisor from the remainder and increment the quotient by one.
// XL will get the quotient bits, 2 per cycle and are left shifted into the LSB.
// QD will hold the contents of the quotient plus one or minus one (determined by the dividend sign) in a similar manner.   
//
// Code shamelessly lifted and modified from Dibrino's code
   
always @* begin
//------------------------------------------------------------------------------------
// Truth Table for 'On-The-Fly' Conversion for Maximally Redundant Radix-4
//
//   Pk+1   Qin    CshiftQ    Qk+1     AMin   CshiftQM   QMk+1    CshiftQP     QPk+1
//------------------------------------------------------------------------------------
//    3      3        1     Q [k],3    2         0     Q [k],2       2         QP[k],0
//    2      2        1     Q [k],2    1         0     Q [k],1       1          Q[k],3
//    1      1        1     Q [k],1    0         0     Q [k],0       1          Q[k],2
//------------------------------------------------------------------------------------
//    0      0        1     Q [k],0    3         1     QM[k],3       1          Q[k],1
//------------------------------------------------------------------------------------
//   -1      7        0     QM[k],3    3         1     QM[k],2       1          Q[k],0
//   -2      6        0     QM[k],2    2         1     QM[k],1       0         QM[k],3
//   -3      5        0     QM[k],1    1         1     QM[k],0       0         QM[k],2
//------------------------------------------------------------------------------------

// Generate On-The-Fly Control Signals
// Remember, quotient select bits are in sign-magnitude form
       
  case ({NegDivisorSel, MuxSel[1:0]})
    3'b111  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b10; QPkp1[1:0] = 2'b00; Qkp1[1:0] = 2'b11; QMkp1[1:0] = 2'b10; end   // +3 
    3'b110  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b11; Qkp1[1:0] = 2'b10; QMkp1[1:0] = 2'b01; end   // +2 
    3'b101  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b10; Qkp1[1:0] = 2'b01; QMkp1[1:0] = 2'b00; end   // +1
    3'b000,
    3'b100  : begin CShiftQ = 1'b1; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b01; Qkp1[1:0] = 2'b00; QMkp1[1:0] = 2'b11; end   //  0 
    3'b001  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b00; Qkp1[1:0] = 2'b11; QMkp1[1:0] = 2'b10; end   // -1 
    3'b010  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b00; QPkp1[1:0] = 2'b11; Qkp1[1:0] = 2'b10; QMkp1[1:0] = 2'b01; end   // -2 
    3'b011  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b00; QPkp1[1:0] = 2'b10; Qkp1[1:0] = 2'b01; QMkp1[1:0] = 2'b00; end   // -3 
    default : begin CShiftQ = 1'bx; CShiftQM = 1'bx; CShiftQP[1:0] = 2'bxx; QPkp1[1:0] = 2'bxx; Qkp1[1:0] = 2'bxx; QMkp1[1:0] =
                                                                                                                               2'bxx; end //! TRUE_DEFAULT
  endcase
end // always @*

   
always @* begin

   debugTRem[69:0] = Sum[69:0] + Carry[69:0];
   absTRem[67:0] = (debugTRem[67] ? (~debugTRem[67:0] + 68'b1) : debugTRem[67:0]);
   absD[67:62]    = (DivisorSign ? (~{DivisorSign, DivisorSign, D[65:62]} + 6'b1) : {DivisorSign, DivisorSign, D[65:62]});
end

always @(posedge CCLK05) begin

   debugTotalPartialRemainder_d1[69:0] <= debugTRem[69:0];
   
   //! unused debugTotalPartialRemainder_d1[69:0]
   //! unused absTRem[67:0]
   //! unused absD[67:62]
end

   // NOTE: remember, the value of PRem may be one less than TRem.  The ova below needs to do the full add to make sure we are
   // within our boundries.
// // ova forbid_bool ((DivState[3:0] == `DIVStateIterate) & (absTRem[67:62] > absD[67:62]),
//                 "Divide error: absolute value of non-redundant partial remainder is greater than absolute value of divisor!");

//--------------------------------------------------------------------------------
// 64 bit CPA
// Used to generate final remainder and perform the remainder fixup.
//
always @* begin
   
// NOTE: in the remainder fixup case, we dont need to care about the MSB [66] of OpA and OpB.
// sign extension is handled separately.
  FRem_OpA[66:0] = DivStateGenRemainder ?  XH[66:0]         : {1'b0, XL[63:0], 2'b00};
  FRem_OpB[66:0] = DivStateGenRemainder ? {5'b00, CH[61:0]} : {1'b0, D[65:0]};   
  FRem_Carryin = (DivState[3:0] == `DIVStateFixupRemainder) & (~(DivisorSign ^ FRemSign_d1));
   
  FinalRemainder[66:0] = FRem_OpA[66:0] + FRem_OpB[66:0] + {66'b0, FRem_Carryin};
//! unused FinalRemainder[1:0]
  
// During GenRemainder, we determine if the remainder will be zero to prevent fixup of a divide expecting a signed negative remainder (since sign of zero is positive)
// Its too slow to do the add of OpA and OpB then use a big OR gate to detect non-zero.  In parallel, we can look for the following patterns:
// ZZZZ...ZZZZZZ  or
// PPPP...PPGZZZ...ZZZ
// these case guarantee that FinalRemainder is zero:  neighbors of: PP, PG, GZ, or ZZ
// where P[i] = OpA[i] ^ OpB[i]
//       G[i] = OpA[i] & OpB[i]
//       Z[i] = ~OpA[i] & ~OpB[i]   
  RemP[66:0] =  XH[66:0] ^  {5'b00, CH[61:0]};
  RemZ[66:0] = ~XH[66:0] & ~{5'b00, CH[61:0]};   
  RemG[66:0] =  XH[66:0] &  {5'b00, CH[61:0]};     
  RemPP[66:0] = RemP[66:0] & {RemP[65:0], 1'b0};
  RemPG[66:0] = RemP[66:0] & {RemG[65:0], 1'b0};     
  RemGZ[66:0] = RemG[66:0] & {RemZ[65:0], 1'b1};
  RemZZ[66:0] = RemZ[66:0] & {RemZ[65:0], 1'b1};     
     
  FinalRemainderIsZero = (& (RemPP[66:0] | RemPG[66:0] | RemGZ[66:0] | RemZZ[66:0]));

// Normally, we only fixup the remainder when its sign doesnt match the sign of the dividend.
// But we also need to fix it up when the signs match and the remainder equals the divisor.   

// If either of the following are true, the final remainder equals the absolute value of the divisor
// FRem_OpA + FRem_OpB - D = 0
// FRem_OpA + FRem_OpB + D = 0

// We'll do the same as above, but do a 3:2 compression first
// First, if Remainder equals a negative D (need to effectively add D to final remainder to get zero):   
  RemIsNegD_S[66:0] = {XH[66:0] ^ {5'b00, CH[61:0]} ^ {DivisorSign, D[65:0]}};
  RemIsNegD_C[66:0] = {(XH[65:0] & {4'b0, CH[61:0]}) | (XH[65:0] & D[65:0]) | ({4'b0, CH[61:0]} & D[65:0]), 1'b0} ;
   
  RemIsNegD_P[66:0] =  RemIsNegD_S[66:0] ^  RemIsNegD_C[66:0];
  RemIsNegD_Z[66:0] = ~RemIsNegD_S[66:0] & ~RemIsNegD_C[66:0];
  RemIsNegD_G[66:0] =  RemIsNegD_S[66:0] &  RemIsNegD_C[66:0];
   
  RemIsNegD_PP[66:0] = RemIsNegD_P[66:0] & {RemIsNegD_P[65:0], 1'b0};
  RemIsNegD_PG[66:0] = RemIsNegD_P[66:0] & {RemIsNegD_G[65:0], 1'b0};     
  RemIsNegD_GZ[66:0] = RemIsNegD_G[66:0] & {RemIsNegD_Z[65:0], 1'b1};
  RemIsNegD_ZZ[66:0] = RemIsNegD_Z[66:0] & {RemIsNegD_Z[65:0], 1'b1};     
     
  FinalRemainderIsNegDivisor = (& (RemIsNegD_PP[66:0] | RemIsNegD_PG[66:0] | RemIsNegD_GZ[66:0] | RemIsNegD_ZZ[66:0]));

// if Remainder equals a positive D: (effectively subtract D from finalremainder to get zero)   (to complete the 2s compl on D, inject the 1 into the [-1] index (in the *_PP, _PG, _GZ, and _ZZ equations below)
  RemIsPosD_S[66:0] = {XH[66:0] ^ {5'b00, CH[61:0]} ^ ~{DivisorSign, D[65:0]}};
  RemIsPosD_C[66:0] = {(XH[65:0] & {4'b0, CH[61:0]}) | (XH[65:0] & ~D[65:0]) | ({4'b0, CH[61:0]} & ~D[65:0]), 1'b0} ;
   
  RemIsPosD_P[66:0] =  RemIsPosD_S[66:0] ^  RemIsPosD_C[66:0];
  RemIsPosD_Z[66:0] = ~RemIsPosD_S[66:0] & ~RemIsPosD_C[66:0];
  RemIsPosD_G[66:0] =  RemIsPosD_S[66:0] &  RemIsPosD_C[66:0];
   
  RemIsPosD_PP[66:0] = RemIsPosD_P[66:0] & {RemIsPosD_P[65:0], 1'b0};
  RemIsPosD_PG[66:0] = RemIsPosD_P[66:0] & {RemIsPosD_G[65:0], 1'b1};     // LSB is 1'b1 to inject +1 to complete 2s complement  (forcing G)
  RemIsPosD_GZ[66:0] = RemIsPosD_G[66:0] & {RemIsPosD_Z[65:0], 1'b0};
  RemIsPosD_ZZ[66:0] = RemIsPosD_Z[66:0] & {RemIsPosD_Z[65:0], 1'b0};     
     
  FinalRemainderIsPosDivisor = (& (RemIsPosD_PP[66:0] | RemIsPosD_PG[66:0] | RemIsPosD_GZ[66:0] | RemIsPosD_ZZ[66:0]));

  FinalRemainderIsDivisor = FinalRemainderIsPosDivisor | FinalRemainderIsNegDivisor;
   
end
   
always @(posedge CCLK05) begin
  if (DivState[3:0] == `DIVStateGenRemainder) begin
   FinalRemainderIsDivisor_d1 <= FinalRemainderIsDivisor;
   FinalRemainderIsZero_d1    <= FinalRemainderIsZero;
   FRemSign_d1                <= FinalRemainder[66];
  end
end
   
     
   
always @* begin


  DivFlags_8[`RESFLAG_OSZAPC] = 6'b00_0100;
  DivError_8 = DivideByZero_d1 | QuotientTooLarge_8 | DivError_d1;

   
// Bubble requests sent early.  All other ops that can jam the result bus (FP, MUL, CLZ, POPCNT) can take priority over DIV jams.
// As such, the bubble from DIV is just a request and if others jams are present, the DIV state machine will issue the request again the
// next cycle.
  FirstAttemptDivSteal2_6 = (DivState[3:0] == `DIVStateBroadcastQuotient) & (DivSteal1_8 | ~DualResDiv2);
  FirstAttemptDivSteal1_6 = DualResDiv2 & ((DivState[3:0] == `DIVStatePauseForSteal) | ((DivState[3:0] == `DIVStateIterate) & (IterationCount[6:0] == 7'd1)));

  AttemptDivSteal2_6 = FirstAttemptDivSteal2_6 | ReattemptDivSteal2;
  AttemptDivSteal1_6 = FirstAttemptDivSteal1_6 | ReattemptDivSteal1;   


// DivSteal1_6 cannot be determined since MulSteal1_6 is a critical path.  We will assume the steal worked, but reattempt if the
// MulSteal was indeed asserted
//  DivSteal1_6 = (AttemptDivSteal1_6 & ~MulSteal1_6);
  DivSteal2_6 = (AttemptDivSteal2_6 & ~FpuSteal2_6);

// including DivideByZero_d1 since FinalRemainder can be X in the DivisorZero case
// Fixup only valid during BroadcastQuotient		       
  FixupNeeded = (DivState[3:0] == `DIVStateBroadcastQuotient) & ~DivideByZero_d1 & 
                (((DividendSign ^ FRemSign_d1) & ~FinalRemainderIsZero_d1) | FinalRemainderIsDivisor_d1);

//
//   Sign of  Sign of  Sign of         Quotient Select   (assuming Rem!=0)         Normal Fixup			   Fixup if
//  Dividend  Divisor  Remainder     Rem!=Divisor     Rem==Divisor (in magnitude)   SignDividend!=SignRemainder    Divisor==Remainder	Fixup Action
//     0        0        0             Q                QP				0				1		-D  (Rem will be zero)
//     0        0        1             QM               QM				1				x		+D
//     0        1        0             Q                QM				0				1		+D  (Rem will be zero)
//     0        1        1             QP               QP				1				x		-D
//     1        0        0             QP               QP				1				x		-D
//     1        0        1             Q                QM				0				1		+D  (Rem will be zero)
//     1        1        0             QM               QM				1				x		+D
//     1        1        1             Q                QP				0				1		-D  (Rem will be zero)
//

  if      (~(DivisorSign ^ FRemSign_d1) & FixupNeeded) Quotient[63:0] = QP[63:0];
  else if ( (DivisorSign ^ FRemSign_d1) & FixupNeeded) Quotient[63:0] = QM[63:0];
  else                                                 Quotient[63:0] = Q[63:0];
   
   
  case (DivisorSize[1:0])
    `DivisorSize16 : QuotientRes[63:0] = {MergeDataA[63:16], Quotient[15:0]};
    `DivisorSize32 : QuotientRes[63:0] =             {32'b0, Quotient[31:0]};     
    `DivisorSize64 : QuotientRes[63:0] =                     Quotient[63:0] ;
    default        : QuotientRes[63:0] =                     64'bx ;  //! TRUE_DEFAULT
  endcase

  case (DivisorSize[1:0]) 
    `DivisorSize8  : RemainderRes[63:0] = {MergeDataB[63:16], XH[7:0], MergeDataA[7:0]};
    `DivisorSize16 : RemainderRes[63:0] = {MergeDataB[63:16], XH[15:0]};
    `DivisorSize32 : RemainderRes[63:0] =             {32'b0, XH[31:0]};     
    `DivisorSize64 : RemainderRes[63:0] =                     XH[63:0] ;
    default        : RemainderRes[63:0] =                     64'bx ;  //! TRUE_DEFAULT
  endcase
   
  case (1'b1)
    (DivState[3:0] == `DIVStateBroadcastQuotient)  & ~DivError_8 : DivResBus_8[`DATA] = QuotientRes[63:0];  
    (DivState[3:0] == `DIVStateBroadcastRemainder) & ~DivError_8 : DivResBus_8[`DATA] = RemainderRes[63:0];
                                                      DivError_8 : DivResBus_8[`DATA] = {51'b0, `UC_EP_HW_DIVERROR};        // forcing ucode entrypoint for handling div error (uses AssertFault mechanism in FR)  (mc_cpu.disasm)
    default                                                      : DivResBus_8[`DATA] = 64'b0; //! TRUE_DEFAULT             // forcing zero to prevent toggling every cycle and wasting power
  endcase
   
end // always @*


always @(posedge CCLK05) begin

  if ((DivState[3:0] == `DIVStatePrescaleDivisor)) InitialIterationCount[6:0] <= IterationCountNext[6:0];
//! unused InitialIterationCount[6:0]

end
   
always @* begin
// Since most of out performance gain is from moving Divides from ucode to fastpath, the feeling is that there's
// not much to gain by optimizing the path of detecting quotient too large early and skip the iteration steps.

// determining Quotient Too Large isnt so easy.  Iteration counts arent exact since the first iteration could be 0 or -1 (so that leading zeros for a positive quotient, or leading ones of a
// negative quotient shouldnt be counted (and can left shift out of the quotient register without a problem).  Additionally, in the negative dividend case, if we need to fixup
// and we always chose q=+3, then the QP register is all zero when it really should be a 1 and all zeros.  This could cross the quotient size boundry.

// If Divisor is zero, we skip PrescaleDivisor and thus, InitialIterationCount and NumQuotientBits_d1 are undefined.   
// // ova forbid_bool ((DivState[3:0] == `DIVStateBroadcastQuotient) & ~DivideByZero_d1 & 
//                  ~QuotientTooLarge_8 & ((InitialIterationCount[6:0] * 7'd2) > (NumQuotientBits_d1[6:0] + 7'd2)),
//                 "Divide error: Iteration count *2 shouldnt be greater than the number of quotient bits without asserting QuotientTooLarge!");

// Can observe the results in the Q, QM, and QP registers for overflow.  We can iterate once beyond the number
// of quotient bits calculated, hence why we look at bits MSB+1 and MSB+2.  We also look at bit MSB+3
// for the sign.  (example: in 8-bit case, MSB is 7, bits 9:8 hold the extra iteration results, and bit 10 is the sign.)
  case (DivisorSize[1:0])
    `DivisorSize8  : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&Q[9:7])   : ((|Q[10:8])  | (Q[7]  & SignedDiv2)));
    `DivisorSize16 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&Q[17:15]) : ((|Q[18:16]) | (Q[15] & SignedDiv2)));
    `DivisorSize32 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&Q[33:31]) : ((|Q[34:32]) | (Q[31] & SignedDiv2)));
    `DivisorSize64 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&Q[65:63]) : ((|Q[66:64]) | (Q[63] & SignedDiv2)));
    default        : QuotientTooLargeQOverflow = 1'bx;  //! TRUE_DEFAULT
  endcase

  case (DivisorSize[1:0])
    `DivisorSize8  : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&QP[9:7])   : (|QP[10:8]  | (QP[7]  & SignedDiv2)));
    `DivisorSize16 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&QP[17:15]) : (|QP[18:16] | (QP[15] & SignedDiv2)));
    `DivisorSize32 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&QP[33:31]) : (|QP[34:32] | (QP[31] & SignedDiv2)));
    `DivisorSize64 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&QP[65:63]) : (|QP[66:64] | (QP[63] & SignedDiv2)));
    default        : QuotientTooLargeQpOverflow = 1'bx;  //! TRUE_DEFAULT
  endcase

  case (DivisorSize[1:0])
    `DivisorSize8  : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&QM[9:7])  : (|QM[10:8])  | (QM[7]  & SignedDiv2));
    `DivisorSize16 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&QM[17:15]): (|QM[18:16]) | (QM[15] & SignedDiv2));
    `DivisorSize32 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&QM[33:31]): (|QM[34:32]) | (QM[31] & SignedDiv2));
    `DivisorSize64 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&QM[65:63]): (|QM[66:64]) | (QM[63] & SignedDiv2));
    default        : QuotientTooLargeQmOverflow = 1'bx;  //! TRUE_DEFAULT
  endcase

// This is only valid during BroadcastQuotient (via FixupNeeded)
   QuotientTooLargeOverflow =  (~(DivisorSign ^ FRemSign_d1) & FixupNeeded) ? QuotientTooLargeQpOverflow_d1 :
			       ( (DivisorSign ^ FRemSign_d1) & FixupNeeded) ? QuotientTooLargeQmOverflow_d1 :
			                                                      QuotientTooLargeQOverflow_d1;
   
// a quotient of zero can be the result of opposite signed dividend and divisor, hence need to squash with NoIterate.
// can also iterate once with a quotient of zero.  NoIterate and IterateOnce are needed here in case we generate a quotient of zero
// but expected a negative quotient.  In that case, we inspect the upper bits of the Q* registers for any 0s to determine overflow,
// but a quotient of zero is all zeros, so that would be a false assert by QuotientTooLargeOverflow.
  QuotientTooLarge_8 = (DivState[3:0] == `DIVStateBroadcastQuotient) & QuotientTooLargeOverflow & ~NoIterate & ~IterateOnce;
   
end // always @ *

   
always @(posedge CCLK05) begin
 
  if (DivState[3:0] != `DIVStateIdle) begin
    QuotientTooLargeQpOverflow_d1 <= QuotientTooLargeQpOverflow;
    QuotientTooLargeQmOverflow_d1 <= QuotientTooLargeQmOverflow;
    QuotientTooLargeQOverflow_d1  <= QuotientTooLargeQOverflow;
  end


  if ((DivState[3:0] == `DIVStatePrescaleCountDividend) |    //to reset
      (DivState[3:0] == `DIVStateBroadcastQuotient))
    DivError_d1 <= DivError_8 & ~(DivState[3:0] == `DIVStatePrescaleCountDividend);

  
  DivSteal1_8 <= AttemptDivSteal1_7 & ~MulSteal1_7;
  DivSteal2_8 <= DivSteal2_7;
  DivSteal2_7 <= DivSteal2_6;
  MulSteal1_7 <= MulSteal1_6;
   
  AttemptDivSteal1_7 <= AttemptDivSteal1_6;
   
  ReattemptDivSteal2 <= DivCancel_8 ? 1'b0 : (AttemptDivSteal2_6 & FpuSteal2_6) | (ReattemptDivSteal2 & FpuSteal2_6);
   
end

always @* begin
  // Reattempt to steal bus 1 if we had attempted to steal the previous cycle, but MulSteal1 was asserted as well
  ReattemptDivSteal1 = ~DivCancel_8 & AttemptDivSteal1_7 & MulSteal1_7;

end
   
                       

//--------------------------------------------------------------------------------
// Display 
//always @(negedge CCLK05) begin
//
//   if (~ExIReset & DivIssue2_7) begin
//      if (ExuCbvsResEnable_7[3:0] == 4'b0011)      $display ("DIVINFO==> 16 bit Divide Issued!    tag = %d, time = %t\n",ResTag2_7[6:2], $time);
//      else if (ExuCbvsResEnable_7[3:0] == 4'b0111) $display ("DIVINFO==> 32 bit Divide Issued!    tag = %d, time = %t\n",ResTag2_7[6:2],$time);
//      else if (ExuCbvsResEnable_7[3:0] == 4'b1111) $display ("DIVINFO==> 64 bit Divide Issued!    tag = %d, time = %t\n",ResTag2_7[6:2],$time);
//      else                                         $display ("DIVINFO==>  8 bit Divide Issued!    tag = %d, time = %t\n",ResTag2_7[6:2],$time);
//
//      $display ("DIVINFO==> Signed Divide = %b\n", DivCbvsSignedDiv2_7);
//      
//   end
//
//   if (~ExIReset & DivIssue2_8) begin
//     case (DivisorSize_8[1:0])
//       `DivisorSize8  : begin
//                          $display ("DIVINFO==> Divisor = %h\n", AOpBus2_8[7:0]);
//                          $display ("DIVINFO==> Dividend = %h\n", BOpBus2_8[15:0]);
//                        end
//       `DivisorSize16 : $display ("DIVINFO==> Dividend = %h_%h\n", BOpBus2_8[15:0], AOpBus2_8[15:0]);
//       `DivisorSize32 : $display ("DIVINFO==> Dividend = %h_%h\n", BOpBus2_8[31:0], AOpBus2_8[31:0]);
//       `DivisorSize64 : $display ("DIVINFO==> Dividend = %h_%h\n", BOpBus2_8[63:0], AOpBus2_8[63:0]);
//     endcase
//   end
//
//   if (~ExIReset & DivIssue1_8) begin
//     case (DivisorSize[1:0])
//       `DivisorSize16 : $display ("DIVINFO==> Divisor = %h\n", AOpBus1_8[15:0]);
//       `DivisorSize32 : $display ("DIVINFO==> Divisor = %h\n", AOpBus1_8[31:0]);
//       `DivisorSize64 : $display ("DIVINFO==> Divisor = %h\n", AOpBus1_8[63:0]);
//     endcase
//   end
//
//  if ((DivState[3:0] == `DIVStatePrescaleDivisor)) begin
//    $display ("DIVINFO==> NumDivisorBits[6:0] = %d\n", NumDivisorBits[6:0]);
//    $display ("DIVINFO==> NumQuotientBits[7:0] = %d\n", NumQuotientBits[7:0]);
//  end
//   
//
//  if ((DivState[3:0] == `DIVStatePrescaleDividend)) begin
//    $display ("DIVINFO==> NumDividendBits[7:0] = %d\n", NumDividendBits[7:0]);
//  end
//
//  if ((DivState[3:0] == `DIVStateIterate) & (DivisorSize[1:0] == `DivisorSize32)) begin
//
//     $display ("DIVINFO==> Iteration #%d ============================================================================\n",IterationCount[6:0]);
//     $display ("DIVINFO==> <<2   %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", XH[66:63], XH[62:59], XH[58:55],
//               XH[54:51], XH[50:47], XH[46:43], XH[42:39], XH[38:35], XH[34:31], XH[30:27], XH[26:23], XH[22:19], XH[18:15],
//               XH[14:11], XH[10:7], XH[6:3]);
//     case ({NegDivisorSel, MuxSel[1:0]})
//           3'b000 : $display ("DIVINFO==> q=-0\n");
//           3'b001 : $display ("DIVINFO==> q=-1\n");           
//           3'b010 : $display ("DIVINFO==> q=-2\n");                
//           3'b011 : $display ("DIVINFO==> q=-3\n");                
//           3'b100 : $display ("DIVINFO==> q=+0\n");
//           3'b101 : $display ("DIVINFO==> q=+1\n");           
//           3'b110 : $display ("DIVINFO==> q=+2\n");           
//           3'b111 : $display ("DIVINFO==> q=+3\n");
//           default  : $display ("DIVINFO==>  Off the Table!!!!!!!!!  MAJOR ERROR!\n");
//           endcase // case({NegDivisorSel, MuxSel[1:0]}...
//
//     $display ("DIVINFO==>  2d   %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", DivOpA[68:65], DivOpA[64:61], DivOpA[60:57],
//               DivOpA[56:53], DivOpA[52:49], DivOpA[48:45], DivOpA[44:41], DivOpA[40:37], DivOpA[36:33], DivOpA[32:29], DivOpA[28:25], DivOpA[24:21], DivOpA[20:17],
//               DivOpA[16:13], DivOpA[12:9], DivOpA[8:5]);
//     $display ("DIVINFO==>   d   %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", DivOpB[68:65], DivOpB[64:61], DivOpB[60:57],
//               DivOpB[56:53], DivOpB[52:49], DivOpB[48:45], DivOpB[44:41], DivOpB[40:37], DivOpB[36:33], DivOpB[32:29], DivOpB[28:25], DivOpB[24:21], DivOpB[20:17],
//               DivOpB[16:13], DivOpB[12:9], DivOpB[8:5]);
//     $display ("DIVINFO==>  ch   %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", DivOpD[68:65], DivOpD[64:61], DivOpD[60:57],
//               DivOpD[56:53], DivOpD[52:49], DivOpD[48:45], DivOpD[44:41], DivOpD[40:37], DivOpD[36:33], DivOpD[32:29], DivOpD[28:25], DivOpD[24:21], DivOpD[20:17],
//               DivOpD[16:13], DivOpD[12:9], DivOpD[8:5]);
//     $display ("DIVINFO==>       --------------------------------------------------------------------------------\n");
//     $display ("DIVINFO==> sum   %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", Sum[68:65], Sum[64:61], Sum[60:57],
//               Sum[56:53], Sum[52:49], Sum[48:45], Sum[44:41], Sum[40:37], Sum[36:33], Sum[32:29], Sum[28:25], Sum[24:21], Sum[20:17],
//               Sum[16:13], Sum[12:9], Sum[8:5]);
//     $display ("DIVINFO==>carry  %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n", Carry[68:65], Carry[64:61], Carry[60:57],
//               Carry[56:53], Carry[52:49], Carry[48:45], Carry[44:41], Carry[40:37], Carry[36:33], Carry[32:29], Carry[28:25], Carry[24:21], Carry[20:17],
//               Carry[16:13], Carry[12:9], Carry[8:5]);
//     $display ("DIVINFO==>       --------------------------------------------------------------------------------\n");
//     $display ("DIVINFO==> prem    %b.%b\n", PRem [66:65], PRem[64:62]);
//     $display ("DIVINFO==>total  %b.%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b_%b\n\n", debugTRem[68:65], debugTRem[64:61], debugTRem[60:57],
//               debugTRem[56:53], debugTRem[52:49], debugTRem[48:45], debugTRem[44:41], debugTRem[40:37], debugTRem[36:33], debugTRem[32:29], debugTRem[28:25], debugTRem[24:21], debugTRem[20:17],
//               debugTRem[16:13], debugTRem[12:9], debugTRem[8:5]);
//                           
//  end
//   
//end  // always @*
   
   
   
endmodule

