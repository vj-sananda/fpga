#include <assert.h>
#include <stdio.h>

uint find_msb( uint n ) {
  uint i=31;

  assert(n != 0);
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

  uint Q, Qi,Qi1,Qi2, R;
  uint iter = 0;
  uint mi ;

  if (argc < 2) {
    printf("Usage: divide <dividend> <divisor>\n");
  }
  else {
    sscanf( argv[1], "%u", &m);
    sscanf( argv[2], "%u", &n);
  }
  printf("Operation: %u / %u\n",m,n);

  n_msb = find_msb(n);
  Q= 0;
  mi = m;
  m_msb = find_msb(mi);

  while ( mi > n ) {
    iter++;
    Qi1 = mi >> (n_msb+1) ;
    //    Qi = (( mi * 11 * (1 << (n_msb +1 -3)) ) - (mi * n)) >> (2*n_msb+1);
    if ( n_msb > 1 )
      Qi2 = (( mi * 11 * (1 << (n_msb-2)) ) - (mi * n)) >> (2*n_msb+1);
    else
      Qi2 = (( mi * 5 * (1 << (n_msb-1)) ) - (mi * n)) >> (2*n_msb+1);
    
    if ( Qi1 > Qi2 || (m_msb+n_msb) > 32)
      Qi = Qi1 ;
    else 
      Qi =  Qi2 ;

    Q += Qi;
    mi -= Qi * n ;

    printf("Iter=%u: Qi=%u, m=%u(m_msb=%u,n_msb=%u),Q=%u\n",iter,Qi,mi,m_msb,n_msb,Q);

    m_msb = find_msb(mi);
    if ( m_msb == n_msb ) {
      if (mi >= n) Q++;
      break;
    }
  }

  R = m-Q*n;
  if ( Q == m/n  &&  R == m % n ) {
    printf("PASS: Q=%u (exp=0x%x) , R=%u (exp=0x%x)\n",Q,m/n,R,m%n);
  }
  else
    printf("FAIL: Q=%u (exp=%u) , R=%u (exp=%u)\n",Q,m/n,R,m%n);
  
  return 0;
}


