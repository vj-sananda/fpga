tb.v : Top level test bench

user_logic.v : Top level of accelerator core + glue logic to interface to PLB bus

accel_sort.v : HW accelerated sort
 
aes_cipher_top.v : AES top

aes_key_expand_128.v : AES submodules

aes_keygen.v : AES submodules

aes_rcon.v : AES submodules

aes_sbox.v : AES submodules

fifo_rd_64_to_128.v : Elastic fifos along with bus width adapters (64 to 128 bit)

fifo_wr_128_to_64.v : Elastic fifos along with bus width adapters (128 to 64 bit)
