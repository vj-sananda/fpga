/*
 * Listing 3 -- bitio.h
 *
 * This header file contains the function prototypes needed to use
 * the bitstream i/o routines.
 *
 */
short int input_bit( FILE *stream );
void initialize_output_bitstream( void );
void output_bit( FILE *stream, int bit );
void flush_output_bitstream( FILE *stream );
void initialize_input_bitstream( void );
long bit_ftell_output( FILE *stream );
long bit_ftell_input( FILE *stream );

