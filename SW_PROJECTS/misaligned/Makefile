CC= /cygdrive/c/djgpp/bin/gcc 
#CC= gcc 

run: build
	./mstruct1.exe $(N)
	./mstruct2.exe $(N)
	./mstruct3.exe $(N)
	./mstruct4.exe $(N)
	./mstruct5.exe $(N)

build: mstruct1.exe mstruct2.exe mstruct3.exe mstruct4.exe mstruct5.exe

mstruct1.exe:
	./mstruct.pl mstruct 1
	$(CC) mstruct.c -o mstruct1.exe
	mv mstruct.c mstruct1.c
	mv mstruct.h mstruct1.h

mstruct2.exe:
	./mstruct.pl mstruct 2
	$(CC) mstruct.c -o mstruct2.exe
	mv mstruct.c mstruct2.c
	mv mstruct.h mstruct2.h

mstruct3.exe:
	./mstruct.pl mstruct 3
	$(CC) mstruct.c -o mstruct3.exe
	mv mstruct.c mstruct3.c
	mv mstruct.h mstruct3.h

mstruct4.exe:
	./mstruct.pl mstruct 4
	$(CC) mstruct.c -o mstruct4.exe
	mv mstruct.c mstruct4.c
	mv mstruct.h mstruct4.h

mstruct5.exe:
	./mstruct.pl mstruct 5
	$(CC) mstruct.c -o mstruct5.exe
	mv mstruct.c mstruct5.c
	mv mstruct.h mstruct5.h

clean:
	rm -f *.stackdump *.exe *.c *.h

