/*
 * MEMOCODE Hardware/Software CoDesign Contest 2008
 *
 * Everyone is granted permission to copy, modify and redistribute
 * this tool set under the following conditions:
 *
 *    This source code is distributed for non-commercial use only.
 *    Please contact the maintainer for restrictions applying to
 *    commercial use.
 *
 *    Permission is granted to anyone to make or distribute copies
 *    of this source code, either as received or modified, in any
 *    medium, provided that all copyright notices, permission and
 *    nonwarranty notices are preserved, and that the distributor
 *    grants the recipient permission for further redistribution as
 *    permitted by this document.
 *
 *    Permission is granted to distribute this file in compiled
 *    or executable form under the same conditions that apply for
 *    source code, provided that either:
 *
 *    A. it is accompanied by the corresponding machine-readable
 *       source code,
 *    B. it is accompanied by a written offer, with no time limit,
 *       to give anyone a machine-readable copy of the corresponding
 *       source code in return for reimbursement of the cost of
 *       distribution.  This written offer must permit verbatim
 *       duplication by anyone, or
 *    C. it is distributed by someone who received only the
 *       executable form, and is accompanied by a copy of the
 *       written offer of source code that they received concurrently.
 *
 * In other words, you are welcome to use, share and improve this
 * source file.  You are forbidden to forbid anyone else to use, share
 * and improve what you give them.
 *
 * THE SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY WARRANTY OF ANY KIND, EITHER
 * EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO ANY WARRANTY
 * THAT THE SOFTWARE WILL CONFORM TO SPECIFICATIONS OR BE ERROR-FREE AND ANY
 * IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
 * TITLE, OR NON-INFRINGEMENT.  IN NO EVENT SHALL CARNEGIE MELLON UNIVERSITY
 * BE LIABLE FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO DIRECT, INDIRECT,
 * SPECIAL OR CONSEQUENTIAL DAMAGES, ARISING OUT OF, RESULTING FROM, OR IN
 * ANY WAY CONNECTED WITH THIS SOFTWARE (WHETHER OR NOT BASED UPON WARRANTY,
 * CONTRACT, TORT OR OTHERWISE).
 *
 */

#include "recordio_tc.h"
#include "aes_core.h"
#include <assert.h>
#include <stdio.h>

RECORD   db[MAXRECORD];
static AES_KEY  db_encrypt_key;
static unsigned db_chk;

unsigned nextrng(unsigned rng) {
  return (rng >> 1) ^ (-(signed int)(rng & 1) & 0xd0000001u);
}

