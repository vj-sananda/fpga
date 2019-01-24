`timescale 1ns/1ps

module user_logic
(
  // -- add user ports below this line ---------------
  // --user ports added here 
  // -- add user ports above this line ---------------

  // -- do not edit below this line ------------------
  // -- bus protocol ports, do not add to or delete
  /*AUTOARG*/
   // Outputs
   ip2bus_data, ip2bus_error, ip2bus_addrack, ip2bus_rdack,
   ip2bus_wrack, ip2wfifo_rdreq,IP2Bus_IntrEvent,
   // Inputs
   bus2ip_clk, bus2ip_reset, bus2ip_data, bus2ip_be, bus2ip_burst,
   bus2ip_rdce, bus2ip_wrce, bus2ip_rdreq, bus2ip_wrreq,
   Bus2IP_BurstLength, wfifo2ip_data, wfifo2ip_rdack,
   wfifo2ip_almostempty, wfifo2ip_empty
   ); // user_logic

// -- add user parameters below this line ------------
// --user parameters added here
// -- add user parameters above this line ------------

// -- do not edit below this line --------------------
// -- bus protocol parameters, do not add to or delete
parameter C_DWIDTH                       = 32;
parameter C_NUM_CE                       = 4;
parameter C_RDFIFO_DWIDTH                = 32;
parameter C_WRFIFO_DWIDTH                = 32;
parameter C_NUM_INTR                     = 1;

//parameter c_rdfifo_depth                 = 128;
//parameter c_wrfifo_depth                 = 128;
   
// -- do not edit above this line --------------------

// -- add user ports below this line -----------------
// --user ports added here 
// -- add user ports above this line -----------------

// -- do not edit below this line --------------------
// -- bus protocol ports, do not add to or delete
input                                     bus2ip_clk;
input                                     bus2ip_reset;
input      [0 : C_DWIDTH-1]               bus2ip_data;
input      [0 : C_DWIDTH/8-1]             bus2ip_be;
input                                     bus2ip_burst;
input      [0 : C_NUM_CE-1]               bus2ip_rdce;
input      [0 : C_NUM_CE-1]               bus2ip_wrce;
input                                     bus2ip_rdreq;
input                                     bus2ip_wrreq;
 input      [0 : 8]                        Bus2IP_BurstLength;
  output     [0 : C_NUM_INTR-1]             IP2Bus_IntrEvent;

output     [0 : C_DWIDTH-1]               ip2bus_data;
//output                                    ip2bus_retry;
output                                    ip2bus_error;
//output                                    ip2bus_toutsup;
output                                    ip2bus_addrack;
//output                                    ip2bus_busy;
output                                    ip2bus_rdack;
output                                    ip2bus_wrack;
//output                                    ip2rfifo_wrreq;
//output     [0 : C_RDFIFO_DWIDTH-1]        ip2rfifo_data;
//input                                     rfifo2ip_wrack;
//input                                     rfifo2ip_almostfull;
//input                                     rfifo2ip_full;
output                                    ip2wfifo_rdreq;
input      [0 : C_WRFIFO_DWIDTH-1]        wfifo2ip_data;
input                                     wfifo2ip_rdack;
input                                     wfifo2ip_almostempty;
input                                     wfifo2ip_empty;
// -- do not edit above this line --------------------

wire [15:0] count_ALL_0 ;
wire [15:0] count_ALL_1 ;
wire [15:0] count_ALL_2 ;
wire [15:0] count_ALL_3 ;
wire [15:0] count_ALL_4 ;
wire [15:0] count_finger_0 ;
wire [15:0] count_ftp_0 ;
wire [15:0] count_http_0 ;
wire [15:0] count_imap_0 ;
wire [15:0] count_netbios_0 ;
wire [15:0] count_nntp_0 ;
wire [15:0] count_pop3_0 ;
wire [15:0] count_rlogin_0 ;
wire [15:0] count_smtp_0 ;
wire [15:0] count_telnet_0 ;
wire [15:0] count_CATEGORY_finger ;
wire [15:0] count_CATEGORY_ftp ;
wire [15:0] count_CATEGORY_http ;
wire [15:0] count_CATEGORY_imap ;
wire [15:0] count_CATEGORY_netbios ;
wire [15:0] count_CATEGORY_nntp ;
wire [15:0] count_CATEGORY_pop3 ;
wire [15:0] count_CATEGORY_rlogin ;
wire [15:0] count_CATEGORY_smtp ;
wire [15:0] count_CATEGORY_telnet ;

`ifdef REGEX_OPTIONAL
wire [15:0] count_ALL_5 ;
wire [15:0] count_ALL_6 ;
wire [15:0] count_ALL_7 ;
wire [15:0] count_ALL_8 ;
wire [15:0] count_ALL_9 ;
wire [15:0] count_ALL_10 ;
wire [15:0] count_ALL_11 ;
wire [15:0] count_ALL_12 ;
wire [15:0] count_ALL_13 ;
wire [15:0] count_ALL_14 ;



