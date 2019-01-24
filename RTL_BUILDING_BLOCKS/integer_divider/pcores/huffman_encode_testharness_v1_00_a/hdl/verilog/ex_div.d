//=======================================================================
//                     Jaguar RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2010 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: ex_div.d,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change$
//=======================================================================
// Module Description:
// defines for ex_div.x hardware integer divider
//=======================================================================

`ifndef _EX_DIV_D_
`define _EX_DIV_D_

// FIXME DAN: I don't like the multiple names per single state value at all!
`define DIVStateIdle                   4'd0
`define DIVStateDualScheduled          4'd1   // added for JG, asserted after DivIssue2_8 until DivIssue1_8 comes for Dual result
`define DIVStatePrescaleCountDividend  4'd2
`define DIVStatePrescaleConcatPrep     4'd0   // during Idle, prep the shifter counts to concat
`define DIVStatePrescaleConcat         4'd2   // during PrescaleCountDividend, if we are 16 or 32 bit datasize,
                                              // left align the lower half so that it concatenates with the
                                              // upper half before prescale shift.
`define DIVStatePrescaleDividend       4'd3 
`define DIVStatePrescaleCountDivisor   4'd4   // this does not exist in new rtl
`define DIVStatePrescaleDivisor        4'd5
`define DIVStateIterate                4'd6
`define DIVStatePauseForSteal          4'd7
`define DIVStateGenRemainder           4'd8
`define DIVStateBroadcastQuotient      4'd9
`define DIVStateFixupRemainder         4'd9   // Fixup Remainder during BroadcastQuotient
`define DIVStatePostscaleRemainder     4'd10
`define DIVStateBroadcastRemainder     4'd11

// DivisorSize definitions
`define DivisorSize8   2'b00
`define DivisorSize16  2'b01
`define DivisorSize32  2'b10
`define DivisorSize64  2'b11


`endif   // `ifndef _EX_DIV_D_
