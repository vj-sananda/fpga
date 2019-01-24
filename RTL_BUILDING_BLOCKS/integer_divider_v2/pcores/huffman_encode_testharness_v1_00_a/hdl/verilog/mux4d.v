//======================================================================
//                       Bobcat RTL design file
//=======================================================================
//                  AMD PROPRIETARY AND CONFIDENTIAL
//           (c) Copyright 2007 Advanced Micro Devices, Inc.
//=======================================================================
// File Id and RCS Info:
// $Id: mux4d.v,v 1.1 2010/12/08 22:14:14 vsananda Exp $
// $Change: 41975 $
//=======================================================================
// Module Description:
// AND/OR multiplexor with one-hot selects.  
// Zero-hot selects produces a zero output.
//=======================================================================

`timescale 1ps/1ps

module mux4d (dout,
              sel0, in0, 
              sel1, in1, 
              sel2, in2, 
              sel3, in3);

parameter upper = 0;
parameter lower = 0; 
parameter width = upper-lower+1;  // default width of output
   
output [upper:lower] dout;  // data out
reg    [upper:lower] dout;
input                sel0;  // selects
input                sel1;
input                sel2;
input                sel3;
input  [upper:lower] in0;   // data inputs
input  [upper:lower] in1;
input  [upper:lower] in2;
input  [upper:lower] in3;


always @*
    case (^{sel0,sel1,sel2,sel3})
      1'b0, 1'b1:  dout[upper:lower] = ({width{sel0}} & in0[upper:lower]) | 
                                       ({width{sel1}} & in1[upper:lower]) | 
                                       ({width{sel2}} & in2[upper:lower]) | 
                                       ({width{sel3}} & in3[upper:lower]) ;
      default:     dout[upper:lower] = {width{1'bx}};
    endcase

endmodule

