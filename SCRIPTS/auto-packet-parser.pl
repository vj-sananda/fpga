#!/usr/bin/perl

my $text;
my $num ;
my $width ;

my @f ;
my %fw ;

my $num_fields = 0;

open(FIN,"$ARGV[0]") or die "Unable to open $ARGV[0]";

#Parse pkt defn file
while ( <FIN> ) {

    #skip blank lines
    next if ( /^\s*$/ ) ;

    ($text,$num) = split /\s+/ ;

    # Get input data bus width
    if ( $text eq "width" ) {
	$width = $num ;
	next ;
    }

    if ( $text =~ /f/ ) {
	$f[$num_fields] = $text ;
	$fw{ $text } = $num ;
	$num_fields++;
    }
}

#Compute bit fields breakpoints
my $lsbptr = 0 ;
my $msbptr = $width-1;
my $bitsleft = $width ;
my %fbp ;
my $wordnum = 0;

for ($i=0;$i<$num_fields;$i++) {
    $fbp{ $f[$i] } = [];


    if ( $bitsleft >= $fw{ $f[$i] } ) {

	$msbptr = $lsbptr + $fw{ $f[$i] } - 1;

	push @{$fbp{ $f[$i] }}, $wordnum ;
	push @{$fbp{ $f[$i] }}, $lsbptr ;
	push @{$fbp{ $f[$i] }}, $msbptr ;

	$bitsleft -= $fw{ $f[$i] } ;
	$lsbptr    = $msbptr + 1 ;
    }
    else {
	$msbptr = $width - 1;

	push @{$fbp{ $f[$i] }}, $wordnum ;
	push @{$fbp{ $f[$i] }}, $lsbptr ;
	push @{$fbp{ $f[$i] }}, $msbptr ;

	$bitsleft_in_field = $fw{ $f[$i] } - ($msbptr - $lsbptr + 1);
	$bitsleft = $width ;
	$wordnum++;

	$lsbptr = 0 ;
	$msbptr = $lsbptr + $bitsleft_in_field - 1;

	push @{$fbp{ $f[$i] }}, $wordnum ;
	push @{$fbp{ $f[$i] }}, $lsbptr ;
	push @{$fbp{ $f[$i] }}, $msbptr ;

	$bitsleft -= ($msbptr - $lsbptr + 1 ) ;
	$lsbptr    = $msbptr + 1 ;
    }

    if ($bitsleft == 0 ) {
	$bitsleft = $width ;
	$lsbptr = 0;
	$wordnum++ ;
    }

    print "$i: wordnum = $wordnum, bitsleft = $bitsleft\n";

}

print "width = $width\n";

my $fileout = $ARGV[0].".vh";
open (FOUT, ">$fileout") or die ;

#list of list refs, indexed by word num
#each list ref is itself a list of list refs
my @Word_lref = () ;

for ($i=0;$i<$num_fields;$i++) {
#    print "$f[$i]:$fw{$f[$i]} :: @{$fbp{ $f[$i]} } \n";

    my @tmp = @{$fbp{ $f[$i]} };

    for ( $j=0; $j< scalar(@tmp); $j += 3 ) {

	$Word_lref[$tmp[$j]]=[] unless defined($Word_lref[$tmp[$j]] );	

	if ( $j+3 >= scalar(@tmp)  ) {
	    push @{$Word_lref[$tmp[$j]]} , [$f[$i],$tmp[$j+1],$tmp[$j+2], "end_true"];
	}
	else {
	    push @{$Word_lref[$tmp[$j]]} , [$f[$i],$tmp[$j+1],$tmp[$j+2], "end_false"];
	}

	print FOUT  "`define $f[$i]_W$tmp[$j]_LSB  $tmp[$j+1]\n";
	print FOUT  "`define $f[$i]_W$tmp[$j]_MSB  $tmp[$j+2]\n";
    }
    print FOUT  "\n";

}

#Use field hash, to generate definitions

for ($i=0;$i<scalar(@Word_lref);$i++) {
    foreach $lref (@{$Word_lref[$i]}) {
	print $i,"::",$lref->[0]," ",$lref->[1]," ",$lref->[2]," ",$lref->[3],"\n";

	print qq{
	    stage$i: begin 
               if (din_v)
	         begin

                 end 
        } ;


    }
}


    
