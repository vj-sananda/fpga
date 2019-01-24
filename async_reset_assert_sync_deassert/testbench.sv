// Code your testbench here
// or browse Examples
module tb ;

  logic clk;
  logic i_rst_n ;
  
  initial clk = 0;
  always #5 clk = ~clk ;
  
  reset_controller dut( .clk(clk),
                       .i_rst_n(i_rst_n),
                       .o_rst_n(o_rst_n)
                      );
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      i_rst_n = 1;
      repeat(5)
        begin
      	#13 i_rst_n = 0;
      	#10 i_rst_n = 1;
        end
	  #100;
      $finish;
    end

  
endmodule