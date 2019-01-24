module lfsr8(/*AUTOARG*/
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

   always @(posedge clk or posedge reset)
     if ( reset )
       out <= 4'b1111;
//       out <= 0;
     else
       if ( enable )
	 out <= {out[6:4],(out[7]^out[3]),(out[7]^out[2]),(out[7]^out[1]),out[0],out[7]};

endmodule // lfsr8

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

   wire align = (out == 17);
   
   lfsr8 dut(/*AUTOINST*/
	     // Outputs
	     .out			(out[7:0]),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .enable			(enable));

endmodule // test
