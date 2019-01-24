`timescale 1ns/1ns

`define init   3'd0
`define stage1 3'd1
`define stage2 3'd2
`define stage3 3'd3
`define stage4 3'd4
`define stage5 3'd5

module huffman_decoder_v1 ( /*AUTOARG*/
   // Outputs
   code, push, pop,
   // Inputs
   rdy, not_full, clk, reset, idata
   ) ;

   parameter c_width = 4 ;//fixed length code width
   
   parameter vlc_width=5  ; //max variable length code width 
   parameter vlcz_width=5 ; //code size width
   
   parameter p_width=32 ; //packed data width 
   parameter p_width_msb=31 ; //packed data width
   
   parameter EOM = 4'd8;
   parameter EOM_LENGTH = 4 ;//code length - 1
   
   output  [3:0] code ;
   input 		rdy;
   input 		not_full ;
   input 		clk,reset ;
   
   input [31:0] idata ;//packed input data
   output 		push;
   output 		pop ;

   // //    
   reg 			push_rc;
   reg 			pop_rc ;
   reg 			push_wc;
   reg 			pop_wc ;   

   reg [35:0] 	pdata_wd,pdata_rd ;//packed data register, 32+4 = 36 bits
   reg [35:0] 	idata_expanded_wd ;//packed data register, 32+4 = 36 bits
   //    
   wire 		push = push_rc ;
   wire 		pop=pop_rc ;

   reg [3:0] 		code_rc,code_wc,code ;
   reg [5:0] 		bits_left_rc,bits_left_wc ;
   reg [2:0] 		shift_len_wc,shift_len_rc;
   reg [1:0] 		idx_wc,idx_rc;
   reg 			code_detect_wc,code_detect_rc ;
   reg [2:0] 		fsm_cs, fsm_ns;

   always @(posedge clk or posedge reset)
     if (reset)
       begin
	  pop_rc <= 0;
	  fsm_cs <= `init ;
	  push_rc <= 0;
	  pdata_rd <= 0;
	  bits_left_rc <= 0;
	  code_detect_rc <= 0;
       end
     else
       begin
	  bits_left_rc <= bits_left_wc ;
	  code_rc <= code_wc ;
	  code_detect_rc <= code_detect_wc ;
	  idx_rc <= idx_wc ;
	  shift_len_rc <= shift_len_wc ;
	  
	  fsm_cs <= fsm_ns ;
	  pop_rc <= pop_wc ;
	  push_rc <= push_wc ;
	  pdata_rd <= pdata_wd ;
       end

   reg eom_detect_wc ;
   
   always @(/*autosense*/
	    bits_left_rc or code_detect_rc or code_rc
	    or fsm_cs or idata or idx_rc or not_full or pdata_rd
	    or rdy or shift_len_rc)
     begin
	
	fsm_ns = fsm_cs ;
	
	//Control signals, inactive, unless maintaining state across multiple cycles
	eom_detect_wc = ( code_rc == EOM );
	pop_wc = 0;
	push_wc = 0;
	shift_len_wc = 0;
	idx_wc = 0;
	code_detect_wc = 0;
	code_wc = code_rc ;
	
	//Hold values, generally only for datapath
	pdata_wd = pdata_rd;
	bits_left_wc = bits_left_rc ;
	
	//Equivalent to a Continuous assign
	//rhs, should not be assigned in any case statement
	idata_expanded_wd = idata ;
	code = code_rc ;
	
	//1. Take 2 bits , if less than 2, then valid code
	//   Take 3 bits , if les
	case ( fsm_cs )
	  
	  `init:
	    if ( rdy & not_full )
	      begin
		 fsm_ns = `stage1 ;
		 pop_wc = 1 ;
	      end

	  `stage1:
	    begin
	       pdata_wd = pdata_rd | (idata_expanded_wd << ( 4- bits_left_rc ));
	       bits_left_wc = bits_left_rc + 32;
	       fsm_ns = `stage2 ;
	    end
	  
	  `stage2://Magnitude comparision 
	    begin
	       if ( pdata_rd[35:34] >=0 && pdata_rd[35:34] <= 1 )
		 begin
		    code_detect_wc = 1;
		    idx_wc = pdata_rd[34];
		    shift_len_wc = 2 ;
		    bits_left_wc = bits_left_rc - 2 ;
		 end

	       if ( pdata_rd[35:33] >= 4  && pdata_rd[35:33] <= 5 )
		 begin
		    code_detect_wc = 1;
		    idx_wc = pdata_rd[33];
		    shift_len_wc = 3 ;
		    bits_left_wc = bits_left_rc - 3 ;		    
		 end

	       if ( pdata_rd[35:32] >= 12 && pdata_rd[35:32] <= 14 )
		 begin
		    code_detect_wc = 1;
		    idx_wc = pdata_rd[33:32];
		    shift_len_wc = 4 ;
		    bits_left_wc = bits_left_rc - 4 ;					   
		 end
	       
	       if ( pdata_rd[35:31] >= 30 && pdata_rd[35:31] <= 31  )
		 begin
		    code_detect_wc = 1;
		    idx_wc = pdata_rd[31];
		    shift_len_wc = 5 ;
		    bits_left_wc = bits_left_rc - 5 ;					   
		 end

	       fsm_ns = `stage3;
	    end

	  `stage3://Table Lookup & shift
	    begin
	       if ( code_detect_rc )
		 begin
	       	    pdata_wd = pdata_rd << ( shift_len_rc ) ;
		 end

	       if ( ~code_detect_rc & bits_left_rc >=5 )
		 $display( $time," ns:Fatal Decoding error: No code detect and bits_left = %d", bits_left_rc);
	       
	       fsm_ns = `stage4 ;

	       case( shift_len_rc )
		 2: code_wc = lookup_2bit( idx_rc ) ;
		 3: code_wc = lookup_3bit( idx_rc ) ;
		 4: code_wc = lookup_4bit( idx_rc ) ;
		 5: code_wc = lookup_5bit( idx_rc ) ;
	       endcase // case ( shift_len_rc )
		     
	    end // case: `stage3

	  `stage4:
	    begin
	       if ( not_full )
		 begin
		    push_wc = 1 ;
		    if ( bits_left_rc <= 4 | code_rc == EOM )
		      begin
			 //pop new dword
			 fsm_ns = `init ;
			 if ( code_rc == EOM )
			   begin
			      bits_left_wc = 0;
			      pdata_wd = 0;
			   end
		      end
		    else //shift and keep going
		      fsm_ns = `stage2 ;

		    if ( bits_left_wc & code_rc == EOM ) 
		      $display($time," ns::Decoding Error:Bits left = %d (should be 0)", bits_left_rc);		 
		    
		 end // if ( not_full )

	    end // case: `stage4
	  
	  default:fsm_ns = `init ;
	  
	endcase // case ( fsm_cs )
     end

   function [3:0] lookup_2bit ;
      input  idata ;
      begin
	 if ( idata )
	   lookup_2bit = 4'd7; //H
	 else
	   lookup_2bit = 4'd4; //E
      end
   endfunction // lookup_2bit

   function [3:0] lookup_3bit ;
      input  idata ;
      begin
	 if ( idata )
	   lookup_3bit = 4'd3; //D
	 else
	   lookup_3bit = 4'd0; //A
      end
   endfunction // lookup_2bit
   
   function [3:0] lookup_4bit ;
      input  [1:0] idata ;
      begin
	 case (idata)
	   0:	   lookup_4bit = 4'd2; //C
	   1:	   lookup_4bit = 4'd5; //F
	   2:	   lookup_4bit = 4'd6; //G
	   3:      lookup_4bit = 4'bx;//don't care
	 endcase // case (idata)
      end
   endfunction // lookup_2bit
   
   function [3:0] lookup_5bit ;
      input  idata ;
      begin
	 if ( idata )
	   lookup_5bit = 4'd8; //EOS
	 else
	   lookup_5bit = 4'd1; //B
      end
   endfunction // lookup_2bit
         
			  
endmodule // huffman_decode_v1
