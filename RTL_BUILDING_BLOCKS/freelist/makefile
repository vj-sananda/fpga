run: build
	 tb.exe -tclbatch run.tcl
build: tb.exe
clean:
	 rm -rf isim/work
	 rm *.exe
isim/work/dpmem.v.compiled: dpmem.v 
	 vlogcomp.exe -d TEST   dpmem.v 
	 touch isim/work/dpmem.v.compiled 

isim/work/freelist.v.compiled: freelist.v 
	 vlogcomp.exe -d TEST   freelist.v 
	 touch isim/work/freelist.v.compiled 

tb.exe: isim/work/dpmem.v.compiled  isim/work/freelist.v.compiled  
	 fuse -top tb  -o tb.exe
