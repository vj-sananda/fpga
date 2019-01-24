`timescale 1ns/1ns
/*
 Purpose:
 Pop 64 bit words from opb fifo
 Assemble into 128 bit word for consumption by
 master state machine
 */

`define init   2'd0
`define stage1 2'd1
`define stage2 2'd2

module fifo_rd_64_to_128 ( /*AUTOARG*/
   // Outputs
   odata, pop, o_rdy,
   // Inputs
   idata, i_rdy, clk, reset, pull
   ) ;

   parameter i_r_width=64 ; //input data width
   parameter o_r_width=128 ; //output data width   
   
   input [i_r_width-1:0] idata ;
   input 		 i_rdy;
   input 		 clk,reset ;
   input 		 pull ;
   
   output [o_r_width-1:0] odata ;
   output 		  pop ;
   output 		  o_rdy ;
   
   reg [o_r_width-1:0] 	odata_wd , odata_rd ;
   reg 			o_rdy_wc , o_rdy_rc ;
   reg 			pop_rc,pop_wc;
   
   //Wire assigns for outputs
   wire 		pop = pop_wc ;
   wire [o_r_width-1:0] odata = odata_rd ;
   wire 		o_rdy = o_rdy_wc;

   //Local var
   reg [1:0] fsm_cs, fsm_ns;

   always @(posedge clk or posedge reset)
     if (reset)
       begin
	  pop_rc <= 0;
	  fsm_cs <= `init ;
	  o_rdy_rc <= 0 ;
	  odata_rd <= 0;
       end
     else
       begin
	  fsm_cs <= fsm_ns ;
	  pop_rc <= pop_wc ;
	  odata_rd <= odata_wd ;
	  o_rdy_rc <= o_rdy_wc ;
       end

   //Algo
   //1. Pop 4 words from Fifo
   //2. Assert o_rdy
   //3. Wait for pull , goto (1)
   
   always @(/*autosense*/
	    fsm_cs or i_rdy or idata or odata_rd or pull)
     begin
	
	fsm_ns = fsm_cs ;
	pop_wc = 0;
	o_rdy_wc = 0;
	
	//Hold values
	odata_wd = odata_rd ;
	
	case ( fsm_cs )
	  `init:
	    if ( i_rdy  )
	      begin
		 odata_wd[127:64] = idata ;
		 fsm_ns = `stage1 ;
		 pop_wc = 1 ;
	      end

	  `stage1:
	    begin
	       if ( i_rdy  )
		 begin
		    fsm_ns = `stage2 ;
		    pop_wc = 1 ;
		    odata_wd[63:0] = idata ;		    
		 end
	    end

	  `stage2:
	    begin
	       o_rdy_wc = 1;
	       if ( pull )
		 fsm_ns = `init ;
	    end

	  default:fsm_ns = `init ;
	  
	endcase // case ( fsm_cs )
     end

endmodule // fifo_rd_64_to_128
