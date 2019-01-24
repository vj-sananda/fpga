#Source is all the C-Files
SRCS = $(shell ls *.c)

#Executable files have the .c replaced with .exe
EXES = ${SRCS:.c=.exe}

TESTOUT = ${SRCS:.c=.out}

%.out: %.exe
	./$< 123456789 2 >> $@
	./$< 123456789 3 >> $@
	./$< 123456789 4 >> $@
	./$< 123456789 5 >> $@
	./$< 123456789 6 >> $@
	./$< 123456789 7 >> $@
	./$< 123456789 8 >> $@
	./$< 123456789 9 >> $@

#Rule to generate exe file from .c file
%.exe: %.c
	gcc -g $< -o $@

#Build target
build: $(EXES)

#Test target
test: $(TESTOUT)

#Clean target
clean:
	rm -rf *.exe
	rm -rf *.out
	rm -rf *~
	rm -rf *.stackdump



