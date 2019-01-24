#!/bin/csh -f

SOURCE = \
	com1a.v \
	com1u.v \
	dut_fifo_intf.v \
	etl1.v \
	ex_div.v \
	ftl2.v \
	gate.v \
	jg_div_fpga.v \
	jg_div_top.v \
	mux2e.v \
	mux4d.v \
	tb.v \
	user_logic.v

#VCS_OPTIONS = -y ./.  +libext+.v

ifdef waves
waves_define = WAVES
simv_target = simv_waves
logfile = sim_waves.log
else
waves_define = NOWAVES
simv_target = simv
logfile = sim.log
endif

run: $(simv_target)
	$(simv_target) 

build: $(simv_target)
$(simv_target): $(SOURCE)
	vcs -sverilog +v2k  $(SOURCE)  $(VCS_OPTIONS) -P ${NOVAS_HOME}/share/PLI/vcsd/LINUX/vcsd.tab ${NOVAS_HOME}/share/PLI/vcsd/LINUX/pli.a +vcsd +define+$(waves_define)  -o $(simv_target) -l $(logfile)

clean:
	 rm -rf simv*
	 rm -rf csrc
	rm -rf verilog.*
