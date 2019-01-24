`timescale 1ns/1ns

module huffman_decode_tb ;

   parameter c_width = 4 ;//fixed length code width
   
   parameter vlc_width=5  ; //max variable length code width 
   parameter vlcz_width=3 ; //code size width
   
   parameter p_width=32 ; //packed data width 
   parameter p_width_msb=31 ; //packed data width
   
   parameter EOM = 5'b11111 ;
   parameter EOM_LENGTH = 4 ;//code length - 1
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of huffman_decode.v
   reg [31:0]		idata;			// To dut of huffman_decode.v
   reg			not_full;		// To dut of huffman_decode.v
   reg			rdy;			// To dut of huffman_decode.v
   reg			reset;			// To dut of huffman_decode.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [3:0]		code;			// From dut of huffman_decode.v
   wire			pop;			// From dut of huffman_decode.v
   wire			push;			// From dut of huffman_decode.v
   // End of automatics

   reg [31:0] 		encoded_data [0:12000];
   integer 		idx ;
   
   initial
     begin
	$dumpvars;
	$readmemh("encoded.dat",encoded_data);
	clk=0;
	reset=1;
	idx = 0;
	
//	idata = 32'h9eca6f3f;
	idata = encoded_data[idx];
	
	rdy=0;
	not_full=0;
	#250 ;
	reset=0;
	repeat (1000000) @(posedge clk);
	$finish;
     end

   always
     #5 clk = ~clk ;

   always @(posedge clk )
     if ( ~reset )
       begin
	  rdy <= 1;
	  if ( pop )
	    begin
	       idx = idx + 1;
	       idata <= encoded_data[idx];
	    end
       end

/* -----\/----- EXCLUDED -----\/-----
   always @(posedge clk)
     begin
	if ( push)
	  $display($time," ns::Decoded = 0x%h", code);
     end
 -----/\----- EXCLUDED -----/\----- */

   reg [31:0] cnt ;
   initial cnt = 7 ;
   
   always @(posedge clk )
     begin
	cnt <= cnt + 1;
	
	if ( !(cnt % 300) )
	  not_full <= ~not_full ;
     end
   
   
   huffman_decoder_v1 dut(/*AUTOINST*/
		      // Outputs
		      .code		(code[3:0]),
		      .push		(push),
		      .pop		(pop),
		      // Inputs
		      .rdy		(rdy),
		      .not_full		(not_full),
		      .clk		(clk),
		      .reset		(reset),
		      .idata		(idata[31:0]));

endmodule // huffman_decode_tb
