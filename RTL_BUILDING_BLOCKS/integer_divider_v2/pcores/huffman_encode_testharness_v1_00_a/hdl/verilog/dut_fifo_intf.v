`timescale 1ns/1ns

module dut_fifo_intf ( /*AUTOARG*/
   // Outputs
   odata, push, pop, 
   // Inputs
   idata, rdy, not_full, clk, reset
   ) ;

   input [31:0] idata ;
   input 		rdy;
   input 		not_full ;
   input 		clk,reset ;
   
   output [31:0] odata ;//packed output data
   output 		push;
   output 		pop ;

   reg [63:0]		Dividend_hi;		// To dut of jg_div_fpga.v
   reg [63:0]		Dividend_lo;		// To dut of jg_div_fpga.v
   reg [63:0]		Divisor;		// To dut of jg_div_fpga.v
   reg			i_valid;		// To dut of jg_div_fpga.v

   wire			DivResult;		// From dut of jg_div_fpga.v
   wire [7:0]		quotient;		// From dut of jg_div_fpga.v
   wire [7:0]		remainder;		// From dut of jg_div_fpga.v
   
   reg [31:0] odata_wd ;//packed output data
   reg [31:0] odata_rd ;//packed output data
   reg [31:0] odata ;
   
   reg 			push_rc;
   reg 			pop_rc ;
   reg 			push_wc;
   reg 			pop_wc ;   

   wire 		push = push_rc ;
   wire 		pop = pop_rc ;

   reg [1:0] fsm_cs, fsm_ns;

   parameter init =  2'd0,
	     stage1 = 2'd1,
	     stage2 = 2'd2,
	     stage3 = 2'd3;

  always @(posedge clk or posedge reset)
     if (reset)
       begin
	  pop_rc <= 0;
	  fsm_cs <= init ;
	  push_rc <= 0;
	  odata_rd <= 0;
       end
     else
       begin
	  fsm_cs <= fsm_ns ;
	  pop_rc <= pop_wc ;
	  push_rc <= push_wc ;
	  odata_rd <= odata_wd ;
       end

   always @*
     begin
	
	fsm_ns = fsm_cs ;
	pop_wc = 0;
	push_wc = 0;
	
	//Hold values
	odata_wd = odata_rd ;
	i_valid = 0;

	Dividend_lo = idata[15:8];
	Divisor = idata[7:0];

	odata = odata_rd;
	
	case ( fsm_cs )

	  init:
	    if ( rdy & not_full )
	      begin
		 fsm_ns = stage1 ;
		 pop_wc = 1 ;
	      end

	  stage1:
	    begin
	       i_valid = 1'b1;
	       fsm_ns = stage2 ;
	    end

	  stage2:
	    begin
	       if ( DivResult )
		 begin
		    odata_wd[7:0] = quotient;
		    odata_wd[15:8] = remainder;

		    if ( not_full )
		      begin
			 push_wc = 1 ;
			 fsm_ns  = init;
		      end
		    else
		      fsm_ns = stage3 ;		    
		 end
	    end // case: stage2

	  stage3:
	    begin
	       if ( not_full )
		 begin
		    push_wc = 1 ;
		    fsm_ns  = init;
		 end
	    end	  

	  default:fsm_ns = init ;
	  
	endcase // case ( fsm_cs )
   
     end // always @ (...
   
   jg_add_fpga dut (
//   jg_div_fpga dut (
		    // Outputs
		    .quotient		(quotient[7:0]),
		    .remainder		(remainder[7:0]),
		    .DivResult		(DivResult),
		    // Inputs
		    .CCLK		(clk),
		    .Dividend_hi	(Dividend_hi[63:0]),
		    .Dividend_lo	(Dividend_lo[63:0]),
		    .Divisor		(Divisor[63:0]),
		    .SSE		(reset),
		    .i_valid		(i_valid));
			  
endmodule // huffman_encode
