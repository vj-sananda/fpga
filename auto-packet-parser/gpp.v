
module gpp( /*AUTOARG*/
   // Outputs
   f0, f1, f2, f3, f4, f0_v, f1_v, f2_v, f3_v, f4_v,
   // Inputs
   clk, reset, din, din_v
   ) ;

   input clk,reset ;
   
   //Autogenerate
   input [31:0] din ;
   input 	din_v ;

   output [`f0_width-1:0] f0 ;
   output [`f1_width-1:0] f1 ;
   output [`f2_width-1:0] f2 ;
   output [`f3_width-1:0] f3 ;
   output [`f4_width-1:0] f4 ;
   
   output 	f0_v ;
   output 	f1_v ;
   output 	f2_v ;
   output 	f3_v ;
   output 	f4_v ;   

   always @*
     begin

	case( c_state )

	  `stage0: if ( din_v )
	    begin
	       f0_wd[`f0_width-1:0] = din_v[`f0_W0_MSB:`f0_W0_LSB] ;
	       f0_v_wc = 1;
	       
	       f1_wd[`f1_width-1:0] = din_v[`f1_W0_MSB:`f1_W0_LSB] ;
	       f1_v_wc = 1;
	       

	    end

	  `stage1: if ( din_v )
	    begin
	       f2_wd[4:0] = din_v[`msb:`lsb] ;
	       f2_v_wc = 1;
	       
	       f3_wd[4:0] = din_v[`msb:`lsb] ;	       
	    end	  
	  
	  `stage2: if ( din_v )
	    begin
	       f1_wd[4:0] = din_v[`msb:`lsb] ;
	       f1_v_wc = 1;
	       
	       f2_wd[4:0] = din_v[`msb:`lsb] ;	       
	    end

	endcase

     end
   
   

   


endmodule // gpp