wire [15:0] count_finger_1 ;
wire [15:0] count_finger_2 ;
wire [15:0] count_finger_3 ;
wire [15:0] count_finger_4 ;
wire [15:0] count_finger_5 ;

wire [15:0] count_ftp_1 ;
wire [15:0] count_ftp_2 ;
wire [15:0] count_ftp_3 ;
wire [15:0] count_ftp_4 ;
wire [15:0] count_ftp_5 ;
wire [15:0] count_ftp_6 ;
wire [15:0] count_ftp_7 ;
wire [15:0] count_ftp_8 ;
wire [15:0] count_ftp_9 ;



wire [15:0] count_http_1 ;
wire [15:0] count_http_2 ;
wire [15:0] count_http_3 ;
wire [15:0] count_http_4 ;
wire [15:0] count_http_5 ;
wire [15:0] count_http_6 ;
wire [15:0] count_http_7 ;
wire [15:0] count_http_8 ;
wire [15:0] count_http_9 ;

wire [15:0] count_imap_1 ;
wire [15:0] count_imap_2 ;
wire [15:0] count_imap_3 ;
wire [15:0] count_imap_4 ;
wire [15:0] count_imap_5 ;
wire [15:0] count_imap_6 ;
wire [15:0] count_imap_7 ;
wire [15:0] count_imap_8 ;
wire [15:0] count_imap_9 ;

wire [15:0] count_netbios_1 ;
wire [15:0] count_netbios_2 ;
wire [15:0] count_netbios_3 ;
wire [15:0] count_netbios_4 ;
wire [15:0] count_netbios_5 ;
wire [15:0] count_netbios_6 ;
wire [15:0] count_netbios_7 ;
wire [15:0] count_netbios_8 ;
wire [15:0] count_netbios_9 ;

wire [15:0] count_nntp_1 ;
wire [15:0] count_nntp_2 ;
wire [15:0] count_nntp_3 ;
wire [15:0] count_nntp_4 ;
wire [15:0] count_nntp_5 ;
wire [15:0] count_nntp_6 ;
wire [15:0] count_nntp_7 ;
wire [15:0] count_nntp_8 ;
wire [15:0] count_nntp_9 ;

wire [15:0] count_pop3_1 ;
wire [15:0] count_pop3_2 ;
wire [15:0] count_pop3_3 ;
wire [15:0] count_pop3_4 ;
wire [15:0] count_pop3_5 ;
wire [15:0] count_pop3_6 ;
wire [15:0] count_pop3_7 ;
wire [15:0] count_pop3_8 ;
wire [15:0] count_pop3_9 ;


wire [15:0] count_rlogin_1 ;
wire [15:0] count_rlogin_2 ;
wire [15:0] count_rlogin_3 ;
wire [15:0] count_rlogin_4 ;
wire [15:0] count_rlogin_5 ;


wire [15:0] count_smtp_1 ;
wire [15:0] count_smtp_2 ;
wire [15:0] count_smtp_3 ;
wire [15:0] count_smtp_4 ;
wire [15:0] count_smtp_5 ;
wire [15:0] count_smtp_6 ;
wire [15:0] count_smtp_7 ;
wire [15:0] count_smtp_8 ;
wire [15:0] count_smtp_9 ;


wire [15:0] count_telnet_1 ;
wire [15:0] count_telnet_2 ;
wire [15:0] count_telnet_3 ;
wire [15:0] count_telnet_4 ;
wire [15:0] count_telnet_5 ;
wire [15:0] count_telnet_6 ;
wire [15:0] count_telnet_7 ;
wire [15:0] count_telnet_8 ;
wire [15:0] count_telnet_9 ;

wire [15:0] count_CATEGORY_aim ;
wire [15:0] count_CATEGORY_bittorrent ;
wire [15:0] count_CATEGORY_cvs ;
wire [15:0] count_CATEGORY_dhcp ;
wire [15:0] count_CATEGORY_directconnect ;
wire [15:0] count_CATEGORY_dns ;
wire [15:0] count_CATEGORY_fasttrack ;
wire [15:0] count_CATEGORY_tor ;
wire [15:0] count_CATEGORY_vnc ;
wire [15:0] count_CATEGORY_worldofwarcraft ;
wire [15:0] count_CATEGORY_x11 ;
wire [15:0] count_CATEGORY_yahoo ;
wire [15:0] count_CATEGORY_freenet ;
wire [15:0] count_CATEGORY_gnutella ;
wire [15:0] count_CATEGORY_gopher ;
wire [15:0] count_CATEGORY_irc ;
wire [15:0] count_CATEGORY_jabber ;
wire [15:0] count_CATEGORY_msn ;
wire [15:0] count_CATEGORY_napster ;
wire [15:0] count_CATEGORY_sip ;
wire [15:0] count_CATEGORY_snmp ;
wire [15:0] count_CATEGORY_socks ;
wire [15:0] count_CATEGORY_ssh ;
wire [15:0] count_CATEGORY_ssl ;
wire [15:0] count_CATEGORY_subversion ;
`endif //  `ifdef REGEX_OPTIONAL
   
