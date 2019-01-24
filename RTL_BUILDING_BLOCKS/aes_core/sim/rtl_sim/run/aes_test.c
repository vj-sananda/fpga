#include "aes_core.h"
#include <assert.h>
#include <stdio.h>
#define MAXRECORD 65536
//#define MAXRECORD 64

static AES_KEY  db_encrypt_key;

const unsigned char globalkey[] = {0xB0, 0x1D, 0xFA, 0xCE, 
                                   0x0D, 0xEC, 0x0D, 0xED, 
                                   0x0B, 0xA1, 0x1A, 0xDE, 
                                   0x0E, 0xFF, 0xEC, 0x70};

void print_128hex ( const unsigned char * din ) 
{
  int i;
  //  printf("128'h");
  for (i=0;i<=15;i++)
    if (i != 15)
      printf("%02x",din[i]);
    else
      printf("%02x\n",din[i]);
}

void getkey(unsigned idx, unsigned *f) {
  unsigned char plaindata[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
                                 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
  unsigned char cryptdata[16];
  int i;
  PUTU32(plaindata, idx);

  //Print out input data
  printf("in= ");
  print_128hex( plaindata ) ;

  AES_encrypt(plaindata, cryptdata, &db_encrypt_key);
  printf("out= ");
  print_128hex( cryptdata ) ;

  for (i=0; i<4; i++)
    f[i] = GETU32(cryptdata + 4*i);
}

void vec_gen(const unsigned char *gkey) {

  unsigned i;
  unsigned record_key[4];
  
  assert(gkey != 0);

  AES_set_encrypt_key(gkey, 128, &db_encrypt_key);

  printf("Global_Key=");
  print_128hex(gkey);

  for (i=0; i<MAXRECORD; i++)
    getkey(i, record_key);

}

int main() {

  vec_gen(globalkey);

  return 0;
}

