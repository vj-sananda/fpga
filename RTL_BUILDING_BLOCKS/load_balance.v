module load_balance(/*AUTOARG*/
   // Outputs
   pop, wr_vec,
   // Inputs
   clk, rst, empty, rdy_vec
   );

   parameter num_clients=4;
     
   input clk,rst;
   input empty ;
   output pop ;
   
   input [num_clients-1:0]  rdy_vec ;
   output [num_clients-1:0] wr_vec  ;

   reg 			    pop ;
   reg [num_clients-1:0]    wr_vec  ;
   wire [num_clients-1:0] out_vec  ;
   wire [num_clients-1:0] rdy_vec  ;            
   
   //TODO: Change instantiation based on num_clients
   priority_encoder_4 find_first_one( 
				     // Outputs
				     .out_vec		(out_vec),
				     .out_enc		(),
				     // Inputs
				     .in_vec		(rdy_vec) ) ;

   always @*
     if (pop)
       wr_vec = out_vec ;
   
   always @(posedge clk)
     if ( rst )
       pop <= 0;
     else
       if ( |rdy_vec & ~empty )
	 pop <= 1;
   
endmodule // load_balance

   