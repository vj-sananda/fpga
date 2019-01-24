`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:28:13 05/30/05
// Design Name:    
// Module Name:    stimulus_test
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
module stimulus_test ;
   
   reg clk ;

   initial
     begin
	clk = 0 ;
	stim.wait_for_alloc_ack = 0;
	stim.wait_for_dealloc_ack = 0;
	stim.div_count = 0;
     end
     
   always
     #5 clk = ~clk ;
   
   stimulus stim ( .SYSTEM_CLOCK(clk) );
   
endmodule
