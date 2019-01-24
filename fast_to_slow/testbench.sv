// Code your testbench here
// or browse Examples
module tb;
  
  logic sclk,fclk;
  logic f_in;
  wire s_out;
  logic reset;
  
  initial begin
    sclk=0;
    fclk=0;
  end
  
  fast2slow dut( reset,sclk,fclk,f_in,s_out);
  
  always 
    #5 fclk = ~fclk;
  always
    #17 sclk = ~sclk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      f_in = 0;
      reset = 1;
      #10 ;
      reset = 0;
      #100;
      repeat(7) begin
      #100;
        @(posedge fclk);
      #1 f_in = 1;
        @(posedge fclk);
      #1 f_in = 0;
      #220;
      end
      $finish;
    end
endmodule
