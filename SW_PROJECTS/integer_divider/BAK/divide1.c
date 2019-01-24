#include <assert.h>
#include <stdio.h>

uint find_msb( uint n ) {
  uint i=31;

  assert( n != 0);
  for(i=31;i>=0;i--) {
    if (n & 0x80000000) return i;
    n = n << 1;
  }
}

int main(int argc , char ** argv) {

  uint m = 100;
  uint n = 10 ;

  uint m_msb ;
  uint n_msb ;

  int Q, Qi, R;
  uint iter = 0;
  int mi ;

  if (argc < 2) {
    printf("Usage: divide <dividend> <divisor>\n");
  }
  else {
    sscanf( argv[1], "%d", &m);
    sscanf( argv[2], "%d", &n);
  }
  printf("Operation: %d / %d\n",m,n);

  n_msb = find_msb(n);
  Q= 0;
  mi = m;
  m_msb = find_msb(mi);

  while ( mi > n ) {
    iter++;

    if ( (m_msb - n_msb) > 4 )
      Qi = ((1 << (m_msb-n_msb))*7)>>3 ;
    else
      Qi = (mi >> (n_msb+1));

    Q += Qi;
    mi -= Qi * n ;

    if ( mi < 0 ) {
      printf("mi<0:Iter=%d: Qi=%d, m=%d(m_msb=%d,n_msb=%d),Q=%d\n",iter,Qi,mi,m_msb,n_msb,Q);
      exit(1);
    }

    m_msb = find_msb(mi);

    printf("Iter=%d: Qi=%d, m=%d(m_msb=%d,n_msb=%d),Q=%d\n",iter,Qi,mi,m_msb,n_msb,Q);

    if ( m_msb == n_msb ) {
      if (mi >= n) Q++;
      break;
    }

    if ( iter > 32 ) {
      printf("ERROR:Exceeded 32 iterations: Qi=%d, m=%d(m_msb=%d,n_msb=%d)\n",Qi,mi,m_msb,n_msb);
      exit(1);
    }
  }

  R = m-Q*n;
  if ( Q == m/n  &&  R == m % n ) {
    printf("PASS: Q=%d (exp=0x%x) , R=%d (exp=0x%x)\n",Q,m/n,R,m%n);
  }
  else
    printf("FAIL: Q=%d (exp=%d) , R=%d (exp=%d)\n",Q,m/n,R,m%n);
  
  return 0;
}


