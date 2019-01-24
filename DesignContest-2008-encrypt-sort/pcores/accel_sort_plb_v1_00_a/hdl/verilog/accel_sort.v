`timescale 1ns/1ns

`define init   4'd0
`define stage1 4'd1
`define stage2 4'd2
`define stage3 4'd3
`define stage4 4'd4
`define stage5 4'd5
`define stage6 4'd6
`define stage7 4'd7
`define stage8 4'd8
`define stage9 4'd9
`define stage10 4'd10
`define stage11 4'd11
`define stage12 4'd12
`define stage13 4'd13
`define stage14 4'd14

module accel_sort ( /*AUTOARG*/
   // Outputs
   odata, push, pop,
   // Inputs
   idata, rdy, not_full, clk, reset, start_index, global_key,
   no_compare, reset_index, zero_key
   ) ;

   parameter i_width=64  ; 
   parameter o_width=64 ; 
   parameter index_width = 19 ;

   parameter i_r_width=64 ;  
   parameter o_r_width=128 ;  

   parameter i_w_width=128 ; 
   parameter o_w_width=64 ; 
   
   input [i_width-1:0] idata ;
   input 	       rdy;
   input 	       not_full ;
   input 	       clk,reset ;
   input [index_width-1:0]	start_index ;
   input [127:0] 		global_key;
   input 			no_compare ;//when set data is not compared,required for an encryption pass
   input 			reset_index ;
   input 			zero_key ;
   
   output [o_width-1:0] 	odata ;
   output 			push;
   output 			pop ;

   wire 			reset_index ;
   
   wire 			pop;
   wire 			no_compare;
   
   reg [3:0] fsm_cs, fsm_ns;

   reg 	     rd_pull_wc,rd_pull_rc;
   reg 	       go_wc,go_rc;

   reg 	       keygen_pull_wc,keygen_pull_rc;

   
   wire [o_r_width-1:0] rdata;
   reg [i_w_width-1:0] 	wr_data_wd,wr_data_rd;
   wire [i_w_width-1:0] wr_data = wr_data_rd;   

   //Reg arrays to hold sorted blocks of 2 records
   reg [i_w_width-1:0] 	r1_rd_0;
   reg [i_w_width-1:0] 	r1_rd_1;      
   reg [i_w_width-1:0] 	r2_rd_0;      
   reg [i_w_width-1:0] 	r2_rd_1;

   reg [i_w_width-1:0] 	r1_wd_0;
   reg [i_w_width-1:0] 	r1_wd_1;      
   reg [i_w_width-1:0] 	r2_wd_0;      
   reg [i_w_width-1:0] 	r2_wd_1;

   reg [i_w_width-1:0] 	r1_wd;      
   reg [i_w_width-1:0] 	r2_wd;               
   
   wire        rd_rdy ;
   wire        keygen_o_rdy ;
   wire        push ;
   reg 	       wr_push_rc,wr_push_wc;
   wire        not_full ;
   wire        clk,reset;

   wire        wr_push = wr_push_rc;   
   wire        i_rdy = rdy ;
   wire        rd_pull = rd_pull_rc;   
   wire        go = go_rc;   
   wire        keygen_pull = keygen_pull_rc;
   wire [127:0] o_key;

   reg data1_lt_data2_wc;
   wire zero_key ;
   
   reg [127:0] data1_wd,data2_wd,
	       data1_rd,data2_rd,
	       data1_unencrypted_wd,data2_unencrypted_wd,
	       data1_unencrypted_rd,data2_unencrypted_rd;
   
   fifo_rd_64_to_128 fifo_read(
			       // Outputs
			       .odata		(rdata[o_r_width-1:0]),
			       .pop		(pop),
			       .o_rdy		(rd_rdy),
			       // Inputs
			       .idata		(idata[i_width-1:0]),
			       .i_rdy		(i_rdy),
			       .clk		(clk),
			       .reset		(reset),
			       .pull		(rd_pull));
   
   fifo_wr_128_to_64 fifo_write( 
				// Outputs
				.rdy		(wr_rdy),
				.odata		(odata[o_w_width-1:0]),
				.o_push		(push),
				// Inputs
				.idata		(wr_data[i_w_width-1:0]),
				.clk		(clk),
				.reset		(reset),
				.not_full	(not_full),
				.i_push		(wr_push));

   
   aes_keygen  keygen(
		      // Outputs
		      .o_key		(o_key[127:0]),
		      .o_rdy		(keygen_o_rdy),
		      // Inputs
		      .clk		(clk),
		      .reset		(reset),
		      .go		(go),
		      .zero_key         (zero_key),
		      .pull		(keygen_pull),
		      .global_key	(global_key[127:0]),
		      .reset_index      (reset_index),
		      .start_index	(start_index[index_width-1:0]));
   

   reg [1:0]   r1_ptr_wc,r1_ptr_rc ;
   reg [1:0]   r2_ptr_wc,r2_ptr_rc ;   
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
	  fsm_cs <= `stage1 ;
	  rd_pull_rc <= 0;
	  go_rc <= 0;
	  keygen_pull_rc <= 0;
	  wr_push_rc <= 0;
	  r1_ptr_rc <= 0;
	  r2_ptr_rc <= 0;
       end
     else
       begin
	  //Control assigns
	  fsm_cs <= fsm_ns ;
	  rd_pull_rc <= rd_pull_wc ;
	  go_rc <= go_wc ;
	  keygen_pull_rc <= keygen_pull_wc ;
	  wr_push_rc <= wr_push_wc;

	  r1_ptr_rc <= r1_ptr_wc ;
	  r2_ptr_rc <= r2_ptr_wc ;		  
   
	  //Datapath assigns
	  data1_rd <= data1_wd ;
	  data2_rd <= data2_wd;
	  data1_unencrypted_rd <= data1_unencrypted_wd;
	  data2_unencrypted_rd <= data2_unencrypted_wd;
	  wr_data_rd <= wr_data_wd ;

	  r1_rd_0 <= r1_wd_0;
	  r1_rd_1 <= r1_wd_1;
	  r2_rd_0 <= r2_wd_0;
	  r2_rd_1 <= r2_wd_1;			  
       end

   
   always @(
	    data1_rd
	    or data1_unencrypted_rd or data2_rd
	    or data2_unencrypted_rd or fsm_cs or keygen_o_rdy
	    or no_compare or o_key or r1_ptr_rc or r1_rd_0 or r1_rd_1
	    or r2_ptr_rc or r2_rd_0 or r2_rd_1 or rd_rdy or rdata
	    or wr_data_rd or wr_rdy)

     begin
	//Control
	fsm_ns = fsm_cs ;
	go_wc = 0;
	rd_pull_wc = 0;
	keygen_pull_wc = 0;
	wr_push_wc = 0;

	r1_ptr_wc = r1_ptr_rc ;
	r2_ptr_wc = r2_ptr_rc ;	
	
	//Datapath
	data1_lt_data2_wc = (data1_unencrypted_rd < data2_unencrypted_rd) | no_compare ;
	data1_wd = data1_rd;
	data1_unencrypted_wd = data1_unencrypted_rd;
	data2_wd = data2_rd;
	data2_unencrypted_wd = data2_unencrypted_rd;	
	wr_data_wd = wr_data_rd;

	r1_wd_0 = r1_rd_0;
	r1_wd_1 = r1_rd_1;
	r2_wd_0 = r2_rd_0;
	r2_wd_1 = r2_rd_1;		

	if ( r1_ptr_rc )
	  r1_wd = r1_rd_1;
	else
	  r1_wd = r1_rd_0;
	
	if ( r2_ptr_rc )
	  r2_wd = r2_rd_1;
	else
	  r2_wd = r2_rd_0;	  
	
	case ( fsm_cs )

	  `stage1://Read from fifo 
	    if ( rd_rdy )
	      begin
		 go_wc = 1 ;		 
		 rd_pull_wc = 1 ;
		 data1_wd = rdata ;
		 fsm_ns = `stage2 ;
	      end

	  `stage2:
	    if ( keygen_o_rdy )
	      begin
		 keygen_pull_wc = 1;
		 data1_unencrypted_wd = data1_rd ^ o_key ;
		 fsm_ns = `stage3;
	      end

	  `stage3:
	    begin
	       go_wc = 1;//Start next round of computation
	       if ( rd_rdy )
		 begin
		    rd_pull_wc = 1 ;
		    data2_wd = rdata ;
		    fsm_ns = `stage4 ;
		 end
	    end // case: `stage3

	  `stage4:
	    if ( keygen_o_rdy )
	      begin
		 keygen_pull_wc = 1;
		 data2_unencrypted_wd = data2_rd ^ o_key ;
		 fsm_ns = `stage5;
	      end

	  `stage5://Compare and push to regfile r1
	    begin
	       go_wc = 1;//start next round of keygen
	       if (data1_lt_data2_wc)
		 begin
		    r1_wd_0= data1_unencrypted_rd;
		    r1_wd_1= data2_unencrypted_rd;		      
		 end
	       else
		 begin
		    r1_wd_1= data1_unencrypted_rd;
		    r1_wd_0= data2_unencrypted_rd;		      		 
		 end
	       fsm_ns = `stage6;
	    end

	  `stage6://Read from fifo 
	    if ( rd_rdy )
	      begin
		 rd_pull_wc = 1 ;
		 data1_wd = rdata ;
		 fsm_ns = `stage7 ;
	      end

	  `stage7:
	    if ( keygen_o_rdy )
	      begin
		 keygen_pull_wc = 1;
		 data1_unencrypted_wd = data1_rd ^ o_key ;
		 fsm_ns = `stage8;
	      end

	  `stage8:
	    begin
	       go_wc = 1;//Start next round of computation
	       if ( rd_rdy )
		 begin
		    rd_pull_wc = 1 ;
		    data2_wd = rdata ;
		    fsm_ns = `stage9 ;
		 end
	    end // case: `stage3

	  `stage9:
	    if ( keygen_o_rdy )
	      begin
		 keygen_pull_wc = 1;
		 data2_unencrypted_wd = data2_rd ^ o_key ;
		 fsm_ns = `stage10;
	      end

	  `stage10://Compare and push to regfile r1
	    begin
	       if (data1_lt_data2_wc)
		 begin
		    r2_wd_0= data1_unencrypted_rd;
		    r2_wd_1= data2_unencrypted_rd;		      
		 end
	       else
		 begin
		    r2_wd_1= data1_unencrypted_rd;
		    r2_wd_0= data2_unencrypted_rd;		      		 
		 end

	       if ( no_compare )
		 fsm_ns = `stage11;
	       else
		 fsm_ns = `stage12;
	    end

	  `stage11:
	    begin
	       if ( ~r1_ptr_rc[1] )
		 begin
		    wr_data_wd = r1_wd ;
		    r1_ptr_wc = r1_ptr_rc + 1;
		    fsm_ns = `stage13;
		 end
	       else
		 if ( ~r2_ptr_rc[1] )
		   begin
		      wr_data_wd = r2_wd ;
		      r2_ptr_wc = r2_ptr_rc + 1;
		      fsm_ns = `stage13;
		   end	

	       if ( r1_ptr_rc[1] & r2_ptr_rc[1] )
		 begin
		    r1_ptr_wc = 0;
		    r2_ptr_wc = 0;
		    fsm_ns = `stage1;
		 end
	       
	    end // case: `stage11
	       
	  //Merge sort block 4
	  `stage12:
	    begin
	       case( {r2_ptr_rc,r1_ptr_rc})
		 4'b0000,4'b0001,4'b0100,4'b0101:
		   begin
		      if (r1_wd < r2_wd)
			begin
			   wr_data_wd = r1_wd;
			   r1_ptr_wc = r1_ptr_rc + 1;
			end
		      else
			begin
			   wr_data_wd = r2_wd;
			   r2_ptr_wc = r2_ptr_rc + 1;
			end
		      
		      fsm_ns = `stage13;
		   end // case: 4'b0000,4'b0001,4'b0100,4'b0101
		 
		 4'b0010,4'b0110://r1_ptr==2
		   begin
		      wr_data_wd = r2_wd;
		      fsm_ns = `stage13;
		      r2_ptr_wc = r2_ptr_rc + 1;
		   end
		 
		 4'b1000,4'b1001://r2_ptr==2
		   begin
		      wr_data_wd = r1_wd;
		      r1_ptr_wc = r1_ptr_rc + 1;			      
		      fsm_ns = `stage13;
		   end
		 
		 4'b1010://both ptrs are 2,2
		   begin
		      r1_ptr_wc = 0;
		      r2_ptr_wc = 0;
		      fsm_ns=`stage1;
		   end
		 
	       endcase // case ( {r1_ptr_rc,r2_ptr_rc})
	    end
	  
	  `stage13://Load the other data word
	    if ( wr_rdy )
	      begin
		 wr_push_wc =1 ;
		 fsm_ns = `stage14;
	      end

	  `stage14://no back2back loads
	    if ( !wr_rdy )
	      if ( no_compare )
		fsm_ns = `stage11;
	      else
		fsm_ns = `stage12;

	  default:fsm_ns = `stage1 ;
	  
	endcase // case ( fsm_cs )
     end
   
endmodule // accel_sort
