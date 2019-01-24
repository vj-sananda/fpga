//------------------------------------
// Capture pulse in fast clock domain from slow clock domain
// Fairly simple
// 1. Synchronize slow signal in fast domain
// 2. Use posedge or negedge detector
//-------------------------------------
module slow2fast(input reset, 
  				 input sclk,
                 input fclk,
                 input s_in,
                 output logic f_out );
  
  logic f1_r, f2_r, f3_r ;
  logic state, next_state;
  
  //Dual rank synchronizer
  always @(posedge fclk)
    begin
  	  f1_r <= s_in;
      f2_r <= f1_r ;
      f3_r <= f2_r;
    end
  
  //Much more simpler posedge detector
  //logical AND of original signal and ~delayed signal
  //negedge detector : AND or ~original signal and delayed signal
  always_comb
    f_out = f3_r & ~f2_r ;

endmodule

  