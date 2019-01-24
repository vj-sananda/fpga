// Command line: conv.prl -o LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/ex_div.x.v -makedeps\
//                LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/ex_div.x.v.prereqs -vdefines var/VDEFINES -vincdirs\
//                var/VINCDIRS LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/ex_div.x.vpp_out -mc -md -dy . -macrospec\
//                LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/lib/verilog/conv_macro_specs.yaml +define+ABV=ABV
// Working dir: /proj/jg_users/arch/bkwan/jg_DIVIDER/simenv/build/jg_1r
// Revision: 1.56 
// Source file: LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/ex_div.x.vpp_out
// 1 LIKE_VERILOG/proj/jg_users/arch/bkwan/jg_DIVIDER/rtl/ex_div.x
//=======================================================================
//                     Jaguar RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2010 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: ex_div.x.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change$
//=======================================================================
// Module Description:
// Jaguar Integer Divider - derived from Husky32 rtl_exdiv.v
//=======================================================================


//================================================================================================================================
// <Module Description>
//
// FIXME BILL: These pipeline suffixes seem wrong? clearly DivIssue_8 is valid in _8 not _9.
//
// Typical non-8-bit divides:
// |             |  _9         |  _10        |   11     |   12     |   13      //   13+n    |   14+n    |   15+n    |   16+n    |   17+n
// | DivIssue_8  | Get         | Calc for    | Prescale |          | Iterate   // Iterate   | Generate  | Broadcast | Postscale | Broadcast
// | divl        | divisor     | prescale    | dividend |          | n cycles  //           | remainder | quotient  | remainder | remainder
// |             |             | dividend    |          |          |           //           |           |           |           |
// |             |             |             |          |          |           //           |           |           |           |
// |             | DivIssue_8  | Get         | Calc for | Prescale |           // Steal     |           | Steal     |           |
// |             | divh        | dividend    | prescale | divisor  |           // ResBus for|           | ResBus for|           |
// |             |             |             | divisor  |          |           // quotient  |           | remainder |           | 
//
//
// Typical 8-bit divides:
// |   8         |   9         |   10        |   11     |   12     |   13      //   13+n    |   14+n    |   15+n    |   16+n    |   17+n
// | DivIssue_8  | Get         | Calc for    | Prescale |          | Iterate   // Iterate   | Generate  |           | Postscale | Broadcast
// | div8        | dividend    | prescale    | dividend |          | n cycles  //           | remainder |           | remainder | remainder
// |             | and         | dividend    |          |          |           //           |           |           |           | and 
// |             | divisor     |             |          |          |           //           |           |           |           | quotient
// |             |             |             | Calc for | Prescale |           //           |           | Steal     |           |
// |             |             |             | prescale | divisor  |           //           |           | ResBus for|           |
// |             |             |             | divisor  |          |           //           |           | remainder |           | 
// |             |             |             |          |          |           //           |           | and       |           | 
// |             |             |             |          |          |           //           |           | quotient  |           | 
//
//
// Divide by zero:
// |   8         |   9         |   10        |   11     |   12     |   13       |   14      |   15      |   16      |   17      |
// | DivIssue_8  | Get         | Calc for    | Prescale |          | Pause for  | Generate  | Broadcast | Postscale | Broadcast | 
// | div         | dividend    | prescale    | dividend |          | steal      | remainder | quotient  | remainder | remainder | 
// |             | and         | dividend    |          |          |            |           |           |           |           |
// |             | divisor     |             |          |          |            | (nothing) |           |           |           |       
// |             |             |             |          |          |            |           |           |           |           |
// |             |             |             | Calc for | Prescale | Steal      |           | Broadcast | Do        | Do        | 
// |             |             |             | prescale | divisor  | ResBus for |           | div flags | nothing   | Nothing   |
// |             |             |             | divisor  |          | div error  |           |           | 
//
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
//  Q+1 or Q-1 as the final quotient.
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
//
// State machine:
// --------------
//
// 1) DIVStateIdle
//      for 8-bit divides, the dividend and divisor are both received here.  otherwise, only dividend is received.
//       D <= DivAOp_9[15:8] or [7:0]              (divisor for 8-bit (I)DIV, depends on AHighSwap)                              // div8/divh AOp
//      XH <= DivBOp_9[63:0]                       (dividend for 8-bit divide, or higher bits of dividend for non-8-bit divide)  // div8/divh BOp
//      XL <= 8 bit divide ? 64'b0 : DivAOp_9[63:0]  (lower half of dividend for non-8-bit divides)                              //      divh AOp
//      CH <= 62'b0;
//      goto DIVStatePrescaleCountDividend
// 
// 2) DIVStatePrescaleCountDividend  (state 3)
//      ShiftAmtD[6:0] <= PrescaleCount (XH:XL)   
//      XL <= XL << 48 or 32.   concatentate dividend for 16 and 32 bit divides (effectively remove unneeded bits between dividend halves in upper XL)
//      TEMPXL <= 8 bit divide ? D : DivAOp_9[63:0]   // divl AOp
//      (detect divisor=0)
//      goto DIVStatePrescaleDividend
// 
// 3) DIVStatePrescaleDividend  (state 4)
//      D  <= XL << ShiftAmtD[6:0]             if non-8-bit divide (D will contain the prescaled lower dividend while XL can get the divisor)
//      XH <= {XH,XL} << ShiftAmtD[6:0]        upper prescaled dividend in XH
//      XL <= TEMPXL                           move divisor into XL to prepare to prescale
//      ShiftAmtX[6:0] <= PrescaleCount (TEMPXL)
//      initialize Q, QM, QP
//      goto DIVStatePauseForSteal if divisor is zero, else DIVStatePrescaleDivisor if DivIssue1_9 and it isn't canceled
// 
// 4) DIVStatePrescaleDivisor  (state 5)
//      D <= XL << ShiftAmtX
//      XH <= {XH,D} << 1   (extra 1-bit left shift if we detect an odd number of quotient bits (to make it even)
//      XL <= D << 1 or 0   (extra 1-bit left shift if we detect an odd number of quotient bits, also to return lower dividend back to XL)
//      Determine divisor lookup bits
//      Determine # of iterations
//      goto DIVStatePauseForSteal if # of iterations = 0, else DIVStateIterate
// 
// 5) DIVStateIterate
//    top 6 bits of XH & divisor bits (in XH) select from table
//  value of q.  
//    a 2-bit left shifted Sum (XH) and Carry (CH), +-2D and +-D (or zero) go to 4:2 compressor
//    Upper bits are added
// 
//    XH and CH[63:0] <= ({XH[63:0] << 1'b1}  +  Mux2D[63:0]  +  MuxD[63:0]
//    top 6 bits of XH are full CPA
// 
//    previous value of Q, QM, and QP, with some logic generate new quotient bits shifted
//  into QP, XL, and QM flops next clock edge
//    XL <= XL<<2
//     Q <= Q bits
//    QM <= QM bits
//    QP <= QP bits
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
// 6) DIVStatePauseForSteal
//      Signal AttemptSteal1
//      goto DIVStateGenRemainder
//
// 7) DIVStateGenRemainder
//      XL <= Add sum and carry to get final remainder (XH + CH)
//      D <= ~D or D  (conditionally 1s complement divisor in preparation for remainder fixup)
//      FinalRemainderIsZero <= XH+CH==0
//      FinalRemainderIsDivisor <= XH+CH==+/-D
//      ReattemptSteal1 if the Mulitplier got priority last cycle and assserted MulSteal1
//      goto DIVStateBroadcastQuotient
//
// 8) DIVStateBroadcastQuotient
//      Determine FixupNeeded
//      DivRes = merge data with Q, QM, or QP (quotient)
//      XH <= all ones or zeros (to Sign extend remainder)
//      XL <= if (fixup needed) Remainder + D
//      ShiftAmt <= Number of divisor bits (prepare to postscale the remainder)
//      Continue to ReattemptSteal if the multiplier keeps getting priority with MulSteal1
//      stay here until we successfully jam the quotient (non-8-bit divides only)
//      signal AttemptSteal2
//      goto DIVStatePostscaleRemainder if the steal attempt was successful (no FpuSteal2)
// 
// 9) DIVStatePostscaleRemainder
//      XH <=  XL << ShiftAmt (postscale remainder)
//      goto DIVStateBroadcastRemainder
//
// 10) DIVStateBroadcastRemainder
//       DivRes = merge data with XH (remainder)
//       goto DIVStateIdle
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
// JG div op and operand documentation
//
// JG div instruction to op mapping - derived from me_fdec RTL.
// 
//                                       Div8Divh SignedDiv DualResDiv  OpA                OpB                DestReg    ResBus
//   ;;; DIV r/m8    [F6 /6]
//           div8.b.m4f  eax, r/m8           1        0         0       divisor            dividend (EAX)     OpB        remainder:quotient
//       =
// 
//   ;;; IDIV r/m8   [F6 /7]
//           idiv8.b.m4f eax, r/m8           1        1         0       divisor            dividend (EAX)     OpB        remainder:quotient
//       =
// 
//   ;;; DIV  r/m16/32/64 [F7 /6]
//           divl.v.m4f  edx, r/m16/32/64    0        0         1       divisor            <unused>           OpB        remainder
//           divh.v.m4f  eax, edx'           1        0         1       Lo dividend (EAX)  Hi dividend (EDX)  OpA        quotient
//       =
// 
//   ;;; IDIV r/m16/32/64 [F7 /7]
//           idivl.v.m4f edx, r/m16/32/64    0        1         1       divisor            <unused>           OpB        remainder
//           idivh.v.m4f eax, edx'           1        1         1       Lo dividend (EAX)  Hi dividend (EDX)  OpA        quotient
//       =
// 
// Decoding div op types from Div8Divh and DualResDiv bits passed through sched queue:
//   div8/idiv8 =  Div8Divh & ~DualResDiv
//   divh       =  Div8Divh &  DualResDiv
//   divl       = ~Div8Divh &  DualResDiv
//   div        =  Div8Divh |  DualResDiv
// 
// 
// JG Operand content for each div op type:
//   AOp ->  div8: divisor;      divl: divisor;   divh: EAX=lower dividend
//   BOp ->  div8: AX=dividend;  divl: <unused>;  divh: EDX=upper dividend
// 
//================================================================================================================================
// HS32 RTL Notes (for reference only - this does not match the RTL in this JG ex_div.x source file!)
//
// HS32 rtl_exdiv.v source operands:
//   AOpBus1_8:                non-8-bit divisor
//   AOpBus2_8: div8 divisor , non-8-bit lower dividend
//   BOpBus2_8: div8 dividend, non-8-bit upper dividend
// 
//================================================================================================================================

`timescale 1ps/1ps

`include "uc_field.d"
`include "ccu_def.d"
`include "ex_div.d"


