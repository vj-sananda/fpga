`timescale 1ns/1ps

`define REGEX_OPTIONAL true

//Parse Packet data using Tag
//Create address Id look up in CAM
`define TAG_ADDRID_0 0
`define TAG_ADDRID_1 1
`define TAG_ADDRID_2 2
`define TAG_EOP      4
`define TAG_EOS      3
`define TAG_PAYLOAD  6

//Fields within each 39 bit data payload
`define TAGBYTE 38:32
`define PKTDATA 31:0

//One hot encoded fields for category_mem data
`define CATEGORY_aim 		 1
`define CATEGORY_bittorrent 		 2
`define CATEGORY_cvs 		 3
`define CATEGORY_dhcp 		 4
`define CATEGORY_directconnect 		 5
`define CATEGORY_dns 		 6
`define CATEGORY_fasttrack 		 7
`define CATEGORY_finger 		 8
`define CATEGORY_freenet 		 9
`define CATEGORY_ftp 		 10
`define CATEGORY_gnutella 		 11
`define CATEGORY_gopher 		 12
`define CATEGORY_http 		 13
`define CATEGORY_imap 		 14
`define CATEGORY_irc 		 15
`define CATEGORY_jabber 		 16
`define CATEGORY_msn 		 17
`define CATEGORY_napster 		 18
`define CATEGORY_netbios 		 19
`define CATEGORY_nntp 		 20
`define CATEGORY_pop3 		 21
`define CATEGORY_rlogin 		 22
`define CATEGORY_sip 		 23
`define CATEGORY_smtp 		 24
`define CATEGORY_snmp 		 25
`define CATEGORY_socks 		 26
`define CATEGORY_ssh 		 27
`define CATEGORY_ssl 		 28
`define CATEGORY_subversion 		 29
`define CATEGORY_telnet 		 30
`define CATEGORY_tor 		 31
`define CATEGORY_vnc 		 32
`define CATEGORY_worldofwarcraft 		 33
`define CATEGORY_x11 		 34
`define CATEGORY_yahoo 		 35

//WTD:Check on this, First 4 packets in each stream will be used for characterization
`define MAX_PACKET_CATEGORIZATION_COUNT 4

//2 bit count
`define STREAMID_PKT_COUNT 38:36 

//if the category is 0 then it means its not categorized
//1-hot coded for each category
`define STREAMID_CATEGORY  35:0 


module tag_parser(/*AUTOARG*/
   // Outputs
   eop_cnt, data_pop, count_ALL_0, count_ALL_1, count_ALL_2, 
   count_ALL_3, count_ALL_4, count_finger_0, count_ftp_0, 
   count_http_0, count_imap_0, count_netbios_0, count_nntp_0, 
   count_pop3_0, count_rlogin_0, count_smtp_0, count_telnet_0, 
   count_CATEGORY_finger, count_CATEGORY_ftp, count_CATEGORY_http, 
   count_CATEGORY_imap, count_CATEGORY_netbios, count_CATEGORY_nntp, 
   count_CATEGORY_pop3, count_CATEGORY_rlogin, count_CATEGORY_smtp, 
   count_CATEGORY_telnet, count_ALL_5, count_ALL_6, count_ALL_7, 
   count_ALL_8, count_ALL_9, count_ALL_10, count_ALL_11, 
   count_ALL_12, count_ALL_13, count_ALL_14, count_finger_1, 
   count_finger_2, count_finger_3, count_finger_4, count_finger_5, 
   count_ftp_1, count_ftp_2, count_ftp_3, count_ftp_4, count_ftp_5, 
   count_ftp_6, count_ftp_7, count_ftp_8, count_ftp_9, count_http_1, 
   count_http_2, count_http_3, count_http_4, count_http_5, 
   count_http_6, count_http_7, count_http_8, count_http_9, 
   count_imap_1, count_imap_2, count_imap_3, count_imap_4, 
   count_imap_5, count_imap_6, count_imap_7, count_imap_8, 
   count_imap_9, count_netbios_1, count_netbios_2, count_netbios_3, 
   count_netbios_4, count_netbios_5, count_netbios_6, 
   count_netbios_7, count_netbios_8, count_netbios_9, count_nntp_1, 
   count_nntp_2, count_nntp_3, count_nntp_4, count_nntp_5, 
   count_nntp_6, count_nntp_7, count_nntp_8, count_nntp_9, 
   count_pop3_1, count_pop3_2, count_pop3_3, count_pop3_4, 
   count_pop3_5, count_pop3_6, count_pop3_7, count_pop3_8, 
   count_pop3_9, count_rlogin_1, count_rlogin_2, count_rlogin_3, 
   count_rlogin_4, count_rlogin_5, count_smtp_1, count_smtp_2, 
   count_smtp_3, count_smtp_4, count_smtp_5, count_smtp_6, 
   count_smtp_7, count_smtp_8, count_smtp_9, count_telnet_1, 
   count_telnet_2, count_telnet_3, count_telnet_4, count_telnet_5, 
   count_telnet_6, count_telnet_7, count_telnet_8, count_telnet_9, 
   count_CATEGORY_aim, count_CATEGORY_bittorrent, count_CATEGORY_cvs, 
   count_CATEGORY_dhcp, count_CATEGORY_directconnect, 
   count_CATEGORY_dns, count_CATEGORY_fasttrack, count_CATEGORY_tor, 
   count_CATEGORY_vnc, count_CATEGORY_worldofwarcraft, 
   count_CATEGORY_x11, count_CATEGORY_yahoo, count_CATEGORY_freenet, 
   count_CATEGORY_gnutella, count_CATEGORY_gopher, 
   count_CATEGORY_irc, count_CATEGORY_jabber, count_CATEGORY_msn, 
   count_CATEGORY_napster, count_CATEGORY_sip, count_CATEGORY_snmp, 
   count_CATEGORY_socks, count_CATEGORY_ssh, count_CATEGORY_ssl, 
   count_CATEGORY_subversion, 
   // Inputs
   clk, rst, data, data_fifo_empty, data_fifo_almost_empty
   );

   input clk,rst;

   input [38:0] data ;
   input 	data_fifo_empty ;
   input 	data_fifo_almost_empty ;

   output [15:0] eop_cnt ;//end of packet count
   
   output 	data_pop ;

output [15:0] count_ALL_0 ;
output [15:0] count_ALL_1 ;
output [15:0] count_ALL_2 ;
output [15:0] count_ALL_3 ;
output [15:0] count_ALL_4 ;
output [15:0] count_finger_0 ;
output [15:0] count_ftp_0 ;
output [15:0] count_http_0 ;
output [15:0] count_imap_0 ;
output [15:0] count_netbios_0 ;
output [15:0] count_nntp_0 ;
output [15:0] count_pop3_0 ;
output [15:0] count_rlogin_0 ;
output [15:0] count_smtp_0 ;
output [15:0] count_telnet_0 ;
output [15:0] count_CATEGORY_finger ;
output [15:0] count_CATEGORY_ftp ;
output [15:0] count_CATEGORY_http ;
output [15:0] count_CATEGORY_imap ;
output [15:0] count_CATEGORY_netbios ;
output [15:0] count_CATEGORY_nntp ;
output [15:0] count_CATEGORY_pop3 ;
output [15:0] count_CATEGORY_rlogin ;
output [15:0] count_CATEGORY_smtp ;
output [15:0] count_CATEGORY_telnet ;

