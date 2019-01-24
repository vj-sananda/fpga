`timescale 1ns/1ps

module tb ;

parameter C_DWIDTH                       = 32;
parameter C_NUM_CE                       = 4;
parameter C_RDFIFO_DWIDTH                = 32;
parameter C_WRFIFO_DWIDTH                = 32;
 parameter C_NUM_INTR                     = 1;
  
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

   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [0:C_NUM_INTR-1] IP2Bus_IntrEvent;
   
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

   reg [31:0] 		idata[0:1638400] ;
   reg [4:0] 		idata_length ;

   reg [31:0] 		rkey[0:3] ;

   wire 		clk = bus2ip_clk;
   wire 		rst = bus2ip_reset ;
   
   initial bus2ip_clk = 0;
   always #5 bus2ip_clk = ~bus2ip_clk ;

   reg 			code ;
   //Read cmd line args
   reg [15:0] pktcnt;
   reg [100:0] datafile;
   
   integer    status;
   initial 
     begin
	pktcnt=20;
	status = $value$plusargs("pktcnt=%d",pktcnt);
	$display("cmd line arg: +pktcnt=%d",pktcnt);

	status = $value$plusargs("data=%s",datafile);
	$display("cmd line arg: +data=%s",datafile);	
     end
   
   
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

   reg [0:31] ctrl_data ;
	
   initial
     begin

`ifdef WAVES
`ifdef VCS_SIM
	$fsdbDumpvars;
`else
	$dumpvars;
`endif
`endif
	
	$readmemh(datafile,idata);
	
	bus2ip_reset = 1 ;
	repeat (10) @(posedge bus2ip_clk);
	bus2ip_reset = 0 ;

	repeat(1) @(posedge clk);
	

	//Pkt cnt interrupt
	ctrl_data = 0;
	ctrl_data[0] = 1;
	write_reg(0,ctrl_data);
	write_reg(1,pktcnt);

	//watchdog cnt interrupt
	//ctrl_data = 0;
	//ctrl_data[31] = 1;
	//write_reg(0,ctrl_data);
	//write_reg(1,40);
	
     end // initial begin
   
   
   always @(ip2wfifo_rdreq)
     wfifo2ip_rdack = #1 ip2wfifo_rdreq & ~wfifo2ip_empty ;
   

/* -----\/----- EXCLUDED -----\/-----
      always @(posedge bus2ip_clk)
     begin
	wfifo2ip_rdack <=  0;
	
	if ( ip2wfifo_rdreq )
	  begin
	     repeat (3) @(posedge bus2ip_clk);
	     wfifo2ip_rdack <= 1 ;
	     @(posedge bus2ip_clk);
	     wfifo2ip_rdack <= 0 ;
	     @(posedge bus2ip_clk);
	     @(posedge bus2ip_clk);
	     @(posedge bus2ip_clk);	     	     
	  end
     end
 -----/\----- EXCLUDED -----/\----- */

   integer idx ;
   initial idx = 0;

  
   //Register writes and reads
   initial
     begin
	wait( bus2ip_reset == 0) ;
	@(posedge bus2ip_clk );
     end
   
    //model write fifo that is always sourcing data
   initial
     begin
	wfifo2ip_data <= idata[idx];
	wait ( bus2ip_reset );
	repeat (10) @(posedge bus2ip_clk);
	
	forever
	  begin
	     @(posedge bus2ip_clk);
	     if ( ip2wfifo_rdreq )
	       begin
		  idx = idx + 1;
		  wfifo2ip_data <= idata[idx];
		  //if ( idx == 90) wfifo2ip_empty <= 1;
		  //if ( idx == 1638400 )
		  //if ( idx == 9000 )
