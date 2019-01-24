//High performance GCD version (better than Bluespec)
//Uses 2 subtractors, to get rid of swap cycle

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module GCD_Perf(CLK,
	     RST_N,
	     
	     start_num1,
	     start_num2,
	     EN_start,
	     RDY_start,
	     
	     result,
	     RDY_result);
  input  CLK;
  input  RST_N;
  
  // action method start
  input  [31 : 0] start_num1;
  input  [31 : 0] start_num2;
  input  EN_start;
  output RDY_start;
  
  // value method result
  output [31 : 0] result;
  output RDY_result;

  // signals for module outputs
  wire [31 : 0] result;
  wire RDY_result, RDY_start;

  // register x
  reg [31 : 0] x_wd,x_rd,y_wd,y_rd;

   reg [31 : 0] result_rd,result_wd;
   
   reg 	       RDY_start_wd, RDY_start_rd, RDY_result_rd,RDY_result_wd;
   
   parameter   s0=0,s1=1;
   
   assign 	 RDY_result = RDY_result_rd;
   assign 	 RDY_start = RDY_start_rd;
   assign 	 result = result_rd;
   
  reg 	       next_state,curr_state;


   always @(posedge CLK)
     if (~RST_N)
       begin
	  RDY_start_rd <= 1;
	  curr_state <= s0;
       end
     else
       begin
	  curr_state <= next_state;
	  x_rd <= x_wd;
	  y_rd <= y_wd;
	  RDY_start_rd <= RDY_start_wd;
	  RDY_result_rd <= RDY_result_wd;	  	  
       end
   
   always @*
     begin
	//Default assigns
	
	RDY_start_wd = RDY_start_rd;
	RDY_result_wd = 0;
	
	x_wd = x_rd;
	y_wd = y_rd;	

	result_wd =  0;
	
	next_state = curr_state;
	
	case (curr_state)
	  s0:
	    begin
	       if ( EN_start)//wait for input
		 begin
		    RDY_start_wd = 0;
		    RDY_result_wd = 0;
		    x_wd = start_num1;
		    y_wd = start_num2;
		    next_state = s1;
		 end
	    end // case: s0

	  s1://compute 
	    begin
	       if ( x_rd <= y_rd )
		 y_wd = y_rd - x_rd ;//2nd subtractor for performance
	       else
		 x_wd = x_rd - y_rd ;		    

	       if ( x_wd==0 || y_wd==0  )
		 begin
		    result_wd = (x_wd==0) ? y_wd : x_wd ;
		    RDY_result_wd = 1;
		    RDY_start_wd = 1;
		    next_state = s0;		    
		 end
	    end
	
	endcase // case (curr_state)
	
     end // always @ *
   
   
endmodule  // GCD

module tb;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg			CLK;			// To dut of GCD.v
   reg			EN_start;		// To dut of GCD.v
   reg			RST_N;			// To dut of GCD.v
   reg [31:0]		start_num1;		// To dut of GCD.v
   reg [31:0]		start_num2;		// To dut of GCD.v
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			RDY_result;		// From dut of GCD.v
   wire			RDY_start;		// From dut of GCD.v
   wire [31:0]		result;			// From dut of GCD.v
   // End of automatics

   initial
     begin
	$dumpvars;
	CLK =0;
	RST_N=0;
	start_num1=15;
	start_num2=6;
	EN_start = 0;
	#100;
	RST_N=1;
	#10000;
	$finish;
     end // initial begin

   always #5 CLK = ~CLK;


   always @(posedge CLK)
     if ( RST_N )
       begin
	  start_num1 <= start_num1 + 1;
	  start_num2 <= start_num2 + 2;
	  EN_start <= 1;
	  @(posedge CLK);
	  EN_start <= 0;
	  @(posedge CLK);	  
	  wait( RDY_start );
       end
   
   
   GCD_Perf  dut(/*AUTOINST*/
	     // Outputs
	     .RDY_start			(RDY_start),
	     .result			(result[31:0]),
	     .RDY_result		(RDY_result),
	     // Inputs
	     .CLK			(CLK),
	     .RST_N			(RST_N),
	     .start_num1		(start_num1[31:0]),
	     .start_num2		(start_num2[31:0]),
	     .EN_start			(EN_start));
   
endmodule // tb
