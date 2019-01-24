//Read 32 bit words from User IP fifo
//splits data into Tag and Packet data
//Tag + Packet data = 5 bytes, which are packed
//into 32 bit words,little endian.

//Little Endian data
//Little Endian Byte defines
`define LBYTE0 31:24
`define LBYTE1 23:16
`define LBYTE2 15:8
`define LBYTE3  7:0

//Byte position definitions for
//odata, MSB to right, LSB to left
`define BYTE3 31:24
`define BYTE2 23:16
`define BYTE1 15:8
`define BYTE0  7:0
`define TAGBYTE 38:32

`timescale 1ns/1ps

module tag_data_splitter(/*AUTOARG*/
   // Outputs
   idata_pop, odata, odata_push,
   // Inputs
   clk, rst, idata, idata_avail, idata_valid, odata_rdy
   );

   input clk,rst;

   //Interface to User IP Wfifo
   //Wfifo is where an agent on the bus side writes into the fifo
   //and the IP reads from this fifo
   input [31:0] idata ;
   input idata_avail ;//Wfifo is not empty (~Wfifo2IP_empty)
   input idata_valid ;//ack from Wfifo, when high idata is valid, Wfifo2IP_rd_ack
   output idata_pop ;//read req from Wfifo (IP2Wfifo_rd_req), hold high

   //Interface to Output fifo
   output [38:0] odata ;//Upper byte is tag, lower 32 bits are pkt data
   output 	 odata_push ;
   input 	 odata_rdy;//odata fifo not full

   reg [31:0] 	 idata_rd ;
   reg 		 idata_valid_rc;
   
   reg [7:0] 	 lbyte0;
   reg [7:0] 	 lbyte1;
   reg [7:0] 	 lbyte2;
   reg [7:0] 	 lbyte3;      
   
   parameter [3:0] //synopsys enum tds_sm
		PARSE_WORD_0 = 4'd0,
		WORD0_PUSH_WAIT = 4'd1,
		PARSE_WORD_1 = 4'd2,
		WORD1_PUSH_WAIT = 4'd3,		
		PARSE_WORD_2 = 4'd4,
		WORD2_PUSH_WAIT = 4'd5,		
		PARSE_WORD_3 = 4'd6,
		WORD3_PUSH_WAIT = 4'd7,		
		PARSE_WORD_4 = 4'd8 ;

   reg [3:0] //synopsys enum tds_sm
	     STATE,NEXT_STATE;

   //synthesis translate_off
   /*AUTOASCIIENUM("STATE","TAG_DATA_SPLITTER_STATE","PARSE_")*/
   // Beginning of automatic ASCII enum decoding
   reg [119:0]		TAG_DATA_SPLITTER_STATE;// Decode of STATE
   always @(STATE) begin
      case ({STATE})
	PARSE_WORD_0:    TAG_DATA_SPLITTER_STATE = "word_0         ";
	WORD0_PUSH_WAIT: TAG_DATA_SPLITTER_STATE = "word0_push_wait";
	PARSE_WORD_1:    TAG_DATA_SPLITTER_STATE = "word_1         ";
	WORD1_PUSH_WAIT: TAG_DATA_SPLITTER_STATE = "word1_push_wait";
	PARSE_WORD_2:    TAG_DATA_SPLITTER_STATE = "word_2         ";
	WORD2_PUSH_WAIT: TAG_DATA_SPLITTER_STATE = "word2_push_wait";
	PARSE_WORD_3:    TAG_DATA_SPLITTER_STATE = "word_3         ";
	WORD3_PUSH_WAIT: TAG_DATA_SPLITTER_STATE = "word3_push_wait";
	PARSE_WORD_4:    TAG_DATA_SPLITTER_STATE = "word_4         ";
	default:         TAG_DATA_SPLITTER_STATE = "%Error         ";
      endcase
   end
   // End of automatics
   //synthesis translate_on

   //zReg
   reg  odata_push_wc ,odata_push_rc;
   reg [38:0] odata_wd,odata_rd;

   reg 	      idata_pop_wc, idata_pop_rc;
   reg [38:0] odata_a_wd ;
   reg [38:0] odata_b_wd ;
   reg [38:0] odata_a_rd ;
   reg [38:0] odata_b_rd ;   
   //end

   wire       idata_pop = odata_rdy & ~rst ;
   
   wire [38:0] odata ;
   wire   odata_push ;

   assign     odata = odata_rd;
   assign     odata_push = odata_push_rc;

   //Register idata inputs
   always @(posedge clk)
       begin
	  idata_valid_rc <= idata_valid;
	  idata_rd <= idata ;
       end
   
   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  //zClkReset
	  idata_pop_rc <= 0;
	  odata_push_rc <=0;
	  //end
	  STATE <= PARSE_WORD_0;
       end
     else
       begin
	  //zClkAssign
	  odata_a_rd <=  odata_a_wd ; 
	  odata_b_rd <=  odata_b_wd ;
	  odata_rd <= odata_wd;
	  idata_pop_rc <= idata_pop_wc ;
	  odata_push_rc <= odata_push_wc ;
	  //end
	  STATE <=  NEXT_STATE;
       end
   
   always @*
     begin
	//zWireAssign
	idata_pop_wc  =  0 ; 
	odata_push_wc =  0 ; 
	odata_a_wd    = odata_a_rd ; 
	odata_b_wd    = odata_b_rd ;
	odata_wd      = odata_rd ;
	//zEnd
	
	lbyte0 = idata_rd[`LBYTE0];
	lbyte1 = idata_rd[`LBYTE1];
	lbyte2 = idata_rd[`LBYTE2];
	lbyte3 = idata_rd[`LBYTE3];	

	NEXT_STATE = STATE ;
	
	case(STATE)

	  PARSE_WORD_0:begin
	     if ( idata_valid_rc ) 
	       begin
		  odata_a_wd[`BYTE2]   = lbyte3;
		  odata_a_wd[`BYTE1]   = lbyte2;
		  odata_a_wd[`BYTE0]   = lbyte1;
		  odata_a_wd[`TAGBYTE] = lbyte0;

		  NEXT_STATE = PARSE_WORD_1 ;
	       end // if ( idata_valid )
	  end // case: PARSE_WORD_0
	  
	  PARSE_WORD_1: 
	    begin
	       if ( idata_valid_rc )
		 begin
		    odata_wd = odata_a_rd;
		    odata_wd[`BYTE3] = lbyte0;
		    
		    odata_b_wd[`TAGBYTE] = lbyte1;		    
		    odata_b_wd[`BYTE1] = lbyte3;
		    odata_b_wd[`BYTE0] = lbyte2;
	       
		    if ( odata_rdy )
		      begin
			 //Output Data and tag
			 odata_push_wc = 1;
			 NEXT_STATE = PARSE_WORD_2 ;
		      end
		    else
		      NEXT_STATE = WORD0_PUSH_WAIT;
		 end // if ( idata_valid_rc )
	       
	    end // case: PARSE_WORD_1

	  WORD0_PUSH_WAIT:begin
	     if ( odata_rdy )
	       begin
		  //Output Data and tag
		  odata_push_wc = 1;
		  NEXT_STATE = PARSE_WORD_2 ;
	       end
	  end
	  
	  PARSE_WORD_2: 
	    begin
	       if ( idata_valid_rc )
		 begin
		    odata_a_wd[`TAGBYTE] = lbyte2;
		    odata_a_wd[`BYTE0] = lbyte3;
		    
		    odata_wd = odata_b_rd;
		    odata_wd[`BYTE3] = lbyte1;
		    odata_wd[`BYTE2] = lbyte0;
	       
		    if ( odata_rdy )
		      begin
			 odata_push_wc = 1;			 
			 NEXT_STATE = PARSE_WORD_3 ;
		      end // if ( tag_rdy & odata_rdy )
		    else
		      NEXT_STATE = WORD1_PUSH_WAIT;
		 end // if ( idata_valid_rc )
	    end // case: PARSE_WORD_2
	  
	  WORD1_PUSH_WAIT:begin
	     if ( odata_rdy )
	       begin
		  //Output Data and tag
		  odata_push_wc = 1;
		  NEXT_STATE = PARSE_WORD_3 ;
	       end
	  end
	  	  
	  PARSE_WORD_3: 
	    begin

	       if (idata_valid_rc)
		 begin
		    odata_b_wd[`TAGBYTE] = lbyte3;

		    odata_wd = odata_a_rd;
		    odata_wd[`BYTE3]=lbyte2;
		    odata_wd[`BYTE2]=lbyte1;
		    odata_wd[`BYTE1]=lbyte0;
	       
		    if ( odata_rdy )
		      begin
			 odata_push_wc = 1;
			 NEXT_STATE = PARSE_WORD_4 ;
		      end
		    else
		      begin
			 NEXT_STATE = WORD2_PUSH_WAIT ;
		      end
		 end // if (idata_valid_rc)
	    end // case: PARSE_WORD_3
	  
	  WORD2_PUSH_WAIT:begin
	     if ( odata_rdy )
	       begin
		  //Output Data and tag
		  odata_push_wc = 1;
		  NEXT_STATE = PARSE_WORD_4 ;
	       end
	  end
	  
	  PARSE_WORD_4: 
	    begin
	       if ( idata_valid_rc)
		 begin
		    odata_b_wd[`BYTE3]=lbyte3;
		    odata_b_wd[`BYTE2]=lbyte2;
		    odata_b_wd[`BYTE1]=lbyte1;
		    odata_b_wd[`BYTE0]=lbyte0;
		    odata_wd = odata_b_wd;

		    if ( odata_rdy )
		      begin
			 odata_push_wc = 1;
			 NEXT_STATE = PARSE_WORD_0 ;
		      end
		    else
		      NEXT_STATE = WORD3_PUSH_WAIT;
		 end // if ( idata_valid_rc)
	    end // case: PARSE_WORD_4

	  WORD3_PUSH_WAIT:begin
	     if ( odata_rdy )
	       begin
		  //Output Data and tag
		  odata_push_wc = 1;
		  NEXT_STATE = PARSE_WORD_0 ;
	       end
	  end
	  
	endcase // case (STATE)

     end

endmodule // tag_data_splitter