/* -----\/----- EXCLUDED -----\/-----
		  if ( dut.eop_cnt == pktcnt)
		    begin
		       repeat(20) @(posedge bus2ip_clk);
		       $display ( "%t::Finish at idx = %d",$time,idx);
		       $display ( "%t::Finish at Pktcnt = %d",$time,dut.eop_cnt);    
		       display_cancid_counters;
		       //	     $display("idata[%d] = 0x%x",idx,idata[idx]);   
		       $finish;
		    end
 -----/\----- EXCLUDED -----/\----- */
	       end // if ( ip2wfifo_rdreq )
	  end // forever begin
     end // initial begin
   
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

   reg [15:0] value ;
   always @(posedge clk or posedge rst)
     if (~rst && IP2Bus_IntrEvent )
       begin
	  repeat(5) @(posedge clk);
	  
	  read_count(0,value);
	  read_count(1,value);
	  display_cancid_counters;

	  repeat(50) @(posedge clk);

	  $finish;
       end
   
   user_logic dut (/*autoinst*/
		   // Outputs
		   .IP2Bus_IntrEvent	(IP2Bus_IntrEvent[0:C_NUM_INTR-1]),
		   .ip2bus_data		(ip2bus_data[0:C_DWIDTH-1]),
		   .ip2bus_error	(ip2bus_error),
		   .ip2bus_addrack	(ip2bus_addrack),
		   .ip2bus_rdack	(ip2bus_rdack),
		   .ip2bus_wrack	(ip2bus_wrack),
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
//		   .Bus2IP_BurstLength	(Bus2IP_BurstLength[0:8]),
		   .wfifo2ip_data	(wfifo2ip_data[0:C_WRFIFO_DWIDTH-1]),
		   .wfifo2ip_rdack	(wfifo2ip_rdack),
		   .wfifo2ip_almostempty(wfifo2ip_almostempty),
		   .wfifo2ip_empty	(wfifo2ip_empty));


   task read_count;
      input [7:0] countidx ;
      output [15:0] value ;
      reg [15:0] value ;
      begin
	 write_reg(2,countidx);
	 read_reg(3,value);
      end
   endtask // read_count
	     
   task write_reg;
      input [1:0] reg_num;
      input [31:0] data ;

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
      output [31:0] data ;
      reg [31:0]    data ;
      
      begin
	 
	 @(posedge bus2ip_clk);

	 case(reg_num)
	   0:bus2ip_rdce <= 4'b1000;
	   1:bus2ip_rdce <= 4'b0100;
	   2:bus2ip_rdce <= 4'b0010;
	   3:bus2ip_rdce <= 4'b0001;
	 endcase
	 
	 data <= ip2bus_data;
	 $display("%t,read_reg = %x",$time,data);
	 
	 @(posedge bus2ip_clk);
	 bus2ip_rdce <= 4'b0000;
 	 
      end
      
   endtask

   task display_cancid_counters;
      begin

	 $display("count_CATEGORY_finger = %d",dut.count_CATEGORY_finger);
	 
	 $display("count_CATEGORY_ftp = %d",dut.count_CATEGORY_ftp);
	 
	 $display("count_CATEGORY_http = %d",dut.count_CATEGORY_http);
	 
	 $display("count_CATEGORY_imap = %d",dut.count_CATEGORY_imap);
	 
	 $display("count_CATEGORY_netbios = %d",dut.count_CATEGORY_netbios);
	 
	 $display("count_CATEGORY_nntp = %d",dut.count_CATEGORY_nntp);
	 
	 $display("count_CATEGORY_pop3 = %d",dut.count_CATEGORY_pop3);
	 
	 $display("count_CATEGORY_rlogin = %d",dut.count_CATEGORY_rlogin);
	 
	 $display("count_CATEGORY_smtp = %d",dut.count_CATEGORY_smtp);
	 
	 $display("count_CATEGORY_telnet = %d\n",dut.count_CATEGORY_telnet);
	 
	 $display("count_CATEGORY_aim = %d",dut.count_CATEGORY_aim);
	 
	 $display("count_CATEGORY_bittorrent    = %d",dut.count_CATEGORY_bittorrent);
	 
	 $display("count_CATEGORY_cvs           = %d",dut.count_CATEGORY_cvs);
	 
	 $display("count_CATEGORY_dhcp          = %d",dut.count_CATEGORY_dhcp);
	 
	 $display("count_CATEGORY_directconnect = %d",dut.count_CATEGORY_directconnect);
	 
	 $display("count_CATEGORY_dns = %d",dut.count_CATEGORY_dns);
	 
	 $display("count_CATEGORY_fasttrack = %d",dut.count_CATEGORY_fasttrack);
	 
	 $display("count_CATEGORY_tor = %d",dut.count_CATEGORY_tor);
	 
	 $display("count_CATEGORY_vnc = %d",dut.count_CATEGORY_vnc);
	 
	 $display("count_CATEGORY_worldofwarcraft = %d",dut.count_CATEGORY_worldofwarcraft);
	 
	 $display("count_CATEGORY_x11 = %d",dut.count_CATEGORY_x11);
	 
	 $display("count_CATEGORY_yahoo = %d",dut.count_CATEGORY_yahoo);
	 
	 $display("count_CATEGORY_freenet = %d",dut.count_CATEGORY_freenet);
	 
	 $display("count_CATEGORY_gnutella = %d",dut.count_CATEGORY_gnutella);
	 
	 $display("count_CATEGORY_gopher = %d",dut.count_CATEGORY_gopher);
	 
	 $display("count_CATEGORY_irc = %d",dut.count_CATEGORY_irc);
	 
	 $display("count_CATEGORY_jabber = %d",dut.count_CATEGORY_jabber);
	 
	 $display("count_CATEGORY_msn = %d",dut.count_CATEGORY_msn);
	 
	 $display("count_CATEGORY_napster = %d",dut.count_CATEGORY_napster);
	 
	 $display("count_CATEGORY_sip = %d",dut.count_CATEGORY_sip);
	 
	 $display("count_CATEGORY_snmp = %d",dut.count_CATEGORY_snmp);
	 
	 $display("count_CATEGORY_socks = %d",dut.count_CATEGORY_socks);
	 
	 $display("count_CATEGORY_ssh = %d",dut.count_CATEGORY_ssh);
	 
	 $display("count_CATEGORY_ssl = %d",dut.count_CATEGORY_ssl);
	 
	 $display("count_CATEGORY_subversion 	 = %d\n",dut.count_CATEGORY_subversion 	);


	 $display("count_finger  = %d",
		  dut.count_finger_0 + dut.count_finger_1 +
		  dut.count_finger_2 + dut.count_finger_3 +
		  dut.count_finger_4 + dut.count_finger_5 );
	 
	 $display("count_ftp     = %d",
		  dut.count_ftp_0 +dut.count_ftp_1 +
		  dut.count_ftp_2 +dut.count_ftp_3 + 
		  dut.count_ftp_4 +dut.count_ftp_5 + 
		  dut.count_ftp_6 +dut.count_ftp_7 + 
		  dut.count_ftp_8 +dut.count_ftp_9 );

	 $display("count_http     = %d",
		  dut.count_http_0 +dut.count_http_1 +
		  dut.count_http_2 +dut.count_http_3 + 
		  dut.count_http_4 +dut.count_http_5 + 
		  dut.count_http_6 +dut.count_http_7 + 
		  dut.count_http_8 +dut.count_http_9 );	 

	 $display("count_imap     = %d",
		  dut.count_imap_0 +dut.count_imap_1 +
		  dut.count_imap_2 +dut.count_imap_3 + 
		  dut.count_imap_4 +dut.count_imap_5 + 
		  dut.count_imap_6 +dut.count_imap_7 + 
		  dut.count_imap_8 +dut.count_imap_9 );

	 $display("count_netbios     = %d",
		  dut.count_netbios_0 +dut.count_netbios_1 +
		  dut.count_netbios_2 +dut.count_netbios_3 + 
		  dut.count_netbios_4 +dut.count_netbios_5 + 
		  dut.count_netbios_6 +dut.count_netbios_7 + 
		  dut.count_netbios_8 +dut.count_netbios_9 );

	 $display("count_nntp     = %d",
		  dut.count_nntp_0 +dut.count_nntp_1 +
		  dut.count_nntp_2 +dut.count_nntp_3 + 
		  dut.count_nntp_4 +dut.count_nntp_5 + 
		  dut.count_nntp_6 +dut.count_nntp_7 + 
		  dut.count_nntp_8 +dut.count_nntp_9 );

	 $display("count_pop3     = %d",
		  dut.count_pop3_0 +dut.count_pop3_1 +
		  dut.count_pop3_2 +dut.count_pop3_3 + 
		  dut.count_pop3_4 +dut.count_pop3_5 + 
		  dut.count_pop3_6 +dut.count_pop3_7 + 
		  dut.count_pop3_8 +dut.count_pop3_9 );

	 $display("count_rlogin  = %d",
		  dut.count_rlogin_0 + dut.count_rlogin_1 +
		  dut.count_rlogin_2 + dut.count_rlogin_3 +
		  dut.count_rlogin_4 + dut.count_rlogin_5 );

	 $display("count_smtp     = %d",
		  dut.count_smtp_0 +dut.count_smtp_1 +
		  dut.count_smtp_2 +dut.count_smtp_3 + 
		  dut.count_smtp_4 +dut.count_smtp_5 + 
		  dut.count_smtp_6 +dut.count_smtp_7 + 
		  dut.count_smtp_8 +dut.count_smtp_9 );	 

	 $display("count_telnet     = %d",
		  dut.count_telnet_0 +dut.count_telnet_1 +
		  dut.count_telnet_2 +dut.count_telnet_3 + 
		  dut.count_telnet_4 +dut.count_telnet_5 + 
		  dut.count_telnet_6 +dut.count_telnet_7 + 
		  dut.count_telnet_8 +dut.count_telnet_9 );	 
	 
	 $display("count_ALL = %d",
		  dut.count_ALL_0 + dut.count_ALL_1 +
		  dut.count_ALL_2 + dut.count_ALL_3 +
		  dut.count_ALL_4 + dut.count_ALL_5 +
		  dut.count_ALL_6 + dut.count_ALL_7 +
		  dut.count_ALL_8 + dut.count_ALL_9 +
		  dut.count_ALL_10 + dut.count_ALL_11 +
		  dut.count_ALL_12 + dut.count_ALL_13 +
		  dut.count_ALL_14 );
	 
