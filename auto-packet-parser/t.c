#include <stdio.h>


typedef union {
  struct {
    int f0:8;
    int f1:8;
    int f2:8;
    int f3:8;
  } pf ;
  int W;
} pkt ;


int main() {

  int i ;
  pkt p ;

  p.pf.f0 = 1 ;
  p.pf.f1 = 2 ;
  p.pf.f2 = 3 ;
  p.pf.f3 = 4 ;

  printf("W0 = 0x%x\n",p.W);

  return 0;
}
