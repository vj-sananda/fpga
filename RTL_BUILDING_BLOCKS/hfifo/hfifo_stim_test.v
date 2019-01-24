`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    11:43:46 05/30/05
// Design Name:    
// Module Name:    hfifo_stim
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hfifo_stim_test ;

reg clk ;

initial
   clk = 0 ;
always
  #5 clk = ~clk ;

   hfifo_stim stim ( .SYSTEM_CLOCK(clk) );

   initial
     begin
	stim.div_count = 0;
	stim.count = 0;
	stim.state = 0;
	stim.push = 0;
	stim.pop = 0;
     end
   
endmodule
