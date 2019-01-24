#!/usr/bin/perl -s
# zVerilog Pre-Processor
# Fills out Reg declarations
# Register assigns (reset and regular)
# Default wire assigns in State machine

#Algo
# For width of signals use pragma
# // aw 8 list of signals, can be regexp
# Multiple pass parsing
# 1. Grab all control wires
# 2. Grab all control registers
# 3. Grab all data wires
# 4. Grab all data registers
# 5. Grab all inputs
# 6. Grab all outputs
# 7. Reg declarations

# Auto generate reg declarations
# Auto generate clocked assignments, with default
# No destructive edits, if a decl is already or assignment is already
# there, leave it alone

use constant {
    TRUE => 1,
    FALSE => 0
    };

my @rc_signals;
my @wc_signals;
my @rd_signals;
my @wd_signals;
my %zWireAssign = ();
my %zClkAssign = ();
my %zClkReset = ();

my %zFlags = ();

my %prior_decl_match =();

my @all_signals = ();

my $file = $ARGV[0];
open (FH, "$file") or die "Unable to open $file\n";

my $pass = 0;
my ($zClk,$zRst) ;

#print "Read Pass::$pass........\n";
while( <FH> ) {

    chomp;

    #List of control wires
    if ( /([A-Za-z0-9_]+_wc)/ ) {
	#print "\t adding $1 to wc_signal_list\n";
	push @wc_signals , $1;
    }

    #List of control registers
    if ( /([A-Za-z0-9_]+_rc)/ ) {
	#print "\t adding $1 to rc_signal_list\n";
	push @rc_signals , $1;
    }

    #List of data wires
    if ( /([A-Za-z0-9_]+_wd)/ ) {
	#print "\t adding $1 to wd_signal_list\n";
	push @wd_signals , $1;
    }

    #List of data registers
    if ( /([A-Za-z0-9_]+_rd)/ ) {
	#print "\t adding $1 to rd_signal_list\n";
	push @rd_signals , $1;
    }

    #List of pre-existing register declarations
    if ( /reg\s+(\S+)\s*;/ or /reg\s+\[\S+\]\s+(\S+)\s*;/ ) {
	my @reg_set = split /,/ , $1 ;
	foreach my $r (@reg_set) {
	    #print "\t pre-existing register defn: $r\n";
	    $prior_decl_match{$r} = 1;
	}
    }

    #List of pre-existing wire declarations
    if ( /wire\s+(\S+)\s*;/ or /wire\s+\[\S+\]\s+(\S+)\s*;/ ) {
	my @wire_set = split /,/ , $1 ;
	foreach my $r (@wire_set) {
	    #print "\t pre-existing wire defn: $r\n";
	    $prior_decl_match{$r} = 1;
	}
    }

    #get zWidth declarations
    if ( /zWidth\s+(\S+)\s+(.+)\s*;/ ) {
	my $width = $1;
	my $tmp = $2;
	chomp($tmp);
	my @w_set = split /\s*,\s*/ , $2;
	#print "zWidth :: @w_set\n";

	foreach my $w (@w_set) {
	    #print "zWidth:: $w \n" ;
	    $zWidth{$w} = $width;
	}
    }

    if ( /zClkR/ ) {
	$zFlags{ClkReset} = TRUE ;
	next;
    }

    if ( /zClkA/ ) {
	$zFlags{ClkAssign} = TRUE ;
	next ;
    }

    if ( /zWireA/ ) {
	$zFlags{WireAssign} = TRUE ;
	next;
    }

    $zFlags{ClkReset} = FALSE if ( $zFlags{ClkReset} and /end/ ) ;    
    $zFlags{ClkAssign} = FALSE if ( $zFlags{ClkAssign} and /end/ ) ;    
    $zFlags{WireAssign} = FALSE if ( $zFlags{WireAssign} and /zEnd/ ) ;    

    if ( $zFlags{ClkReset} ) {
	if ( /(\S+)\s*<=\s*(\S+)\s*;/ ) {
	    $zClkReset{$1} = $2;
	}
    }

    if ( $zFlags{ClkAssign} ) {
	if ( /(\S+)\s*<=\s*(\S+)\s*;/ ) {
	    $zClkAssign{$1} = $2;
	}
    }

    if ( $zFlags{WireAssign} ) {
	if ( /(\S+)\s*=\s*(\S+)\s*;/ ) {
	    $zWireAssign{$1} = $2;
	}
    }

}

