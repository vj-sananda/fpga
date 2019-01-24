module fast2slowpulse ( /*AUTOARG*/
   // Outputs
   slowpulse,
   // Inputs
   fastclk, slowclk, fastpulse, rst
   );
   input fastclk;
   input slowclk ;
   output slowpulse ;
   input  fastpulse ;
   input  rst ;

   reg [1:0] curr_state, next_state;
   reg 	     slowclk_r1,slowclk_r2;
   reg 	     slowpulse_wc,slowpulse_rc;

   
   //synchronize slowclk edges to slow
   always @(posedge fastclk)
     begin
	slowclk_r1 <= slowclk ;
	slowclk_r2 <= slowclk_r1 ;
     end
   
   parameter idle=0,
	       s1=1,
	       s2=2,
	       s3=3;


   assign    slowpulse = slowpulse_rc;
   
   always @(posedge fastclk)
     if (rst)
       begin
	  curr_state <= idle;
	  slowpulse_rc <= 0;
       end
     else
       begin
	  slowpulse_rc <= slowpulse_wc;
	  curr_state <= next_state ;
       end
   
   always @(/*AUTOSENSE*/curr_state or fastpulse or slowclk_r2
	    or slowpulse_rc)
     begin
	slowpulse_wc = slowpulse_rc;
	next_state = curr_state ;
	
	case(curr_state)
	  idle:
	    begin
	       if (fastpulse )
		 begin
		    next_state = s1 ;
		 end
	    end
	    s1:
	      begin
		 if (slowclk_r2)
		   begin
		      slowpulse_wc = 1;		   
		      next_state = s2;
		   end
	      end
	    s2:
	      begin
		 if (slowclk_r2 == 0)
		   next_state = s3;
	      end
	  
	      s3:
		begin
		   if (slowclk_r2)
		     begin
			slowpulse_wc = 0;
			next_state = idle;
		     end
		end
	endcase // case (curr_state)
	
     end
   
endmodule // fast2slowpulse

`ifdef TEST
module test;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			fastclk;		// To dut of fast2slowpulse.v
   reg			fastpulse;		// To dut of fast2slowpulse.v
   reg			rst;			// To dut of fast2slowpulse.v
   reg			slowclk;		// To dut of fast2slowpulse.v
   // End of automatics

   initial
     begin
	$dumpvars;
	
	fastclk <= 0;
	slowclk <= 0;
	rst <= 0;
	fastpulse <= 0;

	@(posedge fastclk);
	rst <= 1;
	@(posedge fastclk);	
	rst <= 0;

	repeat(10)
	  begin
	     @(posedge fastclk);	
	     fastpulse <= 1;
	     @(posedge fastclk);	
	     fastpulse <= 0;	
	     
	     wait (slowpulse);
	     wait (~slowpulse);	
	  end

	$finish;
	
     end

   always #5 fastclk = ~fastclk ;

   always #101 slowclk = ~slowclk ;

   
   
   fast2slowpulse dut(/*AUTOINST*/
		      // Outputs
		      .slowpulse	(slowpulse),
		      // Inputs
		      .fastclk		(fastclk),
		      .slowclk		(slowclk),
		      .fastpulse	(fastpulse),
		      .rst		(rst));
   

   
endmodule // test
`endif //  `ifdef TEST