//--------------------------------------------------------------------------------
		 $display("dut.tag_parser_i.count_finger_0 = %d",dut.tag_parser_i.count_finger_0);
	 $display("dut.tag_parser_i.count_ftp_0 = %d",dut.tag_parser_i.count_ftp_0);
	 $display("dut.tag_parser_i.count_http_0 = %d",dut.tag_parser_i.count_http_0);
	 $display("dut.tag_parser_i.count_imap_0 = %d",dut.tag_parser_i.count_imap_0);
	 $display("dut.tag_parser_i.count_netbios_0 = %d",dut.tag_parser_i.count_netbios_0);
	 $display("dut.tag_parser_i.count_nntp_0 = %d",dut.tag_parser_i.count_nntp_0);
	 $display("dut.tag_parser_i.count_pop3_0 = %d",dut.tag_parser_i.count_pop3_0);
	 $display("dut.tag_parser_i.count_rlogin_0 = %d",dut.tag_parser_i.count_rlogin_0);
	 $display("dut.tag_parser_i.count_smtp_0 = %d",dut.tag_parser_i.count_smtp_0);
	 $display("dut.tag_parser_i.count_telnet_0 = %d",dut.tag_parser_i.count_telnet_0);
	 $display("dut.tag_parser_i.count_ALL_0 = %d",dut.tag_parser_i.count_ALL_0);
//--------------------------------------------------------------------------------	 
      end
   endtask

   //initial  $monitor($time,"::Packet Count = %d", dut.eop_cnt);
   
     
endmodule // tb
