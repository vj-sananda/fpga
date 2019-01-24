/*
 Purpose:
 Keys for encryption/decryption are only a function of the index.
 So a free running index counter can serve as the input to the aes_cipher module 
 Inputs to the module include:
 - 128 bit global key
 - start index (will generate keys starting from this index, free-running)
 */

`define init   1'd0
`define stage1 1'd1

module aes_keygen(/*AUTOARG*/
   // Outputs
   o_key, o_rdy,
   // Inputs
   clk, reset, go, pull, reset_index, global_key, start_index,zero_key
   );

   parameter index_width = 19 ;

   input     clk , reset ;
   input     go;
   input     pull ;
   input     reset_index ;
   input     zero_key ;
   
   input [127:0] global_key ;
   input [index_width-1:0] start_index ;

   output [127:0] 	   o_key ;
   output 		   o_rdy ;
   
   /*AUTOREG*/

   /*AUTOWIRE*/

   //Local Var
   reg 			o_rdy_rc, o_rdy_wc ;
   reg 			fsm_ns,fsm_cs ;
   reg 			ld_wc,ld_rc ;
   reg [index_width-1:0] index_wd,index_rd;   
   reg [127:0] 		text_in_wd,text_in_rd ;
   reg [127:0] 		o_key_wd,o_key_rd;
  
   wire [127:0] 	key = global_key ;
   wire [127:0] 	text_in = text_in_rd ;
   wire			o_rdy = o_rdy_rc;
   wire [127:0] 	o_key = o_key_rd;
   wire 		ld = ld_rc;

   wire [127:0] 	text_out;
   
   aes_cipher_top cipher_i(
			   // Outputs
			   .done		(done),
			   .text_out		(text_out[127:0]),
			   // Inputs
			   .clk			(clk),
			   .rst			(~reset),
			   .ld			(ld),
			   .key			(key[127:0]),
			   .text_in		(text_in[127:0]));
   

   
   always @(posedge clk or posedge reset)
     if  (reset)
       begin
	  text_in_rd <= 0;
	  o_rdy_rc <= 0;
	  ld_rc <= 0;
	  index_rd <= 0;
	  fsm_cs <= `init ;
       end
     else
       begin
	  fsm_cs <= fsm_ns ;
	  text_in_rd <= text_in_wd ;
	  o_rdy_rc <= o_rdy_wc ;
	  ld_rc <= ld_wc ;

	  if ( reset_index )
	    index_rd <= 0;
	  else
	    index_rd <= index_wd ;
	  
	  o_key_rd <= o_key_wd;
       end

   
   always @(/*autosense*/done or fsm_cs or go
	    or index_rd or o_key_rd or o_rdy_rc or pull or start_index
	    or text_out)
     begin
	
	fsm_ns = fsm_cs ;
	ld_wc = 0;
	text_in_wd = 0 ;
	
	//Hold values
	o_rdy_wc = o_rdy_rc ;
	index_wd = index_rd;
	o_key_wd = o_key_rd;
	
	case ( fsm_cs )
	  `init:
	    if ( go  )
	      begin
		 fsm_ns = `stage1 ;
		 text_in_wd[127:96] = index_rd + start_index ;
		 index_wd = index_rd + 1;
		 ld_wc = 1 ;
	      end
	  `stage1:
	    begin
	       if ( done )
		 begin
		    o_rdy_wc = 1;
		    if ( zero_key )
		      o_key_wd = 0;
		    else
		      o_key_wd = text_out;
		 end
	       
	       if (pull)
		 begin
		    o_rdy_wc = 0;
		    fsm_ns = `init ;
		 end
	    end

	  default:fsm_ns = `init ;
	  
	endcase // case ( fsm_cs )
     end
       
endmodule // aes_keygen