module ex_div(
CCLK,
SDO,
SDI,
SSE,
FR_Abort_11,
DivIssue_8,
DivLateCancel_8,
Div8Divh_8,
SignedMulDiv_8,
DualResMulDiv_8,
AHighSwap_8,
ResEnable_8,
EX_ResBus0_10,
EX_ResBus1_10,
EX_DcResBus_12,
AFwd9AL0_8,
AFwd9AL1_8,
AFwdP4LS_8,
AFwdHi_8,
BFwd9AL0_8,
BFwd9AL1_8,
BFwdP4LS_8,
BFwdHi_8,
ResTag_8,
Prn_8,
PrnV_8,
AOp_9,
BOp_9,
MulBubbleNoLateCancel_6,
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
output        SDO;                 // scan data out
input         SDI;                 // scan data in
input         SSE;                 // scan clock for scan flop slave latch

input         FR_Abort_11;         // reset, exception, or branch misprediction

input         DivIssue_8;          // Divide op issued in _8
input         DivLateCancel_8;     // Divide op is late cancelled (in late _8)

input         Div8Divh_8;          // div8/divh/idiv8/idivh op
input         SignedMulDiv_8;      // signed divide op (idiv8/idivl/idivh)
input         DualResMulDiv_8;     // double-op divides (divl/divh/idivl/idivh)
input         AHighSwap_8;         // high byte swap
input   [3:0] ResEnable_8;         // dest enables. 0: bits 7:0; 1: bits 15:8; 2: 31:0; 3: 63:32

input  [63:0] EX_ResBus0_10;       // ALU0 Result Bus
input  [63:0] EX_ResBus1_10;       // ALU1 Result Bus
input  [63:0] EX_DcResBus_12;      // Load Result Bus

input         AFwd9AL0_8;          // Forward EX_ResBus0_10  to AOp in _9
input         AFwd9AL1_8;          // Forward EX_ResBus1_10  to AOp in _9
input         AFwdP4LS_8;          // Forward EX_DcResBus_12 to AOp in _9
input         AFwdHi_8;            // Forward high half of data
input         BFwd9AL0_8;          // Forward EX_ResBus0_10  to BOp in _9
input         BFwd9AL1_8;          // Forward EX_ResBus1_10  to BOp in _9
input         BFwdP4LS_8;          // Forward EX_DcResBus_12 to BOp in _9
input         BFwdHi_8;            // Forward high half of data

input   [5:0] ResTag_8;            // ROB tag for issuing divide 
input   [5:0] Prn_8;               // PRN (physical register number)
input         PrnV_8;              // Prn_8 is valid (writes to PRF)

input  [63:0] AOp_9;               // DIV A operand (div8: AX=dividend;  divl: divisor;    divh: EAX=lower dividend)
input  [63:0] BOp_9;               // DIV B operand (div8: divisor;      divl: <unused>;   divh: EDX=upper dividend)

input         MulBubbleNoLateCancel_6;  // multiplier result is in effective 6 of ALU scheduler, result will mux into ALU in _9

        
output        DivBubble_6;          // divider result is in effective _6 of ALU scheduler, result will mux into ALU in _9
output  [5:0] DivDestTag_6;         // divide result ROB tag (in effective 6 of ALU scheduler)
output        DivPrnV_6;            // divide result PRN is valid (writes to PRF) 
output  [5:0] DivPrn_6;             // divide result PRN (in effective 6 of ALU scheduler)

output [63:0] DivResBus_9;          // Divider Result Bus
output [5:0]  DivFlags_9;           // Divider Result Flags
output        DivError_9;           // Divider Fault (divide by zero or quotient too large)

output        MostDivBusy_9;        // Divider is busy. Prevent divides from being scheduled. (Does not include first busy cycle.)

// Begin nets auto-declared by conv.prl
wire   AFwd10AL0_9;
wire   AFwd10AL0_9_eve;
wire   AFwd10AL1_9;
wire   AFwd10AL1_9_eve;
wire   AFwd10ALHi0_9;
wire   AFwd10ALHi0_9_eve;
wire   AFwd10ALHi1_9;
wire   AFwd10ALHi1_9_eve;
wire   AFwdP5LSHi_9;
wire   AFwdP5LSHi_9_eve;
wire   AFwdP5LS_9;
wire   AFwdP5LS_9_eve;
wire   AHighSwap_9;
wire   AHighSwap_9_eve;
wire   AlreadyFixedupRemainder;
wire   AlreadyFixedupRemainder_eve;
wire   AttemptJamQuotient_6;
wire   AttemptJamQuotient_7;
wire   AttemptJamQuotient_7_eve;
wire   AttemptJamRemainder_6;
wire   AttemptJamRemainder_7;
wire   AttemptJamRemainder_7_eve;
wire   BFwd10AL0_9;
wire   BFwd10AL0_9_eve;
wire   BFwd10AL1_9;
wire   BFwd10AL1_9_eve;
wire   BFwd10ALHi0_9;
wire   BFwd10ALHi0_9_eve;
wire   BFwd10ALHi1_9;
wire   BFwd10ALHi1_9_eve;
wire   BFwdP5LSHi_9;
wire   BFwdP5LSHi_9_eve;
wire   BFwdP5LS_9;
wire   BFwdP5LS_9_eve;
wire  [61:0] CH;
wire  [61:0] CH_eve;
wire  [70:0] Carry;
wire  [69:0] Ci;
wire  [65:0] D;
wire  [65:0] D_eve;
wire  [5:0] D_in_Selects;
wire  [69:0] Di;
wire  [68:0] Div2D;
wire   Div8Divh_9;
wire   Div8Divh_9_eve;
wire  [5:0] Div8DivlPrn;
wire   Div8DivlPrnV;
wire   Div8DivlPrnV_eve;
wire  [5:0] Div8DivlPrn_eve;
wire  [5:0] Div8DivlResTag;
wire  [5:0] Div8DivlResTag_eve;
wire   Div8_8;
wire   Div8_9;
wire  [63:0] DivAOp_9;
wire   DivAOp_defaultHi_9;
wire   DivAOp_defaultHi_9_eve;
wire   DivAOp_default_9;
wire   DivAOp_default_9_eve;
wire  [63:0] DivBOp_9;
wire   DivBOp_defaultHi_9;
wire   DivBOp_defaultHi_9_eve;
wire   DivBOp_default_9;
wire   DivBOp_default_9_eve;
wire   DivBubbleQuotient_6;
wire   DivBubbleRemainder_6;
wire   DivBubble_6;
wire  [68:0] DivD;
wire  [5:0] DivDestTag_6;
wire   DivError_9;
wire   DivError_d1;
wire   DivError_d1_eve;
wire   DivError_d1_intmux;
wire   DivError_d1_intmux_sel;
wire  [5:0] DivFlags_9;
wire   DivIssueDiv8Divh_8;
wire   DivIssueDiv8Divh_9;
wire   DivIssueDiv8Divl_8;
wire   DivIssueDiv8_9;
wire   DivIssueDivh_9;
wire   DivIssueDivl_9;
wire   DivIssue_9;
wire   DivIssue_9_eve;
wire  [68:0] DivOpA;
wire  [68:0] DivOpB;
wire  [68:0] DivOpC;
wire  [68:0] DivOpD;
wire   DivPrnV_6;
wire  [5:0] DivPrn_6;
wire  [3:0] DivState;
wire   DivStateGenRemainder;
wire   DivStateGenRemainder_eve;
wire   DivStatePrescaleDividend;
wire   DivStatePrescaleDividend_eve;
wire  [3:0] DivState_eve;
wire  [5:0] DivhPrn;
wire   DivhPrnV;
wire   DivhPrnV_eve;
wire  [5:0] DivhPrn_eve;
wire  [5:0] DivhResTag;
wire  [5:0] DivhResTag_eve;
wire   Divh_8;
wire   Divh_9;
wire   DivideByZero_d1;
wire   DivideByZero_d1_eve;
wire   DivideByZero_d1_intmux;
wire   DivideByZero_d1_intmux_sel;
wire   DividendSign;
wire  [2:0] DividendSign_9_Selects;
wire   DividendSign_eve;
wire   DividendSign_intmux;
wire   DividendSign_intmux_sel;
wire   DividendZero_d1;
wire   DividendZero_d1_eve;
wire   DividendZero_d1_intmux;
wire   DividendZero_d1_intmux_sel;
wire  [64:63] DivisorLookup;
wire  [64:63] DivisorLookup_eve;
wire   DivisorSign;
wire  [3:0] DivisorSign_9_Selects;
wire   DivisorSign_eve;
wire   DivisorSign_intmux;
wire   DivisorSign_intmux_sel;
wire  [1:0] DivisorSize;
wire  [1:0] DivisorSize_9;
wire  [1:0] DivisorSize_9_eve;
wire  [1:0] DivisorSize_eve;
wire   Divl_8;
wire   Divl_9;
wire   DualResDiv;
wire   DualResDiv_9;
wire   DualResDiv_9_eve;
wire   DualResDiv_eve;
wire   FRemSign_d1;
wire   FRemSign_d1_eve;
wire   FRem_Carryin;
wire  [66:0] FRem_OpA;
wire  [66:0] FRem_OpB;
wire   FinalRemainderIsDivisor_d1;
wire   FinalRemainderIsDivisor_d1_eve;
wire   FinalRemainderIsZero_d1;
wire   FinalRemainderIsZero_d1_eve;
wire   FirstAttemptJamQuotient_6;
wire   FirstAttemptJamRemainder_6;
wire   FixupDivLookup_d1;
wire   FixupDivLookup_d1_eve;
wire   FixupDivLookup_d1_intmux;
wire   FixupDivLookup_d1_intmux_sel;
wire   FixupNeeded;
wire  [6:0] InitialIterationCount;
wire  [6:0] InitialIterationCount_eve;
wire   Inject1;
wire   Inject2;
wire   IterateDone;
wire   IterateOnce;
wire   IterateOnce_eve;
wire   IterateOnce_intmux;
wire   IterateOnce_intmux_sel;
wire  [6:0] IterationCount;
wire  [6:0] IterationCountNext;
wire   IterationCountNext_6_0__sel;
wire  [6:0] IterationCount_eve;
wire  [6:0] IterationCount_intmux;
wire   IterationCount_intmux_6_0__sel;
wire   JamQuotient_8;
wire   JamQuotient_8_eve;
wire   JamQuotient_9;
wire   JamQuotient_9_eve;
wire   JamRemainder_8;
wire   JamRemainder_8_eve;
wire   JamRemainder_9;
wire   JamRemainder_9_eve;
wire  [63:0] MergeDataA;
wire  [63:0] MergeDataA_eve;
wire  [6:0] MergeDataA_in_Selects;
wire  [63:16] MergeDataB;
wire  [63:16] MergeDataB_eve;
wire   MostDivBusy_9;
wire   MostDivBusy_9_eve;
wire   MulBubbleNoLateCancel_7;
wire   MulBubbleNoLateCancel_7_eve;
wire   NegDivisorAt2NBoundry_d1;
wire   NegDivisorAt2NBoundry_d1_eve;
wire   NegDivisorAt2NBoundry_d1_intmux;
wire   NegDivisorAt2NBoundry_d1_intmux_sel;
wire   NegDivisorSel;
wire   NoIterate;
wire   NoIterate_eve;
wire   NoIterate_intmux;
wire   NoIterate_intmux_sel;
wire  [7:0] NumDividendBits_d1;
wire  [7:0] NumDividendBits_d1_eve;
wire  [6:0] NumDivisorBits;
wire  [6:0] NumDivisorBits_d1;
wire  [6:0] NumDivisorBits_d1_eve;
wire  [7:0] NumQuotientBits;
wire  [7:0] NumQuotientBits4IterCnt;
wire   NumQuotientBits4IterCnt_7_0__sel;
wire   NumQuotientBits_7_0__sel;
wire  [6:0] NumQuotientBits_d1;
wire  [6:0] NumQuotientBits_d1_eve;
wire   OddQuotientBits;
wire  [67:62] PRem;
wire  [66:0] Q;
wire  [66:0] QM;
wire  [66:0] QM_eve;
wire  [66:0] QP;
wire  [66:0] QP_eve;
wire  [66:0] Q_eve;
wire   QuotientTooLargeQOverflow_d1;
wire   QuotientTooLargeQOverflow_d1_eve;
wire   QuotientTooLargeQOverflow_d1_intmux;
wire   QuotientTooLargeQOverflow_d1_intmux_sel;
wire   QuotientTooLargeQmOverflow_d1;
wire   QuotientTooLargeQmOverflow_d1_eve;
wire   QuotientTooLargeQmOverflow_d1_intmux;
wire   QuotientTooLargeQmOverflow_d1_intmux_sel;
wire   QuotientTooLargeQpOverflow_d1;
wire   QuotientTooLargeQpOverflow_d1_eve;
wire   QuotientTooLargeQpOverflow_d1_intmux;
wire   QuotientTooLargeQpOverflow_d1_intmux_sel;
wire   RCLK_DIVStateGenRemainder_AR;
wire   RCLK_DIVStateGenRemainder_AR_cvc;
wire   RCLK_DIVStatePrescaleDivisor_AR;
wire   RCLK_DIVStatePrescaleDivisor_AR_cvc;
wire   RCLK_Div8DivhRegs_AR;
wire   RCLK_Div8DivhRegs_AR_cvc;
wire   RCLK_Div8Divh_9_AR;
wire   RCLK_Div8Divh_9_AR_cvc;
wire   RCLK_Div8Divl_8_AR;
wire   RCLK_Div8Divl_8_AR_cvc;
wire   RCLK_Div8Regs_AR;
wire   RCLK_Div8Regs_AR_cvc;
wire   RCLK_DivIssue8_AR;
wire   RCLK_DivIssue8_AR_cvc;
wire   RCLK_DivIssue9_AR;
wire   RCLK_DivIssue9_AR_cvc;
wire   RCLK_DivState_AR;
wire   RCLK_DivState_AR_cvc;
wire   RCLK_Divh_8_AR;
wire   RCLK_Divh_8_AR_cvc;
wire   RCLK_DivlRegs_AR;
wire   RCLK_DivlRegs_AR_cvc;
wire   RCLK_ExDivFree_AR;
wire   RCLK_NumDividendBits_d1_AR;
wire   RCLK_NumDividendBits_d1_AR_cvc;
wire   RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR;
wire   RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR_cvc;
wire   RCLK_ShiftAmt_d1_AR;
wire   RCLK_ShiftAmt_d1_AR_cvc;
wire   ReattemptJamQuotient;
wire   ReattemptJamQuotient_eve;
wire   ReattemptJamRemainder;
wire   ReattemptJamRemainder_eve;
wire   SDO;
wire  [5:0] SDO_0000;
wire  [5:0] SDO_0001;
wire   SDO_0002;
wire  [5:0] SDO_0003;
wire  [5:0] SDO_0004;
wire   SDO_0005;
wire   SDO_0006;
wire   SDO_0007;
wire   SDO_0008;
wire   SDO_0009;
wire   SDO_0010;
wire  [1:0] SDO_0011;
wire   SDO_0012;
wire   SDO_0013;
wire  [1:0] SDO_0014;
wire   SDO_0015;
wire   SDO_0016;
wire  [3:0] SDO_0017;
wire   SDO_0018;
wire   SDO_0019;
wire   SDO_0020;
wire   SDO_0021;
wire   SDO_0022;
wire   SDO_0023;
wire   SDO_0024;
wire   SDO_0025;
wire   SDO_0026;
wire   SDO_0027;
wire   SDO_0028;
wire   SDO_0029;
wire   SDO_0030;
wire   SDO_0031;
wire   SDO_0032;
wire   SDO_0033;
wire   SDO_0034;
wire   SDO_0035;
wire  [63:0] SDO_0036;
wire  [63:16] SDO_0037;
wire  [65:0] SDO_0038;
wire  [63:0] SDO_0039;
wire  [67:0] SDO_0040;
wire  [63:0] SDO_0041;
wire  [61:0] SDO_0042;
wire  [66:0] SDO_0043;
wire  [66:0] SDO_0044;
wire  [66:0] SDO_0045;
wire  [64:63] SDO_0046;
wire  [6:0] SDO_0047;
wire   SDO_0048;
wire  [7:0] SDO_0049;
wire   SDO_0050;
wire   SDO_0051;
wire   SDO_0052;
wire   SDO_0053;
wire  [6:0] SDO_0054;
wire  [6:0] SDO_0055;
wire   SDO_0056;
wire  [6:0] SDO_0057;
wire   SDO_0058;
wire   SDO_0059;
wire   SDO_0060;
wire   SDO_0061;
wire   SDO_0062;
wire  [6:0] SDO_0063;
wire   SDO_0064;
wire   SDO_0065;
wire   SDO_0066;
wire   SDO_0067;
wire   SDO_0068;
wire   SDO_0069;
wire   SDO_0070;
wire   SDO_0071;
wire   SDO_0072;
wire   SDO_0073;
wire   SDO_0074;
wire   SDO_0075;
wire   SDO_0076;
wire   SDO_0077;
wire  [6:0] ShiftAmt_d1;
wire  [6:0] ShiftAmt_d1_eve;
wire   ShiftFixup_d1;
wire   ShiftFixup_d1_eve;
wire  [127:0] ShiftRes;
wire  [128:0] ShiftResFinal;
wire  [69:0] Si;
wire   SignedDiv;
wire   SignedDiv_9;
wire   SignedDiv_9_eve;
wire   SignedDiv_eve;
wire   StartDivStateMach_9;
wire  [69:0] Sum;
wire  [63:0] TEMPXL;
wire  [63:0] TEMPXL_eve;
wire  [67:0] XH;
wire  [67:0] XH_eve;
wire  [63:0] XL;
wire  [63:0] XL_eve;
wire  [63:0] XL_mux;
wire   scan_chain_input;
wire   scan_chain_output;
// End nets auto-declared by conv.prl

// conv.prl: throwing in a gate to tie the end of the auto-generated scan chain to 'scan_chain_output'
  gate            gate__scan_chain_output(scan_chain_output,SDO_0077);


// **************************************************************************


// output that are reg type
reg [63:0] DivResBus_9;

// new reg types introduced by converting to .x format
reg    [3:0] DivStateNext;
reg    [63:0] MergeDataA_in;
reg    [65:0] D_in;
reg    [67:0] XH_in;
reg    [63:0] XL_in;
reg    [61:0] CH_in;
reg    [66:0] Q_in;
reg    [66:0] QM_in;
reg    [66:0] QP_in;

// type declaration  
reg[1:0] DivisorSize_8;
reg DivisorZero;

reg DividendSign_9;
reg DivisorSign_9;

reg[63:0] MergeDataA_9;
reg[63:0] Quotient;
reg[66:0] FinalRemainder;
reg CShiftQ;
reg[1:0] Qkp1;
reg CShiftQM;
reg[1:0] QMkp1;
reg[1:0] CShiftQP;
reg[1:0] QPkp1;
reg[1:0] DivisorShiftedLookup;
reg[5:0] ClzXH64;
reg[4:0] ClzXH32;
reg[3:0] ClzXH16;
reg[5:0] ClzXL64;
reg[4:0] ClzXL32;
reg[3:0] ClzXL16;
reg[2:0] ClzXL8;
reg[5:0] CloXH64;
reg[4:0] CloXH32;
reg[3:0] CloXH16;
reg[5:0] CloXL64;
reg[4:0] CloXL32;
reg[3:0] CloXL16;
reg[2:0] CloXL8;
reg[5:0] CtzXL64;
reg[4:0] CtzXL32;
reg[3:0] CtzXL16;
reg[2:0] CtzXL8;
reg AnyOneXH64;
reg AnyOneXH32;
reg AnyOneXH16;
reg AnyOneXL64;
reg AnyOneXL32;
reg AnyOneXL16;
reg AnyOneXL8;
reg AnyZeroXH64;
reg AnyZeroXH32;
reg AnyZeroXH16;

reg    AnyOneTEMPXL64;
reg    AnyOneTEMPXL32;
reg    AnyOneTEMPXL16;
reg    AnyOneTEMPXL8;

reg SignedNegativeDividend;
reg SignedNegativeDivisor;
reg[6:0] ShiftAmtPrescaleCountDividend;
reg[6:0] ShiftAmtPrescaleCountDivisor;
reg[6:0] ShiftAmtPrescaleConcatPrep;
reg[6:0] ShiftAmtBroadcastQuotient;
reg[6:0] ShiftAmt;
reg NegDivisorAt2NBoundry;
reg FixupDivLookup;
reg[7:0] NumDividendBits;
reg ShiftFixup;
reg DividendZero;
reg[1:0] MuxSel;
reg[69:0] debugTRem;
reg[67:0] absTRem;
reg[67:62] absD;
//reg[69:0] debugTotalPartialRemainder_d1;
reg[66:0] RemP;
reg[66:0] RemZ;
reg[66:0] RemG;
reg[66:0] RemPP;
reg[66:0] RemPG;
reg[66:0] RemGZ;
reg[66:0] RemZZ;
reg FinalRemainderIsZero;
reg[66:0] RemIsNegD_S;
reg[66:0] RemIsNegD_C;
reg[66:0] RemIsNegD_P;
reg[66:0] RemIsNegD_Z;
reg[66:0] RemIsNegD_G;
reg[66:0] RemIsNegD_PP;
reg[66:0] RemIsNegD_PG;
reg[66:0] RemIsNegD_GZ;
reg[66:0] RemIsNegD_ZZ;
reg FinalRemainderIsNegDivisor;
reg[66:0] RemIsPosD_S;
reg[66:0] RemIsPosD_C;
reg[66:0] RemIsPosD_P;
reg[66:0] RemIsPosD_Z;
reg[66:0] RemIsPosD_G;
reg[66:0] RemIsPosD_PP;
reg[66:0] RemIsPosD_PG;
reg[66:0] RemIsPosD_GZ;
reg[66:0] RemIsPosD_ZZ;
reg FinalRemainderIsPosDivisor;
reg FinalRemainderIsDivisor;
reg QuotientTooLarge_9;
reg[63:0] QuotientRes;
reg[63:0] RemainderRes;
reg QuotientTooLargeQOverflow;
reg QuotientTooLargeQpOverflow;
reg QuotientTooLargeQmOverflow;
reg QuotientTooLargeOverflow;


// **************************************************************************

// clocks, resets, power/ground

//ova clock posedge CCLK;

// Internal free-running clock for ex_ctl
  com1u            com1u__RCLK_ExDivFree_AR(RCLK_ExDivFree_AR, CCLK);

// scan chain
  gate            gate__scan_chain_input(scan_chain_input, SDI);
  gate            gate__SDO(SDO, scan_chain_output);


// **************************************************************************


//================================================================================
// Assertions for assumptions by Rusinoff in formal proof of divider:

//ova forbid_bool (DivIssue_8 & (AttemptJamQuotient_6 | AttemptJamRemainder_6), "Divider error: cannot attempt to steal result bus while issuing a divide!");
//ova forbid_bool (DivIssue_8 & (DivState[3:0] != `DIVStateIdle),               "Divider error: cannot issue divide while divider is busy!");

//ova forbid_bool (DivIssue_9 & ((DualResDiv_9 & DivisorSize_9[1:0] == `DivisorSize8) | (~DualResDiv_9 & DivisorSize_9[1:0] != `DivisorSize8)), 
//ova              "Divider error: DivisorSize_9 is illegal for DualResDiv_9 value");
   

//=== Control logic ================================================================================


// **************************************************************************

// divide op input capture

// decode issued div op type
  gate            gate__Div8_8(Div8_8,  Div8Divh_8 & ~DualResMulDiv_8);
  gate            gate__Divh_8(Divh_8,  Div8Divh_8 &  DualResMulDiv_8);
  gate            gate__Divl_8(Divl_8, ~Div8Divh_8 &  DualResMulDiv_8);

  gate            gate__DivIssueDiv8Divl_8(DivIssueDiv8Divl_8, DivIssue_8 & (Div8_8 | Divl_8));
  gate            gate__DivIssueDiv8Divh_8(DivIssueDiv8Divh_8, DivIssue_8 & (Div8_8 | Divh_8));

// insert gate for condition input : +++++ com1a (RCLK_Divh_8_AR,     CCLK, DivIssue_8 & Divh_8);
  gate            gate__RCLK_Divh_8_AR_cvc(RCLK_Divh_8_AR_cvc,DivIssue_8 & Divh_8);
  com1a            com1__RCLK_Divh_8_AR(RCLK_Divh_8_AR,     CCLK, RCLK_Divh_8_AR_cvc, SSE);

// insert gate for condition input : +++++ com1a (RCLK_Div8Divl_8_AR, CCLK, DivIssueDiv8Divl_8);
  gate            gate__RCLK_Div8Divl_8_AR_cvc(RCLK_Div8Divl_8_AR_cvc,DivIssueDiv8Divl_8);
  com1a            com1__RCLK_Div8Divl_8_AR(RCLK_Div8Divl_8_AR, CCLK, RCLK_Div8Divl_8_AR_cvc, SSE);

// capture ResTag/Prn/PrnV for divh: EAX=quotient.  
// NOTE: divl issued first, then divh for non-8-bit divide instructions. However, divh (quotient) completes prior to divl (remainder).

// insert gate for d input : +++++ etl1 (DivhResTag[5:0], RCLK_Divh_8_AR, ResTag_8[5:0]); 
  gate #(5,0)     gate__DivhResTag_eve__5_0(DivhResTag_eve[5:0],ResTag_8[5:0]);
  etl1 #(5,0)     etl1__DivhResTag__5_0(.q(DivhResTag[5:0]), .clk(RCLK_Divh_8_AR), .d(DivhResTag_eve[5:0]), .SDO(SDO_0000[5:0]), .SDI({scan_chain_input, SDO_0000[5:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivhPrn[5:0],    RCLK_Divh_8_AR, Prn_8[5:0]); 
  gate #(5,0)     gate__DivhPrn_eve__5_0(DivhPrn_eve[5:0],Prn_8[5:0]);
  etl1 #(5,0)     etl1__DivhPrn__5_0(.q(DivhPrn[5:0]),    .clk(RCLK_Divh_8_AR), .d(DivhPrn_eve[5:0]), .SDO(SDO_0001[5:0]), .SDI({SDO_0000[0], SDO_0001[5:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivhPrnV,        RCLK_Divh_8_AR, PrnV_8); 
  gate            gate__DivhPrnV_eve(DivhPrnV_eve,PrnV_8);
  etl1            etl1__DivhPrnV(.q(DivhPrnV),        .clk(RCLK_Divh_8_AR), .d(DivhPrnV_eve), .SDO(SDO_0002), .SDI(SDO_0001[0]), .SSE(SSE));

// capture ResTag/Prn/PrnV for either 
// a) divl: EDX=remainder, or 
// b) div8:  AX=remainder:quotient

// insert gate for d input : +++++ etl1 (Div8DivlResTag[5:0],     RCLK_Div8Divl_8_AR,     ResTag_8[5:0]); 
  gate #(5,0)     gate__Div8DivlResTag_eve__5_0(Div8DivlResTag_eve[5:0],ResTag_8[5:0]);
  etl1 #(5,0)     etl1__Div8DivlResTag__5_0(.q(Div8DivlResTag[5:0]),     .clk(RCLK_Div8Divl_8_AR),     .d(Div8DivlResTag_eve[5:0]), .SDO(SDO_0003[5:0]), .SDI({SDO_0002, SDO_0003[5:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (Div8DivlPrn[5:0],        RCLK_Div8Divl_8_AR,     Prn_8[5:0]); 
  gate #(5,0)     gate__Div8DivlPrn_eve__5_0(Div8DivlPrn_eve[5:0],Prn_8[5:0]);
  etl1 #(5,0)     etl1__Div8DivlPrn__5_0(.q(Div8DivlPrn[5:0]),        .clk(RCLK_Div8Divl_8_AR),     .d(Div8DivlPrn_eve[5:0]), .SDO(SDO_0004[5:0]), .SDI({SDO_0003[0], SDO_0004[5:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (Div8DivlPrnV,            RCLK_Div8Divl_8_AR,     PrnV_8);  
  gate            gate__Div8DivlPrnV_eve(Div8DivlPrnV_eve,PrnV_8);
  etl1            etl1__Div8DivlPrnV(.q(Div8DivlPrnV),            .clk(RCLK_Div8Divl_8_AR),     .d(Div8DivlPrnV_eve), .SDO(SDO_0005), .SDI(SDO_0004[0]), .SSE(SSE));

// Mux out divider result Tag/Prn/PrnV for quotient (divh) and remainder (divl) during DivBubbleQuotient_6 and DivBubbleRemainder_6 cycles.
// 8-bit div8 op broadcasts one result with both remainder and quotient in the same register.
  mux2e #(5,0)     mux2e__DivDestTag_6__5_0(DivDestTag_6[5:0], DivBubbleQuotient_6, DivhResTag[5:0], Div8DivlResTag[5:0]);
  mux2e #(5,0)     mux2e__DivPrn_6__5_0(DivPrn_6[5:0],     DivBubbleQuotient_6, DivhPrn[5:0],    Div8DivlPrn[5:0]);
  mux2e            mux2e__DivPrnV_6(DivPrnV_6,         DivBubbleQuotient_6, DivhPrnV,        Div8DivlPrnV);


// translate ResEnable into old ExuSize form on the way in
always @* 
  casez (ResEnable_8[3:0])
    4'b0001,
    4'b0010 : DivisorSize_8[1:0] = `DivisorSize8;   //  8-bits
    4'b0011 : DivisorSize_8[1:0] = `DivisorSize16;  // 16-bits
    4'b01?? : DivisorSize_8[1:0] = `DivisorSize32;  // 32-bits
    4'b1??? : DivisorSize_8[1:0] = `DivisorSize64;  // 64-bits
    default : DivisorSize_8[1:0] = 2'bx;            //! TRUE_DEFAULT
  endcase



// insert gate for d input : +++++ etl1 (DivIssue_9,    RCLK_ExDivFree_AR, DivIssue_8 & ~DivLateCancel_8 & ~FR_Abort_11);
  gate            gate__DivIssue_9_eve(DivIssue_9_eve,DivIssue_8 & ~DivLateCancel_8 & ~FR_Abort_11);
  etl1            etl1__DivIssue_9(.q(DivIssue_9),    .clk(RCLK_ExDivFree_AR), .d(DivIssue_9_eve), .SDO(SDO_0006), .SDI(SDO_0005), .SSE(SSE));


// insert gate for condition input : +++++ com1a (RCLK_DivIssue8_AR, CCLK, DivIssue_8);
  gate            gate__RCLK_DivIssue8_AR_cvc(RCLK_DivIssue8_AR_cvc,DivIssue_8);
  com1a            com1__RCLK_DivIssue8_AR(RCLK_DivIssue8_AR, CCLK, RCLK_DivIssue8_AR_cvc, SSE);

// insert gate for d input : +++++ etl1 (Div8Divh_9,         RCLK_DivIssue8_AR, Div8Divh_8);
  gate            gate__Div8Divh_9_eve(Div8Divh_9_eve,Div8Divh_8);
  etl1            etl1__Div8Divh_9(.q(Div8Divh_9),         .clk(RCLK_DivIssue8_AR), .d(Div8Divh_9_eve), .SDO(SDO_0007), .SDI(SDO_0006), .SSE(SSE));

// insert gate for d input : +++++ etl1 (SignedDiv_9,        RCLK_DivIssue8_AR, SignedMulDiv_8);
  gate            gate__SignedDiv_9_eve(SignedDiv_9_eve,SignedMulDiv_8);
  etl1            etl1__SignedDiv_9(.q(SignedDiv_9),        .clk(RCLK_DivIssue8_AR), .d(SignedDiv_9_eve), .SDO(SDO_0008), .SDI(SDO_0007), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DualResDiv_9,       RCLK_DivIssue8_AR, DualResMulDiv_8);
  gate            gate__DualResDiv_9_eve(DualResDiv_9_eve,DualResMulDiv_8);
  etl1            etl1__DualResDiv_9(.q(DualResDiv_9),       .clk(RCLK_DivIssue8_AR), .d(DualResDiv_9_eve), .SDO(SDO_0009), .SDI(SDO_0008), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AHighSwap_9,        RCLK_DivIssue8_AR, AHighSwap_8);
  gate            gate__AHighSwap_9_eve(AHighSwap_9_eve,AHighSwap_8);
  etl1            etl1__AHighSwap_9(.q(AHighSwap_9),        .clk(RCLK_DivIssue8_AR), .d(AHighSwap_9_eve), .SDO(SDO_0010), .SDI(SDO_0009), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivisorSize_9[1:0], RCLK_DivIssue8_AR, DivisorSize_8[1:0]);
  gate #(1,0)     gate__DivisorSize_9_eve__1_0(DivisorSize_9_eve[1:0],DivisorSize_8[1:0]);
  etl1 #(1,0)     etl1__DivisorSize_9__1_0(.q(DivisorSize_9[1:0]), .clk(RCLK_DivIssue8_AR), .d(DivisorSize_9_eve[1:0]), .SDO(SDO_0011[1:0]), .SDI({SDO_0010, SDO_0011[1:0+1]}), .SSE(SSE));

// decode issued div op type
  gate            gate__Div8_9(Div8_9,  Div8Divh_9 & ~DualResDiv_9);
  gate            gate__Divh_9(Divh_9,  Div8Divh_9 &  DualResDiv_9);
  gate            gate__Divl_9(Divl_9, ~Div8Divh_9 &  DualResDiv_9);


// Latch in and store for many cycles on these signals.  (first three nets will double clock on divh/divl but data identical so no problem)

// insert gate for condition input : +++++ com1a (RCLK_DivIssue9_AR,      CCLK, DivIssue_9);
  gate            gate__RCLK_DivIssue9_AR_cvc(RCLK_DivIssue9_AR_cvc,DivIssue_9);
  com1a            com1__RCLK_DivIssue9_AR(RCLK_DivIssue9_AR,      CCLK, RCLK_DivIssue9_AR_cvc, SSE);

// insert gate for d input : +++++ etl1      (SignedDiv,         RCLK_DivIssue9_AR, SignedDiv_9);
  gate            gate__SignedDiv_eve(SignedDiv_eve,SignedDiv_9);
  etl1            etl1__SignedDiv(.q(SignedDiv),         .clk(RCLK_DivIssue9_AR), .d(SignedDiv_eve), .SDO(SDO_0012), .SDI(SDO_0011[0]), .SSE(SSE));

// insert gate for d input : +++++ etl1      (DualResDiv,        RCLK_DivIssue9_AR, DualResDiv_9);
  gate            gate__DualResDiv_eve(DualResDiv_eve,DualResDiv_9);
  etl1            etl1__DualResDiv(.q(DualResDiv),        .clk(RCLK_DivIssue9_AR), .d(DualResDiv_eve), .SDO(SDO_0013), .SDI(SDO_0012), .SSE(SSE));

// insert gate for d input : +++++ etl1      (DivisorSize[1:0],  RCLK_DivIssue9_AR, DivisorSize_9[1:0]);
  gate #(1,0)     gate__DivisorSize_eve__1_0(DivisorSize_eve[1:0],DivisorSize_9[1:0]);
  etl1 #(1,0)     etl1__DivisorSize__1_0(.q(DivisorSize[1:0]),  .clk(RCLK_DivIssue9_AR), .d(DivisorSize_eve[1:0]), .SDO(SDO_0014[1:0]), .SDI({SDO_0013, SDO_0014[1:0+1]}), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (DivisorSign,       RCLK_DivIssue9_AR, Div8_9 | Divl_9, DivisorSign_9 , DivisorSign);   // divisor  sign bit delivered on div8/divl AOp

// insert gate for sel input : +++++ etl1mux2e (DivisorSign,       RCLK_DivIssue9_AR, Div8_9 | Divl_9, DivisorSign_9 , DivisorSign);   // divisor  sign bit delivered on div8/divl AOp
  gate            gate__DivisorSign_intmux_sel(DivisorSign_intmux_sel,Div8_9 | Divl_9);
  mux2e            mux2e__DivisorSign_intmux(DivisorSign_intmux, DivisorSign_intmux_sel, DivisorSign_9 , DivisorSign);

// insert gate for d input : +++++ etl1mux2e (DivisorSign,       RCLK_DivIssue9_AR, Div8_9 | Divl_9, DivisorSign_9 , DivisorSign);   // divisor  sign bit delivered on div8/divl AOp
  gate            gate__DivisorSign_eve(DivisorSign_eve,DivisorSign_intmux);
  etl1            etl1__DivisorSign(.q(DivisorSign),       .clk(RCLK_DivIssue9_AR), .d(DivisorSign_eve), .SDO(SDO_0015), .SDI(SDO_0014[0]), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (DividendSign,      RCLK_DivIssue9_AR, Div8_9 | Divh_9, DividendSign_9, DividendSign);  // dividend sign bit delivered on div8/divh BOp

// insert gate for sel input : +++++ etl1mux2e (DividendSign,      RCLK_DivIssue9_AR, Div8_9 | Divh_9, DividendSign_9, DividendSign);  // dividend sign bit delivered on div8/divh BOp
  gate            gate__DividendSign_intmux_sel(DividendSign_intmux_sel,Div8_9 | Divh_9);
  mux2e            mux2e__DividendSign_intmux(DividendSign_intmux, DividendSign_intmux_sel, DividendSign_9, DividendSign);

// insert gate for d input : +++++ etl1mux2e (DividendSign,      RCLK_DivIssue9_AR, Div8_9 | Divh_9, DividendSign_9, DividendSign);  // dividend sign bit delivered on div8/divh BOp
  gate            gate__DividendSign_eve(DividendSign_eve,DividendSign_intmux);
  etl1            etl1__DividendSign(.q(DividendSign),      .clk(RCLK_DivIssue9_AR), .d(DividendSign_eve), .SDO(SDO_0016), .SDI(SDO_0015), .SSE(SSE));


//--------------------------------------------------------------------------------
// DIVIDE STATE MACHINE

// Kick off divider state machine with issue of div8 or divh (divh follows divl issue in double op divides)
  gate            gate__StartDivStateMach_9(StartDivStateMach_9, DivIssueDiv8Divh_9 & ~FR_Abort_11);

//ova forbid_bool (StartDivStateMach_9 & (DivState[3:0] != `DIVStateIdle), "Issue of divide div8/divh op when divide state machine is not idle");

// Enable DivState flops if a new divide is coming in (div8/divh) or the state machine is busy

// insert gate for condition input : +++++ com1a (RCLK_DivState_AR, CCLK, StartDivStateMach_9 | (DivState[3:0] != `DIVStateIdle));
  gate            gate__RCLK_DivState_AR_cvc(RCLK_DivState_AR_cvc,StartDivStateMach_9 | (DivState[3:0] != `DIVStateIdle));
  com1a            com1__RCLK_DivState_AR(RCLK_DivState_AR, CCLK, RCLK_DivState_AR_cvc, SSE);

// FIXME DAN XPROP
always @*
begin
    case (1'b1)
      StartDivStateMach_9                                                                                                       : DivStateNext[3:0] = `DIVStatePrescaleCountDividend;
      // If we have a late cancel, go back to Idle
      ((DivState[3:0] == `DIVStatePrescaleCountDividend)                                                        & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStatePrescaleDividend;
      ((DivState[3:0] == `DIVStatePrescaleDividend) & ~DivisorZero                                              & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStatePrescaleDivisor;
      ((DivState[3:0] == `DIVStatePrescaleDividend) &  DivisorZero                                              & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStatePauseForSteal;
      ((DivState[3:0] == `DIVStatePrescaleDivisor) & (IterationCountNext[6:0] != 7'b0)                          & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateIterate;
      ((DivState[3:0] == `DIVStatePrescaleDivisor) & (IterationCountNext[6:0] == 7'b0)                          & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStatePauseForSteal;
      ((DivState[3:0] == `DIVStateIterate) & ~IterateDone                                                       & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateIterate;
      ((DivState[3:0] == `DIVStateIterate) &  IterateDone                                                       & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateGenRemainder;
      ((DivState[3:0] == `DIVStatePauseForSteal)                                                                & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateGenRemainder;
      ((DivState[3:0] == `DIVStateGenRemainder)                                                                 & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateBroadcastQuotient;
      ((DivState[3:0] == `DIVStateBroadcastQuotient) &   DualResDiv & ~JamQuotient_9                            & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateBroadcastQuotient;
      ((DivState[3:0] == `DIVStateBroadcastQuotient) & (~DualResDiv |  JamQuotient_9)                           & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStatePostscaleRemainder;
      ((DivState[3:0] == `DIVStatePostscaleRemainder)                                                           & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateBroadcastRemainder;
      ((DivState[3:0] == `DIVStateBroadcastRemainder) & ~JamRemainder_9                                         & ~FR_Abort_11) : DivStateNext[3:0] = `DIVStateBroadcastRemainder;
      default                                                                                                                   : DivStateNext[3:0] = `DIVStateIdle;
    endcase 
end


// insert gate for d input : +++++ etl1 (DivState[3:0], RCLK_DivState_AR, DivStateNext[3:0]);
  gate #(3,0)     gate__DivState_eve__3_0(DivState_eve[3:0],DivStateNext[3:0]);
  etl1 #(3,0)     etl1__DivState__3_0(.q(DivState[3:0]), .clk(RCLK_DivState_AR), .d(DivState_eve[3:0]), .SDO(SDO_0017[3:0]), .SDI({SDO_0016, SDO_0017[3:0+1]}), .SSE(SSE));


// insert gate for d input : +++++ etl1 (DivStateGenRemainder, RCLK_DivState_AR, ((DivState[3:0] == `DIVStateIterate) & IterateDone & ~FR_Abort_11) | 
  gate            gate__DivStateGenRemainder_eve(DivStateGenRemainder_eve,((DivState[3:0] == `DIVStateIterate) & IterateDone & ~FR_Abort_11) | 
                                              ((DivState[3:0] == `DIVStatePauseForSteal)         & ~FR_Abort_11) );
  etl1            etl1__DivStateGenRemainder(.q(DivStateGenRemainder), .clk(RCLK_DivState_AR), .d(DivStateGenRemainder_eve), .SDO(SDO_0018), .SDI(SDO_0017[0]), .SSE(SSE));
        
//etl1 (DivStatePostscaleOrBroadcastRemainder, RCLK_DivState_AR, 
//      ((DivState[3:0] == `DIVStateBroadcastQuotient ) & (~DualResDiv | JamQuotient_8) & ~FR_Abort_11) | 
//      ((DivState[3:0] == `DIVStatePostscaleRemainder) & ~FR_Abort_11) | 
//      ((DivState[3:0] == `DIVStateBroadcastRemainder) & ~JamRemainder_8 & ~FR_Abort_11) );


// insert gate for d input : +++++ etl1 (DivStatePrescaleDividend, RCLK_DivState_AR, ((DivState[3:0] == `DIVStatePrescaleCountDividend) & ~FR_Abort_11));
  gate            gate__DivStatePrescaleDividend_eve(DivStatePrescaleDividend_eve,((DivState[3:0] == `DIVStatePrescaleCountDividend) & ~FR_Abort_11));
  etl1            etl1__DivStatePrescaleDividend(.q(DivStatePrescaleDividend), .clk(RCLK_DivState_AR), .d(DivStatePrescaleDividend_eve), .SDO(SDO_0019), .SDI(SDO_0018), .SSE(SSE));


// === DATAPATH ====================================================================================

// carry operand forwarding selects into _9 to ResBus fwd muxes

// insert gate for d input : +++++ etl1 (AFwd10AL0_9,    RCLK_DivIssue8_AR, AFwd9AL0_8);
  gate            gate__AFwd10AL0_9_eve(AFwd10AL0_9_eve,AFwd9AL0_8);
  etl1            etl1__AFwd10AL0_9(.q(AFwd10AL0_9),    .clk(RCLK_DivIssue8_AR), .d(AFwd10AL0_9_eve), .SDO(SDO_0020), .SDI(SDO_0019), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AFwd10ALHi0_9,  RCLK_DivIssue8_AR, AFwd9AL0_8 & AFwdHi_8);
  gate            gate__AFwd10ALHi0_9_eve(AFwd10ALHi0_9_eve,AFwd9AL0_8 & AFwdHi_8);
  etl1            etl1__AFwd10ALHi0_9(.q(AFwd10ALHi0_9),  .clk(RCLK_DivIssue8_AR), .d(AFwd10ALHi0_9_eve), .SDO(SDO_0021), .SDI(SDO_0020), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AFwd10AL1_9,    RCLK_DivIssue8_AR, AFwd9AL1_8);
  gate            gate__AFwd10AL1_9_eve(AFwd10AL1_9_eve,AFwd9AL1_8);
  etl1            etl1__AFwd10AL1_9(.q(AFwd10AL1_9),    .clk(RCLK_DivIssue8_AR), .d(AFwd10AL1_9_eve), .SDO(SDO_0022), .SDI(SDO_0021), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AFwd10ALHi1_9,  RCLK_DivIssue8_AR, AFwd9AL1_8 & AFwdHi_8);
  gate            gate__AFwd10ALHi1_9_eve(AFwd10ALHi1_9_eve,AFwd9AL1_8 & AFwdHi_8);
  etl1            etl1__AFwd10ALHi1_9(.q(AFwd10ALHi1_9),  .clk(RCLK_DivIssue8_AR), .d(AFwd10ALHi1_9_eve), .SDO(SDO_0023), .SDI(SDO_0022), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AFwdP5LS_9,     RCLK_DivIssue8_AR, AFwdP4LS_8);
  gate            gate__AFwdP5LS_9_eve(AFwdP5LS_9_eve,AFwdP4LS_8);
  etl1            etl1__AFwdP5LS_9(.q(AFwdP5LS_9),     .clk(RCLK_DivIssue8_AR), .d(AFwdP5LS_9_eve), .SDO(SDO_0024), .SDI(SDO_0023), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AFwdP5LSHi_9,   RCLK_DivIssue8_AR, AFwdP4LS_8 & AFwdHi_8);
  gate            gate__AFwdP5LSHi_9_eve(AFwdP5LSHi_9_eve,AFwdP4LS_8 & AFwdHi_8);
  etl1            etl1__AFwdP5LSHi_9(.q(AFwdP5LSHi_9),   .clk(RCLK_DivIssue8_AR), .d(AFwdP5LSHi_9_eve), .SDO(SDO_0025), .SDI(SDO_0024), .SSE(SSE));


// insert gate for d input : +++++ etl1 (BFwd10AL0_9,    RCLK_DivIssue8_AR, BFwd9AL0_8);
  gate            gate__BFwd10AL0_9_eve(BFwd10AL0_9_eve,BFwd9AL0_8);
  etl1            etl1__BFwd10AL0_9(.q(BFwd10AL0_9),    .clk(RCLK_DivIssue8_AR), .d(BFwd10AL0_9_eve), .SDO(SDO_0026), .SDI(SDO_0025), .SSE(SSE));

// insert gate for d input : +++++ etl1 (BFwd10ALHi0_9,  RCLK_DivIssue8_AR, BFwd9AL0_8 & BFwdHi_8);
  gate            gate__BFwd10ALHi0_9_eve(BFwd10ALHi0_9_eve,BFwd9AL0_8 & BFwdHi_8);
  etl1            etl1__BFwd10ALHi0_9(.q(BFwd10ALHi0_9),  .clk(RCLK_DivIssue8_AR), .d(BFwd10ALHi0_9_eve), .SDO(SDO_0027), .SDI(SDO_0026), .SSE(SSE));

// insert gate for d input : +++++ etl1 (BFwd10AL1_9,    RCLK_DivIssue8_AR, BFwd9AL1_8);
  gate            gate__BFwd10AL1_9_eve(BFwd10AL1_9_eve,BFwd9AL1_8);
  etl1            etl1__BFwd10AL1_9(.q(BFwd10AL1_9),    .clk(RCLK_DivIssue8_AR), .d(BFwd10AL1_9_eve), .SDO(SDO_0028), .SDI(SDO_0027), .SSE(SSE));

// insert gate for d input : +++++ etl1 (BFwd10ALHi1_9,  RCLK_DivIssue8_AR, BFwd9AL1_8 & BFwdHi_8);
  gate            gate__BFwd10ALHi1_9_eve(BFwd10ALHi1_9_eve,BFwd9AL1_8 & BFwdHi_8);
  etl1            etl1__BFwd10ALHi1_9(.q(BFwd10ALHi1_9),  .clk(RCLK_DivIssue8_AR), .d(BFwd10ALHi1_9_eve), .SDO(SDO_0029), .SDI(SDO_0028), .SSE(SSE));

// insert gate for d input : +++++ etl1 (BFwdP5LS_9,     RCLK_DivIssue8_AR, BFwdP4LS_8);
  gate            gate__BFwdP5LS_9_eve(BFwdP5LS_9_eve,BFwdP4LS_8);
  etl1            etl1__BFwdP5LS_9(.q(BFwdP5LS_9),     .clk(RCLK_DivIssue8_AR), .d(BFwdP5LS_9_eve), .SDO(SDO_0030), .SDI(SDO_0029), .SSE(SSE));

// insert gate for d input : +++++ etl1 (BFwdP5LSHi_9,   RCLK_DivIssue8_AR, BFwdP4LS_8 & BFwdHi_8);
  gate            gate__BFwdP5LSHi_9_eve(BFwdP5LSHi_9_eve,BFwdP4LS_8 & BFwdHi_8);
  etl1            etl1__BFwdP5LSHi_9(.q(BFwdP5LSHi_9),   .clk(RCLK_DivIssue8_AR), .d(BFwdP5LSHi_9_eve), .SDO(SDO_0031), .SDI(SDO_0030), .SSE(SSE));


// insert gate for d input : +++++ etl1 (DivAOp_defaultHi_9, RCLK_DivIssue8_AR, ~AFwd9AL0_8 & ~AFwd9AL1_8 & ~AFwdP4LS_8 & AFwdHi_8);
  gate            gate__DivAOp_defaultHi_9_eve(DivAOp_defaultHi_9_eve,~AFwd9AL0_8 & ~AFwd9AL1_8 & ~AFwdP4LS_8 & AFwdHi_8);
  etl1            etl1__DivAOp_defaultHi_9(.q(DivAOp_defaultHi_9), .clk(RCLK_DivIssue8_AR), .d(DivAOp_defaultHi_9_eve), .SDO(SDO_0032), .SDI(SDO_0031), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivAOp_default_9,   RCLK_DivIssue8_AR, ~AFwd9AL0_8 & ~AFwd9AL1_8 & ~AFwdP4LS_8);
  gate            gate__DivAOp_default_9_eve(DivAOp_default_9_eve,~AFwd9AL0_8 & ~AFwd9AL1_8 & ~AFwdP4LS_8);
  etl1            etl1__DivAOp_default_9(.q(DivAOp_default_9),   .clk(RCLK_DivIssue8_AR), .d(DivAOp_default_9_eve), .SDO(SDO_0033), .SDI(SDO_0032), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivBOp_defaultHi_9, RCLK_DivIssue8_AR, ~BFwd9AL0_8 & ~BFwd9AL1_8 & ~BFwdP4LS_8 & BFwdHi_8);
  gate            gate__DivBOp_defaultHi_9_eve(DivBOp_defaultHi_9_eve,~BFwd9AL0_8 & ~BFwd9AL1_8 & ~BFwdP4LS_8 & BFwdHi_8);
  etl1            etl1__DivBOp_defaultHi_9(.q(DivBOp_defaultHi_9), .clk(RCLK_DivIssue8_AR), .d(DivBOp_defaultHi_9_eve), .SDO(SDO_0034), .SDI(SDO_0033), .SSE(SSE));

// insert gate for d input : +++++ etl1 (DivBOp_default_9,   RCLK_DivIssue8_AR, ~BFwd9AL0_8 & ~BFwd9AL1_8 & ~BFwdP4LS_8);
  gate            gate__DivBOp_default_9_eve(DivBOp_default_9_eve,~BFwd9AL0_8 & ~BFwd9AL1_8 & ~BFwdP4LS_8);
  etl1            etl1__DivBOp_default_9(.q(DivBOp_default_9),   .clk(RCLK_DivIssue8_AR), .d(DivBOp_default_9_eve), .SDO(SDO_0035), .SDI(SDO_0034), .SSE(SSE));


// Operand content for each div op type:
//   AOp ->  div8: divisor;      divl: divisor;   divh: EAX=lower dividend
//   BOp ->  div8: AX=dividend;  divl: <unused>;  divh: EDX=upper dividend

// operand forwarding muxes

// for (i) divisor of 8-bit divide (div8); or (ii) lower half of dividend of non-8-bit divide (divh); or (iii) divisor of non-8-bit divide (divl)
  mux4d #(63,32)   mux4d__DivAOp_9__63_32(DivAOp_9[63:32], AFwd10ALHi0_9,       EX_ResBus0_10[63:32],
                        AFwd10ALHi1_9,       EX_ResBus1_10[63:32],
                        AFwdP5LSHi_9,        EX_DcResBus_12[63:32],
                        DivAOp_defaultHi_9,  AOp_9[63:32]);

  mux4d #(31,0)    mux4d__DivAOp_9__31_0(DivAOp_9[31:0],  AFwd10AL0_9,         EX_ResBus0_10[31:0],
                        AFwd10AL1_9,         EX_ResBus1_10[31:0],
                        AFwdP5LS_9,          EX_DcResBus_12[31:0],
                        DivAOp_default_9,    AOp_9[31:0]);

// for (i) dividend of 8-bit divide (div8); or (ii) upper half of dividend of non-8-bit divide (divl)
  mux4d #(63,32)   mux4d__DivBOp_9__63_32(DivBOp_9[63:32], BFwd10ALHi0_9,       EX_ResBus0_10[63:32],
                        BFwd10ALHi1_9,       EX_ResBus1_10[63:32],
                        BFwdP5LSHi_9,        EX_DcResBus_12[63:32],
                        DivBOp_defaultHi_9,  BOp_9[63:32]);

  mux4d #(31,0)    mux4d__DivBOp_9__31_0(DivBOp_9[31:0],  BFwd10AL0_9,         EX_ResBus0_10[31:0],
                        BFwd10AL1_9,         EX_ResBus1_10[31:0],
                        BFwdP5LS_9,          EX_DcResBus_12[31:0],
                        DivBOp_default_9,    BOp_9[31:0]);


// **************************************************************************


// dividend sign
  gate #(2,0)     gate__DividendSign_9_Selects__2_0(DividendSign_9_Selects[2:0], {SignedDiv_9, DivisorSize_9[1:0]});
always @*
    casez (DividendSign_9_Selects[2:0]) 
       3'b0_??:               DividendSign_9 = 1'b0;           // 8/16/32/64-bit unsigned divide 
      {1'b1, `DivisorSize8 }: DividendSign_9 = DivBOp_9[15];   // 8-bit    signed divide 
      {1'b1, `DivisorSize16}: DividendSign_9 = DivBOp_9[15];   // 16-bit   signed divide 
      {1'b1, `DivisorSize32}: DividendSign_9 = DivBOp_9[31];   // 32-bit   signed divide 
      {1'b1, `DivisorSize64}: DividendSign_9 = DivBOp_9[63];   // 64-bit   signed divide
      default: 
          case (^DividendSign_9_Selects[2:0])
            1'b0, 1'b1: DividendSign_9 = 1'b0; 
            default:    DividendSign_9 = 1'bx; 
          endcase
    endcase

// divisor sign
  gate #(3,0)     gate__DivisorSign_9_Selects__3_0(DivisorSign_9_Selects[3:0], {SignedDiv_9, AHighSwap_9, DivisorSize_9[1:0]});
always @*
    casez (DivisorSign_9_Selects[3:0])
       4'b0?_??:                DivisorSign_9 = 1'b0;          // 8/16/32/64-bit unsigned divide
      {2'b10, `DivisorSize8 } : DivisorSign_9 = DivAOp_9[7];   //  8-bit signed divide           (divl AOp)
      {2'b11, `DivisorSize8 } : DivisorSign_9 = DivAOp_9[15];  //  8-bit signed divide high byte (divl AOp)
      {2'b1?, `DivisorSize16} : DivisorSign_9 = DivAOp_9[15];  // 16-bit signed divide           (divl AOp)
      {2'b1?, `DivisorSize32} : DivisorSign_9 = DivAOp_9[31];  // 32-bit signed divide           (divl AOp)
      {2'b1?, `DivisorSize64} : DivisorSign_9 = DivAOp_9[63];  // 63-bit signed divide           (divl AOp)
      default: 
          case (^DivisorSign_9_Selects[3:0])
            1'b0, 1'b1: DivisorSign_9 = 1'b0; 
            default:    DivisorSign_9 = 1'bx; 
          endcase
    endcase


// **************************************************************************


always @*
  case (DivisorSize_9[1:0])
    `DivisorSize8  : MergeDataA_9[63:0] = {48'bx, 8'bx, 8'hFF};                   // used only for sign-extension of 8-bit divides
    `DivisorSize16 : MergeDataA_9[63:0] = {DivAOp_9[63:16],       16'hFFFF};      // div8/divh AOp
    `DivisorSize32 : MergeDataA_9[63:0] = {DivAOp_9[63:32],       32'hFFFFFFFF};  // merge data not needed for 32-bit (zero extended) but the FFF... are needed
    `DivisorSize64 : MergeDataA_9[63:0] = {                       64'hFFFFFFFF_FFFFFFFF};
    default        : MergeDataA_9[63:0] = 64'hx;  //! TRUE_DEFAULT
  endcase


// updates to registers loaded by various div ops
  gate            gate__DivIssueDiv8_9(DivIssueDiv8_9,     DivIssue_9 & Div8_9);
  gate            gate__DivIssueDivh_9(DivIssueDivh_9,     DivIssue_9 & Divh_9);
  gate            gate__DivIssueDivl_9(DivIssueDivl_9,     DivIssue_9 & Divl_9);
  gate            gate__DivIssueDiv8Divh_9(DivIssueDiv8Divh_9, DivIssue_9 & (Div8_9 | Divh_9));

// insert gate for condition input : +++++ com1a (RCLK_Div8Regs_AR,     CCLK, DivIssueDiv8_9     | (DivState[3:0] != `DIVStateIdle));
  gate            gate__RCLK_Div8Regs_AR_cvc(RCLK_Div8Regs_AR_cvc,DivIssueDiv8_9     | (DivState[3:0] != `DIVStateIdle));
  com1a            com1__RCLK_Div8Regs_AR(RCLK_Div8Regs_AR,     CCLK, RCLK_Div8Regs_AR_cvc, SSE);

// insert gate for condition input : +++++ com1a (RCLK_DivlRegs_AR,     CCLK, DivIssueDivl_9     | (DivState[3:0] != `DIVStateIdle));
  gate            gate__RCLK_DivlRegs_AR_cvc(RCLK_DivlRegs_AR_cvc,DivIssueDivl_9     | (DivState[3:0] != `DIVStateIdle));
  com1a            com1__RCLK_DivlRegs_AR(RCLK_DivlRegs_AR,     CCLK, RCLK_DivlRegs_AR_cvc, SSE);

// insert gate for condition input : +++++ com1a (RCLK_Div8DivhRegs_AR, CCLK, DivIssueDiv8Divh_9 | (DivState[3:0] != `DIVStateIdle));
  gate            gate__RCLK_Div8DivhRegs_AR_cvc(RCLK_Div8DivhRegs_AR_cvc,DivIssueDiv8Divh_9 | (DivState[3:0] != `DIVStateIdle));
  com1a            com1__RCLK_Div8DivhRegs_AR(RCLK_Div8DivhRegs_AR, CCLK, RCLK_Div8DivhRegs_AR_cvc, SSE);

// insert gate for condition input : +++++ com1a (RCLK_Div8Divh_9_AR,   CCLK, DivIssueDiv8Divh_9);
  gate            gate__RCLK_Div8Divh_9_AR_cvc(RCLK_Div8Divh_9_AR_cvc,DivIssueDiv8Divh_9);
  com1a            com1__RCLK_Div8Divh_9_AR(RCLK_Div8Divh_9_AR,   CCLK, RCLK_Div8Divh_9_AR_cvc, SSE);

// MergeDataA will hold the merge data for EAX.   
// NOTE: MergeDataA is used to assist in sign extension of the quotient.  The upper bits of MergeDataA will, of course, hold merge data, but the unused lower
// bits will contain a mask that is left shifted 2 bits per iteration.  The result, 111...10...000 shows where the quotient bits will reside.
// Additionally, the transistion point from 1s to 0s shows where theres a potential carryout of QP (should we need to select it and it is all zeros (implying
// we always selected Q=+3 each iteration and Q is all ones, thus QP=Q+1 which is all zeros with a carryout of 1)
//
// for 8-bit divides, we store the quotient result in MergeDataA while we generate the final remainder
// NOTE exception: merged bits of EAX for 8-bit divides is held in MergeDataB (eases mux in RemainderRes)
  gate #(6,0)     gate__MergeDataA_in_Selects__6_0(MergeDataA_in_Selects[6:0], {DivIssueDiv8Divh_9, DivisorSize[1:0], DivState[3:0]});
always @*
    casez (MergeDataA_in_Selects[6:0])
      {1'b1, 2'b??, 4'b????}                             : MergeDataA_in[63:0] = MergeDataA_9[63:0];

      {1'b0, `DivisorSize8,  `DIVStateIterate}           : MergeDataA_in[63:0] = {MergeDataA[63:8],  MergeDataA[5:0],  2'b00};
      {1'b0, `DivisorSize16, `DIVStateIterate}           : MergeDataA_in[63:0] = {MergeDataA[63:16], MergeDataA[13:0], 2'b00};
      {1'b0, `DivisorSize32, `DIVStateIterate}           : MergeDataA_in[63:0] = {MergeDataA[63:32], MergeDataA[29:0], 2'b00};
      {1'b0, `DivisorSize64, `DIVStateIterate}           : MergeDataA_in[63:0] = {MergeDataA[61:0],                    2'b00};
      {1'b0, `DivisorSize8,  `DIVStateBroadcastQuotient} : MergeDataA_in[63:0] = {MergeDataA[63:8], Quotient[7:0]};
      default: 
        case (^MergeDataA_in_Selects[6:0])
          1'b0, 1'b1:                                      MergeDataA_in[63:0] =  MergeDataA[63:0];    //! TRUE_DEFAULT
          default:                                         MergeDataA_in[63:0] =  64'bx; 
        endcase
    endcase

// RAX merge data (divh)

// insert gate for d input : +++++ etl1 (MergeDataA[63:0],  RCLK_Div8DivhRegs_AR, MergeDataA_in[63:0]);  // loaded by div8/divh AOp or state machine
  gate #(63,0)    gate__MergeDataA_eve__63_0(MergeDataA_eve[63:0],MergeDataA_in[63:0]);
  etl1 #(63,0)    etl1__MergeDataA__63_0(.q(MergeDataA[63:0]),  .clk(RCLK_Div8DivhRegs_AR), .d(MergeDataA_eve[63:0]), .SDO(SDO_0036[63:0]), .SDI({SDO_0035, SDO_0036[63:0+1]}), .SSE(SSE));

// RAX merge data for byte divides (div8), RDX merge data for non-byte divides (divh)

// insert gate for d input : +++++ etl1 (MergeDataB[63:16], RCLK_Div8Divh_9_AR, DivBOp_9[63:16]);
  gate #(63,16)   gate__MergeDataB_eve__63_16(MergeDataB_eve[63:16],DivBOp_9[63:16]);
  etl1 #(63,16)   etl1__MergeDataB__63_16(.q(MergeDataB[63:16]), .clk(RCLK_Div8Divh_9_AR), .d(MergeDataB_eve[63:16]), .SDO(SDO_0037[63:16]), .SDI({SDO_0036[0], SDO_0037[63:16+1]}), .SSE(SSE));

// NOTE: Conceptually, its simpler to think of the design conditionally inverting the Divisor during GenRemainder if Divisor Sign equals RemainderSign
//       The problem with that is that we need to get the sign out of the adder and fan it out across 66 gates to invert it.  This is probably a speedpath
//       since the conditional 1s complement was originally in the same path as the adder originally, but then requested to be retimed to the previous cycle by implementation.
//       As such, we will conditionally invert it if DivisorSign doesnt equal DividendSign but then force zeros on the remainder (in the XL register) if FinalRemainderIsDivisor_d1.

  gate #(5,0)     gate__D_in_Selects__5_0(D_in_Selects[5:0], {DivIssueDiv8_9, DivState[3:0], DualResDiv});
always @*
    case (1'b1)
      // FIXME XPROP
      DivIssueDiv8_9                                                : D_in[65:0] = {D[65:10], AHighSwap_9 ? DivAOp_9[15:8] : DivAOp_9[7:0], 2'b00};  // div8 AOp
      (DivState[3:0] == `DIVStatePrescaleDividend) & DualResDiv,
      (DivState[3:0] == `DIVStatePrescaleDivisor)                   : D_in[65:0] = {ShiftResFinal[63:0], 2'b00};
      (DivState[3:0] == `DIVStateGenRemainder)                      : D_in[65:0] = (DivisorSign ^ DividendSign) ? ~D[65:0] : D[65:0];   
      default: 
        case (^D_in_Selects[5:0]) 
          1'b0, 1'b1                                                : D_in[65:0] = D[65:0]; 
          default                                                   : D_in[65:0] = 66'bx; 
        endcase
    endcase 

// TEMPXL not in HS32 - FIXME Document purpose?
reg [63:0] TEMPXL_in;
always @*
    case (1'b1)
      DivIssueDivl_9                                                    : TEMPXL_in[63:0] = DivAOp_9[63:0];   // divl AOp
      (DivState[3:0] == `DIVStatePrescaleCountDividend) & ~DualResDiv   : TEMPXL_in[63:0] = D[65:2]; 
      default                                                           : TEMPXL_in[63:0] = TEMPXL[63:0];
    endcase // case(1'b1)


// FIXME DAN XPROP
always @*
    case (1'b1)
      DivIssueDiv8Divh_9                                              : XH_in[67:0] = {4'b0000, DivBOp_9[63:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend), 
      (DivState[3:0] == `DIVStatePostscaleRemainder)                  : XH_in[67:0] = { {3{DividendSign}}, ShiftResFinal[128:64]};
      ((DivState[3:0] == `DIVStatePrescaleDivisor) & OddQuotientBits) : XH_in[67:0] = {XH[66:0], (D[65] & DualResDiv)};  // lower half of dividend was in D during PrescaleDivisor (non-8-bit), for 8-bit shift in a zero.
      (DivState[3:0] == `DIVStateIterate)                             : XH_in[67:0] = {PRem[67:62], Sum[61:0]};     
      (DivState[3:0] == `DIVStateBroadcastQuotient)                   : XH_in[67:0] = {68{DividendSign & ~(SignedDiv & FinalRemainderIsZero_d1) & ~FinalRemainderIsDivisor_d1}};                   //  to sign extend the remainder during PostscaleRemainder
      default                                                         : XH_in[67:0] = XH[67:0];        //! TRUE_DEFAULT
    endcase


// FIXME DAN XPROP
always @*
    // bits [65:64] is only to capture the carryout and detect QuotientTooLarge
    case (1'b1)
      DivIssueDiv8_9                                                                             : XL_in[63:0] = 64'b0;
      DivIssueDivh_9                                                                             : XL_in[63:0] = DivAOp_9[63:0];  // divh AOp
      (DivState[3:0] == `DIVStatePrescaleConcat) & 
       ((DivisorSize[1:0] == `DivisorSize16) | 
        (DivisorSize[1:0] == `DivisorSize32))                                                    : XL_in[63:0] = ShiftResFinal[63:0];

      ////////////((DivState[3:0] == `DIVStatePrescaleDividend) & ~DualResDiv)                              : XL_in[63:0] = D[65:2];
      ////////////DivlIssue_9                                                                               : XL_in[63:0] = DivAOp_9[63:0];     // divisor from divl (DivlIssue_9=1)

      ((DivState[3:0] == `DIVStatePrescaleDividend))                                             : XL_in[63:0] = TEMPXL[63:0];

      ((DivState[3:0] == `DIVStatePrescaleDivisor)  &  DualResDiv &  OddQuotientBits)            : XL_in[63:0] = {D[64:2], 1'b0};
      ((DivState[3:0] == `DIVStatePrescaleDivisor)  &  DualResDiv & ~OddQuotientBits)            : XL_in[63:0] = D[65:2];
      (DivState[3:0] == `DIVStatePrescaleDivisor)   & ~DualResDiv,
      (DivState[3:0] == `DIVStateBroadcastQuotient) &  FinalRemainderIsDivisor_d1                : XL_in[63:0] = 64'b0;
      (DivState[3:0] == `DIVStateGenRemainder),
      (DivState[3:0] == `DIVStateBroadcastQuotient) &  FixupNeeded & ~FinalRemainderIsDivisor_d1 & ~AlreadyFixedupRemainder 
                                                                                                 : XL_in[63:0] = FinalRemainder[65:2];  // prep for postscale remainder
      (DivState[3:0] == `DIVStateIterate)                                                        : XL_in[63:0] = {XL[61:0], 2'b00};
     default                                                                                     : XL_in[63:0] = XL[63:0];        //! TRUE_DEFAULT
    endcase     

// FIXME DAN XPROP
always @*
    case (1'b1)
      DivIssueDiv8Divh_9                  : CH_in[61:0] = 62'b0;           // initialize
      (DivState[3:0] == `DIVStateIterate) : CH_in[61:0] = Carry[61:0];
      default                             : CH_in[61:0] = CH[61:0];        //! TRUE_DEFAULT
    endcase     

// FIXME DAN XPROP
always @*
    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : Q_in[66:0] = CShiftQ ? {Q[64:0], Qkp1[1:0]} : {QM[64:0], Qkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : Q_in[66:0] = 67'h0;                                 //to initialize
      default                                      : Q_in[66:0] = Q[66:0];        //! TRUE_DEFAULT
    endcase     

// FIXME DAN XPROP
always @*
    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : QM_in[66:0] = CShiftQM ? {QM[64:0], QMkp1[1:0]} : {Q[64:0], QMkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : QM_in[66:0] = 67'h7_ffffffff_ffffffff;                                 //to initialize
      default                                      : QM_in[66:0] = QM[66:0];        //! TRUE_DEFAULT
    endcase     

// FIXME DAN XPROP
always @*
    case (1'b1)
      (DivState[3:0] == `DIVStateIterate)          : QP_in[66:0] = CShiftQP[1] ? {QP[64:0], QPkp1[1:0]} : 
                                                                   CShiftQP[0] ? {Q[64:0],  QPkp1[1:0]} : 
                                                                               {QM[64:0], QPkp1[1:0]};
      (DivState[3:0] == `DIVStatePrescaleDividend) : QP_in[66:0] = 67'h1;
      default                                      : QP_in[66:0] = QP[66:0];        //! TRUE_DEFAULT
    endcase     


// insert gate for d input : +++++ etl1 (D[65:0],      RCLK_Div8Regs_AR,     D_in[65:0] );   // updated by div8      AOp issue or state machine
  gate #(65,0)    gate__D_eve__65_0(D_eve[65:0],D_in[65:0] );
  etl1 #(65,0)    etl1__D__65_0(.q(D[65:0]),      .clk(RCLK_Div8Regs_AR),     .d(D_eve[65:0]), .SDO(SDO_0038[65:0]), .SDI({SDO_0037[16], SDO_0038[65:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (TEMPXL[63:0], RCLK_DivlRegs_AR, TEMPXL_in[63:0]);   // updated by divl      AOp issue or state machine 
  gate #(63,0)    gate__TEMPXL_eve__63_0(TEMPXL_eve[63:0],TEMPXL_in[63:0]);
  etl1 #(63,0)    etl1__TEMPXL__63_0(.q(TEMPXL[63:0]), .clk(RCLK_DivlRegs_AR), .d(TEMPXL_eve[63:0]), .SDO(SDO_0039[63:0]), .SDI({SDO_0038[0], SDO_0039[63:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (XH[67:0],     RCLK_Div8DivhRegs_AR, XH_in[67:0]);   // updated by div8/divh BOp issue or state machine
  gate #(67,0)    gate__XH_eve__67_0(XH_eve[67:0],XH_in[67:0]);
  etl1 #(67,0)    etl1__XH__67_0(.q(XH[67:0]),     .clk(RCLK_Div8DivhRegs_AR), .d(XH_eve[67:0]), .SDO(SDO_0040[67:0]), .SDI({SDO_0039[0], SDO_0040[67:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (XL[63:0],     RCLK_Div8DivhRegs_AR, XL_in[63:0]);   // updated by div8/divh AOp issue or state machine
  gate #(63,0)    gate__XL_eve__63_0(XL_eve[63:0],XL_in[63:0]);
  etl1 #(63,0)    etl1__XL__63_0(.q(XL[63:0]),     .clk(RCLK_Div8DivhRegs_AR), .d(XL_eve[63:0]), .SDO(SDO_0041[63:0]), .SDI({SDO_0040[0], SDO_0041[63:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (CH[61:0],     RCLK_DivState_AR,     CH_in[61:0]);   // updated by start or state machine
  gate #(61,0)    gate__CH_eve__61_0(CH_eve[61:0],CH_in[61:0]);
  etl1 #(61,0)    etl1__CH__61_0(.q(CH[61:0]),     .clk(RCLK_DivState_AR),     .d(CH_eve[61:0]), .SDO(SDO_0042[61:0]), .SDI({SDO_0041[0], SDO_0042[61:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (Q[66:0],      RCLK_DivState_AR,     Q_in[66:0]);    // updated by start or state machine
  gate #(66,0)    gate__Q_eve__66_0(Q_eve[66:0],Q_in[66:0]);
  etl1 #(66,0)    etl1__Q__66_0(.q(Q[66:0]),      .clk(RCLK_DivState_AR),     .d(Q_eve[66:0]), .SDO(SDO_0043[66:0]), .SDI({SDO_0042[0], SDO_0043[66:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (QM[66:0],     RCLK_DivState_AR,     QM_in[66:0]);   // updated by state machine
  gate #(66,0)    gate__QM_eve__66_0(QM_eve[66:0],QM_in[66:0]);
  etl1 #(66,0)    etl1__QM__66_0(.q(QM[66:0]),     .clk(RCLK_DivState_AR),     .d(QM_eve[66:0]), .SDO(SDO_0044[66:0]), .SDI({SDO_0043[0], SDO_0044[66:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (QP[66:0],     RCLK_DivState_AR,     QP_in[66:0]);   // updated by state machine
  gate #(66,0)    gate__QP_eve__66_0(QP_eve[66:0],QP_in[66:0]);
  etl1 #(66,0)    etl1__QP__66_0(.q(QP[66:0]),     .clk(RCLK_DivState_AR),     .d(QP_eve[66:0]), .SDO(SDO_0045[66:0]), .SDI({SDO_0044[0], SDO_0045[66:0+1]}), .SSE(SSE));



// insert gate for condition input : +++++ com1a (RCLK_DIVStatePrescaleDivisor_AR, CCLK, DivState[3:0] == `DIVStatePrescaleDivisor);
  gate            gate__RCLK_DIVStatePrescaleDivisor_AR_cvc(RCLK_DIVStatePrescaleDivisor_AR_cvc,DivState[3:0] == `DIVStatePrescaleDivisor);
  com1a            com1__RCLK_DIVStatePrescaleDivisor_AR(RCLK_DIVStatePrescaleDivisor_AR, CCLK, RCLK_DIVStatePrescaleDivisor_AR_cvc, SSE);

// insert gate for d input : +++++ etl1 (DivisorLookup[64:63], RCLK_DIVStatePrescaleDivisor_AR, DivisorShiftedLookup[1:0]);
  gate #(64,63)   gate__DivisorLookup_eve__64_63(DivisorLookup_eve[64:63],DivisorShiftedLookup[1:0]);
  etl1 #(64,63)   etl1__DivisorLookup__64_63(.q(DivisorLookup[64:63]), .clk(RCLK_DIVStatePrescaleDivisor_AR), .d(DivisorLookup_eve[64:63]), .SDO(SDO_0046[64:63]), .SDI({SDO_0045[0], SDO_0046[64:63+1]}), .SSE(SSE));

  mux2e #(63,0)    mux2e__XL_mux__63_0(XL_mux[63:0], DivStatePrescaleDividend, TEMPXL[63:0], XL[63:0]);


always @* 
begin
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
   //      1) FinalRemainderIsDivisor_d1 can signal falsely in the NoIterate case
   //      due to prescaled dividend and divisor -they appear the same, but can still have different # of bits
   //
   //      really with this change we can truly have finalRemainderIsDivisor_d1 for the negative dividends at 2^n boundry
   //      during the noiterate case.  To correctly identify this equality, we need to compare the number of bits as well.
   //
   //  2) due to our extra leading sign bit in the previous version, we'd never hit the case of select +3
   //      each iteration and then needing QP (which will have the overflow bit).  With this
   //      change we must now identify it.
   //
   //  3) also, needed to disable the merge mask on the quotient for the NoIterate case when D=X
   //
   //  4) some trickyness with dividend of -1  (all Fs)  shiftamt decoding was all zeros which lead to grossly wrong
   //      NumDividendBits and quotienttoolarge.  Now shiftamt is same as -2 (all ones) since shifter is only 127 bits max
   //      (ignoreing extra shift).  I think this will be okay, but need to rerun - it seems to pass, but still a concern
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

   //casez (XL[63:0])
   casez (XL_mux[63:0])
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

   //casez (XL[31:0])
   casez (XL_mux[31:0])
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
   
   //casez (XL[15:0])
   casez (XL_mux[15:0])
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

   //casez (XL[7:0])
   casez (XL_mux[7:0])
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

   //casez (XL[63:0])
   casez (XL_mux[63:0])
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

   //casez (XL[31:0])
   casez (XL_mux[31:0])
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
   
   //casez (XL[15:0])
   casez (XL_mux[15:0])
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

   //casez (XL[7:0])
   casez (XL_mux[7:0])
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

   //casez (XL[63:0])
   casez (XL_mux[63:0])
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

   //casez (XL[31:0])
   casez (XL_mux[31:0])
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
   
   //casez (XL[15:0])
   casez (XL_mux[15:0])
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

   //casez (XL[7:0])
   casez (XL_mux[7:0])
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

always @*
  begin
    // check for any one in TEMPXL for the divisor
    AnyOneTEMPXL64 = (| TEMPXL[63:0]);
    AnyOneTEMPXL32 = (| TEMPXL[31:0]);
    AnyOneTEMPXL16 = (| TEMPXL[15:0]);
    AnyOneTEMPXL8  = (| TEMPXL[7:0]);
  end 

always @* 
begin   
  // Prescale Count generation --------------------------------------------------------------------------------

  SignedNegativeDividend = SignedDiv & DividendSign;
  SignedNegativeDivisor  = SignedDiv & DivisorSign;

  case ({DivisorSize[1:0], 1'b1})
    {`DivisorSize8,  ~SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = {3'b011, ClzXH16[3:0]};
    {`DivisorSize8,   SignedNegativeDividend} : ShiftAmtPrescaleCountDividend[6:0] = {3'b011, CloXH16[3:0]};
  // FIXME XPROP
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

  case (DivisorSize_9[1:0])
    // output unused on 8-bit div
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
  // FIXME XPROP
    `DivisorSize64  : ShiftAmtBroadcastQuotient[6:0] = NoIterate ? (NumDividendBits_d1[6:0] + 7'b1 ): NumDivisorBits_d1[6:0];
    default         : ShiftAmtBroadcastQuotient[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case (1'b1)
    DivIssueDiv8Divh_9                                : ShiftAmt[6:0] = ShiftAmtPrescaleConcatPrep[6:0];
    (DivState[3:0] == `DIVStatePrescaleCountDividend) : ShiftAmt[6:0] = ShiftAmtPrescaleCountDividend[6:0];
    (DivState[3:0] == `DIVStatePrescaleDividend)      : ShiftAmt[6:0] = ShiftAmtPrescaleCountDivisor[6:0];
    (DivState[3:0] == `DIVStateBroadcastQuotient)     : ShiftAmt[6:0] = ShiftAmtBroadcastQuotient[6:0];
    default                                           : ShiftAmt[6:0] = 7'bxxxxxxx;                   //! TRUE_DEFAULT
  endcase

  case ({ DivState[3:0], DivisorSize[1:0]})
    {`DIVStatePrescaleDividend, `DivisorSize8}  : NegDivisorAt2NBoundry = SignedDiv & DivisorSign & (~CloXL8[2:0] == CtzXL8[2:0]);
    {`DIVStatePrescaleDividend, `DivisorSize16} : NegDivisorAt2NBoundry = SignedDiv & DivisorSign & (~CloXL16[3:0] == CtzXL16[3:0]);
    {`DIVStatePrescaleDividend, `DivisorSize32} : NegDivisorAt2NBoundry = SignedDiv & DivisorSign & (~CloXL32[4:0] == CtzXL32[4:0]);
    {`DIVStatePrescaleDividend, `DivisorSize64} : NegDivisorAt2NBoundry = SignedDiv & DivisorSign & (~CloXL64[5:0] == CtzXL64[5:0]);
    default                                     : NegDivisorAt2NBoundry = 1'b1;  //! TRUE_DEFAULT
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
    `DivisorSize8   : FixupDivLookup = SignedDiv & DivisorSign & ({1'b0, ~CloXL8[2:0]}  <= ({1'b0, CtzXL8[2:0]}  + 4'b0011));
    `DivisorSize16  : FixupDivLookup = SignedDiv & DivisorSign & ({1'b0, ~CloXL16[3:0]} <= ({1'b0, CtzXL16[3:0]} + 5'b00011));
    `DivisorSize32  : FixupDivLookup = SignedDiv & DivisorSign & ({1'b0, ~CloXL32[4:0]} <= ({1'b0, CtzXL32[4:0]} + 6'b000011));
    `DivisorSize64  : FixupDivLookup = SignedDiv & DivisorSign & ({1'b0, ~CloXL64[5:0]} <= ({1'b0, CtzXL64[5:0]} + 7'b0000011));
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
always @* 
  casez ({ SignedNegativeDivisor, ~NegDivisorAt2NBoundry_d1, FixupDivLookup_d1})
    3'b0_?_?,
    3'b1_0_? : DivisorShiftedLookup[1:0] = ShiftResFinal[62:61];
    3'b1_1_0 : DivisorShiftedLookup[1:0] = ~ShiftResFinal[62:61];
    3'b1_1_1 : DivisorShiftedLookup[1:0] = {(~ShiftResFinal[62] | ~ShiftResFinal[61]), ShiftResFinal[61]} ;
    default  : DivisorShiftedLookup[1:0] = 2'bxx ;              //! TRUE_DEFAULT                                        
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
always @* 
  case (DivisorSize[1:0])
    `DivisorSize8  : NumDividendBits[7:0]   = 8'd128 - 8'd64 - {1'b0, ShiftAmt_d1[6:0]};    // 8-bit divides
    `DivisorSize16 : NumDividendBits[7:0]   = 8'd128 - 8'd48 - {1'b0, ShiftAmt_d1[6:0]};    // 16-bit divides
    `DivisorSize32 : NumDividendBits[7:0]   = 8'd128 - 8'd32 - {1'b0, ShiftAmt_d1[6:0]};    // 32-bit divides
    default        : NumDividendBits[7:0]   = 8'd128 -         {1'b0, ShiftAmt_d1[6:0]};    //! TRUE_DEFAULT  // 64-bit divides
  endcase

  gate #(6,0)     gate__NumDivisorBits__6_0(NumDivisorBits[6:0], 7'd64 - {1'b0, ShiftAmt_d1[5:0]} - {6'b0, (~NegDivisorAt2NBoundry_d1 & SignedDiv & DivisorSign)});


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
  gate            gate__OddQuotientBits(OddQuotientBits, NumDividendBits_d1[0] ^ NumDivisorBits[0]);

// NumQuotientBits4IterCnt* is the number of quotient bits that will be generated by the iteration loop. 
// We need to include +2 due to alignment of dividend (additional zeros (or ones if negative) to the left of the leading one (or zero, if negative).  
// Refer to the dividend alignment to see this.
// Make sure to truncate at zero if the divisor is bigger than dividend.

// NOTE: the implementation could be as: 
//  NumQuotientBits4IterCnt[7:0]   = {8{(NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]})}} &    (NumDividendBits_d1[7:0] + 
//                                                  {2'b0, ShiftAmt_d1[5:0]} + 
//                                                  8'b11000010 +                                                              // -(7'd64) + 2
//                                                  {7'b0, (~NegDivisorAt2NBoundry_d1 & SignedDiv & DivisorSign)} -
//                                                  {7'b0, OddQuotientBits});


// insert gate for sel input : +++++ mux2e (NumQuotientBits4IterCnt[7:0], (NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]}),  (NumDividendBits_d1[7:0] - {1'b0, NumDivisorBits[6:0]} - {7'b0, OddQuotientBits} + 8'd2), 
  gate            gate__NumQuotientBits4IterCnt_7_0__sel(NumQuotientBits4IterCnt_7_0__sel,(NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]}));
  mux2e #(7,0)     mux2e__NumQuotientBits4IterCnt__7_0(NumQuotientBits4IterCnt[7:0], NumQuotientBits4IterCnt_7_0__sel,  (NumDividendBits_d1[7:0] - {1'b0, NumDivisorBits[6:0]} - {7'b0, OddQuotientBits} + 8'd2), 
                                                                                                8'b0);
//! unused NumQuotientBits4IterCnt[0]

// NumQuotientBits is the raw calculation of the number of quotient bits used to determine quotient too large.  This isnt exact, but the padded sign bits
// in front of the dividend protect us.  

// insert gate for sel input : +++++ mux2e (NumQuotientBits[7:0], (NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]}),  (NumDividendBits_d1[7:0] - {1'b0, NumDivisorBits[6:0]}), 
  gate            gate__NumQuotientBits_7_0__sel(NumQuotientBits_7_0__sel,(NumDividendBits_d1[7:0] >= {1'b0, NumDivisorBits[6:0]}));
  mux2e #(7,0)     mux2e__NumQuotientBits__7_0(NumQuotientBits[7:0], NumQuotientBits_7_0__sel,  (NumDividendBits_d1[7:0] - {1'b0, NumDivisorBits[6:0]}), 
                                                                                        8'b0);
//! unused NumQuotientBits[7]
   
//ova forbid_bool ((DivState[3:0] == `DIVStatePrescaleDivisor) & NumQuotientBits4IterCnt[0], "NumQuotientBits4IterCnt[0] is not zero!");


always @* 
begin
  case (1'b1)
    (DivState[3:0] == `DIVStatePrescaleDivisor)       : ShiftFixup = ~NegDivisorAt2NBoundry_d1 & SignedDiv & DivisorSign;
    (DivState[3:0] == `DIVStatePrescaleCountDividend) : ShiftFixup = 1'b0;     // force zero during PrescaleConcat
                                                                               // force zero during normal postscale remainder (except when NoIterate to "undo" the prescale)
    (DivState[3:0] == `DIVStatePostscaleRemainder)    : ShiftFixup = NoIterate & ~ShiftFixup_d1;
    default                                           : ShiftFixup = 1'b0; //! TRUE_DEFAULT                   // for PrescaleDividend
  endcase
end
   
    

// --------------------------------------------------------------------------------

// insert gate for sel input : +++++ mux2e (IterationCountNext[6:0], (DivState[3:0] == `DIVStatePrescaleDivisor), NumQuotientBits4IterCnt[7:1], (IterationCount[6:0] - 7'b0000001));
  gate            gate__IterationCountNext_6_0__sel(IterationCountNext_6_0__sel,(DivState[3:0] == `DIVStatePrescaleDivisor));
  mux2e #(6,0)     mux2e__IterationCountNext__6_0(IterationCountNext[6:0], IterationCountNext_6_0__sel, NumQuotientBits4IterCnt[7:1], (IterationCount[6:0] - 7'b0000001));
  gate            gate__IterateDone(IterateDone, IterationCount[6:0] == 7'd1);
   
                                                        
//--------------------------------------------------------------------------------
// DIV ERROR DETECTION:                                                     
always @* 
begin
  case (DivisorSize[1:0])
    `DivisorSize8  : DividendZero = ~AnyOneXH16;                 // 8-bit divides
    `DivisorSize16 : DividendZero = ~AnyOneXH16 & ~AnyOneXL16;   // 16-bit divides
    `DivisorSize32 : DividendZero = ~AnyOneXH32 & ~AnyOneXL32;   // 32-bit divides
    `DivisorSize64 : DividendZero = ~AnyOneXH64 & ~AnyOneXL64;   // 64-bit divides
    default        : DividendZero = 1'bx;   //! TRUE_DEFAULT
  endcase
   
  case (DivisorSize[1:0])
    `DivisorSize8  : DivisorZero = ~AnyOneTEMPXL8;    // 8-bit divides
    `DivisorSize16 : DivisorZero = ~AnyOneTEMPXL16;   // 16-bit divides
    `DivisorSize32 : DivisorZero = ~AnyOneTEMPXL32;   // 32-bit divides
    `DivisorSize64 : DivisorZero = ~AnyOneTEMPXL64;   // 64-bit divides
    default        : DivisorZero = 1'bx;   //! TRUE_DEFAULT
  endcase
end
                                                        


// insert gate for condition input : +++++ com1a (RCLK_ShiftAmt_d1_AR, CCLK, (DivState[3:0] == `DIVStatePrescaleCountDividend) | 
  gate            gate__RCLK_ShiftAmt_d1_AR_cvc(RCLK_ShiftAmt_d1_AR_cvc,(DivState[3:0] == `DIVStatePrescaleCountDividend) | 
                                 (DivState[3:0] == `DIVStatePrescaleDividend)  | 
                                 DivIssueDiv8Divh_9 |                                      // for PrescaleConcatPrep
                                 (DivState[3:0] == `DIVStateBroadcastQuotient)     );
  com1a            com1__RCLK_ShiftAmt_d1_AR(RCLK_ShiftAmt_d1_AR, CCLK, RCLK_ShiftAmt_d1_AR_cvc, SSE);

// insert gate for d input : +++++ etl1 (ShiftAmt_d1[6:0], RCLK_ShiftAmt_d1_AR, ShiftAmt[6:0]);
  gate #(6,0)     gate__ShiftAmt_d1_eve__6_0(ShiftAmt_d1_eve[6:0],ShiftAmt[6:0]);
  etl1 #(6,0)     etl1__ShiftAmt_d1__6_0(.q(ShiftAmt_d1[6:0]), .clk(RCLK_ShiftAmt_d1_AR), .d(ShiftAmt_d1_eve[6:0]), .SDO(SDO_0047[6:0]), .SDI({SDO_0046[63], SDO_0047[6:0+1]}), .SSE(SSE));



// replace with mux2e, etl1 : +++++ etl1mux2e (DividendZero_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend), DividendZero, DividendZero_d1);

// insert gate for sel input : +++++ etl1mux2e (DividendZero_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend), DividendZero, DividendZero_d1);
  gate            gate__DividendZero_d1_intmux_sel(DividendZero_d1_intmux_sel,(DivState[3:0] == `DIVStatePrescaleCountDividend));
  mux2e            mux2e__DividendZero_d1_intmux(DividendZero_d1_intmux, DividendZero_d1_intmux_sel, DividendZero, DividendZero_d1);

// insert gate for d input : +++++ etl1mux2e (DividendZero_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend), DividendZero, DividendZero_d1);
  gate            gate__DividendZero_d1_eve(DividendZero_d1_eve,DividendZero_d1_intmux);
  etl1            etl1__DividendZero_d1(.q(DividendZero_d1), .clk(RCLK_ShiftAmt_d1_AR), .d(DividendZero_d1_eve), .SDO(SDO_0048), .SDI(SDO_0047[0]), .SSE(SSE));

// NOTE: We could be in PrescaleDividend waiting for the dividend ops to arrive.  As such, NumDividendBits can change
// since ShiftAmt is preparing to concat.  Only allow NumDivisorBits_d1 to flop on the first cycle of PrescaleDividend.

// insert gate for condition input : +++++ com1a (RCLK_NumDividendBits_d1_AR, CCLK, DivState[3:0] == `DIVStatePrescaleDividend);
  gate            gate__RCLK_NumDividendBits_d1_AR_cvc(RCLK_NumDividendBits_d1_AR_cvc,DivState[3:0] == `DIVStatePrescaleDividend);
  com1a            com1__RCLK_NumDividendBits_d1_AR(RCLK_NumDividendBits_d1_AR, CCLK, RCLK_NumDividendBits_d1_AR_cvc, SSE);

// insert gate for d input : +++++ etl1 (NumDividendBits_d1[7:0], RCLK_NumDividendBits_d1_AR, NumDividendBits[7:0] & {8{~DividendZero_d1}});
  gate #(7,0)     gate__NumDividendBits_d1_eve__7_0(NumDividendBits_d1_eve[7:0],NumDividendBits[7:0] & {8{~DividendZero_d1}});
  etl1 #(7,0)     etl1__NumDividendBits_d1__7_0(.q(NumDividendBits_d1[7:0]), .clk(RCLK_NumDividendBits_d1_AR), .d(NumDividendBits_d1_eve[7:0]), .SDO(SDO_0049[7:0]), .SDI({SDO_0048, SDO_0049[7:0+1]}), .SSE(SSE));


// insert gate for d input : +++++ etl1 (AlreadyFixedupRemainder, RCLK_ExDivFree_AR, (DivState[3:0] == `DIVStateBroadcastQuotient));
  gate            gate__AlreadyFixedupRemainder_eve(AlreadyFixedupRemainder_eve,(DivState[3:0] == `DIVStateBroadcastQuotient));
  etl1            etl1__AlreadyFixedupRemainder(.q(AlreadyFixedupRemainder), .clk(RCLK_ExDivFree_AR), .d(AlreadyFixedupRemainder_eve), .SDO(SDO_0050), .SDI(SDO_0049[0]), .SSE(SSE));


// replace with mux2e, etl1 : +++++ etl1mux2e (NegDivisorAt2NBoundry_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), NegDivisorAt2NBoundry, NegDivisorAt2NBoundry_d1);

// insert gate for sel input : +++++ etl1mux2e (NegDivisorAt2NBoundry_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), NegDivisorAt2NBoundry, NegDivisorAt2NBoundry_d1);
  gate            gate__NegDivisorAt2NBoundry_d1_intmux_sel(NegDivisorAt2NBoundry_d1_intmux_sel,(DivState[3:0] == `DIVStatePrescaleDividend));
  mux2e            mux2e__NegDivisorAt2NBoundry_d1_intmux(NegDivisorAt2NBoundry_d1_intmux, NegDivisorAt2NBoundry_d1_intmux_sel, NegDivisorAt2NBoundry, NegDivisorAt2NBoundry_d1);

// insert gate for d input : +++++ etl1mux2e (NegDivisorAt2NBoundry_d1, RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), NegDivisorAt2NBoundry, NegDivisorAt2NBoundry_d1);
  gate            gate__NegDivisorAt2NBoundry_d1_eve(NegDivisorAt2NBoundry_d1_eve,NegDivisorAt2NBoundry_d1_intmux);
  etl1            etl1__NegDivisorAt2NBoundry_d1(.q(NegDivisorAt2NBoundry_d1), .clk(RCLK_ShiftAmt_d1_AR), .d(NegDivisorAt2NBoundry_d1_eve), .SDO(SDO_0051), .SDI(SDO_0050), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (FixupDivLookup_d1       , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), FixupDivLookup       , FixupDivLookup_d1       );

// insert gate for sel input : +++++ etl1mux2e (FixupDivLookup_d1       , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), FixupDivLookup       , FixupDivLookup_d1       );
  gate            gate__FixupDivLookup_d1_intmux_sel(FixupDivLookup_d1_intmux_sel,(DivState[3:0] == `DIVStatePrescaleDividend));
  mux2e            mux2e__FixupDivLookup_d1_intmux(FixupDivLookup_d1_intmux, FixupDivLookup_d1_intmux_sel, FixupDivLookup       , FixupDivLookup_d1       );

// insert gate for d input : +++++ etl1mux2e (FixupDivLookup_d1       , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), FixupDivLookup       , FixupDivLookup_d1       );
  gate            gate__FixupDivLookup_d1_eve(FixupDivLookup_d1_eve,FixupDivLookup_d1_intmux);
  etl1            etl1__FixupDivLookup_d1(.q(FixupDivLookup_d1)       , .clk(RCLK_ShiftAmt_d1_AR), .d(FixupDivLookup_d1_eve), .SDO(SDO_0052), .SDI(SDO_0051), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (DivideByZero_d1         , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), DivisorZero          , DivideByZero_d1         );

// insert gate for sel input : +++++ etl1mux2e (DivideByZero_d1         , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), DivisorZero          , DivideByZero_d1         );
  gate            gate__DivideByZero_d1_intmux_sel(DivideByZero_d1_intmux_sel,(DivState[3:0] == `DIVStatePrescaleDividend));
  mux2e            mux2e__DivideByZero_d1_intmux(DivideByZero_d1_intmux, DivideByZero_d1_intmux_sel, DivisorZero          , DivideByZero_d1         );

// insert gate for d input : +++++ etl1mux2e (DivideByZero_d1         , RCLK_ShiftAmt_d1_AR, (DivState[3:0] == `DIVStatePrescaleDividend), DivisorZero          , DivideByZero_d1         );
  gate            gate__DivideByZero_d1_eve(DivideByZero_d1_eve,DivideByZero_d1_intmux);
  etl1            etl1__DivideByZero_d1(.q(DivideByZero_d1)         , .clk(RCLK_ShiftAmt_d1_AR), .d(DivideByZero_d1_eve), .SDO(SDO_0053), .SDI(SDO_0052), .SSE(SSE));
    

// insert gate for d input : +++++ etl1 (NumDivisorBits_d1[6:0] , RCLK_DIVStatePrescaleDivisor_AR, NumDivisorBits[6:0]);
  gate #(6,0)     gate__NumDivisorBits_d1_eve__6_0(NumDivisorBits_d1_eve[6:0],NumDivisorBits[6:0]);
  etl1 #(6,0)     etl1__NumDivisorBits_d1__6_0(.q(NumDivisorBits_d1[6:0]) , .clk(RCLK_DIVStatePrescaleDivisor_AR), .d(NumDivisorBits_d1_eve[6:0]), .SDO(SDO_0054[6:0]), .SDI({SDO_0053, SDO_0054[6:0+1]}), .SSE(SSE));

// insert gate for d input : +++++ etl1 (NumQuotientBits_d1[6:0], RCLK_DIVStatePrescaleDivisor_AR, NumQuotientBits[6:0]);
  gate #(6,0)     gate__NumQuotientBits_d1_eve__6_0(NumQuotientBits_d1_eve[6:0],NumQuotientBits[6:0]);
  etl1 #(6,0)     etl1__NumQuotientBits_d1__6_0(.q(NumQuotientBits_d1[6:0]), .clk(RCLK_DIVStatePrescaleDivisor_AR), .d(NumQuotientBits_d1_eve[6:0]), .SDO(SDO_0055[6:0]), .SDI({SDO_0054[0], SDO_0055[6:0+1]}), .SSE(SSE));
// Need to save whethere we do the extra left shift for odd quotient bits to postscale the remainder correctly for the NoIterate case

// insert gate for d input : +++++ etl1 (ShiftFixup_d1          , RCLK_DIVStatePrescaleDivisor_AR, OddQuotientBits);
  gate            gate__ShiftFixup_d1_eve(ShiftFixup_d1_eve,OddQuotientBits);
  etl1            etl1__ShiftFixup_d1(.q(ShiftFixup_d1)          , .clk(RCLK_DIVStatePrescaleDivisor_AR), .d(ShiftFixup_d1_eve), .SDO(SDO_0056), .SDI(SDO_0055[0]), .SSE(SSE));

// shared gater so feedback muxes on the flops

// insert gate for condition input : +++++ com1a (RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, CCLK, (DivState[3:0] == `DIVStatePrescaleDividend) |   // for Divide by zero non-8b divides
  gate            gate__RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR_cvc(RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR_cvc,(DivState[3:0] == `DIVStatePrescaleDividend) |   // for Divide by zero non-8b divides
                                                     (DivState[3:0] == `DIVStatePrescaleDivisor)      |   // for iteration count for non-8b divides
                                                     (DivState[3:0] == `DIVStateIterate));
  com1a            com1__RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR(RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, CCLK, RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR_cvc, SSE);


// replace with mux2e, etl1 : +++++ etl1mux2e (IterationCount[6:0], RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStatePrescaleDividend), IterationCount[6:0], IterationCountNext[6:0]);

// insert gate for sel input : +++++ etl1mux2e (IterationCount[6:0], RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStatePrescaleDividend), IterationCount[6:0], IterationCountNext[6:0]);
  gate            gate__IterationCount_intmux_6_0__sel(IterationCount_intmux_6_0__sel,(DivState[3:0] == `DIVStatePrescaleDividend));
  mux2e #(6,0)     mux2e__IterationCount_intmux__6_0(IterationCount_intmux[6:0], IterationCount_intmux_6_0__sel, IterationCount[6:0], IterationCountNext[6:0]);

// insert gate for d input : +++++ etl1mux2e (IterationCount[6:0], RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStatePrescaleDividend), IterationCount[6:0], IterationCountNext[6:0]);
  gate #(6,0)     gate__IterationCount_eve__6_0(IterationCount_eve[6:0],IterationCount_intmux[6:0]);
  etl1 #(6,0)     etl1__IterationCount__6_0(.q(IterationCount[6:0]), .clk(RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR), .d(IterationCount_eve[6:0]), .SDO(SDO_0057[6:0]), .SDI({SDO_0056, SDO_0057[6:0+1]}), .SSE(SSE));


// replace with mux2e, etl1 : +++++ etl1mux2e (IterateOnce, RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), IterateOnce, (IterationCountNext[6:0] == 7'b1));

// insert gate for sel input : +++++ etl1mux2e (IterateOnce, RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), IterateOnce, (IterationCountNext[6:0] == 7'b1));
  gate            gate__IterateOnce_intmux_sel(IterateOnce_intmux_sel,(DivState[3:0] == `DIVStateIterate));
  mux2e            mux2e__IterateOnce_intmux(IterateOnce_intmux, IterateOnce_intmux_sel, IterateOnce, (IterationCountNext[6:0] == 7'b1));

// insert gate for d input : +++++ etl1mux2e (IterateOnce, RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), IterateOnce, (IterationCountNext[6:0] == 7'b1));
  gate            gate__IterateOnce_eve(IterateOnce_eve,IterateOnce_intmux);
  etl1            etl1__IterateOnce(.q(IterateOnce), .clk(RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR), .d(IterateOnce_eve), .SDO(SDO_0058), .SDI(SDO_0057[0]), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (NoIterate  , RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), NoIterate  , (IterationCountNext[6:0] == 7'b0));

// insert gate for sel input : +++++ etl1mux2e (NoIterate  , RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), NoIterate  , (IterationCountNext[6:0] == 7'b0));
  gate            gate__NoIterate_intmux_sel(NoIterate_intmux_sel,(DivState[3:0] == `DIVStateIterate));
  mux2e            mux2e__NoIterate_intmux(NoIterate_intmux, NoIterate_intmux_sel, NoIterate  , (IterationCountNext[6:0] == 7'b0));

// insert gate for d input : +++++ etl1mux2e (NoIterate  , RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR, (DivState[3:0] == `DIVStateIterate), NoIterate  , (IterationCountNext[6:0] == 7'b0));
  gate            gate__NoIterate_eve(NoIterate_eve,NoIterate_intmux);
  etl1            etl1__NoIterate(.q(NoIterate)  , .clk(RCLK_PrescCntDiv_or_PrescDiv_or_Iter_AR), .d(NoIterate_eve), .SDO(SDO_0059), .SDI(SDO_0058), .SSE(SSE));

                                                        
// --------------------------------------------------------------------------------
// Prescalar/Postscalar shifter
//  128 bit shifter, 128 bits wide followed by 1 bit shifter (used for extra left shift to properly normalize negative operands not on 2^n boundries)
//
//  This shifter is used to normalize both dividend and divisor.  In addition it's used to concatenate the low half of a dividend with the high half
//  as we do our prescale count work (only for the 16 and 32 bit divides)

// note: we need the extra bit on the MSB for dividends (on the wide and Hi shifters) since after the normal shift, we can have a 1 in the MSB, then
// the extra shift can come along and shift again (due to odd quotient bits on a positive dividend).  we must capture that.
  gate #(127,0)   gate__ShiftRes__127_0(ShiftRes[127:0], {XH[63:0], XL[63:0]} << ShiftAmt_d1[6:0]);
  mux2e #(128,0)   mux2e__ShiftResFinal__128_0(ShiftResFinal[128:0], ShiftFixup, {ShiftRes[127:0], 1'b0}, {DividendSign, ShiftRes[127:0]});

//----------------------------------------------------------------------------------------------------------------------------------------------------------------
// Lookup Table
//      
// HS32 NOTE TO IMPLEMENTATION:  DivisorLookup[64:63] is a constant throughout all divide iterations.  
// To help timing, we could take advantage of this.  Your choice how its done.....
// A better picture of this can be found in: /home/mikeach/pub/NewDiv-9.pdf
always @* 
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

// ova forbid_bool (( (DivState[3:0] == `DIVStateIterate) &
// ova                      (({XH[66:62], DivisorLookup[64:63]} == 7'b0101_1__10) | 
// ova                       ({XH[66:62], DivisorLookup[64:63]} == 7'b0110_0__10) |
// ova                       ({XH[66:62], DivisorLookup[64:63]} == 7'b0110_1__10) |
// ova                       ({XH[66:62], DivisorLookup[64:63]} == 7'b1000_1__10) |
// ova                       ({XH[66:62], DivisorLookup[64:63]} == 7'b1001_0__10) |
// ova                       ({XH[66:62], DivisorLookup[64:63]} == 7'b1001_1__10))),
// ova                   "EXDIV: Hit Divide table entry never before hit.  Coverage improvement opportunity - please contact rtl_exdiv.v owner!");

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
  gate            gate__NegDivisorSel(NegDivisorSel, ~(DivisorSign ^ XH[67]));

  mux2e #(68,0)    mux2e__Div2D__68_0(Div2D[68:0], NegDivisorSel, {~DivisorSign, ~DivisorSign, ~D[65:0], 1'b1},         {DivisorSign, DivisorSign, D[65:0], 1'b0});
  mux2e #(68,0)    mux2e__DivD__68_0(DivD[68:0],  NegDivisorSel, {~DivisorSign, ~DivisorSign, ~DivisorSign, ~D[65:0]}, {DivisorSign, DivisorSign, DivisorSign,  D[65:0]});

  mux2e #(68,0)    mux2e__DivOpA__68_0(DivOpA[68:0], MuxSel[1], Div2D[68:0], 69'b0);
  mux2e #(68,0)    mux2e__DivOpB__68_0(DivOpB[68:0], MuxSel[0], DivD[68:0],  69'b0);

  gate            gate__Inject2(Inject2, NegDivisorSel & (MuxSel[1] & MuxSel[0]));
  gate            gate__Inject1(Inject1, NegDivisorSel & (MuxSel[1] ^ MuxSel[0]));

  gate #(68,0)    gate__DivOpC__68_0(DivOpC[68:0], {XH[66:0], XL[63:62]});
  gate #(68,0)    gate__DivOpD__68_0(DivOpD[68:0], {5'b00000, CH[61:0], Inject2, Inject1});


//--------------------------------------------------------------------------------   
// 4:2 CSA - Note: due to the zeros in DivOpD, the upper portions could be 3:2 compressors to help timing.

  gate            gate__Si__69(Si[69]  , 1'b0);
  gate #(68,0)    gate__Si__68_0(Si[68:0], DivOpA[68:0] ^ DivOpB[68:0] ^ DivOpC[68:0]);
  gate #(69,1)    gate__Ci__69_1(Ci[69:1], (DivOpA[68:0] & DivOpB[68:0]) | (DivOpB[68:0] & DivOpC[68:0]) | (DivOpA[68:0] & DivOpC[68:0]));
  gate            gate__Ci__0(Ci[0]   , 1'b0);

  gate #(69,0)    gate__Di__69_0(Di[69:0], {DivOpD[68], DivOpD[68:0]});
    
  gate #(69,0)    gate__Sum__69_0(Sum[69:0],   Si[69:0] ^ Ci[69:0] ^ Di[69:0]);
  gate #(70,1)    gate__Carry__70_1(Carry[70:1], (Si[69:0] & Ci[69:0]) | (Ci[69:0] & Di[69:0]) | (Si[69:0] & Di[69:0]));
  gate            gate__Carry__0(Carry[0],    1'b0);
//! unused Carry[70]       

  gate #(67,62)   gate__PRem__67_62(PRem[67:62], Sum[67:62] + Carry[67:62]);
   

// Quotient bit generation.
// This divider generates 2 quotient bits per cycle.
// Since the remainder sign must be the same as the dividend sign, the final quotient can be off by one
// If the dividend is positive, but the remainder comes out negative, we need to add a divisor to the remainder and decrement the quotient by one.   
// If the dividend is negative, but the remainder comes out positive, we need to subtract a divisor from the remainder and increment the quotient by one.
// XL will get the quotient bits, 2 per cycle and are left shifted into the LSB.
// QD will hold the contents of the quotient plus one or minus one (determined by the dividend sign) in a similar manner.   
//
// Code shamelessly lifted and modified from Dibrino's code
   
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
       
always @* 
  case ({NegDivisorSel, MuxSel[1:0]})
    3'b111  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b10; QPkp1[1:0] = 2'b00; Qkp1[1:0] = 2'b11; QMkp1[1:0] = 2'b10; end   // +3 
    3'b110  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b11; Qkp1[1:0] = 2'b10; QMkp1[1:0] = 2'b01; end   // +2 
    3'b101  : begin CShiftQ = 1'b1; CShiftQM = 1'b0; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b10; Qkp1[1:0] = 2'b01; QMkp1[1:0] = 2'b00; end   // +1
    3'b000,
    3'b100  : begin CShiftQ = 1'b1; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b01; Qkp1[1:0] = 2'b00; QMkp1[1:0] = 2'b11; end   //  0 
    3'b001  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b01; QPkp1[1:0] = 2'b00; Qkp1[1:0] = 2'b11; QMkp1[1:0] = 2'b10; end   // -1 
    3'b010  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b00; QPkp1[1:0] = 2'b11; Qkp1[1:0] = 2'b10; QMkp1[1:0] = 2'b01; end   // -2 
    3'b011  : begin CShiftQ = 1'b0; CShiftQM = 1'b1; CShiftQP[1:0] = 2'b00; QPkp1[1:0] = 2'b10; Qkp1[1:0] = 2'b01; QMkp1[1:0] = 2'b00; end   // -3 
    default : begin CShiftQ = 1'bx; CShiftQM = 1'bx; CShiftQP[1:0] = 2'bxx; QPkp1[1:0] = 2'bxx; Qkp1[1:0] = 2'bxx; QMkp1[1:0] = 2'bxx; end //! TRUE_DEFAULT
  endcase


// FIXME
//! unused debugTRem[69:68]
   
always @* 
begin
   debugTRem[69:0] = Sum[69:0] + Carry[69:0];
  // FIXME XPROP
   absTRem[67:0]  = (debugTRem[67] ? (~debugTRem[67:0] + 68'b1) : debugTRem[67:0]);
   absD[67:62]    = (DivisorSign ? (~{DivisorSign, DivisorSign, D[65:62]} + 6'b1) : {DivisorSign, DivisorSign, D[65:62]});
end

//etl1 (debugTotalPartialRemainder_d1[69:0], RCLK_ExDivFree_AR, debugTRem[69:0]);
//DAN DELETED unused debugTotalPartialRemainder_d1[69:0]

//! unused absTRem[67:0]
//! unused absD[67:62]

// NOTE: remember, the value of PRem may be one less than TRem.  The ova below needs to do the full add to make sure we are
// within our boundries.
// ova forbid_bool ((DivState[3:0] == `DIVStateIterate) & (absTRem[67:62] > absD[67:62]),
// ova              "Divide error: absolute value of non-redundant partial remainder is greater than absolute value of divisor!");


//--------------------------------------------------------------------------------
// 64 bit CPA
// Used to generate final remainder and perform the remainder fixup.
//
   
// NOTE: in the remainder fixup case, we dont need to care about the MSB [66] of OpA and OpB.
// sign extension is handled separately.
  mux2e #(66,0)    mux2e__FRem_OpA__66_0(FRem_OpA[66:0], DivStateGenRemainder, XH[66:0]         , {1'b0, XL[63:0], 2'b00});
  mux2e #(66,0)    mux2e__FRem_OpB__66_0(FRem_OpB[66:0], DivStateGenRemainder, {5'b00, CH[61:0]}, {1'b0, D[65:0]});
  gate            gate__FRem_Carryin(FRem_Carryin,   (DivState[3:0] == `DIVStateFixupRemainder) & (~(DivisorSign ^ FRemSign_d1)));
    
always @* 
begin
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

    // if Remainder equals a positive D: (effectively subtract D from finalremainder to get zero)   
    // (to complete the 2s compl on D, inject the 1 into the [-1] index (in the *_PP, _PG, _GZ, and _ZZ equations below)
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
    FinalRemainderIsDivisor    = FinalRemainderIsPosDivisor | FinalRemainderIsNegDivisor;
    
end
   

// insert gate for condition input : +++++ com1a (RCLK_DIVStateGenRemainder_AR, CCLK, DivState[3:0] == `DIVStateGenRemainder);
  gate            gate__RCLK_DIVStateGenRemainder_AR_cvc(RCLK_DIVStateGenRemainder_AR_cvc,DivState[3:0] == `DIVStateGenRemainder);
  com1a            com1__RCLK_DIVStateGenRemainder_AR(RCLK_DIVStateGenRemainder_AR, CCLK, RCLK_DIVStateGenRemainder_AR_cvc, SSE);

// insert gate for d input : +++++ etl1 (FinalRemainderIsDivisor_d1, RCLK_DIVStateGenRemainder_AR, FinalRemainderIsDivisor);
  gate            gate__FinalRemainderIsDivisor_d1_eve(FinalRemainderIsDivisor_d1_eve,FinalRemainderIsDivisor);
  etl1            etl1__FinalRemainderIsDivisor_d1(.q(FinalRemainderIsDivisor_d1), .clk(RCLK_DIVStateGenRemainder_AR), .d(FinalRemainderIsDivisor_d1_eve), .SDO(SDO_0060), .SDI(SDO_0059), .SSE(SSE));

// insert gate for d input : +++++ etl1 (FinalRemainderIsZero_d1   , RCLK_DIVStateGenRemainder_AR, FinalRemainderIsZero);
  gate            gate__FinalRemainderIsZero_d1_eve(FinalRemainderIsZero_d1_eve,FinalRemainderIsZero);
  etl1            etl1__FinalRemainderIsZero_d1(.q(FinalRemainderIsZero_d1)   , .clk(RCLK_DIVStateGenRemainder_AR), .d(FinalRemainderIsZero_d1_eve), .SDO(SDO_0061), .SDI(SDO_0060), .SSE(SSE));

// insert gate for d input : +++++ etl1 (FRemSign_d1               , RCLK_DIVStateGenRemainder_AR, FinalRemainder[66]);
  gate            gate__FRemSign_d1_eve(FRemSign_d1_eve,FinalRemainder[66]);
  etl1            etl1__FRemSign_d1(.q(FRemSign_d1)               , .clk(RCLK_DIVStateGenRemainder_AR), .d(FRemSign_d1_eve), .SDO(SDO_0062), .SDI(SDO_0061), .SSE(SSE));


    
// Divider bubble requests are sent early.  
// All other EX ops that can jam the ALU1 result bus (multiplier) can take priority over divider jams.
// As such, the bubble from DIV is just a request and if others jams are present, the DIV state machine will issue the request again the next cycle.
// Quotient jams ResBus first (state BroadcastQuotient), then the remainder (state BroadcastRemainder).

// Quotient bubble request (used in non-8-bit sizes only)
  gate            gate__FirstAttemptJamQuotient_6(FirstAttemptJamQuotient_6, DualResDiv & (((DivState[3:0] == `DIVStatePrescaleDividend) & DivisorZero                      ) | 
                                               ((DivState[3:0] == `DIVStatePrescaleDivisor)  & (IterationCountNext[6:0] == 7'b0)) | 
                                               ((DivState[3:0] == `DIVStatePrescaleDivisor)  & (IterationCountNext[6:0] == 7'b1)) | 
                                               ((DivState[3:0] == `DIVStateIterate)          & (IterationCount[6:0]     == 7'd2)) ) );
// Remainder bubble request
  gate            gate__FirstAttemptJamRemainder_6(FirstAttemptJamRemainder_6, ((DivState[3:0] == `DIVStateGenRemainder     ) & (JamQuotient_8 | ~DualResDiv)) | 
                                  ((DivState[3:0] == `DIVStateBroadcastQuotient) &  JamQuotient_8               ) );

  gate            gate__AttemptJamQuotient_6(AttemptJamQuotient_6,  FirstAttemptJamQuotient_6  | ReattemptJamQuotient);
  gate            gate__AttemptJamRemainder_6(AttemptJamRemainder_6, FirstAttemptJamRemainder_6 | ReattemptJamRemainder);

  gate            gate__DivBubbleQuotient_6(DivBubbleQuotient_6,  AttemptJamQuotient_6  & ~MulBubbleNoLateCancel_6);
  gate            gate__DivBubbleRemainder_6(DivBubbleRemainder_6, AttemptJamRemainder_6 & ~MulBubbleNoLateCancel_6);
  gate            gate__DivBubble_6(DivBubble_6, DivBubbleQuotient_6 | DivBubbleRemainder_6);



// including DivideByZero_d1 since FinalRemainder can be X in the DivisorZero case
// Fixup only valid during BroadcastQuotient               
  gate            gate__FixupNeeded(FixupNeeded, (DivState[3:0] == `DIVStateBroadcastQuotient) & ~DivideByZero_d1 & 
                   (((DividendSign ^ FRemSign_d1) & ~FinalRemainderIsZero_d1) | FinalRemainderIsDivisor_d1) );

always @* 
begin
    //
    //   Sign of  Sign of  Sign of         Quotient Select   (assuming Rem!=0)         Normal Fixup            Fixup if
    //  Dividend  Divisor  Remainder     Rem!=Divisor     Rem==Divisor (in magnitude)   SignDividend!=SignRemainder    Divisor==Remainder   Fixup Action
    //     0        0        0             Q                QP              0               1       -D  (Rem will be zero)
    //     0        0        1             QM               QM              1               x       +D
    //     0        1        0             Q                QM              0               1       +D  (Rem will be zero)
    //     0        1        1             QP               QP              1               x       -D
    //     1        0        0             QP               QP              1               x       -D
    //     1        0        1             Q                QM              0               1       +D  (Rem will be zero)
    //     1        1        0             QM               QM              1               x       +D
    //     1        1        1             Q                QP              0               1       -D  (Rem will be zero)
    //

    if      (~(DivisorSign ^ FRemSign_d1) & FixupNeeded) Quotient[63:0] = QP[63:0];
    else if ( (DivisorSign ^ FRemSign_d1) & FixupNeeded) Quotient[63:0] = QM[63:0];
    else                                                 Quotient[63:0] = Q[63:0];
    
    
    case (DivisorSize[1:0])
      // only one ResBus broadcast for 8-bit, so no 8-bit mux leg needed in BroadcastQuotient state
      `DivisorSize16 : QuotientRes[63:0] = {MergeDataA[63:16], Quotient[15:0]};
      `DivisorSize32 : QuotientRes[63:0] =             {32'b0, Quotient[31:0]};     
      `DivisorSize64 : QuotientRes[63:0] =                     Quotient[63:0] ;
      default        : QuotientRes[63:0] =                     64'bx ;  //! TRUE_DEFAULT
    endcase

    case (DivisorSize[1:0]) 
      `DivisorSize8  : RemainderRes[63:0] = {MergeDataB[63:16], XH[7:0], MergeDataA[7:0]};  // both quotient and remainder broadcast in BroadcastRemainder state for 8-bit datasize
      `DivisorSize16 : RemainderRes[63:0] = {MergeDataB[63:16], XH[15:0]};
      `DivisorSize32 : RemainderRes[63:0] =             {32'b0, XH[31:0]};     
      `DivisorSize64 : RemainderRes[63:0] =                     XH[63:0] ;
      default        : RemainderRes[63:0] =                     64'bx ;  //! TRUE_DEFAULT
    endcase
    
    case (1'b1)
      (DivState[3:0] == `DIVStateBroadcastQuotient)  : DivResBus_9[63:0] = QuotientRes[63:0];  
      (DivState[3:0] == `DIVStateBroadcastRemainder) : DivResBus_9[63:0] = RemainderRes[63:0];
      default                                        : DivResBus_9[63:0] = 64'b0; //! TRUE_DEFAULT             // forcing zero to prevent toggling every cycle and wasting power
    endcase
   
end // always @*


  gate #(5,0)     gate__DivFlags_9__5_0(DivFlags_9[5:0], 6'b000100);



// insert gate for d input : +++++ etl1 (InitialIterationCount[6:0], RCLK_DIVStatePrescaleDivisor_AR, IterationCountNext[6:0]);
  gate #(6,0)     gate__InitialIterationCount_eve__6_0(InitialIterationCount_eve[6:0],IterationCountNext[6:0]);
  etl1 #(6,0)     etl1__InitialIterationCount__6_0(.q(InitialIterationCount[6:0]), .clk(RCLK_DIVStatePrescaleDivisor_AR), .d(InitialIterationCount_eve[6:0]), .SDO(SDO_0063[6:0]), .SDI({SDO_0062, SDO_0063[6:0+1]}), .SSE(SSE));

//! unused InitialIterationCount[6:0]
   
always @* 
begin
    // Since most of out performance gain is from moving Divides from ucode to fastpath, the feeling is that there's
    // not much to gain by optimizing the path of detecting quotient too large early and skip the iteration steps.

    // determining Quotient Too Large isnt so easy.  Iteration counts arent exact since the first iteration could be 0 or -1 (so that leading zeros for a positive quotient, or leading ones of a
    // negative quotient shouldnt be counted (and can left shift out of the quotient register without a problem).  Additionally, in the negative dividend case, if we need to fixup
    // and we always chose q=+3, then the QP register is all zero when it really should be a 1 and all zeros.  This could cross the quotient size boundry.

    // If Divisor is zero, we skip PrescaleDivisor and thus, InitialIterationCount and NumQuotientBits_d1 are undefined.   
    // ova forbid_bool ((DivState[3:0] == `DIVStateBroadcastQuotient) & ~DivideByZero_d1 & 
    // ova              ~QuotientTooLarge_9 & ((InitialIterationCount[6:0] * 7'd2) > (NumQuotientBits_d1[6:0] + 7'd2)),
    // ova              "Divide error: Iteration count *2 shouldnt be greater than the number of quotient bits without asserting QuotientTooLarge!");

    // Can observe the results in the Q, QM, and QP registers for overflow.  We can iterate once beyond the number
    // of quotient bits calculated, hence why we look at bits MSB+1 and MSB+2.  We also look at bit MSB+3
    // for the sign.  (example: in 8-bit case, MSB is 7, bits 9:8 hold the extra iteration results, and bit 10 is the sign.)
    case (DivisorSize[1:0])
    // FIXME XPROP
      `DivisorSize8  : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&Q[9:7])   : ((|Q[10:8])  | (Q[7]  & SignedDiv)));
      `DivisorSize16 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&Q[17:15]) : ((|Q[18:16]) | (Q[15] & SignedDiv)));
      `DivisorSize32 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&Q[33:31]) : ((|Q[34:32]) | (Q[31] & SignedDiv)));
      `DivisorSize64 : QuotientTooLargeQOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&Q[65:63]) : ((|Q[66:64]) | (Q[63] & SignedDiv)));
      default        : QuotientTooLargeQOverflow = 1'bx;  //! TRUE_DEFAULT
    endcase

    case (DivisorSize[1:0])
    // FIXME XPROP
      `DivisorSize8  : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&QP[9:7])   : (|QP[10:8]  | (QP[7]  & SignedDiv)));
      `DivisorSize16 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&QP[17:15]) : (|QP[18:16] | (QP[15] & SignedDiv)));
      `DivisorSize32 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&QP[33:31]) : (|QP[34:32] | (QP[31] & SignedDiv)));
      `DivisorSize64 : QuotientTooLargeQpOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&QP[65:63]) : (|QP[66:64] | (QP[63] & SignedDiv)));
      default        : QuotientTooLargeQpOverflow = 1'bx;  //! TRUE_DEFAULT
    endcase

    case (DivisorSize[1:0])
    // FIXME XPROP
      `DivisorSize8  : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd8)   | ((DividendSign ^ DivisorSign) ? ~(&QM[9:7])  : (|QM[10:8])  | (QM[7]  & SignedDiv));
      `DivisorSize16 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd16)  | ((DividendSign ^ DivisorSign) ? ~(&QM[17:15]): (|QM[18:16]) | (QM[15] & SignedDiv));
      `DivisorSize32 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd32)  | ((DividendSign ^ DivisorSign) ? ~(&QM[33:31]): (|QM[34:32]) | (QM[31] & SignedDiv));
      `DivisorSize64 : QuotientTooLargeQmOverflow = (NumQuotientBits_d1[6:0] > 7'd64)  | ((DividendSign ^ DivisorSign) ? ~(&QM[65:63]): (|QM[66:64]) | (QM[63] & SignedDiv));
      default        : QuotientTooLargeQmOverflow = 1'bx;  //! TRUE_DEFAULT
    endcase

    // This is only valid during BroadcastQuotient (via FixupNeeded)
    // FIXME XPROP
    QuotientTooLargeOverflow =  (~(DivisorSign ^ FRemSign_d1) & FixupNeeded) ? QuotientTooLargeQpOverflow_d1 :
                                ( (DivisorSign ^ FRemSign_d1) & FixupNeeded) ? QuotientTooLargeQmOverflow_d1 :
                                QuotientTooLargeQOverflow_d1;
    
    // a quotient of zero can be the result of opposite signed dividend and divisor, hence need to squash with NoIterate.
    // can also iterate once with a quotient of zero.  NoIterate and IterateOnce are needed here in case we generate a quotient of zero
    // but expected a negative quotient.  In that case, we inspect the upper bits of the Q* registers for any 0s to determine overflow,
    // but a quotient of zero is all zeros, so that would be a false assert by QuotientTooLargeOverflow.
    QuotientTooLarge_9 = (DivState[3:0] == `DIVStateBroadcastQuotient) & QuotientTooLargeOverflow & ~NoIterate & ~IterateOnce;
end // always @ *



// replace with mux2e, etl1 : +++++ etl1mux2e (QuotientTooLargeQpOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQpOverflow, QuotientTooLargeQpOverflow_d1);

// insert gate for sel input : +++++ etl1mux2e (QuotientTooLargeQpOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQpOverflow, QuotientTooLargeQpOverflow_d1);
  gate            gate__QuotientTooLargeQpOverflow_d1_intmux_sel(QuotientTooLargeQpOverflow_d1_intmux_sel,(DivState[3:0] != `DIVStateIdle));
  mux2e            mux2e__QuotientTooLargeQpOverflow_d1_intmux(QuotientTooLargeQpOverflow_d1_intmux, QuotientTooLargeQpOverflow_d1_intmux_sel, QuotientTooLargeQpOverflow, QuotientTooLargeQpOverflow_d1);

// insert gate for d input : +++++ etl1mux2e (QuotientTooLargeQpOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQpOverflow, QuotientTooLargeQpOverflow_d1);
  gate            gate__QuotientTooLargeQpOverflow_d1_eve(QuotientTooLargeQpOverflow_d1_eve,QuotientTooLargeQpOverflow_d1_intmux);
  etl1            etl1__QuotientTooLargeQpOverflow_d1(.q(QuotientTooLargeQpOverflow_d1), .clk(RCLK_DivState_AR), .d(QuotientTooLargeQpOverflow_d1_eve), .SDO(SDO_0064), .SDI(SDO_0063[0]), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (QuotientTooLargeQmOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQmOverflow, QuotientTooLargeQmOverflow_d1);

// insert gate for sel input : +++++ etl1mux2e (QuotientTooLargeQmOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQmOverflow, QuotientTooLargeQmOverflow_d1);
  gate            gate__QuotientTooLargeQmOverflow_d1_intmux_sel(QuotientTooLargeQmOverflow_d1_intmux_sel,(DivState[3:0] != `DIVStateIdle));
  mux2e            mux2e__QuotientTooLargeQmOverflow_d1_intmux(QuotientTooLargeQmOverflow_d1_intmux, QuotientTooLargeQmOverflow_d1_intmux_sel, QuotientTooLargeQmOverflow, QuotientTooLargeQmOverflow_d1);

// insert gate for d input : +++++ etl1mux2e (QuotientTooLargeQmOverflow_d1, RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQmOverflow, QuotientTooLargeQmOverflow_d1);
  gate            gate__QuotientTooLargeQmOverflow_d1_eve(QuotientTooLargeQmOverflow_d1_eve,QuotientTooLargeQmOverflow_d1_intmux);
  etl1            etl1__QuotientTooLargeQmOverflow_d1(.q(QuotientTooLargeQmOverflow_d1), .clk(RCLK_DivState_AR), .d(QuotientTooLargeQmOverflow_d1_eve), .SDO(SDO_0065), .SDI(SDO_0064), .SSE(SSE));

// replace with mux2e, etl1 : +++++ etl1mux2e (QuotientTooLargeQOverflow_d1 , RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQOverflow , QuotientTooLargeQOverflow_d1 );

// insert gate for sel input : +++++ etl1mux2e (QuotientTooLargeQOverflow_d1 , RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQOverflow , QuotientTooLargeQOverflow_d1 );
  gate            gate__QuotientTooLargeQOverflow_d1_intmux_sel(QuotientTooLargeQOverflow_d1_intmux_sel,(DivState[3:0] != `DIVStateIdle));
  mux2e            mux2e__QuotientTooLargeQOverflow_d1_intmux(QuotientTooLargeQOverflow_d1_intmux, QuotientTooLargeQOverflow_d1_intmux_sel, QuotientTooLargeQOverflow , QuotientTooLargeQOverflow_d1 );

// insert gate for d input : +++++ etl1mux2e (QuotientTooLargeQOverflow_d1 , RCLK_DivState_AR, (DivState[3:0] != `DIVStateIdle), QuotientTooLargeQOverflow , QuotientTooLargeQOverflow_d1 );
  gate            gate__QuotientTooLargeQOverflow_d1_eve(QuotientTooLargeQOverflow_d1_eve,QuotientTooLargeQOverflow_d1_intmux);
  etl1            etl1__QuotientTooLargeQOverflow_d1(.q(QuotientTooLargeQOverflow_d1) , .clk(RCLK_DivState_AR), .d(QuotientTooLargeQOverflow_d1_eve), .SDO(SDO_0066), .SDI(SDO_0065), .SSE(SSE));


// Detect divider errors resulting from DivideByZero or QuotientTooLarge.
// Reset DivError in PrescaleCountDividend state. Evaluate errors in BroadcastQuotient state. Feedback rest of the time.

// replace with mux2e, etl1 : +++++ etl1mux2e (DivError_d1, RCLK_DivState_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend) |    // reset

// insert gate for sel input : +++++ etl1mux2e (DivError_d1, RCLK_DivState_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend) |    // reset
  gate            gate__DivError_d1_intmux_sel(DivError_d1_intmux_sel,(DivState[3:0] == `DIVStatePrescaleCountDividend) |    // reset
                                          (DivState[3:0] == `DIVStateBroadcastQuotient));
  mux2e            mux2e__DivError_d1_intmux(DivError_d1_intmux, DivError_d1_intmux_sel,         // detect errors
                                          DivError_9 & ~(DivState[3:0] == `DIVStatePrescaleCountDividend), 
                                          DivError_d1);

// insert gate for d input : +++++ etl1mux2e (DivError_d1, RCLK_DivState_AR, (DivState[3:0] == `DIVStatePrescaleCountDividend) |    // reset
  gate            gate__DivError_d1_eve(DivError_d1_eve,DivError_d1_intmux);
  etl1            etl1__DivError_d1(.q(DivError_d1), .clk(RCLK_DivState_AR), .d(DivError_d1_eve), .SDO(SDO_0067), .SDI(SDO_0066), .SSE(SSE));
  gate            gate__DivError_9(DivError_9, DivideByZero_d1 | QuotientTooLarge_9 | DivError_d1);


// FIXME DAN: tighten free-running flops here and elsewhere

// for timing reason

// insert gate for d input : +++++ etl1 (MulBubbleNoLateCancel_7, RCLK_ExDivFree_AR, MulBubbleNoLateCancel_6);
  gate            gate__MulBubbleNoLateCancel_7_eve(MulBubbleNoLateCancel_7_eve,MulBubbleNoLateCancel_6);
  etl1            etl1__MulBubbleNoLateCancel_7(.q(MulBubbleNoLateCancel_7), .clk(RCLK_ExDivFree_AR), .d(MulBubbleNoLateCancel_7_eve), .SDO(SDO_0068), .SDI(SDO_0067), .SSE(SSE));


// insert gate for d input : +++++ etl1 (AttemptJamQuotient_7,    RCLK_ExDivFree_AR, AttemptJamQuotient_6);
  gate            gate__AttemptJamQuotient_7_eve(AttemptJamQuotient_7_eve,AttemptJamQuotient_6);
  etl1            etl1__AttemptJamQuotient_7(.q(AttemptJamQuotient_7),    .clk(RCLK_ExDivFree_AR), .d(AttemptJamQuotient_7_eve), .SDO(SDO_0069), .SDI(SDO_0068), .SSE(SSE));

// insert gate for d input : +++++ etl1 (AttemptJamRemainder_7,   RCLK_ExDivFree_AR, AttemptJamRemainder_6); 
  gate            gate__AttemptJamRemainder_7_eve(AttemptJamRemainder_7_eve,AttemptJamRemainder_6);
  etl1            etl1__AttemptJamRemainder_7(.q(AttemptJamRemainder_7),   .clk(RCLK_ExDivFree_AR), .d(AttemptJamRemainder_7_eve), .SDO(SDO_0070), .SDI(SDO_0069), .SSE(SSE));

// insert gate for d input : +++++ etl1 (JamQuotient_8,           RCLK_ExDivFree_AR, AttemptJamQuotient_7  & ~MulBubbleNoLateCancel_7);
  gate            gate__JamQuotient_8_eve(JamQuotient_8_eve,AttemptJamQuotient_7  & ~MulBubbleNoLateCancel_7);
  etl1            etl1__JamQuotient_8(.q(JamQuotient_8),           .clk(RCLK_ExDivFree_AR), .d(JamQuotient_8_eve), .SDO(SDO_0071), .SDI(SDO_0070), .SSE(SSE));

// insert gate for d input : +++++ etl1 (JamRemainder_8,          RCLK_ExDivFree_AR, AttemptJamRemainder_7 & ~MulBubbleNoLateCancel_7);
  gate            gate__JamRemainder_8_eve(JamRemainder_8_eve,AttemptJamRemainder_7 & ~MulBubbleNoLateCancel_7);
  etl1            etl1__JamRemainder_8(.q(JamRemainder_8),          .clk(RCLK_ExDivFree_AR), .d(JamRemainder_8_eve), .SDO(SDO_0072), .SDI(SDO_0071), .SSE(SSE));

// insert gate for d input : +++++ etl1 (ReattemptJamRemainder,   RCLK_ExDivFree_AR, ~FR_Abort_11 & ((FirstAttemptJamRemainder_6 & MulBubbleNoLateCancel_6) |
  gate            gate__ReattemptJamRemainder_eve(ReattemptJamRemainder_eve,~FR_Abort_11 & ((FirstAttemptJamRemainder_6 & MulBubbleNoLateCancel_6) |
                                                                  (ReattemptJamRemainder      & MulBubbleNoLateCancel_6) ));
  etl1            etl1__ReattemptJamRemainder(.q(ReattemptJamRemainder),   .clk(RCLK_ExDivFree_AR), .d(ReattemptJamRemainder_eve), .SDO(SDO_0073), .SDI(SDO_0072), .SSE(SSE));

// Reattempt to steal bus if we had attempted to steal the previous cycle, but MulSteal1 was asserted as well
//gate (ReattemptJamQuotient, ~FR_Abort_11 & AttemptJamQuotient_7 & MulBubbleNoLateCancel_7);

// insert gate for d input : +++++ etl1 (ReattemptJamQuotient,    RCLK_ExDivFree_AR, ~FR_Abort_11 & ((FirstAttemptJamQuotient_6 & MulBubbleNoLateCancel_6) |
  gate            gate__ReattemptJamQuotient_eve(ReattemptJamQuotient_eve,~FR_Abort_11 & ((FirstAttemptJamQuotient_6 & MulBubbleNoLateCancel_6) |
                                                                  (ReattemptJamQuotient      & MulBubbleNoLateCancel_6) ));
  etl1            etl1__ReattemptJamQuotient(.q(ReattemptJamQuotient),    .clk(RCLK_ExDivFree_AR), .d(ReattemptJamQuotient_eve), .SDO(SDO_0074), .SDI(SDO_0073), .SSE(SSE));


// insert gate for d input : +++++ etl1 (JamQuotient_9,           RCLK_ExDivFree_AR, JamQuotient_8  & ~FR_Abort_11);
  gate            gate__JamQuotient_9_eve(JamQuotient_9_eve,JamQuotient_8  & ~FR_Abort_11);
  etl1            etl1__JamQuotient_9(.q(JamQuotient_9),           .clk(RCLK_ExDivFree_AR), .d(JamQuotient_9_eve), .SDO(SDO_0075), .SDI(SDO_0074), .SSE(SSE));

// insert gate for d input : +++++ etl1 (JamRemainder_9,          RCLK_ExDivFree_AR, JamRemainder_8 & ~FR_Abort_11);
  gate            gate__JamRemainder_9_eve(JamRemainder_9_eve,JamRemainder_8 & ~FR_Abort_11);
  etl1            etl1__JamRemainder_9(.q(JamRemainder_9),          .clk(RCLK_ExDivFree_AR), .d(JamRemainder_9_eve), .SDO(SDO_0076), .SDI(SDO_0075), .SSE(SSE));
                       

// Divider Busy indication
// Generate all but the first divider busy indications here.  The first possible divider busy indication to the ALU1 scheduler
// is necessarily generated in EX in _8 (before the divider execution starts).  The remaining divider busy cycles are generated here.
// Asserted on div8 or divh issue.  divl (LoDbl) issue has no effect on busy - it's up to the scheduler to follow divl issue with divh issue.

// insert gate for d input : +++++ etl1 (MostDivBusy_9, RCLK_ExDivFree_AR, ((DivIssueDiv8Divh_8 & ~DivLateCancel_8) | MostDivBusy_9)          &   // set on div8/divh issue
  gate            gate__MostDivBusy_9_eve(MostDivBusy_9_eve,((DivIssueDiv8Divh_8 & ~DivLateCancel_8) | MostDivBusy_9)          &   // set on div8/divh issue
                                        ~((DivState[3:0] == `DIVStateBroadcastRemainder) & JamRemainder_9) &   // clear at normal end of divide
                                        ~FR_Abort_11                                                       );
  etl1            etl1__MostDivBusy_9(.q(MostDivBusy_9), .clk(RCLK_ExDivFree_AR), .d(MostDivBusy_9_eve), .SDO(SDO_0077), .SDI(SDO_0076), .SSE(SSE));

endmodule

