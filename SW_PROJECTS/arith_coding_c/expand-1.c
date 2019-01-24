/*
 * Listing 7 -- expand-1.c
 *
 * This listing is the driver program for the decompression routine
 * using the order 0 fixed context model.  It follows the model
 * shown in BILL.C for a decompression program, by reading in
 * high, low, range values from the arithmetic coder, converting
 * them to integer symbols using the model code.  Finally, the
 * character is removed from the input code, and the model is updated.
 * When an EOF is detected, the program exits.
 *
 * To build this program:
 *
 * Turbo C:     tcc -w expand-1.c model-1.c bitio.c coder.c
 * QuickC:      qcl /W3 expand-1.c model-1.c bitio.c coder.c
 * Zortech:     ztc expand-1.c model-1.c bitio.c coder.c
 * *NIX:        cc -o expand-1 expand-1.c model-1.c bitio.c coder.c
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

/*
 * Local function prototypes.
 */
void initialize_options( int argc, char **argv );
void print_compression(void);

/*
 * The two file names are used by several routines in this module.
 */
FILE *text_file;
FILE *compressed_file;

/*
 * The main procedure here is a simple straight-line piece of code.
 * first, the files, model, bit-oriented I/O, and the arithmetic
 * decoder are all initialized.  Then, the program sits in a loop
 * reading in symbol ranges, converting them, writing them out to
 * the text file, and updating the model.  When this is all done,
 * a little clean up activity takes place, and the program exits.
 */
void main( int argc, char *argv[] )
{
    SYMBOL s;
    int c;
    long int counter = 0;
    int count;

    initialize_options( --argc, ++argv );
    initialize_model();
    initialize_input_bitstream();
    initialize_arithmetic_decoder( compressed_file );
    for ( ; ; )
    {
	get_symbol_scale( &s );
	count = get_current_count( &s );
	c = convert_symbol_to_int( count, &s );
	remove_symbol_from_stream( compressed_file, &s );
	if ( c == EOF )
            break;
	//        if ( ( ++counter & 0xff ) == 0 )
	//print_compression();
        putc( (char) c, text_file );
	update_model( c );
    }
    print_compression();
    fputc( '\n', stderr );
    exit( 0 );
}

/*
 * This routine reads in the command line options and opens the input
 * and output files.  The only command line options for this piece of
 * code are the input and output file names.
 *
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
	else
	{
            fprintf( stderr,
              "\nUsage: EXPAND-1 [-f text file] [-c compressed file]\n" );
	    exit( -1 );
	}
	argc--;
	argv++;
    }
    text_file = fopen( text_file_name, "wb" );
    compressed_file = fopen( compressed_file_name, "rb" );

    if ( text_file==NULL || compressed_file==NULL )
    {
        printf( "Had trouble opening one of the files!\n" );
        exit( -1 );
    }
    setvbuf( text_file, NULL, _IOFBF, 4096 );
    setbuf( stdout, NULL );
    printf( "Expanding %s to %s\n", compressed_file_name, text_file_name );
}

/*
 * This is a pacifier routine that is called to print out the
 * compression ratio once every 256 characters.  It prints out the
 * input byte count, the output byte count, and the current ratio
 * of bits per byte.
 */
void print_compression()
{
    long input_bytes;
    long output_bytes;

    output_bytes = ftell( text_file );
    input_bytes = bit_ftell_input( compressed_file );
    if ( output_bytes == 0 )
        output_bytes = 1;
    fprintf( stderr,"\r%ld/%ld, %2.3f     ",
	     input_bytes,
	     output_bytes,
             8.0 * input_bytes / output_bytes );

}

