/*
 * Listing 13 -- churn.c
 *
 * This is a utility program used to test compression/decompression
 * programs for accuracy, speed, and compression ratios.  Calling
 * CHURN.EXE with a single argument will cause CHURN to compress then
 * decompress every file in the specified directory tree, checking the
 * compression ratio and the accuracy of the operation.  This is a good
 * program to run overnight when you think your new algorithm works
 * properly.
 *
 * This program will presently compile using TopSpeed C, Turbo C/C++,
 * and QuickC.  The DOS directory structure-specific calls aren't
 * portable to *NIX, VMS, etc.  They all need their own versions of
 * of CHURN.C.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <process.h>
#include <conio.h>
#include <dos.h>

/*
 * The findfirst and findnext functions operate nearly identically
 * under TurboC and MSC.  The only difference is that the functions
 * names, structures, and structure elements all have different names.
 * I just create macros for these things and redefine them appropriately
 * here.
 */
#ifdef __TURBOC__

#include <dir.h>
#define FILE_INFO                 struct ffblk
#define FIND_FIRST( name, info )  findfirst( ( name ), ( info ), FA_DIREC )
#define FIND_NEXT( info )         findnext( ( info ) )
#define FILE_IS_DIR( info )       ( ( info ).ff_attrib & FA_DIREC )
#define FILE_NAME( info )         ( ( info ).ff_name )

#else

#define FILE_INFO                 struct find_t
#define FIND_FIRST( name, info )  _dos_findfirst( ( name ), _A_SUBDIR, ( info ) )
#define FIND_NEXT( info )         _dos_findnext( ( info ) )
#define FILE_IS_DIR( info )       ( ( info ).attrib & _A_SUBDIR )
#define FILE_NAME( info )         ( ( info ).name )

#endif

/*
 * Some global variables.
 */
long total_input_bytes;
long total_output_bytes;

/*
 * Declarations for global routines.
 */
void churn_files( char *path );
int file_is_already_compressed( char *name );
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
    time_t start_time;
    time_t stop_time;
    char argument[ 81 ];

    if ( argc < 2 )
        strcpy( argument, "C:\\" );
    else
        strcpy( argument, argv[ 1 ] );
    if ( argument[ strlen( argument ) - 1 ] != '\\' )
       strcat( argument, "\\" );
    total_input_bytes = 0L;
    total_output_bytes = 0L;
    time( &start_time );
    churn_files( argument );
    time( &stop_time );

    printf( "%f seconds\n", difftime( stop_time, start_time ) );
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
    FILE_INFO file_info;
    int result;
    char full_name[ 81 ];

    strcpy( full_name, path );
    strcat( full_name, "*.*" );
    result = FIND_FIRST( full_name, &file_info );

    while ( result == 0 )
    {
        if ( kbhit() )
        {
            getch();
            exit(0);
        }
        if ( FILE_IS_DIR( file_info ) )
        {
            if ( FILE_NAME( file_info )[ 0 ] != '.' )
            {
                strcpy( full_name, path );
                strcat( full_name, FILE_NAME( file_info) );
                strcat( full_name, "\\" );
                churn_files( full_name );
            }
        }
        else
        {
            strcpy( full_name, path );
            strcat( full_name, FILE_NAME( file_info )  );
            if ( !file_is_already_compressed( full_name ) )
            {
                fprintf( stderr, "Testing %s\n", full_name );
                if ( !compress( full_name ) )
                    fprintf( stderr, "Comparison failed!\n" );
            }
        }
        result = FIND_NEXT( &file_info );
    }
}

/*
 * The job of this routine is simply to check on the file
 * whose name is passed as an argument.  The file extension is compared
 * agains a list of standard extensions that are commonly used on
 * compressed files.  If it matches one of these names, we assume it is
 * compressed and return a TRUE, otherwise FALSE is returned.
 */
int file_is_already_compressed( char *name )
{
    char *extension;
    static char *matches[]={ "ZIP", "ICE", "LZH", "ARC", "GIF", "PAK", NULL };
    int i;

    extension=strchr( name, '.' );
    if ( extension++ == NULL )
        return( 0 );
    i = 0;
    while ( matches[ i ] != NULL )
        if ( strcmpi( extension, matches[ i++ ] ) == 0 )
            return( 1 );
    return( 0 );
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
    int c;

    printf( "%s\n", file_name );

    fflush( stdout );
    spawnl( P_WAIT, "COMPRESS.EXE", "COMPRESS", "-f", file_name, NULL );
    spawnl( P_WAIT, "EXPAND.EXE", "EXPAND", NULL );

    input = fopen( file_name, "rb" );
    output = fopen( "test.out", "rb" );
    compressed = fopen( "test.cmp", "rb" );

    if ( input == NULL || output == NULL || compressed == NULL )
    {
        close_all_the_files();
        printf( "Failed, couldn't open file!\n" );
        return( 0 );
    }

    fseek( input, 0L, SEEK_END );
    old_size = ftell( input );
    fseek( input, 0L, SEEK_SET );
    fseek( compressed, 0L, SEEK_END );
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

