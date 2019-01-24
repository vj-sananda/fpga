//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: com1.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// Behavioral models for a phi1 clock gater.
//=======================================================================

`timescale 1ps/1ps


module com1a(cond_clk, clk, condition, SSE);

output  cond_clk;       // conditional (gated) clock
input   clk;            // clock
input   condition;      // condition - must be high for output clock to pulse.
                        // condition is sampled only while input clock is low.
input   SSE;            // scan shift enable


`ifdef GUTS_TEST
// ***************************************************************
// for GUTS synthesis

// TSMC clock gater
CKLNQD8BWP com_clk_gate (.Q(cond_clk), .CP(clk), .E(condition), .TE(SSE));


`else // GUTS_TEST

wire    IQ;
wire    cond_clk;

ftl2 com_lat (.dout(IQ), .clk(clk), .din(condition | SSE));

assign cond_clk = clk & IQ;

`endif  // GUTS_TEST


endmodule