#Rewind file pointer for 2nd pass
$pass++;
seek(FH,0,0);

push @all_signals , @rc_signals ;
push @all_signals , @wc_signals ;
push @all_signals , @rd_signals ;
push @all_signals , @wd_signals ;

#print "Write Pass::$pass ........\n";
while( <FH> ) {

    print $_; 

    #Print out all missing zReg declarations once you see this
    if ( /(\s*)\/\/zReg/ ) {
	my $indent = $1;
	#foreach register found
	foreach my $r ( @all_signals ) {

	    #Prior declaration ?
	    if ( exists $prior_decl_match{$r} ) {
		#do nothing
		next;
	    }
	    else {
		#Cycle thru all entries in %zWidth since regexp match
		#can also set the width
		my $width = "" ;
		foreach my $rw ( keys %zWidth ) {
		    
		    #Strip out any whitespace at beginning or end of words
		    #else match will mysteriously fail
		    my $m_rw, $m_r;
		    $rw =~ /\s*(\S+)\s*/;
		    $m_rw = $1 ;

		    $r =~ /\s*(\S+)\s*/;
		    $m_r = $1 ;

		    if ( $m_r =~ m/($m_rw)/ ) {
			$width = $zWidth{$rw};
#			print "$r matches zWidth entry = $zWidth{$rw}\n";
		    }
		}

		#Can print out, need width if specified
#		if ( exists $zWidth{$r} ) {
		if ( $width ne "" ) {
		    printf "%sreg %s %s ;\n", $indent,$width,$r;
		}
		else {
		    printf "%sreg  %s ;\n", $indent,$r;
		}
		$prior_decl_match{$r} = 1;
	    }
	}
    }

    if ( /(\s*)\/\/zClkR/ ) {
	my $indent = $1;
	#Loop thru all control signals
	foreach my $r (@rc_signals) {
	    if ( exists $zClkReset{$r} ) {
		next;
	    }
	    else {
		printf "%s%s <= 0 ; \n", $indent,$r;
		$zClkReset{$r} = TRUE ;
	    }
	}
    }


    if ( /(\s*)\/\/zClkA/ ) {
	my $indent = $1;
	#Loop thru all control signals
	foreach my $r (@rc_signals) {
	    if ( exists $zClkAssign{$r} ) {
		next;
	    }
	    else {
		my $w = $r;
		$w =~ s/_rc/_wc/ ;
		printf "%s%s <=  %s ; \n", $indent,$r,$w;
		$zClkAssign{$r} = $w ;
	    }
	}

	foreach my $w (@wd_signals) {
	    if ( exists $zClkAssign{$w} ) {
		next;
	    }
	    else {
		my $r = $w;
		$r=~ s/_wd/_rd/ ;
		printf "%s%s <=  %s ; \n", $indent,$r,$w;
		$zClkAssign{$w} = $r ;
	    }
	}

    }

    if ( /(\s*)\/\/zWireA/ ) {
	my $indent = $1;
	#Loop thru all control signals
	foreach my $w (@wc_signals) {
	    if ( exists $zWireAssign{$w} ) {
		next;
	    }
	    else {
		printf "%s%s =  0 ; \n", $indent,$w;
		$zWireAssign{$w} = 0 ;
	    }
	}

	foreach my $w (@wd_signals) {
	    if ( exists $zWireAssign{$w} ) {
		next;
	    }
	    else {
		my $r = $w;
		$r=~ s/_wd/_rd/ ;
		printf "%s%s =  %s ; \n", $indent,$w,$r;
		$zWireAssign{$w} = $r ;
	    }
	}
    }

}
