// Code your testbench here
// or browse Examples
module tb;
  
  logic sclk,fclk;
  logic s_in;
  wire f_out;
  logic reset;
  
  initial begin
    sclk=0;
    fclk=0;
  end
  
  slow2fast dut( reset,sclk,fclk,s_in,f_out);
  
  always 
    #5 fclk = ~fclk;
  always
    #39 sclk = ~sclk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      s_in = 0;
      reset = 1;
      #10 ;
      reset = 0;
      #10;
      repeat(7) begin
      #20;
      @(posedge sclk);
      #1 s_in = 1;
      @(posedge sclk);
      #1 s_in = 0;
      #22;
      end
      $finish;
    end
endmodule
