#include <assert.h>
#include <stdio.h>

uint find_msb( uint n ) {
  uint i=31;

  //Inpug argument, n has to be non-zero
  assert( n != 0 );

  for(i=31;i>=0;i--) {
    if (n & 0x80000000) return i;
    n = n << 1;
  }
}

int main(int argc , char ** argv) {

  uint m = 100;
  uint n = 10 ;

  uint m_s ;
  uint n_s ;

  uint m_msb ;
  uint n_msb ;

  uint Q,R;

  uint iter = 0;
  uint mi ;

  uint x_initial ;
  uint x_next ;

  if (argc < 2) {
    printf("Usage: divide <dividend> <divisor>\n");
  }
  else {
    sscanf( argv[1], "%d", &m);
    sscanf( argv[2], "%d", &n);
  }
  printf("Operation: %d / %d\n",m,n);

  n_msb = find_msb(n);
  m_s = (uint)m;
  n_s = (uint)n;

  printf("n_msb = %d, m_s = %d, n_s = %d\n", n_msb, m_s, n_s);

  //  x_initial = 16.0/17.0 * n_s ;
  x_initial = n_s ;

  iter = 1;
  
  uint Shifted_2 ;
  Shifted_2 = (1 << (n_msb+2));

  uint error = 1;
  while (error) {
    printf ("x[%d] = %d\n",iter,x_initial);

    x_next = x_initial*( Shifted_2 - n_s * x_initial);
    error = x_next-x_initial;
    x_initial = x_next ;
    n_msb = find_msb(x_initial);
    Shifted_2 = (1 << (n_msb+2));


    iter++;
  }

  Q = (m_s * x_initial) >> (n_msb) ;

  R = m-Q*n;

  uint Qexp = (uint)m/(uint)n ;
  uint Rexp = (uint)m % (uint)n;

  if ( Q == Qexp &&  R == Rexp ) {
    printf("PASS: Q=%d (exp=0x%x) , R=%d (exp=0x%x)\n",Q,Qexp,R,Rexp);
  }
  else
    printf("FAIL: Q=%d (exp=%d) , R=%d (exp=%d)\n",Q,Qexp,R,Rexp);
  
  return 0;
}


