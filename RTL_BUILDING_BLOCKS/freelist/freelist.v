`timescale 1ns/1ns

module freelist(/*AUTOARG*/
   // Outputs
   alloc_id, alloc_ack, dealloc_ack, init_done,
   // Inputs
   clk, rst, alloc_req, dealloc_req, dealloc_id
   );

   parameter dwidth = 8 ;
   parameter awidth = dwidth;
   parameter dwidth_1s = 8'hff;
   
   input     clk;
   input     rst;
   
   input     alloc_req ;
   output [dwidth-1:0] alloc_id ;
   output 	       alloc_ack ;   

   input     dealloc_req ;   
   input  [dwidth-1:0] dealloc_id;
   output 	       dealloc_ack ;
   output 	       init_done;
   
   //Alloc: read head ptr and return
   //Dealloc: wr tail ptr and return
   //Use dual port mem
   //Alloc and dealloc can proceed in parallel

   /*AUTOREG*/

   /*AUTOWIRE*/

//zReg
//zBegin
   //zEnd
   
//zWidth 8 slf , js ,js , sdf , sfk
        
   reg [dwidth-1:0] head_wc,head_rc,tail_wc,tail_rc ;

   reg 		    alloc_pending_wc, alloc_pending_rc;
   reg 		    dealloc_pending_wc, dealloc_pending_rc;   
   reg 		    alloc_ack_wc,alloc_ack_rc;
   reg 		    dealloc_ack_wc,dealloc_ack_rc;
   reg 		    wr1_wc,wr1_rc;
   reg [dwidth-1:0] addr1_wc;
   reg [dwidth-1:0] addr1_rc;
   reg [dwidth-1:0] din1_wc;
   reg [dwidth-1:0] din1_rc;
   reg [dwidth-1:0] alloc_id_wc;
   reg [dwidth-1:0] alloc_id_rc;      
   reg 		    init_done_wc, init_done_rc;
   
   wire [dwidth-1:0] dout1;
   wire [dwidth-1:0] dout2;   
   
   //Common status
   //Will use head and tail pointers
   
   //1 port of dpram will be controlled by alloc and dealloc sm
   //deallocs have priorty over allocs
   //1. Dealloc or 

   wire [dwidth-1:0] alloc_id = alloc_id_rc;
   wire 	     alloc_ack = alloc_ack_rc;
   wire 	     dealloc_ack = dealloc_ack_rc;
   wire 	     init_done = init_done_rc;
   
   parameter 	    initialize=3,wait_for_req = 0, write_update_tail=1,read_nxt_head=2;

   reg [1:0] 	    flist_cs,flist_ns;

   //zAssign clk,rst
   //zBegin
   always @(posedge clk)
     if (rst)
       begin
	  din1_rc <= 0;
	  alloc_pending_rc <= 0;
	  dealloc_pending_rc <= 0;
	  head_rc <= 0;
	  tail_rc <= dwidth_1s;
	  alloc_ack_rc <= 0;
	  dealloc_ack_rc <= 0;
	  init_done_rc <= 0;
	  flist_cs <= initialize;
       end
     else
       begin
	  addr1_rc <= addr1_wc;
	  wr1_rc <= wr1_wc;
	  din1_rc <= din1_wc;
	  alloc_pending_rc <= alloc_pending_wc;
	  dealloc_pending_rc <= dealloc_pending_wc;
	  tail_rc <= tail_wc;
	  head_rc <= head_wc;
	  alloc_ack_rc <= alloc_ack_wc;
	  dealloc_ack_rc <= dealloc_ack_wc;
	  flist_cs <= flist_ns;
	  init_done_rc <= init_done_wc;
	  alloc_id_rc <= alloc_id_wc;
       end
   //zEnd
   
   always @(/*AUTOSENSE*/alloc_pending_rc or alloc_req or dealloc_id
	    or dealloc_pending_rc or dealloc_req or din1_rc or dout1
	    or flist_cs or head_rc or init_done_rc or tail_rc)
     begin
	//Control signals (pulsed)

	//zAssign default
	//zBegin
	wr1_wc = 0;
	addr1_wc = 0;
	din1_wc = 0;
	alloc_id_wc = 0;
	
	alloc_ack_wc = 0;
	dealloc_ack_wc = 0;
	
	//Signals that hold value
	tail_wc = tail_rc;
	head_wc = head_rc;
	init_done_wc = init_done_rc;
	
	//Signals that hold value and update
	if ( alloc_req )
	  alloc_pending_wc = 1;
	else
	  alloc_pending_wc = alloc_pending_rc;
	
	if ( dealloc_req )
	    dealloc_pending_wc = 1;
	else
	  dealloc_pending_wc = dealloc_pending_rc;	  
	
	flist_ns = flist_cs;
	//zEnd
	
	case (flist_cs)

	  initialize:
	    begin
	       addr1_wc = din1_rc;
	       wr1_wc = 1;
	       din1_wc = din1_rc+1;

	       if ( din1_wc == 0 )
		 begin
		    init_done_wc=1;
		    flist_ns = wait_for_req ;
		 end
	    end
	  
	  wait_for_req:
	    begin
	       if ( dealloc_req | dealloc_pending_rc )
		 begin
		    wr1_wc = 1 ;
		    addr1_wc = tail_rc;
		    din1_wc = dealloc_id ;
		    tail_wc = dealloc_id ;
		    dealloc_ack_wc = 1;
		    dealloc_pending_wc = 0;
		    flist_ns = write_update_tail ;
		 end
	       else
		 if ( alloc_req | alloc_pending_rc )
		   begin
		      if ( head_rc != tail_rc )
			begin
			   alloc_id_wc = head_rc ;
			   alloc_ack_wc = 1;
			   alloc_pending_wc = 0;
			   addr1_wc = head_rc ;
			   flist_ns = read_nxt_head ;
			end
		   end // if ( alloc_pending_wc )
	    end // case: s1

	  write_update_tail:
	    begin
	       flist_ns = wait_for_req;
	    end

	  read_nxt_head:
	    begin
	       head_wc = dout1;
	       flist_ns = wait_for_req;
	    end
	
	endcase
     end

   wire clk1 = clk;
   wire clk2 = clk;
   wire [dwidth-1:0] addr1 = addr1_wc;
   wire wr1 = wr1_wc;
   wire [dwidth-1:0] din1 = din1_wc;
   wire [dwidth-1:0] addr2;
   
   dpmem freemem(/*AUTOINST*/
		 // Outputs
		 .dout1			(dout1[dwidth-1:0]),
		 .dout2			(dout2[dwidth-1:0]),
		 // Inputs
		 .clk1			(clk1),
		 .clk2			(clk2),
		 .din1			(din1[dwidth-1:0]),
		 .addr1			(addr1[awidth-1:0]),
		 .addr2			(addr2[awidth-1:0]),
		 .wr1			(wr1));

endmodule // freelist


module tb;

   parameter dwidth = 8 ;
   
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			alloc_req;		// To dut of freelist.v
   reg			clk;			// To dut of freelist.v
   reg [dwidth-1:0]	dealloc_id;		// To dut of freelist.v
   reg			dealloc_req;		// To dut of freelist.v
   reg			rst;			// To dut of freelist.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			alloc_ack;		// From dut of freelist.v
   wire [dwidth-1:0]	alloc_id;		// From dut of freelist.v
   wire			dealloc_ack;		// From dut of freelist.v
   wire			init_done;		// From dut of freelist.v
   // End of automatics

   integer alloc_count ;
   integer dealloc_count ;   
   
   initial
     begin
	$dumpvars;
	alloc_count=0;
	dealloc_count=0;	
	clk = 0;
	rst = 1;
	alloc_req = 0;
	dealloc_req = 0;
	dealloc_id = 0;
	#111;
	rst = 0;
	repeat (5000) @(posedge clk);
	$finish;
     end // initial begin

   always #5 clk = ~clk ;
   
   always @(posedge clk)
     if ( ~rst & init_done)
       begin
	  alloc_req <= 1;
	  @(posedge clk);
	  alloc_req <= 0;
	  while( ~alloc_ack ) @(posedge clk);
	  alloc_count = alloc_count + 1;
       end

   always @(posedge clk)
     if ( alloc_count > 254 )
       begin
	  dealloc_req <= 1;
	  dealloc_id <= dealloc_id + 1;
	  @(posedge clk);
	  dealloc_req <= 0;
	  while( ~dealloc_ack ) @(posedge clk);
	  dealloc_count = dealloc_count + 1;
       end   
  
   freelist dut(/*AUTOINST*/
		// Outputs
		.alloc_id		(alloc_id[dwidth-1:0]),
		.alloc_ack		(alloc_ack),
		.dealloc_ack		(dealloc_ack),
		.init_done		(init_done),
		// Inputs
		.clk			(clk),
		.rst			(rst),
		.alloc_req		(alloc_req),
		.dealloc_req		(dealloc_req),
		.dealloc_id		(dealloc_id[dwidth-1:0]));
   

endmodule // tb
