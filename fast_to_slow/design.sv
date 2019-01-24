//----------------------------------------------------------------------
// Capture pulse in slow clock domain from fast clock domain
// Bit more involved, need feedback from slow domain.
// 1. In fast domain, create signal that extends pulse, goes high
//    in fast clock domain
// 2. Synchronize this to slow clock domain
// 3. Once captured in slow clock domain, synchronize this output back to fast clock domain
// 4. In fast clock domain, use synchronized output from slow domain to reset pulse
//     extender
// 5. In slow domain use posedge or negedge detector to create a pulse with a 
//    a single clock width.
//----------------------------------------------------------------------

module fast2slow(input reset, 
  				 input sclk,
                 input fclk,
                 input f_in,
                 output logic s_out );
  
  logic f1_r, f2_r, f3_r ,f_extend ;
  logic s1_r, s2_r;
  logic s_out_lvl, s_out_lvl_dly;
    
  
  //Synchronize s_out to fclk
  always @(posedge fclk)
    begin
      f1_r <= s_out_lvl;
      f2_r <= f1_r;
    end
  
  always @(posedge fclk)
    begin
      if (reset)
        f_extend <= 0;
      else
        if (f_in)
          f_extend <= 1;
        else
          if (f2_r)
            f_extend <= 0;
    end
  
  //Synchronize f_extend to sclk
  always @(posedge sclk)
    begin
      s1_r <= f_extend ;
      s2_r <= s1_r;
    end
  
  always @(posedge sclk)
    if (reset)
      s_out_lvl <= 0;
  else
    if (s2_r)
      s_out_lvl <= 1;
    else
      s_out_lvl <= 0;
 
  always @(posedge sclk)
    s_out_lvl_dly <= s_out_lvl ;
  
  //Generate pulse off posedge 
  always_comb
    s_out = s_out_lvl & ~s_out_lvl_dly ;

endmodule

  