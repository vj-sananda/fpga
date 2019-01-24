run: build
	 tb.exe -tclbatch run.tcl
build: tb.exe
clean:
	 rm -rf isim/work
	 rm *.exe
isim/work/ringbuf.v.compiled: ringbuf.v 
	 vlogcomp.exe -d TEST   ringbuf.v 
	 touch isim/work/ringbuf.v.compiled 

tb.exe: isim/work/ringbuf.v.compiled  
	 fuse -top tb  -o tb.exe
