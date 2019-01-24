`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:16:55 05/30/2005
// Design Name:   test
// Module Name:   test.v
// Project Name:  llist_fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////


module test;

   parameter width = 8;

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   // End of automatics
   wire			alloc_ack;		// From dut of flist.v
   wire [width-1:0]	alloc_id;		// From dut of flist.v
   wire			dealloc_ack;		// From dut of flist.v
   wire			init_done;		// From dut of flist.v

   reg [width-1:0] 	dealloc_id;		// From dut of flist.v
   //    
   reg clk ;
   reg rst ;
   reg alloc_req;
   reg dealloc_req ;
   
   initial
     begin
        $fsdbDumpfile("flist.fsdb");
        $fsdbDumpvars ;
	clk = 0;
	rst = 1;
	alloc_req = 0;
	dealloc_req = 0;
	dealloc_id = 0;
	
	#100 ;
	rst = 0 ;
	
	wait(init_done);

	fork 
	   repeat(300)
	     begin
		alloc_req <= 1;
		@(posedge clk);
		alloc_req <= 0;
		wait(alloc_ack);
		@(posedge clk);	     
	     end

	   begin
	      #19000;
	      @(posedge clk);
	      repeat(100)
		begin
		   dealloc_req <= 1;
		   @(posedge clk);
		   dealloc_req <= 0;
		   wait(dealloc_ack);
		   dealloc_id <= dealloc_id + 1;
		   @(posedge clk);	     
		end
	   end // fork branch
	join	   
	
	#1000;
	$finish;
	
     end

   always
     #5 clk = ~clk ;
          
   
   flist dut(/*AUTOINST*/
	     // Outputs
	     .alloc_ack			(alloc_ack),
	     .dealloc_ack		(dealloc_ack),
	     .alloc_id			(alloc_id[width-1:0]),
	     .init_done			(init_done),
	     // Inputs
	     .clk			(clk),
	     .rst			(rst),
	     .alloc_req			(alloc_req),
	     .dealloc_req		(dealloc_req),
	     .dealloc_id		(dealloc_id[width-1:0]));

endmodule // test
