//app = automatic packet parser
//given a pkt definition will build a parser auto-magically
//rev1: Assumptions
//Fields are not larger than the width
//

`timescale 1ns/1ns
`include "pkt.defn.vh"

module app_unpack (/*AUTOARG*/
   // Outputs
   f0, f0_v, f1, f1_v, f2, f2_v, f3, f3_v, f4, f4_v,
   // Inputs
   clk, rst, din, din_v
   );

   `include "parameter.vh"
   
   input     clk,rst;
   
   input [w_din-1:0] din ;
   input 	     din_v ;//din valid signal

   output [w_f0-1:0] f0;
   output 	     f0_v;//valid signal, pulse 1 clk wide

   output [w_f1-1:0] f1;
   output 	     f1_v;

   output [w_f2-1:0] f2;
   output 	     f2_v;

   output [w_f3-1:0] f3;
   output 	     f3_v;

   output [w_f4-1:0] f4;
   output 	     f4_v;   

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [w_f0-1:0]	f0;
   reg [w_f1-1:0]	f1;
   reg [w_f2-1:0]	f2;
   reg [w_f3-1:0]	f3;
   reg [w_f4-1:0]	f4;
   // End of automatics

   /*AUTOWIRE*/

   //zReg
   reg  [w_f2-1:0] f2_rd ;
   reg  [w_f3-1:0] f3_rd ;
   reg  [w_f4-1:0] f4_rd ;
   
   reg  f0_v_wc ;
   reg  f1_v_wc ;
   reg  f2_v_wc ;
   reg  f3_v_wc ;
   reg  f4_v_wc ;
   
   reg  [w_f2-1:0]  f2_wd ;
   reg  [w_f3-1:0] f3_wd ;
   reg  [w_f4-1:0]  f4_wd ;

   reg [msb_states:0] curr_state , next_state;

   wire 	      f0_v = f0_v_wc ;
   wire 	      f1_v = f1_v_wc ;
   wire 	      f2_v = f2_v_wc ;
   wire 	      f3_v = f3_v_wc ;
   wire 	      f4_v = f4_v_wc ;   

   parameter 	      s0=0,s1=1,s2=2;
   
   always @(posedge clk)
     if (rst)
       begin
	  //zClkReset
	  curr_state <= s0;
       end
     else
       begin
	  //zClkAssign
	  f2_rd <=  f2_wd ; 
	  f3_rd <=  f3_wd ; 
	  f4_rd <=  f4_wd ; 
	  curr_state <= next_state;
       end
      
   always @*
     begin
	//zWireAssign
	f0_v_wc =  0 ; 
	f1_v_wc =  0 ; 
	f2_v_wc =  0 ; 
	f3_v_wc =  0 ; 
	f4_v_wc =  0 ; 
	f0 = 0;
	f1 = 0;
	
	f2_wd =  f2_rd ; 
	f3_wd =  f3_rd ; 
	f4_wd =  f4_rd ; 
	//zEnd

	//Don't forget this
	next_state = curr_state;
	
	case( curr_state )

	  s0: //Got W0, so can parse out f0, and f1
	    //which are completely contained in W0
	    //f2 is partially contained and so must use temporary storage
	    begin
	       if ( din_v )
		 begin
		    f0 = din[`f0_W0_MSB:`f0_W0_LSB];
		    f0_v_wc = 1;
		    
		    f1 = din[`f1_W0_MSB:`f1_W0_LSB];
		    f1_v_wc = 1;
		    
		    f2_wd[`f2_W0_MSB-`f2_W0_LSB:0] = din[`f2_W0_MSB:`f2_W0_LSB];
		    next_state = s1;
		 end
	    end // case: s0


	  s1: //Got W0, so can parse out f0, and f1
	    //which are completely contained in W0
	    //f2 is partially contained and so must use temporary storage
	    begin
	       if ( din_v )
		 begin
		    f2_wd[`f2_W1_MSB-`f2_W1_LSB+`f2_W0_MSB-`f2_W0_LSB+1:`f2_W0_MSB-`f2_W0_LSB+1] = din[`f2_W1_MSB:`f2_W1_LSB];
		    f2_v_wc = 1;

		    f3_wd[`f3_W1_MSB-`f3_W1_LSB:0] = din[`f3_W1_MSB:`f3_W1_LSB];		    
		    
		    next_state = s2;
		 end
	    end // case: s0

	  s2: //Got W0, so can parse out f0, and f1
	    //which are completely contained in W0
	    //f2 is partially contained and so must use temporary storage
	    begin
	       if ( din_v )
		 begin
		    f3_wd[`f3_W2_MSB-`f3_W2_LSB+`f3_W1_MSB-`f3_W1_LSB+1:`f3_W1_MSB-`f3_W1_LSB+1] = din[`f3_W2_MSB:`f3_W2_LSB];
		    f3_v_wc = 1;

		    f4_wd[`f4_W2_MSB-`f4_W2_LSB:0] = din[`f4_W2_MSB:`f4_W2_LSB];		    
		    f4_v_wc = 1;
		    
		    next_state = s0;
		 end
	    end // case: s0

	endcase // case ( curr_state )

	
	//Equivalent to continuous assigns here
	f2 = f2_wd;
	f3 = f3_wd;
	f4 = f4_wd;
	
     end

endmodule // app_unpack
