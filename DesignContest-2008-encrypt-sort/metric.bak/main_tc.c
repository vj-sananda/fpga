#include "aes_core.h"
#include "recordio_tc.h"
#include "timer.h"
#include <math.h>
#include <stdio.h>

//VJS:Added hw merge sort
#include "sortrecord_hw_plb.h"
#include "msort.h"

const unsigned char globalkey[] = {0xB0, 0x1D, 0xFA, 0xCE, 
                                   0x0D, 0xEC, 0x0D, 0xED, 
                                   0x0B, 0xA1, 0x1A, 0xDE, 
                                   0x0E, 0xFF, 0xEC, 0x70};

int main() {
  long long start, stop;
  long elapsed[8], acc;
  double sumln, geometric_rel;
  long elapsed_ref[8] = {5239,
                         5714,
                         177490,
                         176060,
                         4411572,
                         4299949,
                         97784247,
			 97951475
                         };
  unsigned i, k;
  
  //VJS:Changed cache enable from 0xf0000000 to 0xc0000000
  XCache_EnableICache(0xc0000000);
  XCache_EnableDCache(0xc0000000);

  printf("Sorting starts\n\r");

  //VJS:Added, tell hw accelerator what the globalkey is
  sortrecord_hw_global_key( globalkey);

  for (i=0; i<1; i++) {

    acc = 0;

      initializedb_rand(globalkey, 6+4*i);  
      start = ts_get_ll();

      //VJS:Comment out refcode and add hw accel call
      //sortrecord_tc(6+4*i);
      sortrecord_hw_plb(6+4*i);
      //sortrecord_blockmerge(6+4*i);

      stop = ts_get_ll();
      acc += ts_elapse_us(start, stop);

    elapsed[2*i] = acc / 3;
    
    printf("Case (rand, pwr=%3d) : Elapsed %9d, ", 6+4*i, elapsed[2*i]);
    if (verifydb_tc(6+4*i))
      printf(" correct\n\r");
    else
      printf(" wrong\n\r");
    
  }    
  sumln = 0.0;
  for (i=0; i<8; i++)
    sumln += log(1.0 * elapsed_ref[i] / elapsed[i]);
  geometric_rel = exp(sumln / 8);
  
  printf("Relative Geometric Mean: %f\n\r", geometric_rel);
  
  printf("Sorting completed\n\r");
  
  return 0;
}
