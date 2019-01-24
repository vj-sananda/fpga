/*
 * Listing 11 -- expand-2.c
 *
 * This module is the driver program for a variabler order finite
 * context expansion program.  The maximum order is determined by
 * command line option.  This particular version can respond to
 * the FLUSH code inserted in the bit stream by the compressor.
 *
 * To build this program:
 *
 * Turbo C:     tcc -w -mc expand-2.c model-2.c bitio.c coder.c
 * QuickC:      qcl /W3 /AC expand-2.c model-2.c bitio.c coder.c
 * Zortech:     ztc -mc expand-2.c model-2.c bitio.c coder.c
 * *NIX:        cc -o expand-2 expand-2.c model-2.c bitio.c coder.c
 *
 *
 * Command line options:
 *
 *  -f text_file_name  [defaults to test.inp]
 *  -c compressed_file_name [defaults to test.cmp]
 *  -o order [defaults to 3 for model-2]
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "coder.h"
#include "model.h"
#include "bitio.h"

/*
 * Declarations for local procedures.
 */
void initialize_options( int argc, char **argv );
void print_compression( void );

/*
 * Variables used throughout this particular file.
 */
FILE *text_file;
FILE *compressed_file;

/*
 * The main loop for expansion is very similar to the expansion routine
 * used in the simpler compression program, EXPAND-1.C.  The routine
 * first has to initialize the standard i/o, the bit oriented i/o,
 * the arithmetic coder, and the model.  The decompression loop
 * differs in a couple of respects.  First of all, it handles the
 * special ESCAPE character, by removing them from the input
 * bit stream but just throwing them away otherwise.  Secondly,
 * it handles the special FLUSH character.  Once the main decoding
 * loop is done, the cleanup code is called, and the program exits.
 */
void main( int argc, char *argv[] )
{
    SYMBOL s;
    int c;
    int count;
    long int counter = 0;

    initialize_options( --argc, ++argv );
    initialize_model();
    initialize_input_bitstream();
    initialize_arithmetic_decoder( compressed_file );
    for ( ; ; )
    {
        do
        {
            get_symbol_scale( &s );
            count = get_current_count( &s );
            c = convert_symbol_to_int( count, &s );
	    remove_symbol_from_stream( compressed_file, &s );
        } while ( c == ESCAPE );
        if ( c == DONE )
            break;
        if ( ( ++counter & 0xff ) == 0 )
	    print_compression();
	if ( c != FLUSH )
	    putc( (char) c, text_file );
	else
	{
	    fprintf( stderr, "\rFlushing...      \r" );
	    flush_model();
	}
	update_model( c );
	add_character_to_model( c );
    }
    print_compression();
    fputc( '\n', stderr );
    exit( 0 );
}

/*
 * This routine checks for command line options, and opens the
 * input and output files.  The only other command line option
 * besides the input and output file names is the order of the model,
 * which defaults to 3.
 */
void initialize_options( int argc, char **argv )
{
    char text_file_name[ 81 ];
    char compressed_file_name[ 81 ];

    strcpy( compressed_file_name, "test.cmp" );
    strcpy( text_file_name, "test.out" );
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
        else if ( strcmp( *argv, "-o" ) == 0 )
	{
	    argc--;
            max_order = atoi( *++argv );
	}
	else
	{
            fprintf( stderr, "\nUsage: EXPAND-2 [-o order] " );
            fprintf( stderr, "[-f text file] [-c compressed file]\n" );
            exit( -1 );
	}
	argc--;
	argv++;
    }
    text_file = fopen( text_file_name, "wb" );
    compressed_file = fopen( compressed_file_name, "rb" );
    setvbuf( text_file, NULL, _IOFBF, 4096 );
    setbuf( stdout, NULL );
    printf( "Decoding %s to %s, order %d.\n",
            compressed_file_name ,
            text_file_name,
            max_order );
}

/*
 * This routine is called to print the current compression ratio.
 * It prints out the number of input bytes, the number of output bytes,
 * and the bits per byte compression ratio.   This is done both as a
 * pacifier and as a seat-of-the-pants diagnostice.  A better version
 * of this routine would also print the local compression ratio.
 */
void print_compression()
{
    long input_bytes;
    long output_bytes;

    output_bytes = ftell( text_file );
    input_bytes = bit_ftell_input( compressed_file );
    if ( output_bytes == 0 )
        output_bytes = 1;
    fprintf( stderr,
             "\r%ld/%ld, %2.3f    ",
	     input_bytes,
	     output_bytes,
             8.0 * input_bytes / output_bytes );
}