`ifdef REGEX_OPTIONAL
output [15:0] count_ALL_5 ;
output [15:0] count_ALL_6 ;
output [15:0] count_ALL_7 ;
output [15:0] count_ALL_8 ;
output [15:0] count_ALL_9 ;
output [15:0] count_ALL_10 ;
output [15:0] count_ALL_11 ;
output [15:0] count_ALL_12 ;
output [15:0] count_ALL_13 ;
output [15:0] count_ALL_14 ;



output [15:0] count_finger_1 ;
output [15:0] count_finger_2 ;
output [15:0] count_finger_3 ;
output [15:0] count_finger_4 ;
output [15:0] count_finger_5 ;

output [15:0] count_ftp_1 ;
output [15:0] count_ftp_2 ;
output [15:0] count_ftp_3 ;
output [15:0] count_ftp_4 ;
output [15:0] count_ftp_5 ;
output [15:0] count_ftp_6 ;
output [15:0] count_ftp_7 ;
output [15:0] count_ftp_8 ;
output [15:0] count_ftp_9 ;



output [15:0] count_http_1 ;
output [15:0] count_http_2 ;
output [15:0] count_http_3 ;
output [15:0] count_http_4 ;
output [15:0] count_http_5 ;
output [15:0] count_http_6 ;
output [15:0] count_http_7 ;
output [15:0] count_http_8 ;
output [15:0] count_http_9 ;

output [15:0] count_imap_1 ;
output [15:0] count_imap_2 ;
output [15:0] count_imap_3 ;
output [15:0] count_imap_4 ;
output [15:0] count_imap_5 ;
output [15:0] count_imap_6 ;
output [15:0] count_imap_7 ;
output [15:0] count_imap_8 ;
output [15:0] count_imap_9 ;

output [15:0] count_netbios_1 ;
output [15:0] count_netbios_2 ;
output [15:0] count_netbios_3 ;
output [15:0] count_netbios_4 ;
output [15:0] count_netbios_5 ;
output [15:0] count_netbios_6 ;
output [15:0] count_netbios_7 ;
output [15:0] count_netbios_8 ;
output [15:0] count_netbios_9 ;

output [15:0] count_nntp_1 ;
output [15:0] count_nntp_2 ;
output [15:0] count_nntp_3 ;
output [15:0] count_nntp_4 ;
output [15:0] count_nntp_5 ;
output [15:0] count_nntp_6 ;
output [15:0] count_nntp_7 ;
output [15:0] count_nntp_8 ;
output [15:0] count_nntp_9 ;

output [15:0] count_pop3_1 ;
output [15:0] count_pop3_2 ;
output [15:0] count_pop3_3 ;
output [15:0] count_pop3_4 ;
output [15:0] count_pop3_5 ;
output [15:0] count_pop3_6 ;
output [15:0] count_pop3_7 ;
output [15:0] count_pop3_8 ;
output [15:0] count_pop3_9 ;


output [15:0] count_rlogin_1 ;
output [15:0] count_rlogin_2 ;
output [15:0] count_rlogin_3 ;
output [15:0] count_rlogin_4 ;
output [15:0] count_rlogin_5 ;


output [15:0] count_smtp_1 ;
output [15:0] count_smtp_2 ;
output [15:0] count_smtp_3 ;
output [15:0] count_smtp_4 ;
output [15:0] count_smtp_5 ;
output [15:0] count_smtp_6 ;
output [15:0] count_smtp_7 ;
output [15:0] count_smtp_8 ;
output [15:0] count_smtp_9 ;


output [15:0] count_telnet_1 ;
output [15:0] count_telnet_2 ;
output [15:0] count_telnet_3 ;
output [15:0] count_telnet_4 ;
output [15:0] count_telnet_5 ;
output [15:0] count_telnet_6 ;
output [15:0] count_telnet_7 ;
output [15:0] count_telnet_8 ;
output [15:0] count_telnet_9 ;

output [15:0] count_CATEGORY_aim ;
output [15:0] count_CATEGORY_bittorrent ;
output [15:0] count_CATEGORY_cvs ;
output [15:0] count_CATEGORY_dhcp ;
output [15:0] count_CATEGORY_directconnect ;
output [15:0] count_CATEGORY_dns ;
output [15:0] count_CATEGORY_fasttrack ;
output [15:0] count_CATEGORY_tor ;
output [15:0] count_CATEGORY_vnc ;
output [15:0] count_CATEGORY_worldofwarcraft ;
output [15:0] count_CATEGORY_x11 ;
output [15:0] count_CATEGORY_yahoo ;
output [15:0] count_CATEGORY_freenet ;
output [15:0] count_CATEGORY_gnutella ;
output [15:0] count_CATEGORY_gopher ;
output [15:0] count_CATEGORY_irc ;
output [15:0] count_CATEGORY_jabber ;
output [15:0] count_CATEGORY_msn ;
output [15:0] count_CATEGORY_napster ;
output [15:0] count_CATEGORY_sip ;
output [15:0] count_CATEGORY_snmp ;
output [15:0] count_CATEGORY_socks ;
output [15:0] count_CATEGORY_ssh ;
output [15:0] count_CATEGORY_ssl ;
output [15:0] count_CATEGORY_subversion ;
`endif //  `ifdef REGEX_OPTIONAL

   //-----------------------------------------------------------------
   parameter [0:0] //synopsys enum fifo_read_sm
		CHECK_ALMOST_EMPTY = 1'b0,
		CHECK_EMPTY = 1'b1;
   
   reg  //synopsys enum fifo_read_sm
	FIFO_READ_STATE, FIFO_READ_NEXT_STATE;

   //synthesis translate_off
   /*AUTOASCIIENUM("FIFO_READ_STATE","FIFO_STATE_","CHECK_")*/
   // Beginning of automatic ASCII enum decoding
   reg [95:0]		FIFO_STATE_;		// Decode of FIFO_READ_STATE
   always @(FIFO_READ_STATE) begin
      casex ({FIFO_READ_STATE}) // synopsys full_case parallel_case
	CHECK_ALMOST_EMPTY: FIFO_STATE_ = "almost_empty";
	CHECK_EMPTY:        FIFO_STATE_ = "empty       ";
	default:            FIFO_STATE_ = "%Error      ";
      endcase
   end
   // End of automatics
   //synthesis translate_on

   //zWidth [31:0] odata ;
   
   //zReg
   reg  data_pop_rc ;
   reg  data_pop_wc ;
   wire data_pop = data_pop_wc ;
   wire [5:0]  streamid ;
   wire        new_streamid ;

   reg  read_enable_wc ,read_enable_rc;
   
   reg [95:0] addrid_wd ,addrid_rd;
   
   //end

   //srl Fifo read State machine
   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  //zClkReset
	  data_pop_rc <= 0;
	  //end
	  FIFO_READ_STATE <= CHECK_ALMOST_EMPTY;
       end
     else
       begin
	  //zClkAssign
	  data_pop_rc <=  data_pop_wc ; 
	  //end
	  FIFO_READ_STATE <= FIFO_READ_NEXT_STATE;
	  data_pop_rc <= data_pop_wc ;
       end
   
   always @*
     begin
	data_pop_wc = 0;
	FIFO_READ_NEXT_STATE = FIFO_READ_STATE;
	//zWireAssign
	data_pop_wc =  0 ; 
	//zEnd
	case( FIFO_READ_STATE )

	  CHECK_ALMOST_EMPTY: begin
	     if ( data_fifo_almost_empty )
	       FIFO_READ_NEXT_STATE = CHECK_EMPTY ;
	     else
	       if ( read_enable_wc )
		 data_pop_wc = 1 ;
	  end

	  CHECK_EMPTY: begin
	     if ( ~data_fifo_empty )
	       begin
		  if ( read_enable_wc )
		    begin
		       data_pop_wc = 1 ;
		       FIFO_READ_NEXT_STATE = CHECK_ALMOST_EMPTY;
		    end
	       end
	  end	  
	endcase // case ( FIFO_READ_STATE )
     end
   
   wire data_valid = data_pop_rc ;

   //----------------------------------------------------------

   //Tag + Data Parser  State machine
   reg [4:0] //synopsys enum tdp_sm
	     STATE,NEXT_STATE;

   parameter [4:0]  //synopsys enum tdp_sm
		ADDRID_0 = 0,
		ADDRID_1 = 1,
		ADDRID_2 = 2,
		ALLOC_ID = 3,
		WAIT_FOR_ID = 4,
		REGEX_DISPATCH = 5,
		REGEX_CHAR_DISPATCH = 6,
		STREAMID_LOOKUP_RESULT = 7,
		STREAMID_DEALLOC_WAIT = 8,
		REGEX_FINALIZE_CATEGORY_D1 = 9,
		REGEX_FINALIZE_D1 = 10,
		REGEX_FINALIZE_CATEGORY_D2 = 11,
		REGEX_FINALIZE_D2 = 12,
		REGEX_FINALIZE_CATEGORY_D3 = 13,
		REGEX_FINALIZE_D3 = 14,		    
		REGEX_FINALIZE_CATEGORY = 15,
		REGEX_FINALIZE = 16 ;
   
   //synthesis translate_off
   /*AUTOASCIIENUM("STATE","TAG_PARSE_STATE")*/
   // Beginning of automatic ASCII enum decoding
   reg [207:0]		TAG_PARSE_STATE;	// Decode of STATE
   always @(STATE) begin
      casex ({STATE}) // synopsys full_case parallel_case
	ADDRID_0:                   TAG_PARSE_STATE = "addrid_0                  ";
	ADDRID_1:                   TAG_PARSE_STATE = "addrid_1                  ";
	ADDRID_2:                   TAG_PARSE_STATE = "addrid_2                  ";
	ALLOC_ID:                   TAG_PARSE_STATE = "alloc_id                  ";
	WAIT_FOR_ID:                TAG_PARSE_STATE = "wait_for_id               ";
	REGEX_DISPATCH:             TAG_PARSE_STATE = "regex_dispatch            ";
	REGEX_CHAR_DISPATCH:        TAG_PARSE_STATE = "regex_char_dispatch       ";
	STREAMID_LOOKUP_RESULT:     TAG_PARSE_STATE = "streamid_lookup_result    ";
	STREAMID_DEALLOC_WAIT:      TAG_PARSE_STATE = "streamid_dealloc_wait     ";
	REGEX_FINALIZE_CATEGORY_D1: TAG_PARSE_STATE = "regex_finalize_category_d1";
	REGEX_FINALIZE_D1:          TAG_PARSE_STATE = "regex_finalize_d1         ";
	REGEX_FINALIZE_CATEGORY_D2: TAG_PARSE_STATE = "regex_finalize_category_d2";
	REGEX_FINALIZE_D2:          TAG_PARSE_STATE = "regex_finalize_d2         ";
	REGEX_FINALIZE_CATEGORY_D3: TAG_PARSE_STATE = "regex_finalize_category_d3";
	REGEX_FINALIZE_D3:          TAG_PARSE_STATE = "regex_finalize_d3         ";
	REGEX_FINALIZE_CATEGORY:    TAG_PARSE_STATE = "regex_finalize_category   ";
	REGEX_FINALIZE:             TAG_PARSE_STATE = "regex_finalize            ";
	default:                    TAG_PARSE_STATE = "%Error                    ";
      endcase
   end
   // End of automatics
   //synthesis translate_on

   //    
   //zWidth [31:0] odata ;
   
   //zReg
   reg addrid_push_rc , addrid_push_wc ;
   reg regex_char_valid_wc , regex_char_valid_rc ;
   reg [7:0] regex_char_wd, regex_char_rd ;
   reg [31:0] regex_data_wd,regex_data_rd;
   reg [1:0]  char_cnt_wc, char_cnt_rc;
   reg [2:0]  packet_count_categorize_wd, packet_count_categorize_rd;
   reg 	     category_valid_wc , category_valid_rc;
   reg 	     category_enable_wc, category_enable_rc;
   reg 	     dealloc_wc , dealloc_rc ;
   reg 	     regex_finalize_wc, regex_finalize_rc;
   
   wire        rdy;
   wire        streamid_valid ;

   reg [15:0]  pkt_id_wd, pkt_id_rd ;
   
   //end
   reg [35:0] category_wd, category_rd;

      //Table to store category information by streamid
   reg [38:0] category_mem[0:63];
   reg 	      category_mem_write_wc, category_mem_read_wc, category_mem_write_rc;
   
   reg [38:0] category_mem_wdata_wd,category_mem_wdata_rd;
   reg [38:0] category_mem_rdata_wd,category_mem_rdata_rd;   

   reg 	      regex_load_state_wc ,regex_load_state_rc;
   
   always @(posedge clk)
     begin
	if ( category_mem_write_rc )
	  category_mem[streamid] <= category_mem_wdata_rd ;

	if ( category_mem_read_wc )
	  category_mem_rdata_rd <= category_mem[streamid];
     end


   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  //zClkReset
	  addrid_push_rc <= 0 ;
	  char_cnt_rc <= 0 ;
	  regex_char_valid_rc <= 0 ;
	  category_valid_rc <= 0;
	  category_enable_rc <= 0;
	  category_rd <= 0;
	  packet_count_categorize_rd <= 0;
	  pkt_id_rd <= 0;
	  dealloc_rc <= 0;
	  category_mem_write_rc <= 0;
	  //end
	  STATE <= ADDRID_0;
       end
     else
       begin
	  //zClkAssign
	  //end
	  STATE <= NEXT_STATE;
	  addrid_rd <= addrid_wd;
	  regex_char_rd <= regex_char_wd ;
	  regex_data_rd <= regex_data_wd ;
	  category_valid_rc  <= category_valid_wc ;	
	  addrid_push_rc <= addrid_push_wc ;
	  char_cnt_rc <= char_cnt_wc ;
	  regex_char_valid_rc <= regex_char_valid_wc ;
	  category_enable_rc <= category_enable_wc;
	  regex_finalize_rc <= regex_finalize_wc;
	  category_rd <= category_wd;
	  packet_count_categorize_rd <= packet_count_categorize_wd;
	  pkt_id_rd <= pkt_id_wd ;
	  dealloc_rc <= dealloc_wc ;
	  category_mem_wdata_rd <= category_mem_wdata_wd ; 
	  category_mem_write_rc <= category_mem_write_wc ;
	  
       end

