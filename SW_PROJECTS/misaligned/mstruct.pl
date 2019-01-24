#!/usr/bin/perl

my $fileheader=$ARGV[0];

my $file_c = $fileheader.".c";
my $file_h = $fileheader.".h";

my $start=1;
my $end = 32;
my $step = $ARGV[1];

open( FC,">$file_c") or die "Unable to open $file_c\n" ;
open( FH,">$file_h") or die "Unable to open $file_h\n" ;


print FH  <<EOF;
#ifndef __MSTRUCT_H__
#define __MSTRUCT_H__

#include <stdlib.h> 

typedef struct  __attribute__((__packed__)) {
//typedef struct  __attribute__((__aligned__)) {
//typedef struct  {
EOF

    for ($i=$start;$i<$end;$i=$i+$step) {
	printf FH "\t unsigned int f%d:%d;\n",$i,$i ;
    }

print FH <<EOF;

} mstruct ;

void randomize (mstruct * m) ;

void copy_value ( mstruct * src, mstruct * dst ) ;

void inc_value ( mstruct * dst ) ;

#endif

EOF
 

print FC <<EOF;
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "mstruct.h"

//Usage: mstruct <N>
//return 0 if no error

int main (int argc, char ** argv) {

  mstruct * m1_ptr ;
  mstruct * m2_ptr ;

  int i;
  int N ;

  if (argc < 2 ) {
    fprintf(stderr,"Usage: mstruct <N>\\n");
    return 1 ;
  }
  else {
    sscanf(argv[1],"%d",&N);
    printf("mstruct: N = %d\\n",N);
  }

  //1. Malloc m1
  m1_ptr = (mstruct *)malloc(N*sizeof(mstruct));
  assert(m1_ptr != NULL);

  //2. Initialize 
  for(i=0;i<N;i++) 
    randomize( m1_ptr+i ) ;

  //3. Malloc m2
  m2_ptr = (mstruct *)malloc(N*sizeof(mstruct));
  assert(m2_ptr != NULL);

  //4. Read orig and add 1
  for(i=0;i<N;i++) {
    copy_value(m1_ptr+i,m2_ptr+i);
    inc_value(m2_ptr+i);
  }

  //5. Compare
  for(i=0;i<N;i++) {

EOF

for ($i=$start;$i<$end;$i=$i+$step) {
  printf FC "\t assert(  ((m2_ptr+i)->f%d) == (((m1_ptr+i)->f%d)^1) );\n",$i,$i ;
}

print FC <<EOF;

  }
  
  printf("mstruct test:PASSED\\n");

  return 0;
}

void randomize (mstruct * m) {
EOF


for ($i=$start;$i<$end;$i=$i+$step) {
  printf FC "\t m->f%d = random();\n",$i ;
}

print FC <<EOF;
}

void copy_value ( mstruct * src, mstruct * dst ) {
EOF

for ($i=$start;$i<$end;$i=$i+$step) {
  printf FC "\t dst->f%d = src->f%d;\n",$i,$i ;
}

print FC <<EOF;
}

void inc_value ( mstruct * dst ) {
EOF

for ($i=$start;$i<$end;$i=$i+$step) {
  printf FC "\t  dst->f%d = dst->f%d ^1;\n",$i,$i ;
}

print FC "}\n";














