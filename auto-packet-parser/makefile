run: build
	 tb.exe -tclbatch run.tcl
build: tb.exe
clean:
	 rm -rf isim/work
	 rm *.exe
waves:
	 gtkwave dump.vcd&
isim/work/app_pack.v.compiled: app_pack.v 
	 vlogcomp.exe -d TEST   app_pack.v 
	 touch isim/work/app_pack.v.compiled 

isim/work/app_unpack.v.compiled: app_unpack.v 
	 vlogcomp.exe -d TEST   app_unpack.v 
	 touch isim/work/app_unpack.v.compiled 

isim/work/tb.v.compiled: tb.v 
	 vlogcomp.exe -d TEST   tb.v 
	 touch isim/work/tb.v.compiled 

tb.exe: isim/work/app_pack.v.compiled  isim/work/app_unpack.v.compiled  isim/work/tb.v.compiled  
	 fuse -top tb  -o tb.exe
