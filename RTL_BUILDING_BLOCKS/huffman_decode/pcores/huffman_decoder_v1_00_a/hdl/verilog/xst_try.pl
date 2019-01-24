#!/usr/bin/perl

# Example synthesis script file : synth.scr
# created by ISE 7.1

if ( ($#ARGV + 1) == 0) {
    print "Usage: xst_try.pl <input_file_1> <input_file_2> ...\n";
    print "       Assume Top Module is the first file\n";
    exit(0);
}

my $topmodule = $ARGV[0];
$topmodule =~ s/\.v// ;
my $i;

open( SYNTH_PRJFILE,">synth.prj") || die "Unable to open synth.prj\n";
for ( $i=0;$i <= $#ARGV ;$i++) {
    print SYNTH_PRJFILE "verilog work \"\.\/$ARGV[$i]\"\n";
}
close SYNTH_PRJFILE;

open( SYNTH_LSOFILE,">synth.lso") || die "Unable to open synth.lso\n";
print SYNTH_LSOFILE "work\n";
close SYNTH_LSOFILE ;

open( SYNTH_RUNFILE,">synth.scr") || die "Unable to open synth.scr\n";
print SYNTH_RUNFILE <<EOF;
run
-ifn synth.prj
-ifmt mixed
-ofn synth
-ofmt NGC
-p xc2vp30-7-ff896
-top $topmodule
-opt_mode Speed
-opt_level 1
-iuc NO
-lso synth.lso
-keep_hierarchy NO
-glob_opt AllClockNets
-rtlview Yes
-read_cores YES
-write_timing_constraints NO
-cross_clock_analysis NO
-hierarchy_separator /
-bus_delimiter <>
-case maintain
-slice_utilization_ratio 100
-verilog2001 YES
-fsm_extract YES -fsm_encoding Auto
-safe_implementation No
-fsm_style lut
-ram_extract Yes
-ram_style Auto
-rom_extract Yes
-rom_style Auto
-mux_extract YES
-mux_style Auto
-decoder_extract YES
-priority_extract YES
-shreg_extract YES
-shift_extract YES
-xor_collapse YES
-resource_sharing YES
-mult_style auto
-iobuf YES
-max_fanout 500
-bufg 16
-register_duplication YES
-equivalent_register_removal YES
-register_balancing No
-slice_packing YES
-optimize_primitives NO
-tristate2logic Yes
-use_clock_enable Yes
-use_sync_set Yes
-use_sync_reset Yes
-enable_auto_floorplanning No
-iob auto
-slice_utilization_ratio_maxmargin 5
EOF
close SYNTH_RUNFILE;

system("xst -ifn synth.scr");

print "===================================\n";
print "=  Report     File = synth.srp \n";
print "=  Project    File = synth.prj \n";
print "=  Script     File = synth.scr \n";
print "=  Lib Search File = synth.lso \n";
print "=  Output     File = synth.ng? \n";
print "===================================\n" ;
exit(0);
