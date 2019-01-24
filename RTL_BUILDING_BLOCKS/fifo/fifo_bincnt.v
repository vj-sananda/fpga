module fifo_bincnt(/*AUTOARG*/
   // Outputs
   full, empty, w_addr, r_addr,
   // Inputs
   clk, reset, wr, rd
   );

   input clk,reset;
   input wr,rd;

   output full,empty;
   output [7:0] w_addr,r_addr;

   reg [8:0] 	w_ptr_rc, w_ptr_wc ;
   reg [8:0] 	r_ptr_rc, r_ptr_wc ;
   reg 		full_wc, empty_wc ;
   reg 		full,empty;
   reg 	[7:0]	w_addr,r_addr;
   
   always @(posedge clk or posedge reset)
     if ( reset )
       begin
	  w_ptr_rc <= 0;
	  r_ptr_rc <= 0;
       end
     else
       begin
	  w_ptr_rc <= w_ptr_wc;
	  r_ptr_rc <= r_ptr_wc ;
       end

   always @*
     begin
	if ( wr )
	  w_ptr_wc = w_ptr_rc + 1;
	else
	  w_ptr_wc = w_ptr_rc ;
	
	if (( r_ptr_wc[8] != w_ptr_wc[8] ) & (r_ptr_wc[7:0] == w_ptr_wc[7:0]) )
	  full_wc = 1;
	else
	  full_wc = 0;

	if ( rd )
	  r_ptr_wc = r_ptr_rc + 1;
	else
	  r_ptr_wc = r_ptr_rc;
	  
	if (r_ptr_wc == w_ptr_wc)
	  empty_wc = 1;
	else
	  empty_wc = 0;

	w_addr = w_ptr_rc[7:0];
	r_addr = r_ptr_rc[7:0];
	full = full_wc;
	empty = empty_wc ;
	
     end // always @ *

endmodule // fifo_bincnt


module test ;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			empty;			// From dut of fifo_bincnt.v
   wire			full;			// From dut of fifo_bincnt.v
   wire [7:0]		r_addr;			// From dut of fifo_bincnt.v
   wire [7:0]		w_addr;			// From dut of fifo_bincnt.v
   // End of automatics

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of fifo_bincnt.v
   reg			rd;			// To dut of fifo_bincnt.v
   reg			reset;			// To dut of fifo_bincnt.v
   reg			wr;			// To dut of fifo_bincnt.v
   // End of automatics

   initial
     begin
	$dumpvars;
	clk =0;
	reset =1;
	rd=0;
	wr=0;
	repeat(5000) @(posedge clk);
	$finish;
     end

   always #5 clk = ~clk;
   
   initial
     begin
	repeat(10) @(posedge clk);
	reset <=1 ;
	repeat(10) @(posedge clk);
	reset <=0;
     end // initial begin

   always @(posedge clk)
     begin
	if ( ~full & ~reset)
	  wr <= 1;

	@(posedge clk);
     
	  wr <= 0;
	
     end
   
   fifo_bincnt dut(/*AUTOINST*/
		   // Outputs
		   .full		(full),
		   .empty		(empty),
		   .w_addr		(w_addr[7:0]),
		   .r_addr		(r_addr[7:0]),
		   // Inputs
		   .clk			(clk),
		   .reset		(reset),
		   .wr			(wr),
		   .rd			(rd));

   
endmodule // test
