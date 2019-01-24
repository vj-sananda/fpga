//Allocates stream id given an address id = {srcip,destip,port_pair} (96  bits)
//CAMs address id and returns stream id on a match
//if no match allocates new stream id and returns that, then stores address id
//in CAM for future matches
//On a dealloc, returns stream id to free list
//free list modeled as a fifo.
`timescale 1ns/1ps

module id_allocator(/*AUTOARG*/
   // Outputs
   streamid, new_streamid, streamid_valid, rdy, 
   // Inputs
   clk, rst, addrid, addrid_valid, dealloc
   );

   input clk ;
   input rst;
   
   input [95:0] addrid ;
   input addrid_valid;
   input dealloc;

   output [5:0] streamid;//0 to 63
   output new_streamid;
   output streamid_valid;
   output rdy ; //indicates rdy to process next id

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   // End of automatics

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   // End of automatics

   //zWidth [5:0] flist_init, cam_addr ,cam_match_addr ;
   //zWidth [95:0] cam_din ;
   
   //zReg
   reg 			streamid_valid_wc , streamid_valid_rc ;
   reg [5:0] streamid_wd,streamid_rd;
   
   reg  flist_rd ;
   reg [95:0] cam_din_rd ;
   reg [5:0] cam_addr_rd ;
   reg  flist_write_wc ;
   reg  rdy_wc ,rdy_rc;
   reg  cam_write_wc ,cam_write_rc;
   reg  flist_read_wc ;
   reg [5:0] flist_init_rd ;
   reg [5:0] flist_init_wd ;
   reg  [5:0] flist_in_wd ,flist_in_rd ;
   wire [5:0] flist_out;
   
   reg [95:0] cam_din_wd ;
   reg [5:0] cam_addr_wd ;
   wire [5:0] cam_match_addr;
   wire       cam_match;
   

   reg 	      new_streamid_wd,new_streamid_rd;

   //Register cam_match & cam_match_addr for timing
   reg 	      cam_match_rd      ;
   reg [5:0]  cam_match_addr_rd ;
   
   
   parameter [2:0] //synopsys enum mysm
		INIT = 3'h0,
		WAIT_FOR_CMD = 3'h1,
		WAIT_FOR_CAM_RESULT_1 = 3'h2,
		WAIT_FOR_CAM_RESULT_2 = 3'h3,		   
		CAM_RESULT = 3'h4,
		FLIST_ID_READ = 3'h5;

   reg [2:0] //synopsys enum  mysm
	     STATE, NEXT_STATE;

   //synopsys translate off
   /*AUTOASCIIENUM("STATE","STATE_ID_ALLOC")*/
   // Beginning of automatic ASCII enum decoding
   reg [167:0]		STATE_ID_ALLOC;		// Decode of STATE
   always @(STATE) begin
      casex ({STATE}) // synopsys full_case parallel_case
	INIT:                  STATE_ID_ALLOC = "init                 ";
	WAIT_FOR_CMD:          STATE_ID_ALLOC = "wait_for_cmd         ";
	WAIT_FOR_CAM_RESULT_1: STATE_ID_ALLOC = "wait_for_cam_result_1";
	WAIT_FOR_CAM_RESULT_2: STATE_ID_ALLOC = "wait_for_cam_result_2";
	CAM_RESULT:            STATE_ID_ALLOC = "cam_result           ";
	FLIST_ID_READ:         STATE_ID_ALLOC = "flist_id_read        ";
	default:               STATE_ID_ALLOC = "%Error               ";
      endcase
   end
   // End of automatics
   //synopsys translate on
   
   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  //zClkReset
	  STATE <= INIT;
	  flist_init_rd <= 0;
	  new_streamid_rd <= 0;
	  streamid_valid_rc <= 0;
	  cam_write_rc <= 0;
	  rdy_rc <= 0 ;	  
	  //zEnd
       end
     else
       begin
	  //zClkAssign
	  flist_init_rd <=  flist_init_wd ; 
	  cam_din_rd <=  cam_din_wd ; 
	  cam_addr_rd <=  cam_addr_wd ; 
	  flist_in_rd <=  flist_in_wd ;
	  cam_din_rd <=  cam_din_wd ; 
	  cam_addr_rd <=  cam_addr_wd ;
	  streamid_rd <= streamid_wd ;
	  new_streamid_rd <= new_streamid_wd;
	  streamid_valid_rc <= streamid_valid_wc ;
	  cam_write_rc <= cam_write_wc ;
	  rdy_rc <= rdy_wc ;
	  
	  STATE <= NEXT_STATE;
	  //zEnd
       end

   always @*
     begin
	//zWireAssign
	streamid_valid_wc =  0 ; 
	flist_write_wc =  0 ; 
	rdy_wc =  0 ; 
	cam_write_wc =  0 ; 
	flist_read_wc =  0 ; 
	flist_init_wd =  flist_init_rd ; 
	flist_in_wd =  flist_in_rd ;
	cam_din_wd =  cam_din_rd ; 
	cam_addr_wd =  cam_addr_rd ; 
	streamid_wd = streamid_rd ;
	NEXT_STATE = STATE;
	new_streamid_wd = new_streamid_rd;
	
	//zEnd
	case(STATE)

	  //Initialize freelist from 0 to 63
	  //not rdy yet
	  INIT: begin
	     if (~rst) begin
		flist_init_wd = flist_init_rd + 1 ;
		
		flist_in_wd = flist_init_rd;
		flist_write_wc = 1;
		
		if ( flist_init_rd == 6'd63 )
		  begin
		     rdy_wc = 1;
		     NEXT_STATE = WAIT_FOR_CMD;
		  end
	     end // if (~rst)
	  end

	  WAIT_FOR_CMD:begin
	     rdy_wc = 1;

	     if (addrid_valid)
	       begin
		  cam_din_wd = addrid;
		  NEXT_STATE = WAIT_FOR_CAM_RESULT_1 ;
	       end

	     if (dealloc) //Use the streamid found previously to deallocate
	       begin
		  rdy_wc = 0;
		  
		  cam_din_wd = 0;
		  cam_addr_wd = streamid_rd;
		  cam_write_wc = 1;

		  flist_in_wd = streamid_rd;
		  flist_write_wc = 1;
	       end
	  end

	  WAIT_FOR_CAM_RESULT_1: NEXT_STATE = WAIT_FOR_CAM_RESULT_2;
	  WAIT_FOR_CAM_RESULT_2: NEXT_STATE = CAM_RESULT;	  
	  
	  CAM_RESULT:begin
	     if ( cam_match_rd )
	       begin
		  streamid_wd = cam_match_addr_rd;
		  streamid_valid_wc = 1;
		  new_streamid_wd = 0;
		  NEXT_STATE = WAIT_FOR_CMD ;
	       end
	     else
	       begin
		  //Get streamid from freelist
		  flist_read_wc = 1;
		  NEXT_STATE = FLIST_ID_READ ;
	       end // else: !if( cam_match )
	  end // case: CAM_RESULT

	  FLIST_ID_READ: begin
	     //Return streamid and write into CAM
	     streamid_wd = flist_out;
	     streamid_valid_wc = 1;
	     new_streamid_wd = 1;

	     //write CAM
	     cam_write_wc = 1;
	     cam_addr_wd = flist_out;
	     rdy_wc = 1;
	     NEXT_STATE = WAIT_FOR_CMD ;
	  end
	  
	endcase // case (STATE)
	
     end

   assign rdy = rdy_wc;   
   /* Register outputs for timing
   assign rdy = rdy_wc;
   assign streamid_valid = streamid_valid_wc ;
   assign new_streamid = new_streamid_wd;
   assign     streamid = streamid_wd;
*/
   assign streamid_valid = streamid_valid_rc ;
   assign new_streamid = new_streamid_rd;
   assign     streamid = streamid_rd;   
   
   flist flist_inst(
		    // Outputs
		    .dout		(flist_out[5:0]),
		    // Inputs
		    .clk		(clk),
		    .rst		(rst),
		    .wr			(flist_write_wc),
		    .rd			(flist_read_wc),
		    .din		(flist_in_wd));

   //Register to break timing path
   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  cam_match_rd      <= 0;
	  cam_match_addr_rd <= 0;
       end
     else
       begin
	  cam_match_rd      <= cam_match ;
	  cam_match_addr_rd <= cam_match_addr;
       end
   
   cam_v6_1 cam_inst (
		 // Outputs
		 .busy			(busy),
		 .match			(cam_match),
		 .match_addr		(cam_match_addr[5:0]),
		 // Inputs
		 .clk			(clk),
		 .din			(cam_din_rd),
		 .we			(cam_write_rc),
		 .wr_addr		(cam_addr_rd[5:0]));
   
endmodule // id_allocator

