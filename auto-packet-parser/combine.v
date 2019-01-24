module test ;

   parameter W = 32 ;//Width of data input bus
   parameter N = 3 ;//Number of data words in packet
   parameter LOG2N = 2 ;//Ceiling of Log2(N)
   
   parameter BIGENDIAN = 0;//1 if big endian

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To unpack of gdu.v, ...
   reg [W-1:0]		din;			// To unpack of gdu.v
   reg [`F0_W-1:0]	din_f0;			// To pack of gdp.v
   reg [`F1_W-1:0]	din_f1;			// To pack of gdp.v
   reg [`F2_W-1:0]	din_f2;			// To pack of gdp.v
   reg [`F3_W-1:0]	din_f3;			// To pack of gdp.v
   reg [`F4_W-1:0]	din_f4;			// To pack of gdp.v
   reg			eop;			// To unpack of gdu.v
   reg			reset;			// To unpack of gdu.v, ...
   reg			sop;			// To unpack of gdu.v
   reg			valid_din;		// To unpack of gdu.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [W-1:0]		dout;			// From pack of gdp.v
   wire [`F0_W-1:0]	dout_f0;		// From unpack of gdu.v
   wire [`F1_W-1:0]	dout_f1;		// From unpack of gdu.v
   wire [`F2_W-1:0]	dout_f2;		// From unpack of gdu.v
   wire [`F3_W-1:0]	dout_f3;		// From unpack of gdu.v
   wire [`F4_W-1:0]	dout_f4;		// From unpack of gdu.v
   wire			err;			// From unpack of gdu.v
   wire			valid_dout;		// From pack of gdp.v
   wire			valid_f0;		// From unpack of gdu.v
   wire			valid_f1;		// From unpack of gdu.v
   wire			valid_f2;		// From unpack of gdu.v
   wire			valid_f3;		// From unpack of gdu.v
   wire			valid_f4;		// From unpack of gdu.v
   // End of automatics
   
   initial
     begin
	$dumpvars;
	clk = 0;
	din = 0;
	eop = 0;
	sop = 0;
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

   gdu unpack (/*AUTOINST*/
	       // Outputs
	       .err			(err),
	       .valid_f0		(valid_f0),
	       .valid_f1		(valid_f1),
	       .valid_f2		(valid_f2),
	       .valid_f3		(valid_f3),
	       .valid_f4		(valid_f4),
	       .dout_f0			(dout_f0[`F0_W-1:0]),
	       .dout_f1			(dout_f1[`F1_W-1:0]),
	       .dout_f2			(dout_f2[`F2_W-1:0]),
	       .dout_f3			(dout_f3[`F3_W-1:0]),
	       .dout_f4			(dout_f4[`F4_W-1:0]),
	       // Inputs
	       .clk			(clk),
	       .reset			(reset),
	       .sop			(sop),
	       .eop			(eop),
	       .din			(din[W-1:0]),
	       .valid_din		(valid_din));
   

   gdp pack (/*AUTOINST*/
	     // Outputs
	     .dout			(dout[W-1:0]),
	     .valid_dout		(valid_dout),
	     // Inputs
	     .clk			(clk),
	     .reset			(reset),
	     .valid_f0			(valid_f0),
	     .valid_f1			(valid_f1),
	     .valid_f2			(valid_f2),
	     .valid_f3			(valid_f3),
	     .valid_f4			(valid_f4),
	     .din_f0			(dout_f0[`F0_W-1:0]),
	     .din_f1			(dout_f1[`F1_W-1:0]),
	     .din_f2			(dout_f2[`F2_W-1:0]),
	     .din_f3			(dout_f3[`F3_W-1:0]),
	     .din_f4			(dout_f4[`F4_W-1:0]));
   
endmodule  // test


