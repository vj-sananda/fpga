//base is always 1-hot, indicating the first position from which to scan right
module arbiter ( req, gnt , base);

   parameter WIDTH=16;

   input [WIDTH-1:0] req,base;
   output [WIDTH-1:0] gnt ;

   wire [WIDTH-1:0] gnt ;   

   wire [2*WIDTH-1:0] double_req ;
   wire [2*WIDTH-1:0] double_gnt ;   

   assign double_req = { req, req };

   assign double_gnt = double_req & ~(double_req - base);

   assign gnt = double_gnt[WIDTH-1:0] | double_gnt[2*WIDTH-1:WIDTH];

endmodule // arbiter

module tb;
   parameter WIDTH=16;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [WIDTH-1:0]	gnt;			// From dut of arbiter.v
   // End of automatics

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [WIDTH-1:0]	base;			// To dut of arbiter.v
   reg [WIDTH-1:0]	req;			// To dut of arbiter.v
   // End of automatics
   
   arbiter dut(/*AUTOINST*/
	       // Outputs
	       .gnt			(gnt[WIDTH-1:0]),
	       // Inputs
	       .req			(req[WIDTH-1:0]),
	       .base			(base[WIDTH-1:0]));
   
   initial
     begin
	$dumpvars;
	
	base=16'b1000_0000_0000_0000;
	req = 16'b0000_1000_0000_0000;
	#100;
	
	req = 16'b1110_1000_0000_1110;
	#100;
	
	req = 16'b1100_0000_1011_0000;
	#100;
	
	req = 16'b0011_0000_0000_1001;	
	#100;

	$finish;
     end // initial begin

endmodule // tb
