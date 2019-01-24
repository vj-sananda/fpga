`timescale 1ns/1ps

module category_finger (/*AUTOARG*/
   // Outputs
   count, 
   // Inputs
   clk, rst_n, eop, char_in, enable, char_in_vld, stream_id, 
   reset_state, load_state
   );

   // The clock and reset info.
    input clk, rst_n;

   input  eop ;
   
    // Input character, and state, if being set.
   input [7:0] char_in;

   input       enable ;
   
    // char_in_vld should be true if there's a character to process.
    // state_in_vld should be true if the outside world is overwriting our state.
    input char_in_vld ;
   
   input [5:0] stream_id ;
   
   input   reset_state ;
   input   load_state ;

   output [15:0] count ;
   
   //Memory
   reg [7:0] state_mem [0:63] ;

   reg 	     state_in_vld;
   reg [7:0] state_in ;

   reg [15:0] count ;
   reg [15:0] speculative_count ;   
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			accept_out;		// From regex of regex_category_finger.v
   wire [7:0]		state_out;		// From regex of regex_category_finger.v
   // End of automatics

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   // End of automatics

   always @(posedge clk)
     if (~rst_n)
       begin
	  count <= 0;
	  speculative_count <= 0;
       end	  
     else
       begin

	  if ( accept_out ) 
	    speculative_count <= speculative_count + 1;
	  
	  if ( eop )
	    begin

	       if ( enable )
		 begin
		    //This regex is enabled for this stream id
		    count <= count + speculative_count ;
		    state_mem[stream_id] <= state_out ;
		 end
	       else
		 //regex not enabled for this count
		 speculative_count <= 0;
	       
	    end // if ( eop )
	  
       end
   
   always @(posedge clk)
       begin
	  state_in_vld <= 0;

	  //If StreamID recognized
	  if ( load_state )
	    begin
	       state_in <= state_mem[stream_id];
	       state_in_vld <= 1;
	    end

	  //If new StreamID
	  if ( reset_state )
	    begin
	       state_in <= 0;
	       state_in_vld <= 1;
	    end	
       end

    regex_category_finger regex (/*AUTOINST*/
				 // Outputs
				 .state_out(state_out[7:0]),
				 .accept_out(accept_out),
				 // Inputs
				 .clk	(clk),
				 .rst_n	(rst_n),
				 .char_in(char_in[7:0]),
				 .state_in(state_in[7:0]),
				 .char_in_vld(char_in_vld),
				 .state_in_vld(state_in_vld));
   

endmodule // canscid_category_finger
