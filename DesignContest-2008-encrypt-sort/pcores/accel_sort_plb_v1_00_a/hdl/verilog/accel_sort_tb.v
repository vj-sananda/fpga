`timescale 1ns/1ns

module accel_sort_tb ;

   parameter 		o_width = 32 ;
   parameter 		i_width = 32 ;
   parameter 		index_width = 19;
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of accel_sort.v
   reg [127:0]		global_key;		// To dut of accel_sort.v
   reg [i_width-1:0]	idata;			// To dut of accel_sort.v
   reg			no_compare;		// To dut of accel_sort.v
   reg			not_full;		// To dut of accel_sort.v
   reg			rdy;			// To dut of accel_sort.v
   reg			reset;			// To dut of accel_sort.v
   reg [index_width-1:0]start_index;		// To dut of accel_sort.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [o_width-1:0]	odata;			// From dut of accel_sort.v
   wire			pop;			// From dut of accel_sort.v
   wire			push;			// From dut of accel_sort.v
   // End of automatics

   
   initial
     begin
	$dumpvars;
	idata=0;
	start_index = 0;
	global_key = 0;
	no_compare = 0;
	clk=0;
	reset=1;
	rdy=0;
	not_full=0;
	#250 ;
	reset=0;
	repeat (1000) @(posedge clk);
	$finish;
     end

   always
     #5 clk = ~clk ;

   always @( posedge clk )
     if ( ~reset )
       begin
	  rdy <= ~rdy ;
 	  not_full <= ~not_full ;
	  if ( pop )
	    begin
	       idata <= idata + 1;
	    end
       end

   always @(posedge clk)
     begin
	if ( push )
	  $display($time," ns::Pushed Dword = 0x%h", odata);
     end
	  
   accel_sort dut(/*AUTOINST*/
		  // Outputs
		  .odata		(odata[o_width-1:0]),
		  .push			(push),
		  .pop			(pop),
		  // Inputs
		  .idata		(idata[i_width-1:0]),
		  .rdy			(rdy),
		  .not_full		(not_full),
		  .clk			(clk),
		  .reset		(reset),
		  .start_index		(start_index[index_width-1:0]),
		  .global_key		(global_key[127:0]),
		  .no_compare		(no_compare));

endmodule // 