void getkey(unsigned idx, unsigned *f) {
  unsigned char plaindata[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
                                 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
  unsigned char cryptdata[16];
  int i;
  PUTU32(plaindata, idx);
  AES_encrypt(plaindata, cryptdata, &db_encrypt_key);
  for (i=0; i<4; i++)
    f[i] = GETU32(cryptdata + 4*i);
}

void initializedb_rand(const unsigned char *gkey, unsigned pwr) {
  unsigned rng = RNGSEED;
  unsigned maxrecord = (1 << pwr);
  unsigned i;
  unsigned record_key[4];
  
  assert(gkey !=  0);
  assert(pwr  <= 18);

  AES_set_encrypt_key(gkey, 128, &db_encrypt_key);

  db_chk = 0; // reference checksum for non-encrypted data
  
  for (i=0; i<maxrecord; i++) {
    getkey(i, record_key);

    rng = nextrng(rng);
    if (rng < 0x80000000) 
	   db[i].f1 = record_key[0];
    else {
      db[i].f1  = rng ^ record_key[0];
      db_chk   += rng;
    }

    rng = nextrng(rng);
    if (rng < 0x40000000)
      db[i].f2 = record_key[1];
    else {
      db[i].f2  = rng ^ record_key[1];
      db_chk   += rng;
    }

    rng = nextrng(rng);
    if (rng < 0x20000000)
      db[i].f3 = record_key[2];
    else {
      db[i].f3  = rng ^ record_key[2];
      db_chk   += rng;
	 }

    rng = nextrng(rng);
    db[i].f4  = rng ^ record_key[3];
    db_chk   += rng;
  }
}

void initializedb_rot(const unsigned char *gkey, unsigned pwr) {
  unsigned rng = RNGSEED;
  unsigned i, j, k;
  unsigned record_key[4];
  unsigned side = 1 << (pwr/2);
  
  assert(gkey != 0);
  assert(pwr <= 18);

  AES_set_encrypt_key(gkey, 128, &db_encrypt_key);

  db_chk = 0; // reference checksum for non-encrypted data
  
  for (j=0; j < side; j++)
    for (k=0; k < side; k++) {
      i = (side - 1 - k) * side + j;

      getkey(j*side + k, record_key);
      
      rng = nextrng(rng);
      if (rng < 0x80000000) 
	     db[j*side + k].f1 = record_key[0];
      else {
	     db[j*side + k].f1  = i ^ record_key[0];
	     db_chk   += i;
      }

      rng = nextrng(rng);
      if (rng < 0x40000000)
	     db[j*side + k].f2 = record_key[1];
      else {
	     db[j*side + k].f2  = i ^ record_key[1];
	     db_chk   += i;
      }
      
      rng = nextrng(rng);
      if (rng < 0x20000000)
	     db[j*side + k].f3 = record_key[2];
      else {
	     db[j*side + k].f3  = i ^ record_key[2];
	     db_chk   += i;
      }

      rng = nextrng(rng);
      db[j*side + k].f4  = i ^ record_key[3];
      db_chk   += i;
    }
}

void readrecord(RECORD *r, unsigned idx) {
  unsigned record_key[4];
  assert(r != 0);
  assert(idx < MAXRECORD);
  getkey(idx, record_key);
  r->f1 = db[idx].f1 ^ record_key[0];
  r->f2 = db[idx].f2 ^ record_key[1];
  r->f3 = db[idx].f3 ^ record_key[2];
  r->f4 = db[idx].f4 ^ record_key[3];
}

void writerecord(RECORD *r, unsigned idx) {
  unsigned record_key[4];
  assert(r != 0);
  assert(idx < MAXRECORD);
  getkey(idx, record_key);
  db[idx].f1 = r->f1 ^ record_key[0];
  db[idx].f2 = r->f2 ^ record_key[1];
  db[idx].f3 = r->f3 ^ record_key[2];
  db[idx].f4 = r->f4 ^ record_key[3];
}

int comparerecord(unsigned idx1, unsigned idx2) {
  RECORD r1, r2;
  unsigned r;
  readrecord(&r1, idx1);
  readrecord(&r2, idx2);
  if ( (r1.f1) >  (r2.f1)) r = 0; 
  else if (((r1.f1) == (r2.f1)) && 
           ((r1.f2)  > (r2.f2))) r = 0; 
  else if (((r1.f1) == (r2.f1)) && 
           ((r1.f2) == (r2.f2)) && 
			  ((r1.f3)  > (r2.f3))) r = 0; 
  else if (((r1.f1) == (r2.f1)) && 
           ((r1.f2) == (r2.f2)) && 
			  ((r1.f3) == (r2.f3)) && 
			  ((r1.f4)  > (r2.f4))) r = 0; 
  else r = 1;
  return r;
}

void swaprecord(unsigned idx1, unsigned idx2) {
  RECORD r1, r2;
  readrecord(&r1, idx1);
  readrecord(&r2, idx2);
  writerecord(&r2, idx1);
  writerecord(&r1, idx2);
}

int verifydb_tc(unsigned pwr) {
  unsigned i;
  unsigned ok = 1;
  unsigned chk;
  unsigned maxrecord = (1 << pwr);

  assert(pwr <= 18);

  RECORD   R;
  // verify if the ordering is correct
  for (i=0; i<maxrecord-1; i++)
    ok = ok & (comparerecord(i+1, i) == 0);
  // evaluate checksum
  chk = 0;
  for (i=0; i<maxrecord; i++) {
    readrecord(&R, i);
    chk += R.f1;
    chk += R.f2;
    chk += R.f3;
    chk += R.f4;
  }
  
  return ok & (chk == db_chk);
}

void sortrecord_tc(unsigned pwr) {
  unsigned i, swapped = 1, gap;
  unsigned maxrecord = (1 << pwr);

  assert(pwr <= 18);

  gap = maxrecord * 10 / 13;

  while ((gap > 1) || (swapped)) {
    swapped = 0;
    if (gap > 1) {
      gap = gap * 10 / 13;
      gap = (gap == 10) ? 11 : gap;
      gap = (gap ==  9) ? 11 : gap;
    }
    for (i=0; (i + gap) <= maxrecord-1; i++)
      if (comparerecord(i+gap, i)) {
        swaprecord(i,i+gap);
        swapped = 1;
      }
  }
}

void showdb_tc(unsigned pwr) {
  unsigned i;
  unsigned record_key[4];
  unsigned maxrecord = (1 << pwr);

  assert(pwr <= 18);

  for (i=0; i<maxrecord; i++) {
    printf("%3x ", i);

    printf("%8x ", db[i].f1);
    printf("%8x ", db[i].f2);
    printf("%8x ", db[i].f3);
    printf("%8x ", db[i].f4);
    
    getkey(i, record_key);

    printf("%8x ", (db[i].f1 ^ record_key[0]));
    printf("%8x ", (db[i].f2 ^ record_key[1]));
    printf("%8x ", (db[i].f3 ^ record_key[2]));
    printf("%8x\n",(db[i].f4 ^ record_key[3]));    
  }

}
