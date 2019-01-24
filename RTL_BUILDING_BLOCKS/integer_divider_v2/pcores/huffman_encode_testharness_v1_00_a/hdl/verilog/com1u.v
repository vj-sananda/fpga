//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: com1u.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// Behavioral models for a free running clock gater.
//=======================================================================

`timescale 1ps/1ps


module com1u(outclk, inclk);

output  outclk;       // clock output
input   inclk;        // clock input


`ifdef GUTS_TEST
// ***************************************************************
// for GUTS tests

// TSMC clock gater
CKAN2D8BWP com_clk_gate (.A1(inclk), .A2(1'b1), .Z(outclk));


`else // GUTS_TEST

wire    outclk;
assign  outclk = inclk;

`endif  // GUTS_TEST


endmodule

