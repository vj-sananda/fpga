#include <assert.h>
#include <stdio.h>
#include <math.h>

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

  float m_s ;
  float n_s ;

  uint m_msb ;
  uint n_msb ;

  uint Q,R;

  uint iter = 0;
  uint mi ;

  float x_initial ;
  float x_next ;

  if (argc < 2) {
    printf("Usage: divide <dividend> <divisor>\n");
  }
  else {
    sscanf( argv[1], "%u", &m);
    sscanf( argv[2], "%u", &n);
  }
  printf("Operation: %u / %u\n",m,n);

  n_msb = find_msb(n);
  m_s = (float)m;
  n_s = (float)n;

  m_s = m_s / (1<<(n_msb + 1));
  n_s = n_s / (1<<(n_msb + 1));

  printf("n_msb = %u, m_s = %f, n_s = %f\n", n_msb, m_s, n_s);

  //  x_initial = 16.0/17.0 * n_s ;
  x_initial = n_s ;

  iter = 0;
  
  float error = 1;
  while (error) {
    iter++;
    printf ("x[%u] = %f\n",iter,x_initial);
    x_next = x_initial*(2.0-n_s*x_initial);
    error = x_next-x_initial;
    x_initial = x_next ;
  }

  Q = m_s * x_initial ;

  R = m-Q*n;

  if (R >= n )
    printf ("Enter Cleanup: Q = %u , R=%u (>= %u)\n",Q,R,n);
  while( R >= n ) {
    iter++;
    Q++;
    R = m - Q*n ;
    printf ("Q[%u] = %u , R=%u\n",iter,Q,R);
    assert ( abs(R) < n );
  }

  uint Qexp = (uint)m/(uint)n ;
  uint Rexp = (uint)m % (uint)n;

  if ( Q == Qexp &&  R == Rexp ) {
    printf("PASS: Q=%u (exp=0x%x) , R=%u (exp=0x%x)\n",Q,Qexp,R,Rexp);
  }
  else
    printf("FAIL: Q=%u (exp=%u) , R=%u (exp=%u)\n",Q,Qexp,R,Rexp);
  
  return 0;
}


