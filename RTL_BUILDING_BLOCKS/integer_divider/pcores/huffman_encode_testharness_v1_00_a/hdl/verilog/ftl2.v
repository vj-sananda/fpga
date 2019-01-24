//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: ftl2.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// Phi2 transparent latch.
//=======================================================================

`timescale 1ps/1ps

// BOZO - only putting this to workaround a bug in Leda
// leda NTL_STR33 off

module ftl2(dout, clk, din);

parameter upper=0, lower=0; // default width of output
parameter width = upper - lower + 1;

output [upper:lower] dout;  // data out
input                clk;   // clock
input  [upper:lower] din;   // data in

reg    [upper:lower] dout_pre;
wire   [upper:lower] dout;


// avoid "non-blocking" assignments warning in conv'ed blocks
// @hdl ichecks_off 68
// leda SYN9_5 off
// leda W410 off
// leda FM_2_15 off
// XPROP_IF2 is the old name for the Leda rule. XPROP_IF2FFd is the new name for this particular violation. Keep both just to be able to use either leda version
// leda XPROP_IF2 off
// leda XPROP_IF2FFd off
//! latch
always @*
    if (~clk) 
        dout_pre[upper:lower] <= din[upper:lower];

assign dout[upper:lower] = dout_pre[upper:lower];

// leda SYN9_5 on
// leda W410 on
// leda FM_2_15 on
// leda XPROP_IF2FFd on
// leda XPROP_IF2 on
// @hdl ichecks_on

endmodule

// leda NTL_STR33 on

