/*
 * Listing 15 -- churnx.c
 *
 * This is a utility program used to test compression/decompression
 * programs for accuracy, speed, and compression ratios.  Calling
 * CHURN.EXE with a single argument will cause CHURN to compress then
 * decompress every file in the specified directory tree, checking the
 * compression ratio and the accuracy of the operation.  This is a good
 * program to run overnight when you think your new algorithm works
 * properly.
 *
 * This program will presently compile on my SCO Xenix system.
 * I don't know if the directory access and time routines are portable
 * to other *NIX systems.
 *
 * To build this program:
 *
 *   cc -o churnx churnx.c -lx
 *
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/ndir.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
 * Some global variables.
 */
long total_input_bytes;
long total_output_bytes;

/*
 * Declarations for global routines.
 */
void churn_files( char *path );
void close_all_the_files( void );
int compress( char *file_name );

/*
 * main() doesn't have to do a whole lot in this program.  It
 * reads in the command line to determine what the root directory
 * to start looking at is, then it initializes the total byte counts
 * and the start time.  It can then call churn_files(), which does all
 * the work, then report on the statistics resulting from churn_files.
 */
void main( int argc, char *argv[] )
{
    long int start_time;
    long int stop_time;
    char argument[ 81 ];

    if ( argc < 2 )
        strcpy( argument, "/" );
    else
        strcpy( argument, argv[ 1 ] );
    total_input_bytes = 0L;
    total_output_bytes = 0L;
    start_time = time( (long *) 0 );
    churn_files( argument );
    stop_time = time( (long *) 0 );
    printf( "%ld seconds elapsed time\n", stop_time - start_time );
    printf( "Total input bytes: %8ld: \n", total_input_bytes );
    printf( "Total output bytes: %8ld: \n", total_output_bytes );
    printf( "Reduction:%ld%%  ",
            100L - ( ( 100L * total_output_bytes) / total_input_bytes ) );
    printf( "Bits per byte: %f\n",
            8.0 * total_output_bytes / total_input_bytes );

}

/*
 * churn_files() is a routine that sits in a loop looking at
 * files in the directory specified by its single argument, "path".
 * As each file is looked at, one of three things happens.  If it
 * is a normal file, and has a compressed extension name, like ".ZIP",
 * the file is ignored.  If it is a normal file, and doesn't have a
 * compressed extension name, it is compressed and decompressed by
 * another routine.  Finally, if the file is a subdirectory,
 * churn_files() is called recursively with the file name as its
 * path argument.  This is one of those rare routines where recursion
 * provides a way to truly simplify the task at hand.
 */
void churn_files( char *path )
{
    DIR *dirp;
    struct direct *entry;
    struct stat buf;
    char full_name[ 81 ];


    dirp = opendir( path );
    if ( dirp == NULL )
    {
	printf( "Error opening directory %s\n", path );
	exit( -1 );
    }
    for ( entry=readdir(dirp) ; entry != NULL ; entry=readdir(dirp) )
    {
	if ( entry->d_name[0] != '.' )
	{
	    strcpy( full_name, path );
	    strcat( full_name, "/" );
	    strcat( full_name, entry->d_name );
	    if ( stat( full_name, &buf ) == -1 )
	    {
		printf( "Error reading stat from file %s!\n", full_name );
		exit( -1 );
	    }
	    if ( buf.st_mode & 040000 )
		churn_files( full_name );
	    else
	    {
                fprintf( stderr, "Testing %s\n", full_name );
                if ( !compress( full_name ) )
                    fprintf( stderr, "Comparison failed!\n" );
	    }
	}
    }
}

/*
 * This is the routine that does the majority of the work for
 * this program.  It takes a file whose name is passed here.  It then
 * compresses, then decompresses that file.  It then compares the file
 * to the decompressed output, and reports on the results.
 */
FILE *input;
FILE *output;
FILE *compressed;

int compress( char *file_name )
{
    long new_size;
    long old_size;
    char command_line[132];
    int c;

    fflush( stdout );
    printf( "%s\n", file_name );
    sprintf( command_line, "./comp-1 -f %s\n", file_name );
    system( command_line );
    sprintf( command_line, "./expand-1\n" );
    system( command_line );
    input = fopen( file_name, "rb" );
    output = fopen( "test.out", "rb" );
    compressed = fopen( "test.cmp", "rb" );

    if ( input == NULL || output == NULL || compressed == NULL )
    {
        close_all_the_files();
        printf( "Failed, couldn't open file!\n" );
        return( 0 );
    }

    fseek( input, 0L, 2 );
    old_size = ftell( input );
    fseek( input, 0L, 0 );
    fseek( compressed, 0L, 2 );
    new_size = ftell( compressed );

    printf( "Old size: %8ld: ", old_size );
    printf( "New size: %8ld\n", new_size );
    if ( old_size == 0L )
        old_size = 1L;
    printf( "Reduction: %ld%%  ",
            100L - ( ( 100L * new_size ) / old_size ) );
    printf( "Bits per byte: %f\n", 8.0 * new_size / old_size );
    total_input_bytes += old_size;
    total_output_bytes += new_size;
    do
    {
        c = getc( input );
        if ( getc( output ) != c )
        {
            printf( "Failed comparison!\n" );
            close_all_the_files();
            return( 0 );
        }
    }
    while ( c != EOF );
    printf( "File compare passed.\n" );
    close_all_the_files();
    return( 1 );
}

void close_all_the_files()
{
    if ( input != NULL )
        fclose( input );
    if ( output != NULL )
        fclose( output );
    if ( compressed != NULL )
        fclose( compressed );
}