//----------------------------------------------------------------------------
// implementation
//----------------------------------------------------------------------------

  // --user nets declarations added here, as needed for user logic

  // nets for user logic slave model s/w accessible register example
  reg        [0 : C_DWIDTH-1]               slv_reg0;
  reg        [0 : C_DWIDTH-1]               slv_reg1;
  reg        [0 : C_DWIDTH-1]               slv_reg2;
  reg        [0 : C_DWIDTH-1]               slv_reg3;
   reg [0 : C_DWIDTH-1] 		    slv_reg3_wd;
  wire       [0 : 3]                        slv_reg_write_select;
  wire       [0 : 3]                        slv_reg_read_select;
  reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

   wire [0:(C_DWIDTH - 1)] ip2bus_data;
   wire 		   ip2bus_ack;
   wire 		   ip2bus_retry;
   wire 		   ip2bus_error;
   wire 		   ip2bus_toutsup;
   reg 			   ip2rfifo_wrreq;
   wire [0:(C_RDFIFO_DWIDTH - 1)] ip2rfifo_data;
   
  // --user logic implementation added here

  // ------------------------------------------------------
  // example code to read/write user logic slave model s/w accessible registers
  // 
  // note:
  // the example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // each bit of the bus2ip_wrce/bus2ip_rdce signals is configured to correspond
  // to one software accessible register by the top level template. for example,
  // if you have four 32 bit software accessible registers in the user logic, you
  // are basically operating on the following memory mapped registers:
  // 
  //    bus2ip_wrce or   memory mapped
  //       bus2ip_rdce   register
  //            "1000"   c_baseaddr + 0x0
  //            "0100"   c_baseaddr + 0x4
  //            "0010"   c_baseaddr + 0x8
  //            "0001"   c_baseaddr + 0xc
  // 
  // ------------------------------------------------------
  
  assign
    slv_reg_write_select = bus2ip_wrce[0:3],
    slv_reg_read_select  = bus2ip_rdce[0:3],
    slv_write_ack        = bus2ip_wrce[0] || bus2ip_wrce[1] || bus2ip_wrce[2] || bus2ip_wrce[3],
    slv_read_ack         = bus2ip_rdce[0] || bus2ip_rdce[1] || bus2ip_rdce[2] || bus2ip_rdce[3];

   wire [127:0] global_key;
   
   wire [2:0]  reg_select = slv_reg3[29:31];

  // implement slave model register(s)
  always @( posedge bus2ip_clk )
    begin: slave_reg_write_proc

      if ( bus2ip_reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
          slv_reg2 <= 0;
          slv_reg3 <= 0;
        end
      else
	begin
	   slv_reg3 <= slv_reg3_wd;

        case ( slv_reg_write_select )
          4'b1000 :
	    slv_reg0 <= bus2ip_data;

          4'b0100 :
	    slv_reg1 <= bus2ip_data;	    

          4'b0010 :
	    slv_reg2 <= bus2ip_data;

          4'b0001 :
	    slv_reg3 <= bus2ip_data;

          default : ; 
//	       begin
//		  if ( slv_reg3[33] )//Read
//		    case( reg_select)
//		      3'd1: slv_reg2 <= global_key[127:96];
//		      3'd2: slv_reg2 <= global_key[95:64] ;
//		      3'd3: slv_reg2 <= global_key[63:32] ;
//		      3'd4: slv_reg2 <= global_key[31:0]  ;	    
//		    endcase // case ( slv_reg1[16:31] )	  
//	       end // case: default

        endcase
	end // else: !if( bus2ip_reset == 1 )
       
    end // slave_reg_write_proc

   //Implement indirect Register addressing scheme
//   always @(posedge bus2ip_clk)
//     if (bus2ip_reset == 1)
//       begin
//	  global_key <= 0;
 //      end
//     else
//       begin
//	  if ( slv_reg3[32] )//Write
//	    case(reg_select)
//	      3'd1: global_key[127:96] <= slv_reg2[32:63] ;
//	      3'd2: global_key[95:64] <= slv_reg2[32:63] ;
//	      3'd3: global_key[63:32] <= slv_reg2[32:63] ;
//	      3'd4: global_key[31:0] <= slv_reg2[32:63] ;	    
//	    endcase // case ( slv_reg1[16:31] )
 //      end
   
  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 )
    begin: slave_reg_read_proc

      case ( slv_reg_read_select )
        4'b1000 : slv_ip2bus_data <= slv_reg0;
        4'b0100 : slv_ip2bus_data <= slv_reg1;
        4'b0010 : slv_ip2bus_data <= slv_reg2;
        4'b0001 : slv_ip2bus_data <= slv_reg3;
        default : slv_ip2bus_data <= 0;
      endcase

    end // slave_reg_read_proc

  // ------------------------------------------------------------
  // example code to drive ip to bus signals
  // ------------------------------------------------------------

  assign ip2bus_data        = slv_ip2bus_data;
  assign ip2bus_wrack       = slv_write_ack;
  assign ip2bus_rdack       = slv_read_ack;
  assign ip2bus_addrack     = slv_write_ack || slv_read_ack;
  assign ip2bus_busy        = 0;
  assign ip2bus_error       = 0;
  assign ip2bus_retry       = 0;
  assign ip2bus_toutsup     = 0;
   assign {ip2bus_ack}=(slv_write_ack | slv_read_ack);

   // *************************************************************
   wire   clk = bus2ip_clk ;
   wire   rst = bus2ip_reset ;
   
   reg [1:0] fifo_wr_cntl_cs ,fifo_wr_cntl_ns ;

   reg 	     rdy_rc,rdy_wc;
   wire      rdy = rdy_rc ;
   
   wire [C_DWIDTH-1:0] idata = wfifo2ip_data ;
   wire 	       idata_avail = ~wfifo2ip_empty ;
   wire 	       idata_valid = wfifo2ip_rdack;

   //From output fifo
   wire 	       almost_full;
   wire 	       odata_rdy = ~almost_full ;
   
   wire 	       idata_pop;
   
   wire 	       ip2wfifo_rdreq = idata_pop ;
   
   wire [38:0] 	       odata ;
   wire 	       odata_push ;

   wire [6:0] 	       streamid ;
   wire [15:0] 	       eop_cnt ;
      reg [15:0] 	       watchdog_cnt ;
   reg 		       fire_interrupt ;

   //synthesis translate_off
