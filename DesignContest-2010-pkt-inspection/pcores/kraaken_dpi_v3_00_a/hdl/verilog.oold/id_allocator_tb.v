`timescale 1ns/1ps

module tb ;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [95:0]		addrid;			// To dut of id_allocator.v
   reg			addrid_valid;		// To dut of id_allocator.v
   reg			clk;			// To dut of id_allocator.v
   reg			dealloc;		// To dut of id_allocator.v
   reg			rst;			// To dut of id_allocator.v
   // End of automatics
   /*AUTOREGOUTPUT*/
   /*AUTOWIREOUTPUT*/
   /*AUTOWIREINPUT*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			new_streamid;		// From dut of id_allocator.v
   wire			rdy;			// From dut of id_allocator.v
   wire [5:0]		streamid;		// From dut of id_allocator.v
   wire			streamid_valid;		// From dut of id_allocator.v
   // End of automatics

   initial clk = 0;
   always #5 clk = ~clk;
   integer 		i;
   integer 		offset;
   
   initial
     begin
	$fsdbDumpvars;
	rst = 1 ;
	addrid_valid = 0;
	dealloc = 0;
	offset = 96'hdeadbeef;
	
	repeat (20) @(posedge clk);
	rst = 0;
	repeat (200) @(posedge clk);

	for (i=offset;i<offset+64;i=i+1)
	  begin
	     send_addr(i);
	  end

	for (i=offset;i<offset+64;i=i+1)
	  begin
	     send_addr(i);
	  end

	for (i=offset;i<offset+64;i=i+1)
	  begin
	     send_addr_dealloc(i);
	  end		

	for (i=offset;i<offset+64;i=i+1)
	  begin
	     send_addr(i);
	  end
	
	repeat (20) @(posedge clk);
	$finish;
     end

   task send_addr ;
      input [95:0] addr;
      
      begin
	 @(posedge clk);
	 wait(rdy);
	 @(posedge clk);
	 
	 addrid <= addr;
	 
	 addrid_valid <= 1;
	 @(posedge clk);
	 addrid_valid <= 0;
      end
   endtask // send_addr

   task send_addr_dealloc ;
      input [95:0] addr;
      
      begin
	 @(posedge clk);
	 wait(rdy);
	 @(posedge clk);
	 
	 addrid <= addr;
	 
	 addrid_valid <= 1;
	 @(posedge clk);
	 addrid_valid <= 0;
	 @(posedge clk);
	 dealloc <= 1;
	 @(posedge clk);
	 dealloc <= 0;
      end
   endtask // send_addr   

   always @(posedge clk)
     if ( ~rst & streamid_valid)
       $display("streamid = %d",streamid);
   
   id_allocator dut(/*AUTOINST*/
		    // Outputs
		    .streamid		(streamid[5:0]),
		    .new_streamid	(new_streamid),
		    .streamid_valid	(streamid_valid),
		    .rdy		(rdy),
		    // Inputs
		    .clk		(clk),
		    .rst		(rst),
		    .addrid		(addrid[95:0]),
		    .addrid_valid	(addrid_valid),
		    .dealloc		(dealloc));
   

endmodule // tb
