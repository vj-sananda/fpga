//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: mux2e.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// AND/OR multiplexor with one-hot selects.  
// Zero-hot selects produces a zero output.
//=======================================================================

`timescale 1ps/1ps

module mux2e (dout, sel, in1, in0);

parameter upper = 0;
parameter lower = 0; 
parameter width = upper-lower+1;  // default width of output
   
output [upper:lower] dout;  // data out
reg    [upper:lower] dout;
input                sel;   // select
input  [upper:lower] in1;   // data inputs
input  [upper:lower] in0;


always @*
    case (sel)
      1'b0, 1'b1:  dout[upper:lower] = ({width{~sel}} & in0[upper:lower]) | 
                                       ({width{ sel}} & in1[upper:lower]) ;
      default:     dout[upper:lower] = {width{1'bx}};
    endcase

endmodule

