module priority_encoder_4 ( in_vec, out_vec, out_enc );
 input [4-1:0] in_vec ;

 output [4-1:0] out_vec ;
 output [2-1:0] out_enc ;

 wire [4-1:0] in_vec ;
 reg  [2-1:0] out_enc ;
 reg  [4-1:0] out_vec ;

always @*
 begin
   out_vec = 4'b0 ;
  if (in_vec[3]) 
    begin
     out_enc = 3 ;
     out_vec[3] = 1 ; 
    end
  else 
  if (in_vec[2]) 
    begin
     out_enc = 2 ;
     out_vec[2] = 1 ; 
    end
  else 
  if (in_vec[1]) 
    begin
     out_enc = 1 ;
     out_vec[1] = 1 ; 
    end
  else 
  if (in_vec[0]) 
    begin
     out_enc = 0 ;
     out_vec[0] = 1 ; 
    end
 end

endmodule
