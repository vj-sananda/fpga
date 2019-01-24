
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

//Usage: heap <N>
//return 0 if successful

//Given child index, returns parent index
//if array indices start from 0
//For parent with index i, children are 2*i+1, and 2*i+2
int get_parent(int child_index) {
  if ( child_index % 2 ) 
    return (( child_index - 1 ) >> 1 );//odd
  else
    return (( child_index >> 1 ) - 1 );//even 
}

void get_children(int parent, int *left , int * right) {
  *left = (parent<<1) + 1;
  *right = (parent+1) << 1;
}


//Move last location up the heap
void up_heap(int * heap, int lastptr) {
  int child = lastptr;
  int parent;
  int tmp;

    while ( child  ) {
      parent = get_parent(child);
      if ( heap[parent] > heap[child] ) {
	//swap parent and child
	tmp = heap[parent];
	heap[parent]=heap[child];
	heap[child] = tmp;
      }
      //one level up the tree
      child = parent ;
    }

}

//Move root down the heap as needed
void down_heap(int * heap, int  lastptr) {
  int left,right;
  int parent = 0;
  int tmp ;

  if ( lastptr ) {
    while(1) {
      get_children(parent,&left,&right);

      //Reached the end of the tree
      if ( left > lastptr && right > lastptr ) break ;

      //Go down the smaller path
      if ( heap[left] < heap[right] ) {
	if ( heap[parent] > heap[left] ) {
	  tmp = heap[parent];
	  heap[parent] = heap[left];
	  heap[left] = tmp ;
	  parent = left ;
	  continue;
	}
      }
      else {
	if ( heap[parent] > heap[right] ) {
	  tmp = heap[parent];
	  heap[parent] = heap[right];
	  heap[right] = tmp;
	  parent = right ;
	  continue;
	}
      }
      break;
    }
  }

}

void add_to_heap(int *heap, int * nxtptr, int entry) {
  //Add to last location, then up heap
  heap[*nxtptr]=entry ;
  up_heap( heap, *nxtptr);
  (*nxtptr)++;
}

//Returns 0 if heap empty
int remove_from_heap(int * heap, int * lastptr, int *entry) {
  //Remove root, move last location to root, then down heap
  *entry = heap[0];    
  heap[0] = heap[*lastptr];

  if ( *lastptr ) {
    (*lastptr)--;
    down_heap(heap, *lastptr);
    return 1;
  }
  else
    return 0;
}

void print_heap(int * heap, int lastptr) {
  int i;
  for (i=0; i<=lastptr; i++) {
    printf( "heap[%d] = %d\n", i,heap[i]);
  }


}

int main (int argc, char ** argv) {

  int *a;
  int *heap;

  int nxtptr=0 ;

  int i,j,tmp;
  int min;
  int lastptr;
  int rval = 1;
  int global_min = 1000 ;
  int nxt_min ;
  int N ;

  if (argc < 2) {
    fprintf(stderr,"Usage: heap <N>\n");
    return 1;
  }
  else {
    sscanf(argv[1],"%d",&N);
    printf("Build heap with %d random integers\n",N);
  }

  a=(int *)malloc(sizeof(int)*N);
  heap=(int *)malloc(sizeof(int)*N);

  for (i=0; i<N; i++) {
    a[i] = random() % 1000 + (random() % 100 + 1 );
    if ( a[i] < global_min )
      global_min = a[i] ;

    add_to_heap( heap, &nxtptr, a[i] ) ;
  }

  printf("global_min = %d\n",global_min);

  lastptr = nxtptr -1 ;
  
  //  print_heap(heap,lastptr);
  
  nxt_min = global_min ;

  printf("Remove from heap 1 at a time, checking order\n");
  while(rval) {
    rval = remove_from_heap( heap, &(lastptr), &min ) ;
    
    //printf("-------------\nmin = %d\n", min);
    assert( min >= nxt_min );
    nxt_min = min ;
    
    //    print_heap(heap,lastptr);
  }

  printf("Heap test PASSED\n");
  return 0;
}
