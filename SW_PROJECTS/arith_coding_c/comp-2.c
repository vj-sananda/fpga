/*
 * Listing 10 -- comp-2.c
 *
 * This module is the driver program for a variable order
 * finite context compression program.  The maximum order is
 * determined by command line option.  This particular version
 * also monitors compression ratios, and flushes the model whenever
 * the local (last 256 symbols) compression ratio hits 90% or higher.
 *
 * To build this program:
 *
 * Turbo C:     tcc -w -mc comp-2.c model-2.c bitio.c coder.c
 * QuickC:      qcl /AC /W3 comp-2.c model-2.c bitio.c coder.c
 * Zortech:     ztc -mc comp-2.c model-2.c bitio.c coder.c
 * *NIX:        cc -o comp-2 comp-2.c model-2.c bitio.c coder.c
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
 * The file pointers are used throughout this module.
 */
FILE *text_file;
FILE *compressed_file;

/*
 * Declarations for local procedures.
 */
void initialize_options( int argc, char **argv );
int check_compression( void );
void print_compression( void );

/*
 * The main procedure is similar to the main found in COMP-1.C.
 * It has to initialize the coder, the bit oriented I/O, the
 * standard I/O, and the model.  It then sits in a loop reading
 * input symbols and encoding them.  One difference is that every
 * 256 symbols a compression check is performed.  If the compression
 * ratio exceeds 90%, a flush character is encoded.  This flushes
 * the encoding model, and will cause the decoder to flush its model
 * when the file is being expanded.  The second difference is that
 * each symbol is repeatedly encoded until a succesfull encoding
 * occurs.  When trying to encode a character in a particular order,
 * the model may have to transmit an ESCAPE character.  If this
 * is the case, the character has to be retransmitted using a lower
 * order.  This process repeats until a succesful match is found of
 * the symbol in a particular context.  Usually this means going down
 * no further than the order -1 model.  However, the FLUSH and DONE
 * symbols do drop back to the order -2 model.  Note also that by
 * all rights, add_character_to_model() and update_model() logically
 * should be combined into a single routine.
 */
void main( int argc, char **argv )
{
    SYMBOL s;
    int c;
    int escaped;
    int flush = 0;
    long int text_count = 0;

    initialize_options( --argc, ++argv );
    initialize_model();
    initialize_output_bitstream();
    initialize_arithmetic_encoder();
    for ( ; ; )
    {
	if ( ( ++text_count & 0x0ff ) == 0 )
            flush = check_compression();
        if ( !flush )
            c = getc( text_file );
        else
            c = FLUSH;
        if ( c == EOF )
            c = DONE;
        do {
            escaped = convert_int_to_symbol( c, &s );
            encode_symbol( compressed_file, &s );
        } while ( escaped );
        if ( c == DONE )
	    break;
        if ( c == FLUSH )
	{
	    flush_model();
            flush = 0;
	}
        update_model( c );
        add_character_to_model( c );
    }
    flush_arithmetic_encoder( compressed_file );
    flush_output_bitstream( compressed_file );
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
        else if ( strcmp( *argv, "-o" ) == 0 )
	{
	    argc--;
            max_order = atoi( *++argv );
	}
	else
	{
            fprintf( stderr, "\nUsage: COMP-2 [-o order] " );
            fprintf( stderr, "[-f text file] [-c compressed file]\n" );
            exit( -1 );
	}
	argc--;
	argv++;
    }
    text_file = fopen( text_file_name, "rb" );
    compressed_file = fopen( "test.cmp", "wb" );
    if ( text_file == NULL || compressed_file == NULL )
    {
        printf( "Had trouble opening one of the files!\n" );
        exit( -1 );
    }
    setvbuf( text_file, NULL, _IOFBF, 4096 );
    setbuf( stdout, NULL );
    printf( "Compressing %s to %s, order %d.\n",
            text_file_name,
            compressed_file_name,
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
    long total_input_bytes;
    long total_output_bytes;

    total_input_bytes  =  ftell( text_file );
    total_output_bytes = bit_ftell_output( compressed_file );
    if ( total_output_bytes == 0 )
        total_output_bytes = 1;

    fprintf( stderr,"%ld/%ld, %2.3f\r",
	     total_input_bytes,
	     total_output_bytes,
             8.0 * total_output_bytes / total_input_bytes );
}

/*
 * This routine is called once every 256 input symbols.  Its job is to
 * check to see if the compression ratio hits or exceeds 90%.  If the
 * output size is 90% of the input size, it means not much compression
 * is taking place, so we probably ought to flush the statistics in the
 * model to allow for more current statistics to have greater impactic.
 * This heuristic approach does seem to have some effect.
 */
int check_compression()
{
    static long local_input_marker = 0L;
    static long local_output_marker = 0L;
    long total_input_bytes;
    long total_output_bytes;
    int local_ratio;

    print_compression();
    total_input_bytes  =  ftell( text_file ) - local_input_marker;
    total_output_bytes = bit_ftell_output( compressed_file );
    total_output_bytes -= local_output_marker;
    if ( total_output_bytes == 0 )
        total_output_bytes = 1;
    local_ratio = (int)( ( total_output_bytes * 100 ) / total_input_bytes );

    local_input_marker = ftell( text_file );
    local_output_marker = bit_ftell_output( compressed_file );

    if ( local_ratio > 90 && flushing_enabled )
    {
        fprintf( stderr, "Flushing... \r" );
        return( 1 );
    }
    return( 0 );
}


