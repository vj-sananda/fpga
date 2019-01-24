In ISE:Synthesis script file in __projnav directory
hdl project .prj file in project directory

Synthesis:
xst -ifn synth.xst -ofn synth.log

specify -ofn for specific logfile
else report file is in <design_name>.srp

#Output files
netlist = .ngc extension
file for schematic viewer = .ngr extension

#Design file read in: stimulus.prj
verilog work "./src/shift_add_mult.v"
verilog work "./src/stimulus.v"

# Example synthesis script file : synth.scr
# created by ISE 7.1
set -tmpdir __projnav
set -xsthdpdir ./xst
run
-ifn stimulus.prj
-ifmt mixed
-ofn stimulus
-ofmt NGC
-p xc2vp30-7-ff896
-top stimulus
-opt_mode Speed
-opt_level 1
-iuc NO
-lso stimulus.lso
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
