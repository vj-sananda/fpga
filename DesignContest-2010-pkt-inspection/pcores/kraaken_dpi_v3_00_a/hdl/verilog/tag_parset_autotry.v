`timescale 1ns/1ps

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
   eop_cnt, data_pop, 
   // Inputs
   clk, rst, data, data_fifo_empty, data_fifo_almost_empty
   );

   input clk,rst;

   input [38:0] data ;
   input 	data_fifo_empty ;
   input 	data_fifo_almost_empty ;

   output [15:0] eop_cnt ;//end of packet count
   
   output 	data_pop ;

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
   reg [3:0] //synopsys enum tdp_sm
	     STATE,NEXT_STATE;

   parameter [3:0]  //synopsys enum tdp_sm
		ADDRID_0 = 0,
		ADDRID_1 = 1,
		ADDRID_2 = 2,
		ALLOC_ID = 3,
		WAIT_FOR_ID = 4,
		REGEX_DISPATCH = 5,
		REGEX_CHAR_DISPATCH = 6,
		STREAMID_LOOKUP_RESULT = 7,
		STREAMID_DEALLOC_WAIT = 8,
		REGEX_FINALIZE_CATEGORY = 9,
		REGEX_FINALIZE = 10 ;
   
   //synthesis translate_off
   /*AUTOASCIIENUM("STATE","TAG_PARSE_STATE")*/
   // Beginning of automatic ASCII enum decoding
   reg [183:0]		TAG_PARSE_STATE;	// Decode of STATE
   always @(STATE) begin
      casex ({STATE}) // synopsys full_case parallel_case
	ADDRID_0:                TAG_PARSE_STATE = "addrid_0               ";
	ADDRID_1:                TAG_PARSE_STATE = "addrid_1               ";
	ADDRID_2:                TAG_PARSE_STATE = "addrid_2               ";
	ALLOC_ID:                TAG_PARSE_STATE = "alloc_id               ";
	WAIT_FOR_ID:             TAG_PARSE_STATE = "wait_for_id            ";
	REGEX_DISPATCH:          TAG_PARSE_STATE = "regex_dispatch         ";
	REGEX_CHAR_DISPATCH:     TAG_PARSE_STATE = "regex_char_dispatch    ";
	STREAMID_LOOKUP_RESULT:  TAG_PARSE_STATE = "streamid_lookup_result ";
	STREAMID_DEALLOC_WAIT:   TAG_PARSE_STATE = "streamid_dealloc_wait  ";
	REGEX_FINALIZE_CATEGORY: TAG_PARSE_STATE = "regex_finalize_category";
	REGEX_FINALIZE:          TAG_PARSE_STATE = "regex_finalize         ";
	default:                 TAG_PARSE_STATE = "%Error                 ";
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
				 regex_finalize_wc = 1;
				 NEXT_STATE = REGEX_FINALIZE ;
			      end
			    else
			      NEXT_STATE = REGEX_FINALIZE_CATEGORY ;
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

	  //EOP : Finalize Regex decision
	  REGEX_FINALIZE_CATEGORY:begin
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
	  
	  REGEX_FINALIZE:begin
	     //Send regex finalize pulse
	     NEXT_STATE = ADDRID_0;
	  end
	  
	endcase // case (STATE)
	
     end // always @ *

   wire [7:0] char_in = regex_char_rd ;
   wire       char_in_vld = regex_char_valid_rc;
   
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

   //WTD:Interrupt generation logic
   //1. Look for eop_cnt to reach a value (set by a register)
   //2. Wait for >2 cycles after. Should be more than sufficient
   //   for all matchers to update their counters
   
  `include "cancid_instantiation.vh" 
								  
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
