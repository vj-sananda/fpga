//Write in verilog, not sure of system verilog support
//in FPGA synthesis

module fifo (/*AUTOARG*/
   // Outputs
   full, empty, dataout, 
   // Inputs
   clk, rst, push, pop, datain
   );

   //------------------------------
   parameter width=8;
   parameter depth=4;
   parameter log2depth=2;
   //------------------------------
   input     clk,rst;
   input     push,pop;
   input [width-1:0] datain;
   
   output    full,empty;
   output [width-1:0] dataout;
   //------------------------------
   reg [width-1:0]    mem[0:depth-1];
   //------------------------------

   reg [log2depth-1:0]  rd_ptr,wr_ptr;
   reg [log2depth:0] 	cnt ,cnt_w ;
   reg 			full, empty;

   always @(posedge clk)
     if (rst)
       begin
	  cnt <= 0;
	  rd_ptr <=0 ;
	  wr_ptr <=0 ;
       end
     else
       begin
	  cnt <= cnt_w;
	  
	  if (push)
	    begin
	       mem[wr_ptr] <= datain;
	       wr_ptr <= wr_ptr + 1;
	    end

	  if (pop)
	    rd_ptr <= rd_ptr + 1 ;
	  
       end // else: !if(rst)

   always @*
     case({push,pop})
       2'b00,2'b11:begin
	  cnt_w = cnt ;
	  full = (cnt_w == depth);
	  empty = (cnt_w == 0);
       end
       
       2'b10: begin
	  cnt_w = cnt + 1;
	  full = (cnt_w == depth);
	  empty = 0;
       end
       
       2'b01: begin
	  cnt_w = cnt - 1;
	  full = 0;
	  empty = (cnt_w == 0);	  
       end
     endcase // case({push,pop})

   wire [width-1:0]	       dataout = mem[rd_ptr] ;

endmodule // fifo

`ifdef TEST
module tb ;

   parameter width = 8;
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of fifo.v
   reg [width-1:0]	datain;			// To dut of fifo.v
   reg			pop;			// To dut of fifo.v
   reg			push;			// To dut of fifo.v
   reg			rst;			// To dut of fifo.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [width-1:0]	dataout;		// From dut of fifo.v
   wire			empty;			// From dut of fifo.v
   wire			full;			// From dut of fifo.v
   // End of automatics
   
   fifo dut(/*AUTOINST*/
	    // Outputs
	    .full			(full),
	    .empty			(empty),
	    .dataout			(dataout[width-1:0]),
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .push			(push),
	    .pop			(pop),
	    .datain			(datain[width-1:0]));

   initial clk = 0;
   always #5 clk = ~clk ;

   initial
     begin
	$dumpvars;
	
	rst <= 1;
	push <= 0;
	datain <= 0;
	pop <= 0;
	tick(10);
	rst <= 0 ;
	tick(10);

	/*
	repeat(4)
	  begin
	     datain <= datain + 1;
	     push <= 1;
	     tick(1);
	  end
	push <= 0;
	tick(10);

	repeat(4)
	  begin
	     pop <= 1;
	     tick(1);
	  end
	pop <= 0;
	tick(10);	
	 */
	tick(1000);
	
	$finish;
     end

   always
     begin

	wait(rst == 0);
	tick(10);

	fork

	   repeat(100)
	   begin
	      tick(1);
	      if ( ~full )
		begin
		   push <= 1;
		   datain <= datain + 1;
		end
	      else
		begin
		   push <= 0 ;
		end // else: !if( ~full )
	   end // fork begin

	   repeat(100)
	   begin
	      tick(10);
	      if ( ~empty )
		begin
		   pop <= 1;
		end
	      else
		begin
		   pop <= 0 ;
		end // else: !if( ~full )
	   end // fork begin
	   
	join
	
     end
   
   task tick;
      input [31:0] n ;
      begin
	 repeat (n) @(posedge clk);
      end
   endtask // tick
   
endmodule // tb
`endif //  `ifdef TEST
