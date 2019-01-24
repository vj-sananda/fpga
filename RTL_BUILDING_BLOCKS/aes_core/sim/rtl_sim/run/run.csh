#!/bin/csh -f

gcc -o aes_test.exe aes_core.c aes_test.c

./aes_test.exe | grep in | awk '{print $2}' > in.dat

./aes_test.exe | grep out | awk '{print $2}' > out.dat

make -f ../bin/Makefile ivl 

./a.out

