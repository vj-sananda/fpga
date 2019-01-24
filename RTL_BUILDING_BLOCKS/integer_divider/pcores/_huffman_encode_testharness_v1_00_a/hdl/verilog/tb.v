`timescale 1ns/1ns

module tb ;

   parameter  [31:0]  c_dwidth =32;
   parameter [31:0]   c_num_ce =2;
   parameter [31:0]   c_rdfifo_dwidth =32;
   parameter [31:0]   c_rdfifo_depth =512;
   parameter [31:0]   c_wrfifo_dwidth =32;
   parameter [31:0]   c_wrfifo_depth =512;
   
   /*autoreginput*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [0:c_dwidth/8-1]	bus2ip_be;		// To dut of user_logic.v
   reg			bus2ip_clk;		// To dut of user_logic.v
   reg [0:c_dwidth-1]	bus2ip_data;		// To dut of user_logic.v
   reg [0:c_num_ce-1]	bus2ip_rdce;		// To dut of user_logic.v
   reg			bus2ip_reset;		// To dut of user_logic.v
   reg [0:c_num_ce-1]	bus2ip_wrce;		// To dut of user_logic.v
   reg			rfifo2ip_almostfull;	// To dut of user_logic.v
   reg			rfifo2ip_full;		// To dut of user_logic.v
   reg [0:9]		rfifo2ip_vacancy;	// To dut of user_logic.v
   reg			rfifo2ip_wrack;		// To dut of user_logic.v
   reg			wfifo2ip_almostempty;	// To dut of user_logic.v
   reg [0:c_wrfifo_dwidth-1]wfifo2ip_data;	// To dut of user_logic.v
   reg			wfifo2ip_empty;		// To dut of user_logic.v
   reg [0:9]		wfifo2ip_occupancy;	// To dut of user_logic.v
   reg			wfifo2ip_rdack;		// To dut of user_logic.v
   // End of automatics

   /*autowire*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			ip2bus_ack;		// From dut of user_logic.v
   wire [0:c_dwidth-1]	ip2bus_data;		// From dut of user_logic.v
   wire			ip2bus_error;		// From dut of user_logic.v
   wire			ip2bus_retry;		// From dut of user_logic.v
   wire			ip2bus_toutsup;		// From dut of user_logic.v
   wire [0:c_rdfifo_dwidth-1]ip2rfifo_data;	// From dut of user_logic.v
   wire			ip2rfifo_wrreq;		// From dut of user_logic.v
   wire			ip2wfifo_rdreq;		// From dut of user_logic.v
   // End of automatics

   reg [31:0] 		idata[0:50000] ;
   reg [4:0] 		idata_length ;
		
   initial bus2ip_clk = 0;
   always #5 bus2ip_clk = ~bus2ip_clk ;

   reg 			code ;
   
   initial wfifo2ip_data = idata[0];
   initial wfifo2ip_empty = 0;
   initial wfifo2ip_almostempty = 0;
   initial wfifo2ip_occupancy = 5;
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
	repeat (10000) @(posedge bus2ip_clk);
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
   
   //model write fifo that is always sourcing data
   always @(posedge bus2ip_clk)
     begin
	//default assignments
	
	if ( ip2wfifo_rdreq )
	  begin
	     wfifo2ip_data <= idata[idx];
	     $display("idata[%d] = 0x%x",idx,idata[idx]);
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
		   .ip2bus_data		(ip2bus_data[0:c_dwidth-1]),
		   .ip2bus_ack		(ip2bus_ack),
		   .ip2bus_retry	(ip2bus_retry),
		   .ip2bus_error	(ip2bus_error),
		   .ip2bus_toutsup	(ip2bus_toutsup),
		   .ip2rfifo_wrreq	(ip2rfifo_wrreq),
		   .ip2rfifo_data	(ip2rfifo_data[0:c_rdfifo_dwidth-1]),
		   .ip2wfifo_rdreq	(ip2wfifo_rdreq),
		   // Inputs
		   .bus2ip_clk		(bus2ip_clk),
		   .bus2ip_reset	(bus2ip_reset),
		   .bus2ip_data		(bus2ip_data[0:c_dwidth-1]),
		   .bus2ip_be		(bus2ip_be[0:c_dwidth/8-1]),
		   .bus2ip_rdce		(bus2ip_rdce[0:c_num_ce-1]),
		   .bus2ip_wrce		(bus2ip_wrce[0:c_num_ce-1]),
		   .rfifo2ip_wrack	(rfifo2ip_wrack),
		   .rfifo2ip_almostfull	(rfifo2ip_almostfull),
		   .rfifo2ip_full	(rfifo2ip_full),
		   .rfifo2ip_vacancy	(rfifo2ip_vacancy[0:9]),
		   .wfifo2ip_data	(wfifo2ip_data[0:c_wrfifo_dwidth-1]),
		   .wfifo2ip_rdack	(wfifo2ip_rdack),
		   .wfifo2ip_almostempty(wfifo2ip_almostempty),
		   .wfifo2ip_empty	(wfifo2ip_empty),
		   .wfifo2ip_occupancy	(wfifo2ip_occupancy[0:9]));
   
endmodule // tb
