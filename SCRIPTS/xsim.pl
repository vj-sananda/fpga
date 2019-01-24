#!/usr/bin/perl -s

#Example simulation script, using ise simulator
# Inputs: Give file listing source
# Will search in current directory or in XILINX home XilinxCoreLibs and unisims

############ CONFIG SETTINGS #############

#Name of makefile
my $makefile = "makefile";

#Compile command
my $compile_cmd;
if ($inc) {
    $compile_cmd = "vlogcomp.exe -d TEST -i $inc";
}
else {
    $compile_cmd = "vlogcomp.exe -d TEST ";
}

#Waves command
my $waves_cmd = "gtkwave" ;

#fuse/link command
my $fuse_cmd = "fuse";

#isim work directory
my $isim_work = "isim/work";

##########################################

#Help usage
if ( ($#ARGV + 1) == 0) {
    print "Usage: xsim.pl <file_list> <top_module1> <top_module2\n";
    print "       add glbl as the 2nd top module if you get an error\n";
    print "       saying GSR not in instantiated path\n";
    print "       your .f file must include glbl.v\n";
    exit(0);
}

#Input args
my $listfile = $ARGV[0] ;

my $i;
for ($i=1;$i<=$#ARGV;$i++) {
    push @top_mods , $ARGV[$i];
}

my $top = $top_mods[0];

#Need XILINX home variable to get path to XilinxCoreLib and unisims directories
my $xilinx_home = $ENV{"XILINX"};
die "FATAL::XILINX env variable not defined\n" if ($xilinx_home eq "" ) ;

#Replace backslash with forward slash
$xilinx_home =~ s/\\/\// ;

#Run dos2unix, else chomp doesn't seem to work on windows machines
if ( -e $listfile ) {
    system("dos2unix $listfile");
    open( SRC_FILE,$listfile);
}
else {
    print "FATAL::$listfile doesn't exit in current directory\n";
    exit;
}

#Check for xilinxsim.ini, if not there, create one
unless ( -e "xilinxsim.ini") {
    open (XILSIM,">xilinxsim.ini");
    print XILSIM "work=$isim_work\n";
    close (XILSIM);
}

my @files = ();
my %filepath = ();
my %fcompiled = ();

#Loop thru all source files
while (<SRC_FILE>) {
    chomp;

    next if (/^\s*$/ );

    my $file = $_;
    my $found_file = 0;
    my $file_w_path ;

    if ( -e $file ) {
	$found_file=1;
	$file_w_path = $file;
    }
    else { #Search in Xilinx Libs
	if ( -e "$xilinx_home/verilog/src/XilinxCoreLib/$file" ) {
	    $file_w_path = "$xilinx_home/verilog/src/XilinxCoreLib/$file" ;
	    print "Found $file_w_path\n";
	    $found_file=1;
	}

	if ( -e "$xilinx_home/verilog/src/unisims/$file" ) {
	    $file_w_path = "$xilinx_home/verilog/src/unisims/$file" ;
	    print "Found $file_w_path\n";
	    $found_file=1;
	}

	if ( -e "$xilinx_home/verilog/src/$file" ) {
	    $file_w_path = "$xilinx_home/verilog/src/$file" ;
	    print "Found $file_w_path\n";
	    $found_file=1;
	}
    }
    
    if ($found_file == 1) {
	push @files, $file;
	$filepath{$file} = $file_w_path ;
	if ( $file =~ /\S*\/(\S+)$/ ) {
	    $fcompiled{$file} = $1.".compiled";
	}
	else {
	    $fcompiled{$file} = $file.".compiled";
	}
    }
    else {
	print "FATAL::$file not found in current directory or libraries\n";
	print "libraries=$xilinx_home/verilog/src/XilinxCoreLib & unisims\n";
	exit;
    }
}

#Create run.tcl file if needed
unless ( -e "run.tcl") {
    open (TCLRUN,">run.tcl");
    print TCLRUN "run all\nquit\n";
    close(TCLRUN);
}

#Write out makefile
open (MAKEFILE,">$makefile") or die "Unable to open $makefile\n";

#Run , build and clean targets
print MAKEFILE "run: build\n\t $top.exe -tclbatch run.tcl\n";
print MAKEFILE "build: $top.exe\n";
print MAKEFILE "clean:\n\t rm -rf $isim_work\n\t rm *.exe\n";

#waves
print MAKEFILE "waves:\n\t $waves_cmd dump.vcd&\n";

#Compile command
foreach $f (@files) {
    print MAKEFILE "$isim_work/$fcompiled{$f}: $filepath{$f} \n";
    print MAKEFILE "\t $compile_cmd  $filepath{$f} \n";
    print MAKEFILE "\t touch $isim_work/$fcompiled{$f} \n\n";
}

#Link command dependencies
print MAKEFILE "$top.exe: ";
foreach $f (@files) {
    print MAKEFILE "$isim_work/$fcompiled{$f}  ";
}

#Link command
print MAKEFILE "\n\t $fuse_cmd";

foreach my $t (@top_mods) {
    print MAKEFILE " -top $t ";
}
print MAKEFILE " -o $top.exe\n";

close(MAKEFILE);

print("=========== Building ==================================\n");
system("make -f $makefile build");    

print("==================Run $top.exe ========================\n");
system("make -f $makefile run");

exit ;

