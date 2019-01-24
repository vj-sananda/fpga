run: build
	 stimulus_test.exe -tclbatch run.tcl
build: stimulus_test.exe
clean:
	 rm -rf isim/work
	 rm *.exe
isim/work/flist.v.compiled: flist.v 
	 vlogcomp.exe -d TEST   flist.v 
	 touch isim/work/flist.v.compiled 

isim/work/hfifo.v.compiled: hfifo.v 
	 vlogcomp.exe -d TEST   hfifo.v 
	 touch isim/work/hfifo.v.compiled 

isim/work/mem.v.compiled: mem.v 
	 vlogcomp.exe -d TEST   mem.v 
	 touch isim/work/mem.v.compiled 

isim/work/stimulus.v.compiled: stimulus.v 
	 vlogcomp.exe -d TEST   stimulus.v 
	 touch isim/work/stimulus.v.compiled 

isim/work/stimulus_test.v.compiled: stimulus_test.v 
	 vlogcomp.exe -d TEST   stimulus_test.v 
	 touch isim/work/stimulus_test.v.compiled 

stimulus_test.exe: isim/work/flist.v.compiled  isim/work/hfifo.v.compiled  isim/work/mem.v.compiled  isim/work/stimulus.v.compiled  isim/work/stimulus_test.v.compiled  
	 fuse -top stimulus_test  -o stimulus_test.exe
