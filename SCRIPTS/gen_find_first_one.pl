#!/usr/bin/perl

my $width = $ARGV[0];

die "usage: gen_find_first_one.pl <width>\n" if ( $ARGV[0] eq '' ) ;
my $outwidth = log($width)/log(2);

print <<MSG;
module priority_encoder_$width ( in_vec, out_vec, out_enc );
 input [$width-1:0] in_vec ;

 output [$width-1:0] out_vec ;
 output [$outwidth-1:0] out_enc ;

 wire [$width-1:0] in_vec ;
 reg  [$outwidth-1:0] out_enc ;
 reg  [$width-1:0] out_vec ;

always @*
 begin
   out_vec = $width\'b0 ;
MSG

for ($i=$width-1;$i>0;$i--) {

print <<MSG;
  if (in_vec[$i]) 
    begin
     out_enc = $i ;
     out_vec[$i] = 1 ; 
    end
  else 
MSG

}

print <<MSG;
  if (in_vec[0]) 
    begin
     out_enc = 0 ;
     out_vec[0] = 1 ; 
    end
 end

endmodule
MSG

exit(0);
