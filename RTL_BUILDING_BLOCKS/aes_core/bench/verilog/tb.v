//`include "timescale.v"

`define NUM_VEC 65536

module test;

reg		clk;
reg		rst;

reg		kld;
   
   wire [127:0] key ;
   reg [127:0] 	plain [0:`NUM_VEC-1];
   reg [127:0] 	ciph [0:`NUM_VEC-1];   
   
reg	[127:0]	text_in;
wire	[127:0]	text_out;

wire		done, done2;
integer		n, error_cnt;

initial
   begin
	$display("\n\n");
	$display("*****************************************************");
	$display("* AES Test bench ...");
	$display("*****************************************************");
	$display("\n");
//      $dumpvars;

	kld = 0;
	clk = 0;
	rst = 0;
	error_cnt = 0;
	repeat(4)	@(posedge clk);
	rst = 1;
	repeat(20)	@(posedge clk);

	$display("");
	$display("");
	$display("Started random test ...");

      $readmemh("in.dat",plain);
      $readmemh("out.dat",ciph);      
      
      for(n=0;n<`NUM_VEC;n=n+1)
	begin
	   @(posedge clk);
	   #1;
	   text_in = plain[n];
	   kld = 1;
	   @(posedge clk);
	   #1;
	   text_in = 128'hx;
	   kld = 0;
	   @(posedge clk);

	   while(!done)	@(posedge clk);

	//$display("INFO: (a) Vector %0d: xpected %x, Got %x %t", n, ciph, text_out, $time);

	if(text_out != ciph[n] | (|text_out)==1'bx)
	   begin
		$display("ERROR: (a) Vector %0d mismatch. Expected %x, Got %x",
			n, ciph[n], text_out);
		error_cnt = error_cnt + 1;
	   end

	@(posedge clk);
	#1;
   end


	$display("");
	$display("");
	$display("Test Done. Found %0d Errors.", error_cnt);
	$display("");
	$display("");
	repeat(10)	@(posedge clk);
	$finish;
end

   assign key     = 128'hb01dface0dec0ded0ba11ade0effec70;
   
   always #5 clk = ~clk;

aes_cipher_top u0(
	.clk(		clk		),
	.rst(		rst		),
	.ld(		kld		),
	.done(		done		),
	.key(		key		),
	.text_in(	text_in		),
	.text_out(	text_out	)
	);

endmodule


