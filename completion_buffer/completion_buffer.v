/*
 Completion Buffer
 
 1. Accepts writes out of order
 2. Data sent out in order
 
 Use Dual-Port Block-RAM for initial version
 
 */


module completion_buffer( /*AUTOARG*/
   // Outputs
   i_rdy, dout, dout_v,
   // Inputs
   clk, rst, din, din_v, wr_addr
   );

`include "parameters.vh"
   
   input clk,rst;
   input [w_din-1 : 0] din ;
   input 	       din_v ;
   output 	       i_rdy ; //asserted when there is space in buffer
   input [log2size-1:0]  wr_addr;
   
   output [w_din-1:0]  dout ;
   output 	       dout_v;
   
   //Memory (include entry present bit)
   reg [w_din:0]       mem [0:size-1];

   //Extra MSB bit will be used to flip polarity of 'present bit'
   //each time we go around
   reg [log2size:0]  wr_ptr,rd_ptr;
   reg [w_din-1:0]   dout_wc,dout_rc;
   
   //zReg

   reg   [log2size-1:0] entry_cnt_rc ;
   reg   [log2size:0] wr_cnt_rc ;
   reg   [log2size:0] rd_ptr_rc ;
   reg   [log2size-1:0] entry_cnt_wc ;
   reg   [log2size:0] wr_cnt_wc ;
   reg 		      dout_v_wc ,dout_v_rc;
   
   reg  vbit_rc ;
   reg   [log2size:0] rd_ptr_wc ;

   wire [w_din-1:0]  dout = dout_rc;
   wire 	     dout_v = dout_v_rc;
   
   
   //Since dual port , can decouple writes and reads
   //2 separate machines (or processes)

   //Process to track number of entries
   //Also, the total number of writes, so that I can flip
   //the valid bit
   always @(posedge clk)
     if (rst)
       begin
	  //zClkReset
	  entry_cnt_rc <= 0 ; 
	  wr_cnt_rc <= 0 ; 
	  rd_ptr_rc <= 0 ; 
       end
     else
       begin
	  //zClkAssign
	  entry_cnt_rc <=  entry_cnt_wc ; 
	  wr_cnt_rc <=  wr_cnt_wc ; 
	  rd_ptr_rc <=  rd_ptr_wc ;
	  dout_v_rc <= dout_v_wc;
       end
   
   always @(/*AUTOSENSE*/din_v or dout_v or entry_cnt_rc or wr_cnt_rc)
     begin
	entry_cnt_wc = entry_cnt_rc;
	wr_cnt_wc = wr_cnt_rc;

	if ( din_v )
	  wr_cnt_wc = wr_cnt_rc + 1;
	
	case ( {dout_v,din_v} )
	  2'b01: entry_cnt_wc  = entry_cnt_rc + 1 ;
	  2'b10: entry_cnt_wc  = entry_cnt_rc - 1 ;
	endcase // case ( {dout_v,din_v} )	
     end

   //note : comb path from din_v, registering it will cause an overflow
   //or can use almost not rdy signal
   wire i_rdy = (entry_cnt_wc != size);

   //WR process
   always @(posedge clk)
     if ( din_v & ~rst )
       //Write, assuming that din_v is well behaved w.r.t i_rdy
       //Valid bit is MSB of wr_cnt_rc flipped
       mem[wr_addr] <= { ~wr_cnt_rc[log2size] , din };

   reg 	rd_happened ;
   
   always @(posedge clk)
     if (rst)
       rd_happened <= 0;
     else
       if ( wr_addr != rd_ptr_rc[log2size-1:0] && ~rst  )
	 begin
	    {vbit_rc,dout_rc} <= mem[rd_ptr_rc[log2size-1:0]];
	    rd_happened <= 1;
	 end
       else
	 rd_happened <= 0;
     
   //RD process, 
   always @(/*AUTOSENSE*/log2size or rd_ptr_rc or vbit_rc)
     begin
	dout_v_wc = 0;
	rd_ptr_wc =  rd_ptr_rc;
	
	//polling location, making sure write not happening to the same addr	
	  begin
	     //Valid entry, push out and inc pointer
	     if ( vbit_rc == ~rd_ptr_rc[log2size] & rd_happened )
	       begin
		  rd_ptr_wc = rd_ptr_rc + 1;
		  dout_v_wc = 1;
	       end
	  end
     end
   

endmodule // completion_buffer


module tb ;

`include "parameters.vh"
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			clk;			// To dut of completion_buffer.v
   reg [w_din-1:0]	din;			// To dut of completion_buffer.v
   reg			din_v;			// To dut of completion_buffer.v
   reg			rst;			// To dut of completion_buffer.v
   reg [log2size-1:0]	wr_addr;		// To dut of completion_buffer.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [w_din-1:0]	dout;			// From dut of completion_buffer.v
   wire			dout_v;			// From dut of completion_buffer.v
   wire			i_rdy;			// From dut of completion_buffer.v
   // End of automatics

   initial
     begin
	$dumpvars;

	clk=0;
	rst =1;
	din = 0;
	din_v = 0;
	wr_addr = 7;
	#105;
	@(negedge clk);	
	rst = 0;


	#10000;
	$finish;
     end // initial begin

   always #5 clk = ~clk;

   always @(posedge clk)
     if ( ~rst )
       begin
	  din <= din + 1;
	  wr_addr <= wr_addr + 1;
	  din_v <= 1;
       end
		
   completion_buffer dut (/*AUTOINST*/
			  // Outputs
			  .i_rdy		(i_rdy),
			  .dout			(dout[w_din-1:0]),
			  .dout_v		(dout_v),
			  // Inputs
			  .clk			(clk),
			  .rst			(rst),
			  .din			(din[w_din-1:0]),
			  .din_v		(din_v),
			  .wr_addr		(wr_addr[log2size-1:0]));


endmodule // tb

   
