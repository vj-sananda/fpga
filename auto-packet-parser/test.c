#include <stdio.h>


typedef union {
  struct {
    unsigned int f0:5;
    unsigned int f1:6;
    unsigned int f2:32;
    unsigned int f3:30;
    unsigned int f4:23;
  } pf ;
  unsigned int W[3];
} pkt ;


int main() {

  int i ;
  pkt p ;

//   p.W[0]=0;
//   p.W[1]=0;
//   p.W[2]=0;


  p.pf.f0 = 1 ;
  p.pf.f1 = 2 ;
  p.pf.f2 = 3 ;
  p.pf.f3 = 4 ;
  p.pf.f4 = 5 ;

  printf("W0 = 0x%x\n",p.W[0]);
  printf("W1 = 0x%x\n",p.W[1]);
  printf("W2 = 0x%x\n",p.W[2]);

  return 0;
}
