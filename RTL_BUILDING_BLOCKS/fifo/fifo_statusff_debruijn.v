module fifo_statusff_debruijn(/*AUTOARG*/
   // Outputs
   full, empty, w_addr, r_addr,
   // Inputs
   clk, reset, wr, rd
   );

   input clk,reset;
   input wr,rd;

   output full,empty;
   output [7:0] w_addr,r_addr;

   reg [7:0] 	w_ptr_rc, w_ptr_wc ,w_ptr_nxt_wc;
   reg [7:0] 	r_ptr_rc, r_ptr_wc ,r_ptr_nxt_wc;
   reg 		full_wc, empty_wc ,full_rc,empty_rc;
   reg 		full,empty;
   reg 	[7:0]	w_addr,r_addr;

   function [7:0] debruijn_xnor ;
      input [7:0] in ;
      reg 	  fb;
      begin
	 fb =in[7] ^ (&in[6:0]);
	 debruijn_xnor[7:5] = in[6:4];
	 debruijn_xnor[4] = ~(fb ^ in[3]);
	 debruijn_xnor[3] = ~(fb ^ in[2]);
	 debruijn_xnor[2] = ~(fb ^ in[1]);
	 debruijn_xnor[1] = in[0];
	 debruijn_xnor[0] = fb; 
      end
   endfunction // debruijn_xnor
      
   always @(posedge clk or posedge reset)
     if ( reset )
       begin
	  w_ptr_rc <= 0;
	  r_ptr_rc <= 0;
	  full_rc <= 0;
	  empty_rc <= 1;
       end
     else
       begin
	  w_ptr_rc <= w_ptr_wc;
	  r_ptr_rc <= r_ptr_wc ;
	  full_rc <= full_wc;
	  empty_rc <= empty_wc;
       end

   always @*
     begin
	empty_wc = empty_rc;
	full_wc = full_rc;
	w_ptr_wc = w_ptr_rc;
	r_ptr_wc = r_ptr_rc;

	w_ptr_nxt_wc = debruijn_xnor(w_ptr_rc);
	r_ptr_nxt_wc = debruijn_xnor(r_ptr_rc);
       
	case( {wr,rd} )
	  2'b00:;
	  2'b10:
	    begin
	       //lfsr counter
	       w_ptr_wc = w_ptr_nxt_wc;
	       empty_wc = 0;
	       if ( w_ptr_wc == r_ptr_rc )
		 full_wc = 1;
	    end
	  2'b01:
	    begin
	       //lfsr counter
	       r_ptr_wc = r_ptr_nxt_wc;
	       full_wc = 0;
	       if ( r_ptr_wc == w_ptr_rc )
		 empty_wc = 1;
	    end
	  2'b11:
	    begin
	       w_ptr_wc = w_ptr_nxt_wc;
	       r_ptr_wc = r_ptr_nxt_wc;
	    end
	endcase // case ( {wr,rd} )

	w_addr = w_ptr_rc[7:0];
	r_addr = r_ptr_rc[7:0];
	full = full_wc;
	empty = empty_wc ;
	
     end // always @ *

endmodule // fifo_statusff_debruijn

`ifdef TEST
module test ;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			empty;			// From dut of fifo_statusff_debruijn.v
   wire			full;			// From dut of fifo_statusff_debruijn.v
   wire [7:0]		r_addr;			// From dut of fifo_statusff_debruijn.v
   wire [7:0]		w_addr;			// From dut of fifo_statusff_debruijn.v
   // End of automatics

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of fifo_statusff_debruijn.v
   reg			rd;			// To dut of fifo_statusff_debruijn.v
   reg			reset;			// To dut of fifo_statusff_debruijn.v
   reg			wr;			// To dut of fifo_statusff_debruijn.v
   // End of automatics

   initial
     begin
	$dumpvars;
	clk =0;
	reset =1;
	rd=0;
	wr=0;
	repeat(5000) @(posedge clk);
	$finish;
     end

   always #5 clk = ~clk;
   
   initial
     begin
	repeat(10) @(posedge clk);
	reset <=1 ;
	repeat(10) @(posedge clk);
	reset <=0;
     end // initial begin

   always @(posedge clk)
     begin
	if ( ~full & ~reset)
	  wr <= 1;
	else
//	@(posedge clk);
	  wr <= 0;
	
     end

   initial
     begin
	repeat (1000) @(posedge clk);
	
	if ( ~empty & ~reset)
	  rd <= 1;
	else
	  rd <= 0;
//	@(posedge clk);
     
	//  wr <= 0;
	
     end   
   
   fifo_statusff_debruijn dut(/*AUTOINST*/
		     // Outputs
		     .full		(full),
		     .empty		(empty),
		     .w_addr		(w_addr[7:0]),
		     .r_addr		(r_addr[7:0]),
		     // Inputs
		     .clk		(clk),
		     .reset		(reset),
		     .wr		(wr),
		     .rd		(rd));

   
endmodule // test
`endif //  `ifdef TEST
