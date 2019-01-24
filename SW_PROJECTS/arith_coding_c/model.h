/*
 * Listing 8 -- model.h
 *
 * This file contains all of the function prototypes and
 * external variable declarations needed to interface with
 * the modeling code found in model-1.c or model-2.c.
 */

/*
 * Eternal variable declarations.
 */
extern int max_order;
extern int flushing_enabled;
/*
 * Prototypes for routines that can be called from MODEL-X.C
 */
void initialize_model( void );
void update_model( int symbol );
int convert_int_to_symbol( int symbol, SYMBOL *s );
void get_symbol_scale( SYMBOL *s );
int convert_symbol_to_int( int count, SYMBOL *s );
void add_character_to_model( int c );
void flush_model( void );

