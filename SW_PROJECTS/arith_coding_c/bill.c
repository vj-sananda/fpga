/*
 * Listing 5 -- bill.c
 *
 * This short demonstration program will use arithmetic data
 * compression to encode and then decode a string that only uses
 * the letters out of the phrase "BILL GATES".  It uses a fixed
 * table of probabilities that is hardcoded in.  Note that it
 * differs from the example in the article in that it adds a single
 * new symbol, '\0', which is used to indicate the end of the string.
 *
 * To build this program:
 *
 * Turbo C:     tcc -w bill.c bitio.c coder.c
 * QuickC:      qcl /W3 bill.c bitio.c coder.c
 * Zortech:     ztc bill.c bitio.c coder.c
 * *NIX:        cc -o bill bill.c bitio.c coder.c
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "coder.h"
#include "bitio.h"

/*
 * Declarations for local routines.
 */
void compress( void );
void expand( void );
void convert_int_to_symbol( char c, SYMBOL *s );
char convert_symbol_to_int( unsigned int count, SYMBOL *s );
void error_exit( char *message );

/*
 * This is a the probability table for the symbol set used
 * in this example.  Each symbols has a low and high range,
 * and the total count is fixed at 11.
 */
struct {
          char c;
          unsigned short int low;
          unsigned short int high;
       } probabilities[]= {{ 'B',  0,  1  },
                           { 'I',  1,  2  },
                           { 'L',  2,  4  },
                           { ' ',  4,  5  },
                           { 'G',  5,  6  },
                           { 'A',  6,  7  },
                           { 'T',  7,  8  },
                           { 'E',  8,  9  },
                           { 'S',  9,  10 },
                           { '\0', 10, 11  }
                          };
/*
 * This example program compresses an input string, sending
 * the output to a file.  It then expands the output file,
 * sending the decoded characters to the screen.
 */
void main()
{
    compress();
    expand();
}

/*
 * This is the compress routine.  It shows the basic algorithm for
 * the compression programs used in this article.  First, an input
 * characters is loaded.  The modeling routines are called to
 * convert the character to a symbol, which has a high, low and
 * range.  Finally, the arithmetic coder module is called to
 * output the symbols to the bit stream.
 */
void compress()
{
    int i;
    char c;
    SYMBOL s;
    FILE *compressed_file;
    static char *input = "GLIB BATES";

    compressed_file=fopen( "test.cmp", "wb" );
    if ( compressed_file == NULL )
        error_exit( "Could not open output file" );
    puts( "Compressing..." );
    initialize_output_bitstream();
    initialize_arithmetic_encoder();
    for ( i=0 ; ; )
    {
        c = input[ i++ ];
        convert_int_to_symbol( c, &s );
        encode_symbol( compressed_file, &s );
        if ( c == '\0' )
            break;
    }
    flush_arithmetic_encoder( compressed_file );
    flush_output_bitstream( compressed_file );
    fclose( compressed_file);
}

/*
 * This expansion routine demonstrates the basic algorithm used for
 * decompression in this article.  It first goes to the modeling
 * module and gets the scale for the current context.  (Note that
 * the scale is fixed here, since this is not an adaptive model).
 * It then asks the arithmetic decoder to give a high and low
 * value for the current input number scaled to match the current
 * range.  Finally, it asks the modeling unit to convert the
 * high and low values to a symbol.
 */
void expand()
{
    FILE *compressed_file;
    SYMBOL s;
    char c;
    int count;

    compressed_file=fopen( "test.cmp", "rb" );
    if ( compressed_file == NULL )
        error_exit( "Could not open output file" );
    puts( "Decoding..." );
    printf( "Incoming characters: " );
    initialize_input_bitstream();
    initialize_arithmetic_decoder( compressed_file );
    for ( ; ; )
    {
        s.scale = 11;
        count = get_current_count( &s );
        c = convert_symbol_to_int( count, &s );
        if ( c == '\0' )
            break;
        remove_symbol_from_stream( compressed_file, &s );
        putc( c, stdout );
    }
    putc( '\n', stdout );
}

/*
 * This routine is called to convert a character read in from
 * the text input stream to a low, high, range SYMBOL.  This is
 * part of the modeling function.  In this case, all that needs
 * to be done is to find the character in the probabilities table
 * and then retrieve the low and high values for that symbol.
 */
void convert_int_to_symbol( char c, SYMBOL *s )
{
    int i;

    i=0;
    for ( ; ; )
    {
        if ( c == probabilities[ i ].c )
        {
            s->low_count = probabilities[ i ].low;
            s->high_count = probabilities[ i ].high;
            s->scale = 11;
            return;
        }
        if ( probabilities[i].c == '\0' )
            error_exit( "Trying to encode a char not in the table" );
        i++;
    }
}

/*
 * This modeling function is called to convert a SYMBOL value
 * consisting of a low, high, and range value into a text character
 * that can be sent to a file.  It does this by finding the symbol
 * in the probability table that straddles the current range.
 */
char convert_symbol_to_int( unsigned int count, SYMBOL *s )
{
    int i;

    i = 0;
    for ( ; ; )
    {
        if ( count >= probabilities[ i ].low &&
             count < probabilities[ i ].high )
        {
            s->low_count = probabilities[ i ].low;
            s->high_count = probabilities[ i ].high;
            s->scale = 11;
            return( probabilities[ i ].c );
        }
        if ( probabilities[ i ].c == '\0' )
            error_exit( "Failure to decode character" );
        i++;
    }
}

/*
 * A generic error routine.
 */
void error_exit( char *message )
{
    puts( message );
    exit( -1 );
}

