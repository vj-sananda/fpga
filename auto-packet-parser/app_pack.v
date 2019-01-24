
//app = automatic packet parser
//given a pkt definition will build a parser auto-magically
//rev1: Assumptions
//Fields are not larger than the width
//
`timescale 1ns/1ns

`include "pkt.defn.vh"

module app_pack (/*AUTOARG*/
   // Outputs
   dout, dout_v,
   // Inputs
   clk, rst, f0, f0_v, f1, f1_v, f2, f2_v, f3, f3_v, f4, f4_v
   );

   `include "parameter.vh"
   
   input     clk,rst;
   
   output [w_din-1:0] dout ;
   output 	     dout_v ;//dout valid signal

   input [w_f0-1:0] f0;
   input 	     f0_v;//valid signal, pulse 1 clk wide

   input [w_f1-1:0] f1;
   input 	     f1_v;

   input [w_f2-1:0] f2;
   input 	     f2_v;

   input [w_f3-1:0] f3;
   input 	     f3_v;

   input [w_f4-1:0] f4;
   input 	     f4_v;   

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [w_din-1:0]	dout;
   reg			dout_v;
   // End of automatics

   /*AUTOWIRE*/

   //zWidth [w_din-1:0] tmp_,dout_ ;
   //zReg
   reg [w_din-1:0] dout_rd ;
   reg  f0_v_rx_wc ;
   reg  f1_v_rx_wc ;
   reg  f2_v_rx_wc ;
   reg  f0_v_rx_rc ;
   reg  f1_v_rx_rc ;
   reg  f2_v_rx_rc ;   
   reg [w_din-1:0] dout_v_wc ;
   reg [w_din-1:0] tmp_rd ;
   reg [w_din-1:0] dout_wd ;
   reg [w_din-1:0] f4_dout_wd ;
   reg [w_din-1:0] f4_dout_rd ;   
   reg [w_din-1:0] tmp_wd ;


   reg  [w_f0-1:0] f0_rd ;
   reg  [w_f1-1:0] f1_rd ;
   
   reg  [w_f2-1:0] f2_rd ;
   reg  [w_f3-1:0] f3_rd ;
   reg  [w_f4-1:0] f4_rd ;
   
   reg  f0_v_wc ;
   reg  f1_v_wc ;
   reg  f2_v_wc ;
   reg  f3_v_wc ;
   reg  f4_v_wc ;


   reg  [w_f0-1:0]  f0_wd ;
   reg  [w_f1-1:0]  f1_wd ;   
   reg  [w_f2-1:0]  f2_wd ;
   reg  [w_f3-1:0] f3_wd ;
   reg  [w_f4-1:0]  f4_wd ;

   reg [msb_states:0] curr_state , next_state;

   reg 		      f4_dout_v_wc,f4_dout_v_rc;
	  
   
   parameter 	      s0=0,s1=1,s2=2;
   
   always @(posedge clk)
     if (rst)
       begin
	  //zClkReset
	  dout_rd <= 0;
	  tmp_rd <= 0;
	  f4_dout_v_rc <= 0;
	  curr_state <= s0;
       end
     else
       begin
	  //zClkAssign
	  dout_rd <=  dout_wd ; 
	  tmp_rd <=  tmp_wd ; 
	  f2_rd <=  f2_wd ; 
	  f3_rd <=  f3_wd ; 
	  f4_rd <=  f4_wd ;

	  f4_dout_rd <=  f4_dout_wd ;	  

	  f0_rd <= f0_wd;
	  f1_rd <= f1_wd;
	  
	  f0_v_rx_rc <=  f0_v_rx_wc ;
	  f1_v_rx_rc <=  f1_v_rx_wc ; 
	  f2_v_rx_rc <=  f2_v_rx_wc ; 
	  f4_dout_v_rc <= f4_dout_v_wc;
	  
	  dout_rd <=  dout_wd ; 
	  tmp_rd <=  tmp_wd ; 

	  curr_state <= next_state;
       end
      
   always @*
     begin
	//zWireAssign
	f0_v_rx_wc =  0 ; 
	f1_v_rx_wc =  0 ; 
	f2_v_rx_wc =  0 ; 
	dout_v_wc =  0 ; 
	f4_dout_v_wc = 0;
	
	dout_wd =  dout_rd ; 
	tmp_wd =  tmp_rd ; 

	
	f0_v_wc =  0 ; 
	f1_v_wc =  0 ; 
	f2_v_wc =  0 ; 
	f3_v_wc =  0 ; 
	f4_v_wc =  0 ; 

	f0_wd = f0_rd;
	f1_wd = f1_rd;
	f2_wd =  f2_rd ; 
	f3_wd =  f3_rd ; 
	f4_wd =  f4_rd ;

	f4_dout_wd =  f4_dout_rd ;	

	f0_v_rx_wc =  f0_v_rx_rc ;
	f1_v_rx_wc =  f1_v_rx_rc ; 
	f2_v_rx_wc =  f2_v_rx_rc ; 
       
	//zEnd

	//Don't forget this
	next_state = curr_state;
	
	case( curr_state )

	  s0: //Got W0, so can parse out f0, and f1
	    //which are completely contained in W0
	    //f2 is partially contained and so must use temporary storage
	    begin
	       if ( f0_v )
		 begin
		    f0_v_rx_wc = 1;//Received f0_v
		    //f0_wd = f0 ;		    
		    dout_wd[`f0_W0_MSB:`f0_W0_LSB] = f0 ;
		 end
	       
	       if ( f1_v )
		 begin
		    f1_v_rx_wc = 1;//Received f1_v		
		    //f1_wd = f1;		    //     
		    dout_wd[`f1_W0_MSB:`f1_W0_LSB] = f1;
		 end
	       
	       if ( f2_v )
		 begin
		    f2_v_rx_wc = 1;//Received f2_v		    
		    dout_wd[`f2_W0_MSB:`f2_W0_LSB]=f2[`f2_W0_MSB-`f2_W0_LSB:0];
		    tmp_wd[`f2_W1_MSB:`f2_W1_LSB] = f2[`f2_W1_MSB-`f2_W1_LSB+`f2_W0_MSB-`f2_W0_LSB+1:`f2_W0_MSB-`f2_W0_LSB+1] ;
		 end

	       if ( f0_v_rx_wc & f1_v_rx_wc & f2_v_rx_wc )
		 begin
		    dout_v_wc = 1;
		    next_state = s1;
		 end
	       
	    end // case: s0

	  s1: 
	    begin
	       f0_v_rx_wc =0;
	       f1_v_rx_wc =0;
	       f2_v_rx_wc  =0;
	       
	       if ( f3_v )
		 begin
		    dout_wd[`f3_W1_MSB:`f3_W1_LSB]=f3[`f3_W1_MSB-`f3_W1_LSB:0];
		    dout_wd[`f2_W1_MSB:`f2_W1_LSB] = tmp_rd[`f2_W1_MSB:`f2_W1_LSB];
		    tmp_wd[`f3_W2_MSB:`f3_W2_LSB] = f3[`f3_W2_MSB-`f3_W2_LSB+`f3_W1_MSB-`f3_W1_LSB+1:`f3_W1_MSB-`f3_W1_LSB+1];
		    dout_v_wc = 1;
		 end

	       if ( f4_v ) 
		 begin
		    f4_dout_wd[`f4_W2_MSB:`f4_W2_LSB] = f4[`f4_W2_MSB-`f4_W2_LSB:0];
		    f4_dout_wd[`f3_W2_MSB:`f3_W2_LSB] = tmp_wd[`f3_W2_MSB:`f3_W2_LSB];
		    f4_dout_v_wc = 1;
		    next_state = s2;
		 end
	       
	    end // case: s0

	  s2:
	    begin
	       if ( f4_dout_v_rc )
		 begin
		    dout_wd = f4_dout_rd ;
		    dout_v_wc = 1;
		    next_state = s0;
		 end
	    end // case: s0

	endcase // case ( curr_state )

	//Equivalent to a continuous assign
	dout_v = dout_v_wc;
	dout = dout_wd;
	
     end

endmodule // app
