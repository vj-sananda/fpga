`timescale 1ns/1ns

module tb ;

parameter C_DWIDTH                       = 64;
parameter C_NUM_CE                       = 4;
parameter C_RDFIFO_DWIDTH                = 64;
parameter C_WRFIFO_DWIDTH                = 64;
   
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [0:C_DWIDTH/8-1]	bus2ip_be;		// To dut of user_logic.v
   reg			bus2ip_burst;		// To dut of user_logic.v
   reg			bus2ip_clk;		// To dut of user_logic.v
   reg [0:C_DWIDTH-1]	bus2ip_data;		// To dut of user_logic.v
   reg [0:C_NUM_CE-1]	bus2ip_rdce;		// To dut of user_logic.v
   reg			bus2ip_rdreq;		// To dut of user_logic.v
   reg			bus2ip_reset;		// To dut of user_logic.v
   reg [0:C_NUM_CE-1]	bus2ip_wrce;		// To dut of user_logic.v
   reg			bus2ip_wrreq;		// To dut of user_logic.v
   reg			rfifo2ip_almostfull;	// To dut of user_logic.v
   reg			rfifo2ip_full;		// To dut of user_logic.v
   reg			rfifo2ip_wrack;		// To dut of user_logic.v
   reg			wfifo2ip_almostempty;	// To dut of user_logic.v
   reg [0:C_WRFIFO_DWIDTH-1]wfifo2ip_data;	// To dut of user_logic.v
   reg			wfifo2ip_empty;		// To dut of user_logic.v
   reg			wfifo2ip_rdack;		// To dut of user_logic.v
   // End of automatics

   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			ip2bus_addrack;		// From dut of user_logic.v
   wire			ip2bus_busy;		// From dut of user_logic.v
   wire [0:C_DWIDTH-1]	ip2bus_data;		// From dut of user_logic.v
   wire			ip2bus_error;		// From dut of user_logic.v
   wire			ip2bus_rdack;		// From dut of user_logic.v
   wire			ip2bus_retry;		// From dut of user_logic.v
   wire			ip2bus_toutsup;		// From dut of user_logic.v
   wire			ip2bus_wrack;		// From dut of user_logic.v
   wire [0:C_RDFIFO_DWIDTH-1]ip2rfifo_data;	// From dut of user_logic.v
   wire			ip2rfifo_wrreq;		// From dut of user_logic.v
   wire			ip2wfifo_rdreq;		// From dut of user_logic.v
   // End of automatics

   reg [63:0] 		idata[0:50000] ;
   reg [4:0] 		idata_length ;

   reg [63:0] 		rkey[0:3] ;
   
   initial bus2ip_clk = 0;
   always #5 bus2ip_clk = ~bus2ip_clk ;

   reg 			code ;
   
   initial wfifo2ip_data = idata[0];
   initial wfifo2ip_empty = 0;
   initial wfifo2ip_almostempty = 0;
   initial rfifo2ip_full = 0;
   initial code = 0 ;

/* -----\/----- EXCLUDED -----\/-----
   always
     begin
	repeat (3) @(posedge bus2ip_clk);
	rfifo2ip_full <= ~rfifo2ip_full ;
     end
 -----/\----- EXCLUDED -----/\----- */

   always 
     begin
	repeat(20) @(posedge bus2ip_clk);
	rfifo2ip_full <= 1;
	repeat(20) @(posedge bus2ip_clk);
	rfifo2ip_full <= 0;
     end
	
   initial
     begin
	$dumpvars;
	$readmemh("encoded.dat",idata);

	bus2ip_reset = 1 ;
	repeat (10) @(posedge bus2ip_clk);
	bus2ip_reset = 0 ;
	repeat (1000) @(posedge bus2ip_clk);
	$finish;
     end

//   always @(ip2wfifo_rdreq)
//     wfifo2ip_rdack = ip2wfifo_rdreq;
   
   always @(posedge bus2ip_clk)
     begin
	wfifo2ip_rdack <=  0;
	
	if ( ip2wfifo_rdreq )
	  begin
	     repeat (3) @(posedge bus2ip_clk);
	     wfifo2ip_rdack <= 1 ;
	  end
     end

   integer idx ;
   initial idx = 0;

   initial
     begin
	wait( bus2ip_reset == 0) ;
	@(posedge bus2ip_clk );

	//Program global key
	write_reg(2,32'hb01dface);
	write_reg(3,32'h00000008);  		
	write_reg(3,32'h80000001);
	write_reg(3,32'h80000001);	
	write_reg(3,32'h00000008);  	
	
	write_reg(2,32'h0dec0ded);
	write_reg(3,32'h00000008);  			
	write_reg(3,32'h80000002);
	write_reg(3,32'h80000002);	
	write_reg(3,32'h00000008);  		
	
	write_reg(2,32'h0ba11ade);
	write_reg(3,32'h00000008);  			
	write_reg(3,32'h80000003);
	write_reg(3,32'h80000003);	
	write_reg(3,32'h00000008);  		
	
	write_reg(2,32'h0effec70);
	write_reg(3,32'h00000008);  			
	write_reg(3,32'h80000004);
	write_reg(3,32'h80000004);	
	write_reg(3,32'h00000008);  		

	//Control reg, reset index, no_compare, zero_key
	write_reg(0,64'h7);

	//Read Reg
	write_reg(3,32'h00000008);  		
	write_reg(3,32'h40000001);
	write_reg(3,32'h40000001);	
	write_reg(3,32'h00000008);  	
	read_reg(2,rkey[0]);
	
	write_reg(3,32'h00000008);  			
	write_reg(3,32'h40000002);
	write_reg(3,32'h40000002);	
	write_reg(3,32'h00000008);
	read_reg(2,rkey[1]);  		
	
	write_reg(3,32'h00000008);  			
	write_reg(3,32'h40000003);
	write_reg(3,32'h40000003);	
	write_reg(3,32'h00000008);  		
	read_reg(2,rkey[2]);  			

	write_reg(3,32'h00000008);  			
	write_reg(3,32'h40000004);
	write_reg(3,32'h40000004);	
	write_reg(3,32'h00000008);  		
	read_reg(2,rkey[3]);

	$display("Global Key = 0x%x_%x_%x_%x",
		 rkey[0],rkey[1],rkey[2],rkey[3]);
	
     end
   
   //model write fifo that is always sourcing data
   always @(posedge bus2ip_clk)
     begin
	//default assignments
	
	if ( ip2wfifo_rdreq )
	  begin
	     wfifo2ip_data <= idata[idx];
//	     $display("idata[%d] = 0x%x",idx,idata[idx]);
	     idx = idx + 1;
	  end
     end

//   always @(ip2rfifo_wrreq)
//     rfifo2ip_wrack = ip2rfifo_wrreq ;
   
   //model read fifo into which result is written into
   always @(posedge bus2ip_clk)
     begin
	rfifo2ip_wrack <=  0;
	
	if ( ip2rfifo_wrreq )
	  begin
	     repeat (3) @(posedge bus2ip_clk);
	     rfifo2ip_wrack <= 1 ;
	  end
   end

   always @(posedge bus2ip_clk)
     if ( rfifo2ip_wrack )
       $display ($time,"packed data = 0x%x", ip2rfifo_data);
       
   user_logic dut (/*autoinst*/
		   // Outputs
		   .ip2bus_data		(ip2bus_data[0:C_DWIDTH-1]),
		   .ip2bus_retry	(ip2bus_retry),
		   .ip2bus_error	(ip2bus_error),
		   .ip2bus_toutsup	(ip2bus_toutsup),
		   .ip2bus_addrack	(ip2bus_addrack),
		   .ip2bus_busy		(ip2bus_busy),
		   .ip2bus_rdack	(ip2bus_rdack),
		   .ip2bus_wrack	(ip2bus_wrack),
		   .ip2rfifo_wrreq	(ip2rfifo_wrreq),
		   .ip2rfifo_data	(ip2rfifo_data[0:C_RDFIFO_DWIDTH-1]),
		   .ip2wfifo_rdreq	(ip2wfifo_rdreq),
		   // Inputs
		   .bus2ip_clk		(bus2ip_clk),
		   .bus2ip_reset	(bus2ip_reset),
		   .bus2ip_data		(bus2ip_data[0:C_DWIDTH-1]),
		   .bus2ip_be		(bus2ip_be[0:C_DWIDTH/8-1]),
		   .bus2ip_burst	(bus2ip_burst),
		   .bus2ip_rdce		(bus2ip_rdce[0:C_NUM_CE-1]),
		   .bus2ip_wrce		(bus2ip_wrce[0:C_NUM_CE-1]),
		   .bus2ip_rdreq	(bus2ip_rdreq),
		   .bus2ip_wrreq	(bus2ip_wrreq),
		   .rfifo2ip_wrack	(rfifo2ip_wrack),
		   .rfifo2ip_almostfull	(rfifo2ip_almostfull),
		   .rfifo2ip_full	(rfifo2ip_full),
		   .wfifo2ip_data	(wfifo2ip_data[0:C_WRFIFO_DWIDTH-1]),
		   .wfifo2ip_rdack	(wfifo2ip_rdack),
		   .wfifo2ip_almostempty(wfifo2ip_almostempty),
		   .wfifo2ip_empty	(wfifo2ip_empty));

   task write_reg;
      input [1:0] reg_num;
      input [63:0] data ;

      begin

	 @(posedge bus2ip_clk);

	 case(reg_num)
	   0:bus2ip_wrce <= 4'b1000;
	   1:bus2ip_wrce <= 4'b0100;
	   2:bus2ip_wrce <= 4'b0010;
	   3:bus2ip_wrce <= 4'b0001;
	 endcase
	 
	 bus2ip_data <= data ;
	 @(posedge bus2ip_clk);
	 bus2ip_wrce <= 4'b0000;
    	 
      end
      
   endtask


   task read_reg;
      input [1:0] reg_num;
      output [63:0] data ;
      reg [63:0]    data ;
      
      begin
	 
	 @(posedge bus2ip_clk);

	 case(reg_num)
	   0:bus2ip_rdce <= 4'b1000;
	   1:bus2ip_rdce <= 4'b0100;
	   2:bus2ip_rdce <= 4'b0010;
	   3:bus2ip_rdce <= 4'b0001;
	 endcase
	 
	 data <= ip2bus_data;
	 @(posedge bus2ip_clk);
	 bus2ip_rdce <= 4'b0000;
 	 
      end
      
   endtask
   
endmodule // tb
