module srl16_infer(/*AUTOARG*/
   // Outputs
   q15, q,
   // Inputs
   clk, din, addr
   );
   input clk;
   input din;
   input [3:0] addr;
   output      q15;
   output      q ;

   reg [15:0]  sreg ;
   
   always @(posedge clk )
     sreg <= { sreg[14:0], din};

   wire q15 = sreg[15];
   wire q  = sreg[addr];

endmodule // srl16
