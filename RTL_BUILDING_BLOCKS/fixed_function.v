module fixed_function(/*AUTOARG*/
   // Outputs
   rdy, valid, dataout,
   // Inputs
   clk, rst, push, pop, datain
   );

   parameter width=8;
   
   input clk,rst;
   input push;
   input pop ;

   output rdy,valid;
   input [width-1:0] datain;
   output [width-1:0] dataout;   

   //--------------------------------

   reg [width-1:0]    cnt_wc,cnt_rc ;
   reg [width-1:0]    dataout_wd, dataout_rd ;   
   reg [1:0] 	      curr_state, nxt_state ;

   always @(posedge clk)
     if (rst)
       begin
	  valid_rc <= 0;
	  rdy_rc <=0;
       end
     else
       begin
	  valid_rc <= valid_wc;
	  rdy_rc <= rdy_wc;
       end
   
   always @*
     begin
	valid_wc = valid_rc;
	rdy_wc = rdy_rc;
	
	case(curr_state)

	  s0: begin
	     if ( push )
	       begin
		  rdy_wc = 0;
		  cnt_wc = datain ;
		  dataout_wd = datain ;
		  nxt_state = s1;
	       end
	  end

	  s1: begin
	     cnt_wc = cnt_rc - 1 ;
	     if ( ~(|cnt_rc) )
	       begin
		  valid_wc = 1;
		  nxt_state = s2;
	       end
	  end

	  s2:begin
	     if ( pop )
	       begin
		  rdy_wc = 1;
		  nxt_state = s0;
	       end
	  end

	endcase // case (curr_state)
	
     end // always @ *
   

endmodule // fixed_function
