`timescale 1ns/1ns

module ringbuf(/*AUTOARG*/
   // Outputs
   one_pass_done, dout, overrun,
   // Inputs
   wclk, rclk, wrst, rrst, din
   );

   parameter dwidth = 8;

   parameter depth = 8;
   parameter log2_depth = 3;//dependent on depth
   parameter depth_1s = 3'b111;//dependent on depth
   parameter depth_halfway = 3'b100 ;//dependent on depth
   parameter depth_halfway_minus1 = 3'b011  ;//dependent on depth  
		       
   input wclk,rclk;
   input wrst,rrst;
   output one_pass_done;

   //if need valid bit, increase dwidth by 1
   input [dwidth-1:0] din;
   output [dwidth-1:0] dout;
   output 	       overrun ;

   reg [dwidth-1:0] dout;
   
   //Ring buf memory, add phase bit to detect over/under run
   reg [dwidth:0]    mem [0:depth-1];

   reg [log2_depth-1:0] wptr, rptr ;
   reg 			wphase, rphase;
   reg 			phase;

   //Reflects both wptr and rptr overrun
   reg 			overrun ;
   
   always @(posedge wclk)
     if ( wrst )
       begin
	  wptr <= 0;
	  wphase <= 0;
       end
     else
       begin
	  wptr <= wptr + 1;
	  if ( wptr == depth_1s )
	    wphase <= ~wphase;
	  mem[wptr] <= {wphase,din};
       end // else: !if( wrst )

   reg one_pass_done;

   reg rphase_d1 ;
   
   always @(posedge rclk)
     if ( rrst )
       begin
	  rptr <= depth_halfway ;
	  rphase <= 0;
	  overrun <= 0;
	  one_pass_done <= 0;
       end
     else
       begin
	  if ( rptr == depth_1s )
	    if ( ~one_pass_done )
	      one_pass_done <= 1;
	    else
	      rphase <= ~rphase;

	  rphase_d1 <= rphase ;
	  
	  {phase,dout} <= mem[rptr] ;

	  //Don't clear overrun,until rrst
	  if ( ~overrun)
 	    overrun <=  phase != rphase_d1 ;
	  else
	    overrun <= 0;

       end // else: !if( wrst )   

endmodule // ringbuf

`ifdef TEST
module tb;

   parameter dwidth = 8;
   

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [dwidth-1:0]	din;			// To dut of ringbuf.v
   reg			rrst;			// To dut of ringbuf.v
   reg			wclk;			// To dut of ringbuf.v
   reg			wrst;			// To dut of ringbuf.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [dwidth-1:0]	dout;			// From dut of ringbuf.v
   wire			one_pass_done;		// From dut of ringbuf.v
   wire			overrun;		// From dut of ringbuf.v
   // End of automatics

   integer 		delay ;
   reg 			rclk_ideal ;
   
   initial
     begin
	$dumpvars;
	din = 0;
	rrst = 1;
	wrst = 1;
	wclk = 0;
	rclk_ideal = 1;
	delay = 1;
	#200;
	rrst =0;
	wrst =0;
	repeat (5000) @(posedge wclk);
	$finish;
     end // initial begin

   always #5 wclk = ~wclk ;
   always #4 rclk_ideal = ~rclk_ideal ;   

   wire rclk ;
   assign #(delay) rclk = rclk_ideal ;
   
   always @(posedge wclk)
     begin
	din <= din + 1;
	if ( din == 8'd255 )
	  delay = delay + 1;
	if ( delay == 5 )
	  delay = 1 ;
     end

   reg [dwidth-1:0] dout_prev,dout_compare;
   
   always @(posedge rclk)   
     begin
	dout_prev <= dout ;
	if ( one_pass_done )
	  begin
	     dout_compare = dout_prev + 1 ;
	     if ( dout_compare != dout )
	       $display($time,"::ERROR: data mismatch: dout=%x, dout_compare=%x",dout,dout_compare);
	  end
     end
	     
   ringbuf dut(/*AUTOINST*/
	       // Outputs
	       .one_pass_done		(one_pass_done),
	       .dout			(dout[dwidth-1:0]),
	       .overrun			(overrun),
	       // Inputs
	       .wclk			(wclk),
	       .rclk			(rclk),
	       .wrst			(wrst),
	       .rrst			(rrst),
	       .din			(din[dwidth-1:0]));

endmodule  // test
`endif //  `ifdef TEST
