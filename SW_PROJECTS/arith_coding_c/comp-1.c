/*
 * Listing 6 -- comp-1.c
 *
 * This listing is the driver program for an order 0 fixed context
 * compression program.  It follows the model shown in BILL.C
 * for a compression program, by reading in symbols from a file,
 * converting them to a high, low, range set, then encoding them.
 * The order 0 modeling code for this routine is found Listing 9,
 * model-1.c.
 *
 * To build this program:
 *
 * Turbo C:     tcc -w comp-1.c model-1.c bitio.c coder.c
 * QuickC:      qcl /W3 comp-1.c model-1.c bitio.c coder.c
 * Zortech:     ztc comp-1.c model-1.c bitio.c coder.c
 * *NIX:        cc -o comp-1 comp-1.c model-1.c bitio.c coder.c
 *
 * Command line options:
 *
 *  -f text_file_name  [defaults to test.inp]
 *  -c compressed_file_name [defaults to test.cmp]
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "coder.h"
#include "model.h"
#include "bitio.h"

FILE *text_file;              /* These variables are used by several   */
FILE *compressed_file;        /* of the modules in this routine.       */

/*
 * Local declarations.
 */
void initialize_options( int argc, char **argv );
void print_compression( void );

/*
 * The main() procedure for this routine is very simple.  After
 * initializing the command line options, model, I/O, and arithmetic
 * coder, it sits in a loop reading in characters from the input
 * file, converting them to type SYMBOL, then encoding them for
 * output.  When done, everything is shut down properly.
 *
 */
void main( int argc, char **argv )
{
    SYMBOL s;
    int c;
    long int text_count = 0;

    initialize_options( --argc, ++argv );
    initialize_model();
    initialize_output_bitstream();
    initialize_arithmetic_encoder();
/*
 * This is the main compression loop.  It gets a character, converts
 * it to SYMBOL, then encodes it.  Finally, the model is updated.
 * One potential portability problem:  EOF is assumed to be -1.
 */
    for ( ; ; )
    {
      //      if (( ++text_count & 0x0ff ) == 0 )
      //print_compression();
      c = getc( text_file );
      convert_int_to_symbol( c, &s );
      encode_symbol( compressed_file, &s );
      if ( c == EOF )
	break;
      update_model( c );
    }
/*
 * This is just some code that is needed to clean up loose ends before
 * the program can exit.
 */
    flush_arithmetic_encoder( compressed_file );
    flush_output_bitstream( compressed_file );
    print_compression();
    fputc( '\n', stderr );
    exit( 0 );
}
/*
 * This routine has the job of reading in all of the command line
 * options.  For this program, the only options are the input file
 * name and the output file name.  After the names are read in,
 * the files are opened.
 */
void initialize_options( int argc, char **argv )
{
    char text_file_name[ 81 ];
    char compressed_file_name[ 81 ];

    strcpy( compressed_file_name, "test.cmp" );
    strcpy( text_file_name, "test.inp" );
    while ( argc-- > 0 )
    {
        if ( strcmp( *argv, "-f" ) == 0 )
	{
	    argc--;
            strcpy( text_file_name, *++argv );
	}
        else if ( strcmp( *argv, "-c" ) == 0 )
	{
	    argc--;
	    strcpy( compressed_file_name, *++argv );
	}
	else
	{
            fprintf( stderr,
                "\nUsage: COMP-1 [-f text file] [-c compressed file]\n" );
	    exit( -1 );
	}
	argc--;
	argv++;
    }

    text_file = fopen( text_file_name, "rb" );
    compressed_file = fopen( compressed_file_name, "wb" );

    if ( text_file == NULL || compressed_file == NULL )
    {
        printf( "Had trouble opening one of the files!\n" );
        exit( -1 );
    }
    setvbuf( text_file, NULL, _IOFBF, 4096 );
    setbuf( stdout, NULL );
    printf( "Compressing %s to %s\n", text_file_name, compressed_file_name );
}

/*
 * This routine is a "bell and whistle" type thing.  It just prints
 * out the current input and output byte counts, and the current number
 * of bits being used per byte.
 */
void print_compression()
{
    long input_bytes;
    long output_bytes;

    input_bytes = ftell( text_file );
    if ( input_bytes == 0 )
        input_bytes = 1;
    output_bytes = bit_ftell_output( compressed_file );
    fprintf( stderr,
             "\r%ld/%ld, %2.3f     ",
	     input_bytes,
	     output_bytes,
             8.0 * output_bytes / input_bytes );
}

