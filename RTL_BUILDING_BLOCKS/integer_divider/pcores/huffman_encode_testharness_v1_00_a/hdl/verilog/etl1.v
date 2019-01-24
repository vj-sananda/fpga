//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: etl1.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// Behavioral models for Mux-D rising edge flop, scan toggle reset to zero.
//=======================================================================

`timescale 1ps/1ps


module etl1(q, clk, d, SDO, SDI, SSE);

parameter upper=0, lower=0; // default width of output
parameter width = upper - lower + 1;

output [upper:lower] q;     // data out
input                clk;   // clock
input  [upper:lower] d;     // data in
output [upper:lower] SDO;   // scan data out  -- FIXME DAN: REMOVE SDO
input  [upper:lower] SDI;   // scan data in
input                SSE;   // scan shift enable 


`ifdef GUTS_TEST
// ***************************************************************
// GUTS synthesis RTL

reg    [upper:lower] q;
wire   [upper:lower] SDO;

always @(posedge clk)
     q[upper:lower] <= d[upper:lower];

assign SDO[upper:lower] = {width{1'b0}};  // FIXME DAN: REMOVE SDO

//! unused SDI
//! unused SSE


`else

// ***************************************************************
// Simulation-only Rising Edge Flop model.

reg    [upper:lower] q;
wire   [upper:lower] SDO;

always @(posedge clk)
    if (SSE)
        q[upper:lower] <= SDI[upper:lower];  // SDI=0 in reset
    else if (~SSE)
        q[upper:lower] <= d[upper:lower];
    else
        q[upper:lower] <= {width{1'bx}};

// FIXME DAN: SDO should be removed, and this whole ifdef pair as well.
`ifdef SCAN_FLOP
assign SDO[upper:lower] = q[upper:lower];
`else 
assign SDO[upper:lower] = SDI[upper:lower];
`endif

`endif  // GUTS_TEST  


endmodule

