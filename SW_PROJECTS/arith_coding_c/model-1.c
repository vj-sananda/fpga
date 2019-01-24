/*
 * Listing 9 -- model-1.c
 *
 * This is the modeling module for an order 0 fixed context
 * data compression program.  This is a relatively simple model.
 * The totals for all of the symbols are stored in an array accessed
 * under the name "totals".  This array has valid indices from -1
 * to 256.  The reason for having a -1 element is because the EOF
 * symbols is included in the table, and it has a value of -1.
 *
 * The total count for all the symbols is stored in totals[256], and
 * the low and high counts for symbol c are found in totals[c] and
 * totals[c+1].  The major performance problem with this is that
 * the update_model() routine on the average will have to increment
 * 128 totals, a very high cost operation.
 */
#include <stdio.h>
#include <stdlib.h>
#include "coder.h"
#include "model.h"

/*
 * In order to create an array with indices -1 through 256, I have
 * to do this funny declaration.  totals[-1] == storage[0].
 */
short int storage[ 258 ];
short int *totals = storage + 1;

/*
 * When the model is first started up, each symbols has a count of
 * 1, which means a low value of c+1, and a high value of c+2.
 */
void initialize_model()
{
    short int i;

    for ( i = -1 ; i <= 256 ; i++ )
        totals[ i ] = i + 1;
}

/*
 * Updating the model means incrementing every single count from
 * the high value for the symbol on up to the total.  Then, there
 * is a complication.  If the cumulative total has gone up to
 * the maximum value, we need to rescale.  Fortunately, the rescale
 * operation is relatively rare.
 */
void update_model( int symbol )
{
    int i;

    for ( symbol++ ; symbol <= 256; symbol++ )
        totals[ symbol ]++;
    if ( totals[ 256 ] == MAXIMUM_SCALE )
    {
        for ( i = 0 ; i <= 256 ; i++ )
	{
            totals[ i ] /= 2;
            if ( totals[ i ] <= totals[ i-1 ] )
                totals[ i ] = totals[ i-1 ] + 1;
	}
    }
}

/*
 * Finding the low count, high count, and scale for a symbol
 * is really easy, because of the way the totals are stored.
 * This is the one redeeming feature of the data structure used
 * in this implementation.  Note that this routine returns an
 * int, but it is not used in this routine.  The return value
 * from convert_int_to_symbol is used in model-2.c.
 */
int convert_int_to_symbol( int c, SYMBOL *s )
{
    s->scale = totals[ 256 ];
    s->low_count = totals[ c ];
    s->high_count = totals[ c+1 ];
    return( 0 );
}

/*
 * Getting the scale for the current context is easy.
 */
void get_symbol_scale( SYMBOL *s )
{
    s->scale = totals[ 256 ];
}

/*
 * During decompression, we have to search through the table until
 * we find the symbol that straddles the "count" parameter.  When
 * it is found, it is returned. The reason for also setting the
 * high count and low count is so that symbol can be properly removed
 * from the arithmetic coded input.
 */
int convert_symbol_to_int( int count, SYMBOL *s)
{
    int c;

    for ( c = 255; count < totals[ c ] ; c-- )
	;
    s->high_count = totals[ c+1 ];
    s->low_count = totals[ c ];
    return( c );
}

