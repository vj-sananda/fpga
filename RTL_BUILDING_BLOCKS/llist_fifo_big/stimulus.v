`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    00:28:13 05/30/05
// Design Name:    
// Module Name:    stimulus
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
module stimulus( SYSTEM_CLOCK, LED_0, LED_1,LED_2,LED_3 );

   input SYSTEM_CLOCK ;

   output LED_0 ;
   output LED_1 ;
   output LED_2 ;
   output LED_3 ;
   wire   LED_0,LED_1,LED_2,LED_3 ;
   
   reg 	     alloc_req ;
   reg 	     dealloc_req ;

   reg 	     RESET ;
   
   wire      alloc_ack ;
   wire      dealloc_ack ;
   wire      init_done ;

   wire [15:0] alloc_id ;
   reg [15:0]  dealloc_id ;
   
   // -----------------------------------------------
   //RESET GENERATOR
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
     begin
	RESET <= 1 ;
	if (clk_enable == 1'b1 | RESET==1'b0 )
	  RESET <= 0 ;
     end
   // -----------------------------------------------   
   
   reg  [15:0] din ;
   wire [15:0] dout ;   
   reg 	      push ;
   reg 	      pop ;
   
   hfifo dealloc_fifo ( .push(push),
			.pop(pop),
			.rdy(rdy),
			.not_full(not_full),
			.clk(SYSTEM_CLOCK),
			.reset(RESET),
			.din(din),
			.dout(dout)
			);

   reg 	      wait_for_dealloc_ack ;
   //Dealloc process
   always @(posedge SYSTEM_CLOCK)
     begin
	pop <= 0 ;
	dealloc_req <= 0;

	if ( rdy == 1'b1 && ~wait_for_dealloc_ack )
	  pop <= 1 ;
	
	if ( pop )
	  begin
	     dealloc_id <= dout ;
	     dealloc_req <= 1 ;
	     wait_for_dealloc_ack <= 1;
	  end

	if (wait_for_dealloc_ack & dealloc_ack)
	  wait_for_dealloc_ack <= 0 ;
     end

   reg 	      wait_for_alloc_ack ;
   //Alloc process
   always @(posedge SYSTEM_CLOCK )
     begin
	push <= 0 ;
	alloc_req <= 0 ;

	if (not_full & ~wait_for_alloc_ack & init_done)
	  begin
	     alloc_req <= 1 ;
	     wait_for_alloc_ack <= 1 ;
	  end

	if (wait_for_alloc_ack & alloc_ack)
	  begin
	     push <= 1 ;
	     din <= alloc_id ;
	     wait_for_alloc_ack <= 0;
	  end
     end
   
   assign LED_0 = init_done ;
   assign LED_1 = ~wait_for_alloc_ack;
   assign LED_2 = ~wait_for_dealloc_ack ;
   assign LED_3 = ~RESET ;
   
   flist dut (
	      // Outputs
	      .alloc_ack(alloc_ack), 
	      .dealloc_ack(dealloc_ack),
	      .alloc_id(alloc_id),
	      .init_done(init_done),
	      // Inputs
	      .clk(SYSTEM_CLOCK), 
	      .rst(RESET),
	      .alloc_req(alloc_req),	
	      .dealloc_req(dealloc_req),
	      .dealloc_id(dealloc_id)
	      );
   
endmodule