`include "fired_wire_decl.vh"

   //synthesis translate_off
   wire [15:0] pkt_id = pkt_id_rd ;
   //synthesis translate_on ;
   //    
   always @*
     begin
	//zWireAssign
	read_enable_wc =  0 ;
	addrid_push_wc = 0;	
	addrid_wd =  addrid_rd ; 
	regex_char_valid_wc = 0;
	char_cnt_wc = char_cnt_rc ;
	regex_char_wd = regex_char_rd ;
	category_mem_write_wc = 0;
	category_mem_read_wc = 0;
	regex_load_state_wc = 0;
	dealloc_wc = 0;
	regex_finalize_wc = 0;
	packet_count_categorize_wd = packet_count_categorize_rd;
	category_valid_wc = category_valid_rc ;	
	//zEnd
	category_wd = category_rd;
	pkt_id_wd = pkt_id_rd ; 
	category_enable_wc = category_enable_rc;
	category_mem_wdata_wd =	category_mem_wdata_rd;
	
	NEXT_STATE = STATE ;
	
	case(STATE)

	  ADDRID_0:begin
	     read_enable_wc = 1;
	     if ( data_valid && data[`TAGBYTE] == `TAG_ADDRID_0 )
	       begin
		  addrid_wd[31:0] = data[`PKTDATA] ;
		  pkt_id_wd = pkt_id_rd + 1;
		  NEXT_STATE = ADDRID_1;
	       end
	  end

	  ADDRID_1:begin
	     read_enable_wc = 1;	     
	     if ( data_valid && data[`TAGBYTE] == `TAG_ADDRID_1 )
	       begin
		  addrid_wd[63:32] = data[`PKTDATA] ;
		  NEXT_STATE = ADDRID_2;
	       end
	  end

	  ADDRID_2:begin
	     read_enable_wc = 1;	     
	     if ( data_valid && data[`TAGBYTE] == `TAG_ADDRID_2 )
	       begin
		  read_enable_wc = 0;	     		  
		  addrid_wd[95:64] = data[`PKTDATA] ;
		  NEXT_STATE = ALLOC_ID;
	       end
	  end

	  ALLOC_ID:begin
	     if ( rdy )
	       begin
		  addrid_push_wc = 1;
		  NEXT_STATE = WAIT_FOR_ID;
	       end
	  end
	  
	  WAIT_FOR_ID:begin
	     if ( streamid_valid )
	       begin
		  //Use new_streamid flag to determine if
		  //regex matcher should be reset or previous state loaded
		  regex_load_state_wc = 1;

		  //Streamid comes back
		  //Look up stream id
		  if ( new_streamid )
		    begin
		       //Initialize count to 0, zero out category
		       category_valid_wc = 0;
		       category_mem_wdata_wd = 0;
		       category_mem_write_wc = 1;
		       packet_count_categorize_wd = 1;
		       NEXT_STATE = REGEX_DISPATCH ;
		    end
		  else
		    begin
		       //Read stream id
		       category_mem_read_wc = 1;
		       NEXT_STATE = STREAMID_LOOKUP_RESULT ;
		    end
	       end
	  end

	  STREAMID_LOOKUP_RESULT:begin
	     if ( category_mem_rdata_rd[`STREAMID_CATEGORY] )
	       begin  //Non-zero category implies its been categorized
		  category_enable_wc = 0;
		  category_wd = category_mem_rdata_rd[`STREAMID_CATEGORY];
		  category_valid_wc = 1 ;
		  NEXT_STATE = REGEX_DISPATCH ;
	       end
	     else
	       begin
		  //This is the (stored packet count + 1)th packet
		  //Can still try to categorize if condition is true
		  //thats why the < sign, if the stored packet count is 3, then this is the 4th
		  //and last packet allowed for categorization (MAX_PACKER_CATEGORIZATION_COUNT=4)
		  if ( category_mem_rdata_rd[`STREAMID_PKT_COUNT] < `MAX_PACKET_CATEGORIZATION_COUNT )
		    begin //Can still try to categorize 
		       //Increment packet count
		       category_valid_wc = 0 ;		       		       
		       category_enable_wc = 1;
		       packet_count_categorize_wd = packet_count_categorize_rd + 1 ;
		    end
		  else
		    begin //Exceeded categorization count, stream deemed uncategorizable
		       category_enable_wc = 0;		       
		       category_wd = 0;
		       category_valid_wc = 1 ;		       
		    end // else: !if( category_mem_rdata_rd[`STREAMID_PKT_COUNT] < `MAX_PACKET_CATEGORIZATION_COUNT )
		  NEXT_STATE = REGEX_DISPATCH;		  
	       end
	  end
	  
	  REGEX_DISPATCH:begin
	     read_enable_wc = 1;	     
	     if ( data_valid )
	       begin
		  read_enable_wc = 0;
		  
		  case(data[`TAGBYTE])

		    `TAG_EOP:begin
		       if ( data[`PKTDATA] == 0 ) //EOP if pktdata = 0
			 begin
			    if (category_valid_rc)
			      begin
				 //Has to move to REGEX_FINALIZE_D1
				 //regex_finalize_wc = 1;
				 NEXT_STATE = REGEX_FINALIZE_D1 ;
			      end
			    else
			      NEXT_STATE = REGEX_FINALIZE_CATEGORY_D1 ;
			 end
		    end
		    
		    `TAG_PAYLOAD:begin
		       NEXT_STATE = REGEX_CHAR_DISPATCH ;
		       regex_data_wd = data[`PKTDATA];
		    end

		    `TAG_EOS:begin
		       if ( data[`PKTDATA] != 0 ) //End of Stream , deallocate
			 if ( rdy)
			   dealloc_wc = 1;
			 else
			   NEXT_STATE = STREAMID_DEALLOC_WAIT ;
		    end
		  endcase // case (data[`TAGBYTE])
	       end // if ( data_valid )
	  end // case: REGEX_DISPATCH

	  //Can optimize this state out
	  STREAMID_DEALLOC_WAIT:begin
	     if (rdy)
	       begin
		  dealloc_wc = 1;
		  NEXT_STATE = REGEX_DISPATCH;
	       end
	  end
	  
	  REGEX_CHAR_DISPATCH:begin
	     char_cnt_wc = char_cnt_rc + 1;

	     regex_char_valid_wc = 1;
	     case(char_cnt_rc)
	       0: regex_char_wd = regex_data_rd[7:0];
	       1: regex_char_wd = regex_data_rd[15:8];	       
	       2: begin
		  regex_char_wd = regex_data_rd[23:16];
	       end
	       3: begin
		  read_enable_wc = 1;
		  regex_char_wd = regex_data_rd[31:24];
		  NEXT_STATE = REGEX_DISPATCH ;
	       end
	     endcase // case (char_cnt_wc)
	  end // case: REGEX_CHAR_DISPATCH

	  //Pipe Delay, 1 cycle for Distrib Flop
	  REGEX_FINALIZE_CATEGORY_D1: NEXT_STATE = REGEX_FINALIZE_CATEGORY_D2 ;
	  //Pipe Delay, 1 cycle for Flop registering input to Regex	  
	  REGEX_FINALIZE_CATEGORY_D2: NEXT_STATE = REGEX_FINALIZE_CATEGORY_D3 ;
	  //Pipe Delay, 1 cycle for Flop registering output from Regex	  	  
	  REGEX_FINALIZE_CATEGORY_D3: NEXT_STATE = REGEX_FINALIZE_CATEGORY ;	  
	  
	  //EOP : Finalize Regex decision
	  REGEX_FINALIZE_CATEGORY:begin
	     //Send regex finalize pulse	     	     
	     regex_finalize_wc = 1;
	     
	     //Did any category regex fire, speculative count will be non-zero
	     //Find out which one
	     //Based on this set category_wd
	     category_wd = 0;

	     if (fired_CATEGORY_finger) category_wd[`CATEGORY_finger] = 1 ;
	     if (fired_CATEGORY_ftp) category_wd[`CATEGORY_ftp] = 1 ;
	     if (fired_CATEGORY_http) category_wd[`CATEGORY_http] = 1 ;
	     if (fired_CATEGORY_imap) category_wd[`CATEGORY_imap] = 1 ;
	     if (fired_CATEGORY_netbios) category_wd[`CATEGORY_netbios] = 1 ;
	     if (fired_CATEGORY_nntp) category_wd[`CATEGORY_nntp] = 1 ;
	     if (fired_CATEGORY_pop3) category_wd[`CATEGORY_pop3] = 1 ;
	     if (fired_CATEGORY_rlogin) category_wd[`CATEGORY_rlogin] = 1 ;
	     if (fired_CATEGORY_smtp) category_wd[`CATEGORY_smtp] = 1 ;
	     if (fired_CATEGORY_telnet) category_wd[`CATEGORY_telnet] = 1 ;

	     //These are the optional patterns,
	     //All regex matchers run in parallel in this architecture
	     //Added to make FPGA build easier, with just mandatory patterns
	     `ifdef REGEX_OPTIONAL
	     if (fired_CATEGORY_aim) category_wd[`CATEGORY_aim] = 1 ;
	     if (fired_CATEGORY_bittorrent) category_wd[`CATEGORY_bittorrent] = 1 ;
	     if (fired_CATEGORY_cvs) category_wd[`CATEGORY_cvs] = 1 ;
	     if (fired_CATEGORY_dhcp) category_wd[`CATEGORY_dhcp] = 1 ;
	     if (fired_CATEGORY_directconnect) category_wd[`CATEGORY_directconnect] = 1 ;
	     if (fired_CATEGORY_dns) category_wd[`CATEGORY_dns] = 1 ;
	     if (fired_CATEGORY_fasttrack) category_wd[`CATEGORY_fasttrack] = 1 ;
	     if (fired_CATEGORY_freenet) category_wd[`CATEGORY_freenet] = 1 ;
	     if (fired_CATEGORY_gnutella) category_wd[`CATEGORY_gnutella] = 1 ;
	     if (fired_CATEGORY_gopher) category_wd[`CATEGORY_gopher] = 1 ;
	     if (fired_CATEGORY_irc) category_wd[`CATEGORY_irc] = 1 ;
	     if (fired_CATEGORY_jabber) category_wd[`CATEGORY_jabber] = 1 ;
	     if (fired_CATEGORY_msn) category_wd[`CATEGORY_msn] = 1 ;
	     if (fired_CATEGORY_napster) category_wd[`CATEGORY_napster] = 1 ;
	     if (fired_CATEGORY_sip) category_wd[`CATEGORY_sip] = 1 ;
	     if (fired_CATEGORY_snmp) category_wd[`CATEGORY_snmp] = 1 ;
	     if (fired_CATEGORY_socks) category_wd[`CATEGORY_socks] = 1 ;
	     if (fired_CATEGORY_ssh) category_wd[`CATEGORY_ssh] = 1 ;
	     if (fired_CATEGORY_ssl) category_wd[`CATEGORY_ssl] = 1 ;
	     if (fired_CATEGORY_subversion) category_wd[`CATEGORY_subversion] = 1 ;
	     if (fired_CATEGORY_tor) category_wd[`CATEGORY_tor] = 1 ;
	     if (fired_CATEGORY_vnc) category_wd[`CATEGORY_vnc] = 1 ;
	     if (fired_CATEGORY_worldofwarcraft) category_wd[`CATEGORY_worldofwarcraft] = 1 ;
	     if (fired_CATEGORY_x11) category_wd[`CATEGORY_x11] = 1 ;
	     if (fired_CATEGORY_yahoo) category_wd[`CATEGORY_yahoo] = 1 ;
	     `endif //  `ifdef REGEX_OPTIONAL
	     
	     //Update streamid_category_rd
	     //if not then update packet count in stream_lookup table
	     category_mem_wdata_wd[`STREAMID_CATEGORY] = category_wd ;
	     category_mem_wdata_wd[`STREAMID_PKT_COUNT] = packet_count_categorize_rd ;
	     category_mem_write_wc = 1;	

	     NEXT_STATE = REGEX_FINALIZE;
	  end // case: REGEX_FINALIZE_CATEGORY

	  //Pipe delay
	  REGEX_FINALIZE_D1:NEXT_STATE = REGEX_FINALIZE_D2  ;

	  REGEX_FINALIZE_D2:NEXT_STATE = REGEX_FINALIZE_D3  ;

	  REGEX_FINALIZE_D3: begin
	     //Send regex finalize pulse   
	     regex_finalize_wc = 1;	     
	     NEXT_STATE = REGEX_FINALIZE ;
	  end
	  
	  REGEX_FINALIZE:begin
	     NEXT_STATE = ADDRID_0;
	  end
	  
	endcase // case (STATE)
	
     end // always @ *

   wire [95:0] addrid = addrid_rd;
   wire        addrid_valid = addrid_push_rc;

   wire        dealloc = dealloc_rc ;

   id_allocator id_alloc_i(
			   // Outputs
			   .streamid		(streamid[5:0]),
			   .new_streamid	(new_streamid),
			   .streamid_valid	(streamid_valid),
			   .rdy			(rdy),
			   // Inputs
			   .clk			(clk),
			   .rst			(rst),
			   .addrid		(addrid[95:0]),
			   .addrid_valid	(addrid_valid),
			   .dealloc		(dealloc));

   wire        rst_n = ~rst ;
   wire        eop = regex_finalize_rc ;
   wire        load_state = regex_load_state_wc ;
   wire        enable_ALL = 1 ;

   //End Of Packet (EOP) counter
   reg [15:0]  eop_cnt ;
   always @(posedge clk or posedge rst)
     if (rst)
       eop_cnt <= 0;
     else
       if ( eop )
	 eop_cnt <= eop_cnt+1;
   
   reg [7:0]   char_in_1 ;
   reg [7:0]   char_in_2 ;
   reg [7:0]   char_in_3 ;
   reg [7:0]   char_in_4 ;
   reg [7:0]   char_in_5 ;
   reg [7:0]   char_in_6 ;
   reg [7:0]   char_in_7 ;
   reg [7:0]   char_in_8 ;
   reg [7:0]   char_in_9 ;
   reg [7:0]   char_in_10 ;
   reg [7:0]   char_in_11 ;
   reg [7:0]   char_in_12 ;

   reg  char_in_vld_1 ;
   reg  char_in_vld_2 ;
   reg  char_in_vld_3 ;
   reg  char_in_vld_4 ;
   reg  char_in_vld_5 ;
   reg  char_in_vld_6 ;
   reg  char_in_vld_7 ;
   reg  char_in_vld_8 ;
   reg  char_in_vld_9 ;
   reg  char_in_vld_10 ;
   reg  char_in_vld_11 ;
   reg  char_in_vld_12 ;   

   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  char_in_vld_1 <= 1'b0;
	  char_in_vld_2 <= 1'b0;
	  char_in_vld_3 <= 1'b0;
	  char_in_vld_4 <= 1'b0;
	  char_in_vld_5 <= 1'b0;
	  char_in_vld_6 <= 1'b0;
	  char_in_vld_7 <= 1'b0;
	  char_in_vld_8 <= 1'b0;
	  char_in_vld_9 <= 1'b0;
	  char_in_vld_10 <= 1'b0;
	  char_in_vld_11 <= 1'b0;
	  char_in_vld_12 <= 1'b0;   	  
       end
     else
       begin
	  char_in_vld_1 <= regex_char_valid_rc ;
	  char_in_vld_2 <= regex_char_valid_rc ;
	  char_in_vld_3 <= regex_char_valid_rc ;
	  char_in_vld_4 <= regex_char_valid_rc ;
	  char_in_vld_5 <= regex_char_valid_rc ;
	  char_in_vld_6 <= regex_char_valid_rc ;
	  char_in_vld_7 <= regex_char_valid_rc ;
	  char_in_vld_8 <= regex_char_valid_rc ;
	  char_in_vld_9 <= regex_char_valid_rc ;
	  char_in_vld_10 <= regex_char_valid_rc ;
	  char_in_vld_11 <= regex_char_valid_rc ;
	  char_in_vld_12 <= regex_char_valid_rc ;   	  	  
       end // else: !if(rst)

   always @(posedge clk)
     begin
	char_in_1 <= regex_char_rd ;
	char_in_2 <= regex_char_rd ;
	char_in_3 <= regex_char_rd ;
	char_in_4 <= regex_char_rd ;
	char_in_5 <= regex_char_rd ;
	char_in_6 <= regex_char_rd ;
	char_in_7 <= regex_char_rd ;
	char_in_8 <= regex_char_rd ;
	char_in_9 <= regex_char_rd ;
	char_in_10 <= regex_char_rd ;
	char_in_11 <= regex_char_rd ;
	char_in_12 <= regex_char_rd ;   	  	  
     end
   
//---------------------------------------------------
//			cancid_ALL.lst
//---------------------------------------------------
wire enable_all  =  1;

wire [15:0] count_ALL_0 ;
cancid_ALL_0_verilog   cancid_ALL_0_verilog_i  (
			     // Outputs
			     .count		(count_ALL_0),
			     .fired             (fired_ALL_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

wire [15:0] count_ALL_1 ;
cancid_ALL_1_verilog   cancid_ALL_1_verilog_i  (
			     // Outputs
			     .count		(count_ALL_1),
			     .fired             (fired_ALL_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_2 ;
cancid_ALL_2_verilog   cancid_ALL_2_verilog_i  (
			     // Outputs
			     .count		(count_ALL_2),
			     .fired             (fired_ALL_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_3 ;
cancid_ALL_3_verilog   cancid_ALL_3_verilog_i  (
			     // Outputs
			     .count		(count_ALL_3),
			     .fired             (fired_ALL_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_4 ;
cancid_ALL_4_verilog   cancid_ALL_4_verilog_i  (
			     // Outputs
			     .count		(count_ALL_4),
			     .fired             (fired_ALL_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

//These are the optional patterns,
//All regex matchers run in parallel in this architecture
//Added to make FPGA build easier, with just mandatory patterns

`ifdef REGEX_EXCLUDE

wire [15:0] count_ALL_5 ;
cancid_ALL_5_verilog   cancid_ALL_5_verilog_i  (
			     // Outputs
			     .count		(count_ALL_5),
			     .fired             (fired_ALL_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_6 ;
cancid_ALL_6_verilog   cancid_ALL_6_verilog_i  (
			     // Outputs
			     .count		(count_ALL_6),
			     .fired             (fired_ALL_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_7 ;
cancid_ALL_7_verilog   cancid_ALL_7_verilog_i  (
			     // Outputs
			     .count		(count_ALL_7),
			     .fired             (fired_ALL_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_8 ;
cancid_ALL_8_verilog   cancid_ALL_8_verilog_i  (
			     // Outputs
			     .count		(count_ALL_8),
			     .fired             (fired_ALL_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_9 ;
cancid_ALL_9_verilog   cancid_ALL_9_verilog_i  (
			     // Outputs
			     .count		(count_ALL_9),
			     .fired             (fired_ALL_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_10 ;
cancid_ALL_10_verilog   cancid_ALL_10_verilog_i  (
			     // Outputs
			     .count		(count_ALL_10),
			     .fired             (fired_ALL_10),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_11 ;
cancid_ALL_11_verilog   cancid_ALL_11_verilog_i  (
			     // Outputs
			     .count		(count_ALL_11),
			     .fired             (fired_ALL_11),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_1),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_1),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_12 ;
cancid_ALL_12_verilog   cancid_ALL_12_verilog_i  (
			     // Outputs
			     .count		(count_ALL_12),
			     .fired             (fired_ALL_12),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_13 ;
cancid_ALL_13_verilog   cancid_ALL_13_verilog_i  (
			     // Outputs
			     .count		(count_ALL_13),
			     .fired             (fired_ALL_13),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_14 ;
cancid_ALL_14_verilog   cancid_ALL_14_verilog_i  (
			     // Outputs
			     .count		(count_ALL_14),
			     .fired             (fired_ALL_14),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));
`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_finger.lst
//---------------------------------------------------
wire enable_finger ;
wire [15:0] count_finger_0 ;
cancid_finger_0_verilog   cancid_finger_0_verilog_i  (
			     // Outputs
			     .count		(count_finger_0),
			     .fired             (fired_finger_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_finger_1 ;
cancid_finger_1_verilog   cancid_finger_1_verilog_i  (
			     // Outputs
			     .count		(count_finger_1),
			     .fired             (fired_finger_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_2 ;
cancid_finger_2_verilog   cancid_finger_2_verilog_i  (
			     // Outputs
			     .count		(count_finger_2),
			     .fired             (fired_finger_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_3 ;
cancid_finger_3_verilog   cancid_finger_3_verilog_i  (
			     // Outputs
			     .count		(count_finger_3),
			     .fired             (fired_finger_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_4 ;
cancid_finger_4_verilog   cancid_finger_4_verilog_i  (
			     // Outputs
			     .count		(count_finger_4),
			     .fired             (fired_finger_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_5 ;
cancid_finger_5_verilog   cancid_finger_5_verilog_i  (
			     // Outputs
			     .count		(count_finger_5),
			     .fired             (fired_finger_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_ftp.lst
//---------------------------------------------------
wire enable_ftp ;
wire [15:0] count_ftp_0 ;
cancid_ftp_0_verilog   cancid_ftp_0_verilog_i  (
			     // Outputs
			     .count		(count_ftp_0),
			     .fired             (fired_ftp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_1 ;
cancid_ftp_1_verilog   cancid_ftp_1_verilog_i  (
			     // Outputs
			     .count		(count_ftp_1),
			     .fired             (fired_ftp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_2 ;
cancid_ftp_2_verilog   cancid_ftp_2_verilog_i  (
			     // Outputs
			     .count		(count_ftp_2),
			     .fired             (fired_ftp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_2),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_2),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_3 ;
cancid_ftp_3_verilog   cancid_ftp_3_verilog_i  (
			     // Outputs
			     .count		(count_ftp_3),
			     .fired             (fired_ftp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_4 ;
cancid_ftp_4_verilog   cancid_ftp_4_verilog_i  (
			     // Outputs
			     .count		(count_ftp_4),
			     .fired             (fired_ftp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_5 ;
cancid_ftp_5_verilog   cancid_ftp_5_verilog_i  (
			     // Outputs
			     .count		(count_ftp_5),
			     .fired             (fired_ftp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_ftp_6 ;
cancid_ftp_6_verilog   cancid_ftp_6_verilog_i  (
			     // Outputs
			     .count		(count_ftp_6),
			     .fired             (fired_ftp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_7 ;
cancid_ftp_7_verilog   cancid_ftp_7_verilog_i  (
			     // Outputs
			     .count		(count_ftp_7),
			     .fired             (fired_ftp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_8 ;
cancid_ftp_8_verilog   cancid_ftp_8_verilog_i  (
			     // Outputs
			     .count		(count_ftp_8),
			     .fired             (fired_ftp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_9 ;
cancid_ftp_9_verilog   cancid_ftp_9_verilog_i  (
			     // Outputs
			     .count		(count_ftp_9),
			     .fired             (fired_ftp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_EXCLUDE

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_http.lst
//---------------------------------------------------
wire enable_http ;
wire [15:0] count_http_0 ;
cancid_http_0_verilog   cancid_http_0_verilog_i  (
			     // Outputs
			     .count		(count_http_0),
			     .fired             (fired_http_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_1 ;
cancid_http_1_verilog   cancid_http_1_verilog_i  (
			     // Outputs
			     .count		(count_http_1),
			     .fired             (fired_http_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_2 ;
cancid_http_2_verilog   cancid_http_2_verilog_i  (
			     // Outputs
			     .count		(count_http_2),
			     .fired             (fired_http_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_3 ;
cancid_http_3_verilog   cancid_http_3_verilog_i  (
			     // Outputs
			     .count		(count_http_3),
			     .fired             (fired_http_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_4 ;
cancid_http_4_verilog   cancid_http_4_verilog_i  (
			     // Outputs
			     .count		(count_http_4),
			     .fired             (fired_http_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_3),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_3),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_5 ;
cancid_http_5_verilog   cancid_http_5_verilog_i  (
			     // Outputs
			     .count		(count_http_5),
			     .fired             (fired_http_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_http_6 ;
cancid_http_6_verilog   cancid_http_6_verilog_i  (
			     // Outputs
			     .count		(count_http_6),
			     .fired             (fired_http_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_7 ;
cancid_http_7_verilog   cancid_http_7_verilog_i  (
			     // Outputs
			     .count		(count_http_7),
			     .fired             (fired_http_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_8 ;
cancid_http_8_verilog   cancid_http_8_verilog_i  (
			     // Outputs
			     .count		(count_http_8),
			     .fired             (fired_http_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_9 ;
cancid_http_9_verilog   cancid_http_9_verilog_i  (
			     // Outputs
			     .count		(count_http_9),
			     .fired             (fired_http_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_imap.lst
//---------------------------------------------------
wire enable_imap ;
wire [15:0] count_imap_0 ;
cancid_imap_0_verilog   cancid_imap_0_verilog_i  (
			     // Outputs
			     .count		(count_imap_0),
			     .fired             (fired_imap_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_1 ;
cancid_imap_1_verilog   cancid_imap_1_verilog_i  (
			     // Outputs
			     .count		(count_imap_1),
			     .fired             (fired_imap_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_2 ;
cancid_imap_2_verilog   cancid_imap_2_verilog_i  (
			     // Outputs
			     .count		(count_imap_2),
			     .fired             (fired_imap_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_3 ;
cancid_imap_3_verilog   cancid_imap_3_verilog_i  (
			     // Outputs
			     .count		(count_imap_3),
			     .fired             (fired_imap_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_4 ;
cancid_imap_4_verilog   cancid_imap_4_verilog_i  (
			     // Outputs
			     .count		(count_imap_4),
			     .fired             (fired_imap_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_5 ;
cancid_imap_5_verilog   cancid_imap_5_verilog_i  (
			     // Outputs
			     .count		(count_imap_5),
			     .fired             (fired_imap_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_imap_6 ;
cancid_imap_6_verilog   cancid_imap_6_verilog_i  (
			     // Outputs
			     .count		(count_imap_6),
			     .fired             (fired_imap_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_4),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_4),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_7 ;
cancid_imap_7_verilog   cancid_imap_7_verilog_i  (
			     // Outputs
			     .count		(count_imap_7),
			     .fired             (fired_imap_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_8 ;
cancid_imap_8_verilog   cancid_imap_8_verilog_i  (
			     // Outputs
			     .count		(count_imap_8),
			     .fired             (fired_imap_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_9 ;
cancid_imap_9_verilog   cancid_imap_9_verilog_i  (
			     // Outputs
			     .count		(count_imap_9),
			     .fired             (fired_imap_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_EXCLUDE

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_netbios.lst
//---------------------------------------------------
wire enable_netbios ;
wire [15:0] count_netbios_0 ;
cancid_netbios_0_verilog   cancid_netbios_0_verilog_i  (
			     // Outputs
			     .count		(count_netbios_0),
			     .fired             (fired_netbios_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_1 ;
cancid_netbios_1_verilog   cancid_netbios_1_verilog_i  (
			     // Outputs
			     .count		(count_netbios_1),
			     .fired             (fired_netbios_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_2 ;
cancid_netbios_2_verilog   cancid_netbios_2_verilog_i  (
			     // Outputs
			     .count		(count_netbios_2),
			     .fired             (fired_netbios_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_3 ;
cancid_netbios_3_verilog   cancid_netbios_3_verilog_i  (
			     // Outputs
			     .count		(count_netbios_3),
			     .fired             (fired_netbios_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_4 ;
cancid_netbios_4_verilog   cancid_netbios_4_verilog_i  (
			     // Outputs
			     .count		(count_netbios_4),
			     .fired             (fired_netbios_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_5 ;
cancid_netbios_5_verilog   cancid_netbios_5_verilog_i  (
			     // Outputs
			     .count		(count_netbios_5),
			     .fired             (fired_netbios_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_netbios_6 ;
cancid_netbios_6_verilog   cancid_netbios_6_verilog_i  (
			     // Outputs
			     .count		(count_netbios_6),
			     .fired             (fired_netbios_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_7 ;
cancid_netbios_7_verilog   cancid_netbios_7_verilog_i  (
			     // Outputs
			     .count		(count_netbios_7),
			     .fired             (fired_netbios_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_8 ;
cancid_netbios_8_verilog   cancid_netbios_8_verilog_i  (
			     // Outputs
			     .count		(count_netbios_8),
			     .fired             (fired_netbios_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_5),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_5),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_9 ;
cancid_netbios_9_verilog   cancid_netbios_9_verilog_i  (
			     // Outputs
			     .count		(count_netbios_9),
			     .fired             (fired_netbios_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_nntp.lst
//---------------------------------------------------
wire enable_nntp ;
wire [15:0] count_nntp_0 ;
cancid_nntp_0_verilog   cancid_nntp_0_verilog_i  (
			     // Outputs
			     .count		(count_nntp_0),
			     .fired             (fired_nntp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_1 ;
cancid_nntp_1_verilog   cancid_nntp_1_verilog_i  (
			     // Outputs
			     .count		(count_nntp_1),
			     .fired             (fired_nntp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_2 ;
cancid_nntp_2_verilog   cancid_nntp_2_verilog_i  (
			     // Outputs
			     .count		(count_nntp_2),
			     .fired             (fired_nntp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_3 ;
cancid_nntp_3_verilog   cancid_nntp_3_verilog_i  (
			     // Outputs
			     .count		(count_nntp_3),
			     .fired             (fired_nntp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_4 ;
cancid_nntp_4_verilog   cancid_nntp_4_verilog_i  (
			     // Outputs
			     .count		(count_nntp_4),
			     .fired             (fired_nntp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_5 ;
cancid_nntp_5_verilog   cancid_nntp_5_verilog_i  (
			     // Outputs
			     .count		(count_nntp_5),
			     .fired             (fired_nntp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_nntp_6 ;
cancid_nntp_6_verilog   cancid_nntp_6_verilog_i  (
			     // Outputs
			     .count		(count_nntp_6),
			     .fired             (fired_nntp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_7 ;
cancid_nntp_7_verilog   cancid_nntp_7_verilog_i  (
			     // Outputs
			     .count		(count_nntp_7),
			     .fired             (fired_nntp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_8 ;
cancid_nntp_8_verilog   cancid_nntp_8_verilog_i  (
			     // Outputs
			     .count		(count_nntp_8),
			     .fired             (fired_nntp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_9 ;
cancid_nntp_9_verilog   cancid_nntp_9_verilog_i  (
			     // Outputs
			     .count		(count_nntp_9),
			     .fired             (fired_nntp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_pop3.lst
//---------------------------------------------------
wire enable_pop3 ;
wire [15:0] count_pop3_0 ;
cancid_pop3_0_verilog   cancid_pop3_0_verilog_i  (
			     // Outputs
			     .count		(count_pop3_0),
			     .fired             (fired_pop3_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_6),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_6),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_1 ;
cancid_pop3_1_verilog   cancid_pop3_1_verilog_i  (
			     // Outputs
			     .count		(count_pop3_1),
			     .fired             (fired_pop3_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_2 ;
cancid_pop3_2_verilog   cancid_pop3_2_verilog_i  (
			     // Outputs
			     .count		(count_pop3_2),
			     .fired             (fired_pop3_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_3 ;
cancid_pop3_3_verilog   cancid_pop3_3_verilog_i  (
			     // Outputs
			     .count		(count_pop3_3),
			     .fired             (fired_pop3_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_4 ;
cancid_pop3_4_verilog   cancid_pop3_4_verilog_i  (
			     // Outputs
			     .count		(count_pop3_4),
			     .fired             (fired_pop3_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_5 ;
cancid_pop3_5_verilog   cancid_pop3_5_verilog_i  (
			     // Outputs
			     .count		(count_pop3_5),
			     .fired             (fired_pop3_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_pop3_6 ;
cancid_pop3_6_verilog   cancid_pop3_6_verilog_i  (
			     // Outputs
			     .count		(count_pop3_6),
			     .fired             (fired_pop3_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_7 ;
cancid_pop3_7_verilog   cancid_pop3_7_verilog_i  (
			     // Outputs
			     .count		(count_pop3_7),
			     .fired             (fired_pop3_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_8 ;
cancid_pop3_8_verilog   cancid_pop3_8_verilog_i  (
			     // Outputs
			     .count		(count_pop3_8),
			     .fired             (fired_pop3_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_9 ;
cancid_pop3_9_verilog   cancid_pop3_9_verilog_i  (
			     // Outputs
			     .count		(count_pop3_9),
			     .fired             (fired_pop3_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_EXCLUDE

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_rlogin.lst
//---------------------------------------------------
wire enable_rlogin ;
wire [15:0] count_rlogin_0 ;
cancid_rlogin_0_verilog   cancid_rlogin_0_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_0),
			     .fired             (fired_rlogin_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_rlogin_1 ;
cancid_rlogin_1_verilog   cancid_rlogin_1_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_1),
			     .fired             (fired_rlogin_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_2 ;
cancid_rlogin_2_verilog   cancid_rlogin_2_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_2),
			     .fired             (fired_rlogin_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_7),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_7),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_3 ;
cancid_rlogin_3_verilog   cancid_rlogin_3_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_3),
			     .fired             (fired_rlogin_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_4 ;
cancid_rlogin_4_verilog   cancid_rlogin_4_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_4),
			     .fired             (fired_rlogin_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_5 ;
cancid_rlogin_5_verilog   cancid_rlogin_5_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_5),
			     .fired             (fired_rlogin_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_smtp.lst
//---------------------------------------------------
wire enable_smtp ;
wire [15:0] count_smtp_0 ;
cancid_smtp_0_verilog   cancid_smtp_0_verilog_i  (
			     // Outputs
			     .count		(count_smtp_0),
			     .fired             (fired_smtp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_smtp_1 ;
cancid_smtp_1_verilog   cancid_smtp_1_verilog_i  (
			     // Outputs
			     .count		(count_smtp_1),
			     .fired             (fired_smtp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_2 ;
cancid_smtp_2_verilog   cancid_smtp_2_verilog_i  (
			     // Outputs
			     .count		(count_smtp_2),
			     .fired             (fired_smtp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_3 ;
cancid_smtp_3_verilog   cancid_smtp_3_verilog_i  (
			     // Outputs
			     .count		(count_smtp_3),
			     .fired             (fired_smtp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_4 ;
cancid_smtp_4_verilog   cancid_smtp_4_verilog_i  (
			     // Outputs
			     .count		(count_smtp_4),
			     .fired             (fired_smtp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_5 ;
cancid_smtp_5_verilog   cancid_smtp_5_verilog_i  (
			     // Outputs
			     .count		(count_smtp_5),
			     .fired             (fired_smtp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_smtp_6 ;
cancid_smtp_6_verilog   cancid_smtp_6_verilog_i  (
			     // Outputs
			     .count		(count_smtp_6),
			     .fired             (fired_smtp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_7 ;
cancid_smtp_7_verilog   cancid_smtp_7_verilog_i  (
			     // Outputs
			     .count		(count_smtp_7),
			     .fired             (fired_smtp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_8 ;
cancid_smtp_8_verilog   cancid_smtp_8_verilog_i  (
			     // Outputs
			     .count		(count_smtp_8),
			     .fired             (fired_smtp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_8),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_8),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_9 ;
cancid_smtp_9_verilog   cancid_smtp_9_verilog_i  (
			     // Outputs
			     .count		(count_smtp_9),
			     .fired             (fired_smtp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_telnet.lst
//---------------------------------------------------
wire enable_telnet ;
wire [15:0] count_telnet_0 ;
cancid_telnet_0_verilog   cancid_telnet_0_verilog_i  (
			     // Outputs
			     .count		(count_telnet_0),
			     .fired             (fired_telnet_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_telnet_1 ;
cancid_telnet_1_verilog   cancid_telnet_1_verilog_i  (
			     // Outputs
			     .count		(count_telnet_1),
			     .fired             (fired_telnet_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_2 ;
cancid_telnet_2_verilog   cancid_telnet_2_verilog_i  (
			     // Outputs
			     .count		(count_telnet_2),
			     .fired             (fired_telnet_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_3 ;
cancid_telnet_3_verilog   cancid_telnet_3_verilog_i  (
			     // Outputs
			     .count		(count_telnet_3),
			     .fired             (fired_telnet_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_4 ;
cancid_telnet_4_verilog   cancid_telnet_4_verilog_i  (
			     // Outputs
			     .count		(count_telnet_4),
			     .fired             (fired_telnet_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_5 ;
cancid_telnet_5_verilog   cancid_telnet_5_verilog_i  (
			     // Outputs
			     .count		(count_telnet_5),
			     .fired             (fired_telnet_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_telnet_6 ;
cancid_telnet_6_verilog   cancid_telnet_6_verilog_i  (
			     // Outputs
			     .count		(count_telnet_6),
			     .fired             (fired_telnet_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_7 ;
cancid_telnet_7_verilog   cancid_telnet_7_verilog_i  (
			     // Outputs
			     .count		(count_telnet_7),
			     .fired             (fired_telnet_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_8 ;
cancid_telnet_8_verilog   cancid_telnet_8_verilog_i  (
			     // Outputs
			     .count		(count_telnet_8),
			     .fired             (fired_telnet_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_9 ;
cancid_telnet_9_verilog   cancid_telnet_9_verilog_i  (
			     // Outputs
			     .count		(count_telnet_9),
			     .fired             (fired_telnet_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_EXCLUDE

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_category.lst
//---------------------------------------------------
wire enable_category = 1;

wire [15:0] count_CATEGORY_finger ;
cancid_CATEGORY_finger_verilog   cancid_CATEGORY_finger_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_finger),
			     .fired             (fired_CATEGORY_finger),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_9),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_9),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_ftp ;
cancid_CATEGORY_ftp_verilog   cancid_CATEGORY_ftp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ftp),
			     .fired             (fired_CATEGORY_ftp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));




wire [15:0] count_CATEGORY_http ;
cancid_CATEGORY_http_verilog   cancid_CATEGORY_http_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_http),
			     .fired             (fired_CATEGORY_http),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_imap ;
cancid_CATEGORY_imap_verilog   cancid_CATEGORY_imap_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_imap),
			     .fired             (fired_CATEGORY_imap),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));






wire [15:0] count_CATEGORY_netbios ;
cancid_CATEGORY_netbios_verilog   cancid_CATEGORY_netbios_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_netbios),
			     .fired             (fired_CATEGORY_netbios),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_nntp ;
cancid_CATEGORY_nntp_verilog   cancid_CATEGORY_nntp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_nntp),
			     .fired             (fired_CATEGORY_nntp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_pop3 ;
cancid_CATEGORY_pop3_verilog   cancid_CATEGORY_pop3_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_pop3),
			     .fired             (fired_CATEGORY_pop3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_rlogin ;
cancid_CATEGORY_rlogin_verilog   cancid_CATEGORY_rlogin_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_rlogin),
			     .fired             (fired_CATEGORY_rlogin),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_smtp ;
cancid_CATEGORY_smtp_verilog   cancid_CATEGORY_smtp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_smtp),
			     .fired             (fired_CATEGORY_smtp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));




wire [15:0] count_CATEGORY_telnet ;
cancid_CATEGORY_telnet_verilog   cancid_CATEGORY_telnet_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_telnet),
			     .fired             (fired_CATEGORY_telnet),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));





wire [15:0] count_CATEGORY_aim ;
cancid_CATEGORY_aim_verilog   cancid_CATEGORY_aim_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_aim),
			     .fired             (fired_CATEGORY_aim),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_bittorrent ;
cancid_CATEGORY_bittorrent_verilog   cancid_CATEGORY_bittorrent_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_bittorrent),
			     .fired             (fired_CATEGORY_bittorrent),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_cvs ;
cancid_CATEGORY_cvs_verilog   cancid_CATEGORY_cvs_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_cvs),
			     .fired             (fired_CATEGORY_cvs),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_10),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_10),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_dhcp ;
cancid_CATEGORY_dhcp_verilog   cancid_CATEGORY_dhcp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_dhcp),
			     .fired             (fired_CATEGORY_dhcp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_directconnect ;
cancid_CATEGORY_directconnect_verilog   cancid_CATEGORY_directconnect_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_directconnect),
			     .fired             (fired_CATEGORY_directconnect),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_dns ;
cancid_CATEGORY_dns_verilog   cancid_CATEGORY_dns_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_dns),
			     .fired             (fired_CATEGORY_dns),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_fasttrack ;
cancid_CATEGORY_fasttrack_verilog   cancid_CATEGORY_fasttrack_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_fasttrack),
			     .fired             (fired_CATEGORY_fasttrack),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_tor ;
cancid_CATEGORY_tor_verilog   cancid_CATEGORY_tor_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_tor),
			     .fired             (fired_CATEGORY_tor),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_vnc ;
cancid_CATEGORY_vnc_verilog   cancid_CATEGORY_vnc_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_vnc),
			     .fired             (fired_CATEGORY_vnc),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_worldofwarcraft ;
cancid_CATEGORY_worldofwarcraft_verilog   cancid_CATEGORY_worldofwarcraft_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_worldofwarcraft),
			     .fired             (fired_CATEGORY_worldofwarcraft),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_EXCLUDE
wire [15:0] count_CATEGORY_x11 ;
cancid_CATEGORY_x11_verilog   cancid_CATEGORY_x11_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_x11),
			     .fired             (fired_CATEGORY_x11),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_yahoo ;
cancid_CATEGORY_yahoo_verilog   cancid_CATEGORY_yahoo_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_yahoo),
			     .fired             (fired_CATEGORY_yahoo),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_freenet ;
cancid_CATEGORY_freenet_verilog   cancid_CATEGORY_freenet_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_freenet),
			     .fired             (fired_CATEGORY_freenet),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_gnutella ;
cancid_CATEGORY_gnutella_verilog   cancid_CATEGORY_gnutella_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_gnutella),
			     .fired             (fired_CATEGORY_gnutella),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_gopher ;
cancid_CATEGORY_gopher_verilog   cancid_CATEGORY_gopher_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_gopher),
			     .fired             (fired_CATEGORY_gopher),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_11),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_11),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_irc ;
cancid_CATEGORY_irc_verilog   cancid_CATEGORY_irc_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_irc),
			     .fired             (fired_CATEGORY_irc),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_jabber ;
cancid_CATEGORY_jabber_verilog   cancid_CATEGORY_jabber_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_jabber),
			     .fired             (fired_CATEGORY_jabber),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_msn ;
cancid_CATEGORY_msn_verilog   cancid_CATEGORY_msn_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_msn),
			     .fired             (fired_CATEGORY_msn),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_napster ;
cancid_CATEGORY_napster_verilog   cancid_CATEGORY_napster_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_napster),
			     .fired             (fired_CATEGORY_napster),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_sip ;
cancid_CATEGORY_sip_verilog   cancid_CATEGORY_sip_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_sip),
			     .fired             (fired_CATEGORY_sip),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_snmp ;
cancid_CATEGORY_snmp_verilog   cancid_CATEGORY_snmp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_snmp),
			     .fired             (fired_CATEGORY_snmp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_socks ;
cancid_CATEGORY_socks_verilog   cancid_CATEGORY_socks_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_socks),
			     .fired             (fired_CATEGORY_socks),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_ssh ;
cancid_CATEGORY_ssh_verilog   cancid_CATEGORY_ssh_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ssh),
			     .fired             (fired_CATEGORY_ssh),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_ssl ;
cancid_CATEGORY_ssl_verilog   cancid_CATEGORY_ssl_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ssl),
			     .fired             (fired_CATEGORY_ssl),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_subversion ;
cancid_CATEGORY_subversion_verilog   cancid_CATEGORY_subversion_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_subversion),
			     .fired             (fired_CATEGORY_subversion),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in_12),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld_12),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
//  `include "cancid_instantiation.vh" 
								  
  assign enable_aim = category_rd[`CATEGORY_aim];
  assign enable_bittorrent = category_rd[`CATEGORY_bittorrent];
  assign enable_cvs = category_rd[`CATEGORY_cvs];
  assign enable_dhcp = category_rd[`CATEGORY_dhcp];
  assign enable_directconnect = category_rd[`CATEGORY_directconnect];
  assign enable_dns = category_rd[`CATEGORY_dns];
  assign enable_fasttrack = category_rd[`CATEGORY_fasttrack];
  assign enable_finger = category_rd[`CATEGORY_finger];
  assign enable_freenet = category_rd[`CATEGORY_freenet];
  assign enable_ftp = category_rd[`CATEGORY_ftp];
  assign enable_gnutella = category_rd[`CATEGORY_gnutella];
  assign enable_gopher = category_rd[`CATEGORY_gopher];
  assign enable_http = category_rd[`CATEGORY_http];
  assign enable_imap = category_rd[`CATEGORY_imap];
  assign enable_irc = category_rd[`CATEGORY_irc];
  assign enable_jabber = category_rd[`CATEGORY_jabber];
  assign enable_msn = category_rd[`CATEGORY_msn];
  assign enable_napster = category_rd[`CATEGORY_napster];
  assign enable_netbios = category_rd[`CATEGORY_netbios];
  assign enable_nntp = category_rd[`CATEGORY_nntp];
  assign enable_pop3 = category_rd[`CATEGORY_pop3];
  assign enable_rlogin = category_rd[`CATEGORY_rlogin];
  assign enable_sip = category_rd[`CATEGORY_sip];
  assign enable_smtp = category_rd[`CATEGORY_smtp];
  assign enable_snmp = category_rd[`CATEGORY_snmp];
  assign enable_socks = category_rd[`CATEGORY_socks];
  assign enable_ssh = category_rd[`CATEGORY_ssh];
  assign enable_ssl = category_rd[`CATEGORY_ssl];
  assign enable_subversion = category_rd[`CATEGORY_subversion];
  assign enable_telnet = category_rd[`CATEGORY_telnet];
  assign enable_tor = category_rd[`CATEGORY_tor];
  assign enable_vnc = category_rd[`CATEGORY_vnc];
  assign enable_worldofwarcraft = category_rd[`CATEGORY_worldofwarcraft];
  assign enable_x11 = category_rd[`CATEGORY_x11];
  assign enable_yahoo = category_rd[`CATEGORY_yahoo];

endmodule // tag_data_splitter
