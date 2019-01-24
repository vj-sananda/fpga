#!/bin/csh -f
set verbose
vcs gdp.v +v2k -sverilog +define+TEST
set seed = `date +%N`
./simv +seed=$seed
unset verbose
