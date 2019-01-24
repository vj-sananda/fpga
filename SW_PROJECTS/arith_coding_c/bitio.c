/*
 * Listing 4 -- bitio.c
 *
 * This routine contains a set of bit oriented i/o routines
 * used for arithmetic data compression.  The important fact to
 * know about these is that the first bit is stored in the msb of
 * the first byte of the output, like you might expect.
 *
 * Both input and output maintain a local buffer so that they only
 * have to do block reads and writes.  This is done in spite of the
 * fact that C standard I/O does the same thing.  If these
 * routines are ever ported to assembly language the buffering
 * will come in handy.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "coder.h"
#include "bitio.h"

#define BUFFER_SIZE 256
static char buffer[ BUFFER_SIZE + 2 ]; /* This is the i/o buffer    */
static char *current_byte;             /* Pointer to current byte   */

static int output_mask;                /* During output, this byte  */
                                       /* contains the mask that is */
                                       /* applied to the output byte*/
                                       /* if the output bit is a 1  */

static int input_bytes_left;           /* During input, these three */
static int input_bits_left;            /* variables keep track of my*/
static int past_eof;                   /* input state.  The past_eof*/
                                       /* byte comes about because  */
                                       /* of the fact that there is */
                                       /* a possibility the decoder */
                                       /* can legitimately ask for  */
                                       /* more bits even after the  */
                                       /* entire file has been      */
                                       /* sucked dry.               */


/*
 * This routine is called once to initialze the output bitstream.
 * All it has to do is set up the current_byte pointer, clear out
 * all the bits in my current output byte, and set the output mask
 * so it will set the proper bit next time a bit is output.
 */
void initialize_output_bitstream()
{
    current_byte = buffer;
    *current_byte = 0;
    output_mask = 0x80;
}

/*
 * The output bit routine just has to set a bit in the current byte
 * if requested to.  After that, it updates the mask.  If the mask
 * shows that the current byte is filled up, it is time to go to the
 * next character in the buffer.  If the next character is past the
 * end of the buffer, it is time to flush the buffer.
 */
void output_bit( FILE *stream, int bit )
{
    if ( bit )
        *current_byte |= output_mask;
    output_mask >>= 1;
    if ( output_mask == 0 )
    {
        output_mask = 0x80;
        current_byte++;
        if ( current_byte == ( buffer + BUFFER_SIZE ) )
        {
            fwrite( buffer, 1, BUFFER_SIZE, stream );
            current_byte = buffer;
        }
        *current_byte = 0;
    }
}

/*
 * When the encoding is done, there will still be a lot of bits and
 * bytes sitting in the buffer waiting to be sent out.  This routine
 * is called to clean things up at that point.
 */
void flush_output_bitstream( FILE *stream )
{
    fwrite( buffer, 1, (size_t)( current_byte - buffer ) + 1, stream );
    current_byte = buffer;
}

/*
 * Bit oriented input is set up so that the next time the input_bit
 * routine is called, it will trigger the read of a new block.  That
 * is why input_bits_left is set to 0.
 */
void initialize_input_bitstream()
{
    input_bits_left = 0;
    input_bytes_left = 1;
    past_eof = 0;
}

/*
 * This routine reads bits in from a file.  The bits are all sitting
 * in a buffer, and this code pulls them out, one at a time.  When the
 * buffer has been emptied, that triggers a new file read, and the
 * pointers are reset.  This routine is set up to allow for two dummy
 * bytes to be read in after the end of file is reached.  This is because
 * we have to keep feeding bits into the pipeline to be decoded so that
 * the old stuff that is 16 bits upstream can be pushed out.
 */
short int input_bit( FILE *stream )
{
    if ( input_bits_left == 0 )
    {
        current_byte++;
        input_bytes_left--;
        input_bits_left = 8;
        if ( input_bytes_left == 0 )
        {
            input_bytes_left = fread( buffer, 1, BUFFER_SIZE, stream );
            if ( input_bytes_left == 0 )
            {
                if ( past_eof )
                {
                    fprintf( stderr, "Bad input file\n" );
                    exit( -1 );
                }
                else
                {
                    past_eof = 1;
                    input_bytes_left = 2;
                }
            }
            current_byte = buffer;
        }
    }
    input_bits_left--;
    return ( ( *current_byte >> input_bits_left ) & 1 );
}

/*
 * When monitoring compression ratios, we need to know how many
 * bytes have been output so far.  This routine takes care of telling
 * how many bytes have been output, including pending bytes that
 * haven't actually been written out.
 */
long bit_ftell_output( FILE *stream )
{
    long total;

    total = ftell( stream );
    total += current_byte - buffer;
    total += underflow_bits/8;
    return( total );
}

/*
 * When monitoring compression ratios, we need to know how many bits
 * have been read in so far.  This routine tells how many bytes have
 * been read in, excluding bytes that are pending in the buffer.
 */
long bit_ftell_input( FILE *stream )
{
    return( ftell( stream ) - input_bytes_left + 1 );
}

