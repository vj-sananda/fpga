/* ----------------------------------------------------------
 Generalized Data Packer (version1: Integral multiples only)
 ==========================================================
 Full parameterized: Assembles an N*M bit packed data output
 given an N bit input.

 Parameters: N = width of input bus
             M = width multiplier, output bus width = N*M
             LOG2M = ceiling( log2(M) )
             default: 8 bit ==> 32 bit ,N=8,M=4,LOG2M=2
 
 Examples: 
 Pack 8 bit bus into 64 bits, N=8, M=8, LOG2M=3
 Pack 9 bit bus into 45 bits, N=9, M=5, LOG2M=3
 Pack 7 bit bus into 21 bits, N=7, M=3, LOG2M=2
 
 Can be used for speed matching.
 small_width, high freq == large_width, low freq  

 For self test , compile this file with +define+TEST

 inputs:
   clk   => posedge triggered
   reset => active high
   din   => input data bus
   valid_din => active high, signals valid data on input bus
   flush => active high , for flush to work valid_din must
            also be active, flush to o/p bus
 
 outputs:
   dout => output data bus
   valid_dout => active high, signals valid data on output bus
 
 Author: VJ Sananda

---------------------------------------------------------- */

module gdp (/*AUTOARG*/
   // Outputs
   dout, valid_dout, 
   // Inputs
   clk, reset, flush, din, valid_din
   );

   parameter N = 8 ;//Width of data input bus
   parameter M = 4 ;//Width of data output bus = N*M
   parameter LOG2M = 2 ;//Log2(M)
   
   input clk ;
   input reset ;

   input 	   flush ;   
   input [N-1:0]   din ;
   input 	   valid_din ;
   
   output [N*M-1:0] dout ;
   wire [N*M-1:0] dout ;
   output 	    valid_dout;
   // ---------- END INPUT/OUTPUT DECL ----------

   //---------------------------------------------
   //A note about the suffixes
   //
   //   _[r,w].[c,d].[#] : choose 1 of the letters in each [] and
   //                      concatenate to build suffix
   //
   //[r,w]: r=>register, w=>wire
   //
   //[c,d]: c=>control,  d=>datapath
   //
   //[#] : Number, reflects register stage number
   //Within a clocked always block, signal on the LHS
   //of a non-blocking assignment, will have this number incremented
   //beyond the largest # of the expression on the RHS or that in a
   //conditional expression controlling the assignment
   //
   //On a wire assign, this number will not increment.
   //Goal is to make the clock cycle dependencies obvious
   //---------------------------------------------

   wire [LOG2M-1:0]  cnt_wc1;   
   reg  [LOG2M-1:0]  cnt_rc2;
   reg [N-1:0] 	   hold_rd1 [M-1] ;
   reg 		   valid_dout ;

   wire 	   end_of_count_wc2 = (cnt_rc2 == M-1);
   
   //Control Counter
   always @(posedge clk or posedge reset)
     //if M is not a power of 2, addcondition to reset
     if (reset || flush || (end_of_count_wc2 & valid_din  )  )
       cnt_rc2 <= 0;
     else
       if ( valid_din )
	 cnt_rc2 <= cnt_wc1;
   assign 	     cnt_wc1 = cnt_rc2 + 1 ;
   
   always @*
     if ( end_of_count_wc2 || flush )
	  valid_dout = valid_din ;
     else
       valid_dout = 0;
   
   genvar i ;
   generate for (i=1; i<M; i=i+1) 
     begin:DOUT_GEN
	assign dout[N*i-1:N*(i-1)] = hold_rd1[i-1];
     end
   endgenerate

   assign dout[N*M-1:N*(M-1)] = din ;
				 
   //Latch data
   always @(posedge clk or posedge reset)
     if ( valid_din )
       hold_rd1[cnt_rc2] <= din ;
   
endmodule // gdp

`ifdef TEST
module test ;

   parameter N=9;
   parameter M=5;
   parameter LOG2M=3;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of gdp.v
   reg [N-1:0]		din;			// To dut of gdp.v
   reg			flush;			// To dut of gdp.v
   reg			reset;			// To dut of gdp.v
   reg			valid_din;		// To dut of gdp.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N*M-1:0]	dout;			// From dut of gdp.v
   wire			valid_dout;		// From dut of gdp.v
   // End of automatics
   
   initial
     begin
	$dumpvars;
	clk = 0;
	din = 0;
	flush = 0;
	reset = 0;
	valid_din = 0;
	reset_dut;
	repeat(20) $display("random no = %d",$random);
       	repeat (20000) @(posedge clk);
	$finish;
     end

   always #5 clk = ~clk ;

   task reset_dut;
     begin
	@(posedge clk);
	reset <= 1;
	repeat (20) @(posedge clk);
	reset <= 0;
	repeat (20) @(posedge clk);	
     end
   endtask // reset_dut

   always @(posedge clk)
     begin
	if ($random % 4)
	  begin
	     din <= din + 1;
	     valid_din <= 1;
	  end
	else
	  valid_din <= 0;
     end

   //--------------------------------------------------------------
   //Rule based Check
   //The din values are an incrementing series of values
   //Use this to look for an incrementing pattern in the packed data
   //To track potential skips: The Most Significant din value packed+1
   //must match the Least Significant din of the next packed word
   //--------------------------------------------------------------
   reg [N-1:0]		msb_value;			// To dut of gdp.v   
   
   genvar i ;
   generate for (i=0; i<M-1; i=i+1) 
     begin:CHK_GEN
	always  @(posedge clk)
	  if ( valid_dout)
	    begin
	       if ( i==0 && msb_value+1'b1 != dout[N-1:0])
		 $display($stime,":ERROR: skip detected:%x, %x",
			  msb_value,dout[7:0]);
	       if ( dout[N*(i+1)-1:N*i]+1'b1 !== dout[N*(i+2)-1:N*(i+1)] )
		 $display($stime,":ERROR: packed data incorrect:%x, %x",
			  dout[N*(i+1)-1:N*i],dout[N*(i+2)-1:N*(i+1)]);
	       msb_value = dout[N*(i+2)-1:N*(i+1)] ;
	    end
        end
   endgenerate

   gdp dut (/*AUTOINST*/
	    // Outputs
	    .dout			(dout[N*M-1:0]),
	    .valid_dout			(valid_dout),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .flush			(flush),
	    .din			(din[N-1:0]),
	    .valid_din			(valid_din));
   defparam dut.N = N ;
   defparam dut.M = M ;
   defparam dut.LOG2M = LOG2M ;   

endmodule  // test

`endif

