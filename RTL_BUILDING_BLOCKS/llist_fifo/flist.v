`timescale 1ns/1ns
`define TRUE  1 
`define FALSE 0

module flist (/*AUTOARG*/
   // Outputs
   alloc_ack, dealloc_ack, alloc_id, init_done, 
   // Inputs
   clk, rst, alloc_req, dealloc_req, dealloc_id
   );

   parameter size  =  256 ;
   parameter width =    8 ;
   
   input clk;
   input rst;

   input alloc_req ;
   input dealloc_req ;
   input [width-1:0] dealloc_id ;

   output 	     alloc_ack ;
   output 	     dealloc_ack ;
   output [width-1:0] alloc_id ;
   output 	      init_done ;

   //initialize flist
   reg 		      init_done ;
   reg [width-1:0] 	      init_addr ;
   reg [width-1:0] 	      init_din ;
   reg 			      init_wr ;
   
   wire [width-1:0] 	      dout ;
   wire [width-1:0] 	      din ;
   wire [width-1:0] 	      addr ;
   reg [width-1:0] 	      m_din ;
   reg  [width-1:0] 	      m_addr ;   
   wire 		      wr ;
   reg 			      m_wr ;   
   
   always @(posedge clk or posedge rst)
     if (rst)
       begin
	  init_done <= 0;
	  init_wr <= 1;
	  init_addr <= 8'b0;
	  init_din  <= 8'b01;
       end
     else
       if (!init_done)
	 begin
	    init_din  <= init_din + 1;
	    init_addr <= init_din ;
	    if (init_addr == 8'hff)
	      begin
		 init_done <= 1'b1 ;
		 init_wr <= 1'b0;
	      end
	 end

   assign 		      addr = (init_done) ? m_addr : init_addr ;
   assign 		      din  = (init_done) ? m_din : init_din ;
   assign 		      wr   = (init_done) ? m_wr : init_wr ;	  

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg 			      alloc_ack;
   reg [width-1:0] 	      alloc_id;
   reg 			      dealloc_ack;
   // End of automatics
   reg 			      allow_alloc,allow_dealloc,alloc_req_pend ;
   reg 			      alloc_s2 ,alloc_s3;
   reg 			      dealloc_req_pend ;
   reg 			      dealloc_s2 ,dealloc_s3;   
   reg [width-1:0] 	      head ;
   reg [width-1:0] 	      tail ;
   reg 			      mem_busy;
   reg 			      token;
			      
   always @(posedge clk or posedge rst)
     if(rst)
       begin
	  allow_alloc   <= `TRUE ;
	  allow_dealloc <= `FALSE;
	  alloc_req_pend <= 0;
	  alloc_s2 <= 0;
	  alloc_ack <= 0;
	  dealloc_ack <= 0;
	  head <= 1'b0  ;
	  tail <= 8'hff ;
	  token <= 1'b0;
       end
     else
       begin
	  //pulse control signals, defaults here
	  alloc_ack <= 1'b0 ;
	  alloc_s2  <= 1'b0;
	  alloc_s3 <= 1'b0;

	  if (dealloc_req_pend || alloc_req_pend)
	    token <= ~token;
	  
	  if (alloc_req)
	    alloc_req_pend <= 1;

	  if (alloc_ack)
	    alloc_req_pend <= 0;
	       
	  if (alloc_req_pend && allow_alloc && token)
	    begin
	       //Read next location
	       alloc_id <= head  ;
	       m_addr <= head ;
	       m_wr   <= 1'b0 ;
	       alloc_s2 <= 1;
	       alloc_req_pend <= 0;
	    end
	  
	  if (alloc_s2)
	    begin
	       if (dout == tail)
		 allow_alloc <= `FALSE ;
	       else
		 allow_alloc <= `TRUE;
	       alloc_s3 <= 1;
	    end
	       
	  if (alloc_s3)
	    begin
	       head <= dout ;
	       alloc_ack <= 1'b1 ;
	       allow_dealloc <= 1'b1;
	    end

	  dealloc_ack <= 1'b0 ;//default
	  dealloc_s2  <= 1'b0;
	       
	  if (dealloc_req)
	    dealloc_req_pend <= 1;

	  if (dealloc_ack)
	    dealloc_req_pend <= 0;

	  if (dealloc_req_pend && allow_dealloc && !token)
	    begin
	       //write next location
	       m_addr <= tail ;
	       m_wr   <= 1'b1;
	       m_din <= dealloc_id;
	       tail <= dealloc_id;
	       dealloc_s2 <= 1;
	       dealloc_req_pend <= 0;
	       allow_alloc <= `TRUE;
	    end
	       
	  if (dealloc_s2)
	    begin
	       if (alloc_s2)
		 if (dout == tail)
		   allow_dealloc <= `FALSE ;
		 else
		   allow_dealloc <= `TRUE;
	       else
		 if (head == tail)
		   allow_dealloc <= `FALSE ;
		 else
		   allow_dealloc <= `TRUE;
	       
	       dealloc_ack <= 1'b1 ;
	    end
	  
       end // else: !if(rst)
   
   mem flist_mem(
		 // Outputs
		 .dout			(dout[width-1:0]),
		 // Inputs
		 .clk			(clk),
		 .din			(din[width-1:0]),
		 .addr			(addr[width-1:0]),
		 .wr			(wr));

endmodule // flist
	  