/* -----\/----- EXCLUDED -----\/-----
   always @(posedge clk)
     if ( odata_push )
       $display ("%t:Tag=%x, Data=%x",$time,odata[38:32],odata[31:0]);
 -----/\----- EXCLUDED -----/\----- */
   //synthesis translate_on
   always @*
     begin
	case(slv_reg2)
	  8'd0: slv_reg3_wd = eop_cnt ;
	  8'd1: slv_reg3_wd = count_ALL_0  ;
	  8'd2: slv_reg3_wd = count_ALL_1  ;
	  8'd3: slv_reg3_wd = count_ALL_2  ;
	  8'd4: slv_reg3_wd = count_ALL_3  ;
	  8'd5: slv_reg3_wd = count_ALL_4  ;
	  8'd6: slv_reg3_wd = count_finger_0  ;
	  8'd7: slv_reg3_wd = count_ftp_0  ;
	  8'd8: slv_reg3_wd = count_http_0  ;
	  8'd9: slv_reg3_wd = count_imap_0  ;
	  8'd10: slv_reg3_wd = count_netbios_0  ;
	  8'd11: slv_reg3_wd = count_nntp_0  ;
	  8'd12: slv_reg3_wd = count_pop3_0  ;
	  8'd13: slv_reg3_wd = count_rlogin_0  ;
	  8'd14: slv_reg3_wd = count_smtp_0  ;
	  8'd15: slv_reg3_wd = count_telnet_0  ;
	  8'd16: slv_reg3_wd = count_CATEGORY_finger  ;
	  8'd17: slv_reg3_wd = count_CATEGORY_ftp  ;
	  8'd18: slv_reg3_wd = count_CATEGORY_http  ;
	  8'd19: slv_reg3_wd = count_CATEGORY_imap  ;
	  8'd20: slv_reg3_wd = count_CATEGORY_netbios  ;
	  8'd21: slv_reg3_wd = count_CATEGORY_nntp  ;
	  8'd22: slv_reg3_wd = count_CATEGORY_pop3  ;
	  8'd23: slv_reg3_wd = count_CATEGORY_rlogin  ;
	  8'd24: slv_reg3_wd = count_CATEGORY_smtp  ;
	  8'd25: slv_reg3_wd = count_CATEGORY_telnet  ;

	  `ifdef REGEX_OPTIONAL
	  8'd26: slv_reg3_wd = count_ALL_5  ;
	  8'd27: slv_reg3_wd = count_ALL_6  ;
	  8'd28: slv_reg3_wd = count_ALL_7  ;
	  8'd29: slv_reg3_wd = count_ALL_8  ;
	  8'd30: slv_reg3_wd = count_ALL_9  ;
	  8'd31: slv_reg3_wd = count_ALL_10  ;
	  8'd32: slv_reg3_wd = count_ALL_11  ;
	  8'd33: slv_reg3_wd = count_ALL_12  ;
	  8'd34: slv_reg3_wd = count_ALL_13  ;
	  8'd35: slv_reg3_wd = count_ALL_14  ;
	  8'd36: slv_reg3_wd = count_finger_1  ;
	  8'd37: slv_reg3_wd = count_finger_2  ;
	  8'd38: slv_reg3_wd = count_finger_3  ;
	  8'd39: slv_reg3_wd = count_finger_4  ;
	  8'd40: slv_reg3_wd = count_finger_5  ;
	  8'd41: slv_reg3_wd = count_ftp_1  ;
	  8'd42: slv_reg3_wd = count_ftp_2  ;
	  8'd43: slv_reg3_wd = count_ftp_3  ;
	  8'd44: slv_reg3_wd = count_ftp_4  ;
	  8'd45: slv_reg3_wd = count_ftp_5  ;
	  8'd46: slv_reg3_wd = count_ftp_6  ;
	  8'd47: slv_reg3_wd = count_ftp_7  ;
	  8'd48: slv_reg3_wd = count_ftp_8  ;
	  8'd49: slv_reg3_wd = count_ftp_9  ;
	  8'd50: slv_reg3_wd = count_http_1  ;
	  8'd51: slv_reg3_wd = count_http_2  ;
	  8'd52: slv_reg3_wd = count_http_3  ;
	  8'd53: slv_reg3_wd = count_http_4  ;
	  8'd54: slv_reg3_wd = count_http_5  ;
	  8'd55: slv_reg3_wd = count_http_6  ;
	  8'd56: slv_reg3_wd = count_http_7  ;
	  8'd57: slv_reg3_wd = count_http_8  ;
	  8'd58: slv_reg3_wd = count_http_9  ;
	  8'd59: slv_reg3_wd = count_imap_1  ;
	  8'd60: slv_reg3_wd = count_imap_2  ;
	  8'd61: slv_reg3_wd = count_imap_3  ;
	  8'd62: slv_reg3_wd = count_imap_4  ;
	  8'd63: slv_reg3_wd = count_imap_5  ;
	  8'd64: slv_reg3_wd = count_imap_6  ;
	  8'd65: slv_reg3_wd = count_imap_7  ;
	  8'd66: slv_reg3_wd = count_imap_8  ;
	  8'd67: slv_reg3_wd = count_imap_9  ;
	  8'd68: slv_reg3_wd = count_netbios_1  ;
	  8'd69: slv_reg3_wd = count_netbios_2  ;
	  8'd70: slv_reg3_wd = count_netbios_3  ;
	  8'd71: slv_reg3_wd = count_netbios_4  ;
	  8'd72: slv_reg3_wd = count_netbios_5  ;
	  8'd73: slv_reg3_wd = count_netbios_6  ;
	  8'd74: slv_reg3_wd = count_netbios_7  ;
	  8'd75: slv_reg3_wd = count_netbios_8  ;
	  8'd76: slv_reg3_wd = count_netbios_9  ;
	  8'd77: slv_reg3_wd = count_nntp_1  ;
	  8'd78: slv_reg3_wd = count_nntp_2  ;
	  8'd79: slv_reg3_wd = count_nntp_3  ;
	  8'd80: slv_reg3_wd = count_nntp_4  ;
	  8'd81: slv_reg3_wd = count_nntp_5  ;
	  8'd82: slv_reg3_wd = count_nntp_6  ;
	  8'd83: slv_reg3_wd = count_nntp_7  ;
	  8'd84: slv_reg3_wd = count_nntp_8  ;
	  8'd85: slv_reg3_wd = count_nntp_9  ;
	  8'd86: slv_reg3_wd = count_pop3_1  ;
	  8'd87: slv_reg3_wd = count_pop3_2  ;
	  8'd88: slv_reg3_wd = count_pop3_3  ;
	  8'd89: slv_reg3_wd = count_pop3_4  ;
	  8'd90: slv_reg3_wd = count_pop3_5  ;
	  8'd91: slv_reg3_wd = count_pop3_6  ;
	  8'd92: slv_reg3_wd = count_pop3_7  ;
	  8'd93: slv_reg3_wd = count_pop3_8  ;
	  8'd94: slv_reg3_wd = count_pop3_9  ;
	  8'd95: slv_reg3_wd = count_rlogin_1  ;
	  8'd96: slv_reg3_wd = count_rlogin_2  ;
	  8'd97: slv_reg3_wd = count_rlogin_3  ;
	  8'd98: slv_reg3_wd = count_rlogin_4  ;
	  8'd99: slv_reg3_wd = count_rlogin_5  ;
	  8'd100: slv_reg3_wd = count_smtp_1  ;
	  8'd101: slv_reg3_wd = count_smtp_2  ;
	  8'd102: slv_reg3_wd = count_smtp_3  ;
	  8'd103: slv_reg3_wd = count_smtp_4  ;
	  8'd104: slv_reg3_wd = count_smtp_5  ;
	  8'd105: slv_reg3_wd = count_smtp_6  ;
	  8'd106: slv_reg3_wd = count_smtp_7  ;
	  8'd107: slv_reg3_wd = count_smtp_8  ;
	  8'd108: slv_reg3_wd = count_smtp_9  ;
	  8'd109: slv_reg3_wd = count_telnet_1  ;
	  8'd110: slv_reg3_wd = count_telnet_2  ;
	  8'd111: slv_reg3_wd = count_telnet_3  ;
	  8'd112: slv_reg3_wd = count_telnet_4  ;
	  8'd113: slv_reg3_wd = count_telnet_5  ;
	  8'd114: slv_reg3_wd = count_telnet_6  ;
	  8'd115: slv_reg3_wd = count_telnet_7  ;
	  8'd116: slv_reg3_wd = count_telnet_8  ;
	  8'd117: slv_reg3_wd = count_telnet_9  ;
	  8'd118: slv_reg3_wd = count_CATEGORY_aim  ;
	  8'd119: slv_reg3_wd = count_CATEGORY_bittorrent  ;
	  8'd120: slv_reg3_wd = count_CATEGORY_cvs  ;
	  8'd121: slv_reg3_wd = count_CATEGORY_dhcp  ;
	  8'd122: slv_reg3_wd = count_CATEGORY_directconnect  ;
	  8'd123: slv_reg3_wd = count_CATEGORY_dns  ;
	  8'd124: slv_reg3_wd = count_CATEGORY_fasttrack  ;
	  8'd125: slv_reg3_wd = count_CATEGORY_tor  ;
	  8'd126: slv_reg3_wd = count_CATEGORY_vnc  ;
	  8'd127: slv_reg3_wd = count_CATEGORY_worldofwarcraft  ;
	  8'd128: slv_reg3_wd = count_CATEGORY_x11  ;
	  8'd129: slv_reg3_wd = count_CATEGORY_yahoo  ;
	  8'd130: slv_reg3_wd = count_CATEGORY_freenet  ;
	  8'd131: slv_reg3_wd = count_CATEGORY_gnutella  ;
	  8'd132: slv_reg3_wd = count_CATEGORY_gopher  ;
	  8'd133: slv_reg3_wd = count_CATEGORY_irc  ;
	  8'd134: slv_reg3_wd = count_CATEGORY_jabber  ;
	  8'd135: slv_reg3_wd = count_CATEGORY_msn  ;
	  8'd136: slv_reg3_wd = count_CATEGORY_napster  ;
	  8'd137: slv_reg3_wd = count_CATEGORY_sip  ;
	  8'd138: slv_reg3_wd = count_CATEGORY_snmp  ;
	  8'd139: slv_reg3_wd = count_CATEGORY_socks  ;
	  8'd140: slv_reg3_wd = count_CATEGORY_ssh  ;
	  8'd141: slv_reg3_wd = count_CATEGORY_ssl  ;
	  8'd142: slv_reg3_wd = count_CATEGORY_subversion ;
	  `endif //  `ifdef REGEX_OPTIONAL
	  8'd255: slv_reg3_wd = watchdog_cnt ;
	  default: slv_reg3_wd = slv_reg3;
	endcase // case(slv_reg3)
     end

   wire empty;
   
   //------------------------------------------------------------------
   //Interrupt generation logic
   //Either after seeing EOP of Nth pkt, 
   //or Watchdog timer which fires after seeing tag_data_fifo_i 
   //continuously empty for N cycles
   //N programmed into slv_reg1
   //
   //slv_reg0 is the control register, choosing the kind of interrupt
   //slv_reg0[0] --> Nth packet, slv_reg0[31] --> N cycles
   //slv_reg0[1] --> resets interrupt
   //------------------------------------------------------------------

   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  watchdog_cnt <= 0;
	  fire_interrupt <= 0;
       end
     else
       begin
	  if ( (eop_cnt == slv_reg1) & slv_reg0[0] & (|eop_cnt) )
	    fire_interrupt <= 1;

	  if (slv_reg0[31])
	    begin
	       if ( empty  )//N cycles seeing empty high
		 watchdog_cnt <= watchdog_cnt + 1;
	       else
		 watchdog_cnt <= 0;

	       if ( watchdog_cnt == slv_reg1 )
		 fire_interrupt <= 1;
	    end

	  if ( slv_reg0[1] )
	    fire_interrupt <= 0;//to reset interrupt	  
       end
   
   wire  [0 : C_NUM_INTR-1]  IP2Bus_IntrEvent = fire_interrupt ;
   
   //------------------------------------------------------------------   
   
   
   tag_data_splitter tds_i ( 
			    // Outputs
			    .idata_pop		(idata_pop),
			    .odata		(odata[38:0]),
			    .odata_push		(odata_push),
			    // Inputs
			    .clk		(clk),
			    .rst		(rst),
			    .idata		(idata[31:0]),
			    .idata_avail	(idata_avail),
			    .idata_valid	(idata_valid),
			    .odata_rdy		(odata_rdy));

   wire 	       wr_en = odata_push ;
   wire [38:0] 	       din = odata;
   wire [38:0] 	       dout;
   wire 	       rd_en ;
   
   srlfifo39 tag_data_fifo_i ( 
			      // Outputs
			      .almost_empty	(almost_empty),
			      .almost_full	(almost_full),
			      .dout		(dout[38:0]),
			      .empty		(empty),
			      .full		(full),
			      // Inputs
			      .clk		(clk),
			      .din		(din[38:0]),
			      .rd_en		(rd_en),
			      .rst		(rst),
			      .wr_en		(wr_en));


   tag_parser tag_parser_i (
			    // Outputs
			    .data_pop		(rd_en),
			    .eop_cnt            (eop_cnt),

		     .count_ALL_0	(count_ALL_0[15:0]),
		     .count_ALL_1	(count_ALL_1[15:0]),
		     .count_ALL_2	(count_ALL_2[15:0]),
		     .count_ALL_3	(count_ALL_3[15:0]),
		     .count_ALL_4	(count_ALL_4[15:0]),
		     .count_finger_0	(count_finger_0[15:0]),
		     .count_ftp_0	(count_ftp_0[15:0]),
		     .count_http_0	(count_http_0[15:0]),
		     .count_imap_0	(count_imap_0[15:0]),
		     .count_netbios_0	(count_netbios_0[15:0]),
		     .count_nntp_0	(count_nntp_0[15:0]),
		     .count_pop3_0	(count_pop3_0[15:0]),
		     .count_rlogin_0	(count_rlogin_0[15:0]),
		     .count_smtp_0	(count_smtp_0[15:0]),
		     .count_telnet_0	(count_telnet_0[15:0]),
		     .count_CATEGORY_finger(count_CATEGORY_finger[15:0]),
		     .count_CATEGORY_ftp(count_CATEGORY_ftp[15:0]),
		     .count_CATEGORY_http(count_CATEGORY_http[15:0]),
		     .count_CATEGORY_imap(count_CATEGORY_imap[15:0]),
		     .count_CATEGORY_netbios(count_CATEGORY_netbios[15:0]),
		     .count_CATEGORY_nntp(count_CATEGORY_nntp[15:0]),
		     .count_CATEGORY_pop3(count_CATEGORY_pop3[15:0]),
		     .count_CATEGORY_rlogin(count_CATEGORY_rlogin[15:0]),
		     .count_CATEGORY_smtp(count_CATEGORY_smtp[15:0]),
		     .count_CATEGORY_telnet(count_CATEGORY_telnet[15:0]),

		     `ifdef REGEX_OPTIONAL
		     .count_ALL_5	(count_ALL_5[15:0]),
		     .count_ALL_6	(count_ALL_6[15:0]),
		     .count_ALL_7	(count_ALL_7[15:0]),
		     .count_ALL_8	(count_ALL_8[15:0]),
		     .count_ALL_9	(count_ALL_9[15:0]),
		     .count_ALL_10	(count_ALL_10[15:0]),
		     .count_ALL_11	(count_ALL_11[15:0]),
		     .count_ALL_12	(count_ALL_12[15:0]),
		     .count_ALL_13	(count_ALL_13[15:0]),
		     .count_ALL_14	(count_ALL_14[15:0]),
		     .count_finger_1	(count_finger_1[15:0]),
		     .count_finger_2	(count_finger_2[15:0]),
		     .count_finger_3	(count_finger_3[15:0]),
		     .count_finger_4	(count_finger_4[15:0]),
		     .count_finger_5	(count_finger_5[15:0]),
		     .count_ftp_1	(count_ftp_1[15:0]),
		     .count_ftp_2	(count_ftp_2[15:0]),
		     .count_ftp_3	(count_ftp_3[15:0]),
		     .count_ftp_4	(count_ftp_4[15:0]),
		     .count_ftp_5	(count_ftp_5[15:0]),
		     .count_ftp_6	(count_ftp_6[15:0]),
		     .count_ftp_7	(count_ftp_7[15:0]),
		     .count_ftp_8	(count_ftp_8[15:0]),
		     .count_ftp_9	(count_ftp_9[15:0]),
		     .count_http_1	(count_http_1[15:0]),
		     .count_http_2	(count_http_2[15:0]),
		     .count_http_3	(count_http_3[15:0]),
		     .count_http_4	(count_http_4[15:0]),
		     .count_http_5	(count_http_5[15:0]),
		     .count_http_6	(count_http_6[15:0]),
		     .count_http_7	(count_http_7[15:0]),
		     .count_http_8	(count_http_8[15:0]),
		     .count_http_9	(count_http_9[15:0]),
		     .count_imap_1	(count_imap_1[15:0]),
		     .count_imap_2	(count_imap_2[15:0]),
		     .count_imap_3	(count_imap_3[15:0]),
		     .count_imap_4	(count_imap_4[15:0]),
		     .count_imap_5	(count_imap_5[15:0]),
		     .count_imap_6	(count_imap_6[15:0]),
		     .count_imap_7	(count_imap_7[15:0]),
		     .count_imap_8	(count_imap_8[15:0]),
		     .count_imap_9	(count_imap_9[15:0]),
		     .count_netbios_1	(count_netbios_1[15:0]),
		     .count_netbios_2	(count_netbios_2[15:0]),
		     .count_netbios_3	(count_netbios_3[15:0]),
		     .count_netbios_4	(count_netbios_4[15:0]),
		     .count_netbios_5	(count_netbios_5[15:0]),
		     .count_netbios_6	(count_netbios_6[15:0]),
		     .count_netbios_7	(count_netbios_7[15:0]),
		     .count_netbios_8	(count_netbios_8[15:0]),
		     .count_netbios_9	(count_netbios_9[15:0]),
		     .count_nntp_1	(count_nntp_1[15:0]),
		     .count_nntp_2	(count_nntp_2[15:0]),
		     .count_nntp_3	(count_nntp_3[15:0]),
		     .count_nntp_4	(count_nntp_4[15:0]),
		     .count_nntp_5	(count_nntp_5[15:0]),
		     .count_nntp_6	(count_nntp_6[15:0]),
		     .count_nntp_7	(count_nntp_7[15:0]),
		     .count_nntp_8	(count_nntp_8[15:0]),
		     .count_nntp_9	(count_nntp_9[15:0]),
		     .count_pop3_1	(count_pop3_1[15:0]),
		     .count_pop3_2	(count_pop3_2[15:0]),
		     .count_pop3_3	(count_pop3_3[15:0]),
		     .count_pop3_4	(count_pop3_4[15:0]),
		     .count_pop3_5	(count_pop3_5[15:0]),
		     .count_pop3_6	(count_pop3_6[15:0]),
		     .count_pop3_7	(count_pop3_7[15:0]),
		     .count_pop3_8	(count_pop3_8[15:0]),
		     .count_pop3_9	(count_pop3_9[15:0]),
		     .count_rlogin_1	(count_rlogin_1[15:0]),
		     .count_rlogin_2	(count_rlogin_2[15:0]),
		     .count_rlogin_3	(count_rlogin_3[15:0]),
		     .count_rlogin_4	(count_rlogin_4[15:0]),
		     .count_rlogin_5	(count_rlogin_5[15:0]),
		     .count_smtp_1	(count_smtp_1[15:0]),
		     .count_smtp_2	(count_smtp_2[15:0]),
		     .count_smtp_3	(count_smtp_3[15:0]),
		     .count_smtp_4	(count_smtp_4[15:0]),
		     .count_smtp_5	(count_smtp_5[15:0]),
		     .count_smtp_6	(count_smtp_6[15:0]),
		     .count_smtp_7	(count_smtp_7[15:0]),
		     .count_smtp_8	(count_smtp_8[15:0]),
		     .count_smtp_9	(count_smtp_9[15:0]),
		     .count_telnet_1	(count_telnet_1[15:0]),
		     .count_telnet_2	(count_telnet_2[15:0]),
		     .count_telnet_3	(count_telnet_3[15:0]),
		     .count_telnet_4	(count_telnet_4[15:0]),
		     .count_telnet_5	(count_telnet_5[15:0]),
		     .count_telnet_6	(count_telnet_6[15:0]),
		     .count_telnet_7	(count_telnet_7[15:0]),
		     .count_telnet_8	(count_telnet_8[15:0]),
		     .count_telnet_9	(count_telnet_9[15:0]),
		     .count_CATEGORY_aim(count_CATEGORY_aim[15:0]),
		     .count_CATEGORY_bittorrent(count_CATEGORY_bittorrent[15:0]),
		     .count_CATEGORY_cvs(count_CATEGORY_cvs[15:0]),
		     .count_CATEGORY_dhcp(count_CATEGORY_dhcp[15:0]),
		     .count_CATEGORY_directconnect(count_CATEGORY_directconnect[15:0]),
		     .count_CATEGORY_dns(count_CATEGORY_dns[15:0]),
		     .count_CATEGORY_fasttrack(count_CATEGORY_fasttrack[15:0]),
		     .count_CATEGORY_tor(count_CATEGORY_tor[15:0]),
		     .count_CATEGORY_vnc(count_CATEGORY_vnc[15:0]),
		     .count_CATEGORY_worldofwarcraft(count_CATEGORY_worldofwarcraft[15:0]),
		     .count_CATEGORY_x11(count_CATEGORY_x11[15:0]),
		     .count_CATEGORY_yahoo(count_CATEGORY_yahoo[15:0]),
		     .count_CATEGORY_freenet(count_CATEGORY_freenet[15:0]),
		     .count_CATEGORY_gnutella(count_CATEGORY_gnutella[15:0]),
		     .count_CATEGORY_gopher(count_CATEGORY_gopher[15:0]),
		     .count_CATEGORY_irc(count_CATEGORY_irc[15:0]),
		     .count_CATEGORY_jabber(count_CATEGORY_jabber[15:0]),
		     .count_CATEGORY_msn(count_CATEGORY_msn[15:0]),
		     .count_CATEGORY_napster(count_CATEGORY_napster[15:0]),
		     .count_CATEGORY_sip(count_CATEGORY_sip[15:0]),
		     .count_CATEGORY_snmp(count_CATEGORY_snmp[15:0]),
		     .count_CATEGORY_socks(count_CATEGORY_socks[15:0]),
		     .count_CATEGORY_ssh(count_CATEGORY_ssh[15:0]),
		     .count_CATEGORY_ssl(count_CATEGORY_ssl[15:0]),
		     .count_CATEGORY_subversion(count_CATEGORY_subversion[15:0]),
		     `endif



			    // Inputs
			    .clk		(clk),
			    .rst		(rst),
			    .data		(dout),
			    .data_fifo_empty	(empty),
			    .data_fifo_almost_empty(almost_empty));
   
endmodule
