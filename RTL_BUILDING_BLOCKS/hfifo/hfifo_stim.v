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
module hfifo_stim( SYSTEM_CLOCK, LED_0,LED_1,LED_2,LED_3);

   input SYSTEM_CLOCK ;
   
   output LED_0 ;
   output LED_1 ;
   output LED_2 ;
   output LED_3 ;
   
   reg [3:0] count ;
   reg [3:0] din ;
   wire [3:0] dout ;
   reg 	      push ;
   reg 	      pop ;
   wire       rdy ;
   wire       not_full ;
   reg 	      RESET ;
   
   assign     LED_0 = dout[0] ;
   assign     LED_1 = dout[1] ;
   assign     LED_2 = dout[2] ;
   assign     LED_3 = dout[3] ;
   
   hfifo dut ( .push(push),
	       .pop(pop),
	       .rdy(rdy),
	       .not_full(not_full),
	       .clk(SYSTEM_CLOCK),
	       .reset(RESET),
	       .din(din),
	       .dout(dout)
	       );
   
   //Divide by 100,000,000 clk enable
   reg 	      clk_enable ;
   reg [7:0]  div_count ;
   always @(posedge SYSTEM_CLOCK)
     begin
	clk_enable <= 0 ;
	div_count <= div_count+1 ;
	if (div_count >= 8'h7f) 
	  begin
	     clk_enable <= 1;
	     div_count <= 0 ;
	  end
     end

   always @(posedge SYSTEM_CLOCK)
     count <= count + 1 ;
   
   always @(posedge SYSTEM_CLOCK)
     begin
	RESET <= 1 ;
	if (clk_enable == 1'b1 | RESET==1'b0 )
			RESET <= 0 ;
     end
   
   reg state ;
   always @(posedge SYSTEM_CLOCK )
     begin
	push <= 0 ;
	pop <= 0;
	
	case(state)
	  1'b0:
	    if (not_full)
	      begin
		 push <= 1 ;
		 din <= count ;
	      end
	    else
	      state <= 1 ;
	  
	  1'b1:
	    if (rdy)
	      pop <= 1;
	    else
	      state <= 0;
	endcase
	
     end
   
endmodule
