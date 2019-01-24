// Code your design here
module reset_controller(
  input clk,
  input i_rst_n,
  output logic o_rst_n );
  
//Reset is active low
  always @(posedge clk or negedge i_rst_n)
    if ( ~i_rst_n )
          o_rst_n <= 0;
      else
          o_rst_n <= 1;

  
endmodule
