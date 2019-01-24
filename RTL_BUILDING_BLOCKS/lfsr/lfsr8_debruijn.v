module lfsr8_debruijn(/*AUTOARG*/
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
   
   function [7:0] debruijn ;
      input [7:0] in ;
      reg 	  fb;
      begin
	 fb =in[7] ^ (~(|in[6:0]));
	 debruijn[7:5] = in[6:4];
	 debruijn[4] = (fb ^ in[3]);
	 debruijn[3] = (fb ^ in[2]);
	 debruijn[2] = (fb ^ in[1]);
	 debruijn[1] = in[0];
	 debruijn[0] = fb; 
      end
   endfunction // debruijn
   // 	 
   always @(posedge clk or posedge reset)
     if ( reset )
       out <= 4'b1111;
     else
       if ( enable )
	 out <= debruijn(out);

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
   
   lfsr8_debruijn dut(/*AUTOINST*/
	     // Outputs
	     .out			(out[7:0]),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .enable			(enable));

endmodule // test
`endif //  `ifdef TEST
