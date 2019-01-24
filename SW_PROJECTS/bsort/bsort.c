
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//Usage: bsort <N>
//return 0 if no error

int main (int argc, char ** argv) {

  int *a;

  int i,j,tmp;
  int N ;

  if (argc < 2 ) {
    fprintf(stderr,"Usage: bsort <N>\n");
    return 1 ;
  }
  else {
    sscanf(argv[1],"%d",&N);
    printf("Bubble sort on %d random integers\n",N);
  }

  a = (int *)malloc(N*sizeof(int));

  for (i=0; i<N; i++) {
    a[i] = random() % 1000 ;
  }

  //  for (i=0; i<N; i++) {
  //    printf("UNSORTED::a[%d] = %d\n",i,a[i]);
  //}

  for (i=0; i<N-1; i++) {
    for (j=0; j<N-1-i; j++)
      if ( a[j+1] < a[j] ) {  /* compare the two neighbors */
	tmp = a[j] ;         /* swap a[j] and a[j+1]      */
	a[j] = a[j+1] ;
	a[j+1] = tmp;
      }
  }

    for (i=0; i<N-1; i++) {
      //printf("SORTED::a[%d] = %d\n",i,a[i]);
            assert ( a[i] <= a[i+1] ) ;
    }

    printf("Bubble sort test PASSED\n");
  return 0;
}
