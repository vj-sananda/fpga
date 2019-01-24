
CC=/cygdrive/c/djgpp/bin/gcc -O3 
#CC=/usr/bin/gcc

run: comp-1.exe comp-2.exe expand-1.exe expand-2.exe
	./comp-1.exe -f comp1.inp -c comp1.cmp
	./expand-1.exe -f exp1.inp -c comp1.cmp
	./comp-2.exe -f comp2.inp -c comp2.cmp
	./expand-2.exe -f exp2.inp -c comp2.cmp
	diff exp1.inp comp1.inp
	diff exp2.inp comp2.inp

comp-1.exe:comp-1.c model-1.c bitio.c coder.c
	$(CC) -c comp-1.c 
	$(CC) -c model-1.c 
	$(CC) -c bitio.c
	$(CC) -c coder.c 
	$(CC) -o comp-1.exe comp-1.o model-1.o bitio.o coder.o

comp-2.exe: comp-2.c model-2.c bitio.c coder.c
	$(CC) -o comp-2.exe comp-2.c model-2.c bitio.c coder.c

expand-1.exe:expand-1.c model-1.c bitio.c coder.c
	$(CC) -o expand-1.exe expand-1.c model-1.c bitio.c coder.c

expand-2.exe:expand-2.c model-2.c bitio.c coder.c
	$(CC) -o expand-2.exe expand-2.c model-2.c bitio.c coder.c


clean:
	rm -rf *.exe *.stackdump
