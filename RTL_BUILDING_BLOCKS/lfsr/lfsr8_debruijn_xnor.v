module lfsr8_debruijn_xnor(/*AUTOARG*/
   // Outputs
   out,
   // Inputs
   clk, reset, enable
   );
   input clk;
   input reset;
   output [7:0] out ;
   input 	enable ;

   reg [7:0] 	out ;
   reg 		fb;

   always @*
     fb = out[7] ^ (&out[6:0]);
	 
   always @(posedge clk or posedge reset)
     if ( reset )
       out <= 0;
     else
       if ( enable )
	 begin
	    out[7:5] <= out[6:4];
	    out[4] <= ~(fb ^ out[3]);
	    out[3] <= ~(fb ^ out[2]);
	    out[2] <= ~(fb ^ out[1]);
	    out[1] <= out[0];
	    out[0] <= fb;
	 end

endmodule // lfsr8

`ifdef TEST
module test;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [7:0]		out;			// From dut of lfsr8.v
   // End of automatics
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of lfsr8.v
   reg			enable;			// To dut of lfsr8.v
   reg			reset;			// To dut of lfsr8.v
   // End of automatics

   initial
     begin
	$dumpvars;
	clk = 0;
	reset = 1 ;
	enable = 1;
	repeat(10) @(posedge clk);
	reset =0;
	repeat(2000) @(posedge clk);
	$finish;
     end

   always #5 clk = ~clk;

   wire all_1 = (out == 255);
   wire all_0 = (out == 0);
   wire all_1_butmsb = (out == 127);
   wire all_1_butlsb = (out == 254);         
   
   lfsr8_debruijn_xnor dut(/*AUTOINST*/
	     // Outputs
	     .out			(out[7:0]),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .enable			(enable));

endmodule // test
`endif //  `ifdef TEST
