/*
 * Listing 12 -- model-2.c
 *
 * This module contains all of the modeling functions used with
 * comp-2.c and expand-2.c.  This modeling unit keeps track of
 * all contexts from 0 up to max_order, which defaults to 3.
 * In addition, there is a special context -1 which is a fixed model
 * used to encode previously unseen characters, and a context -2
 * which is used to encode EOF and FLUSH messages.
 *
 * Each context is stored in a special CONTEXT structure, which is
 * documented below.  Context tables are not created until the
 * context is seen, and they are never destroyed.
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "coder.h"
#include "model.h"

/*
 * This program consumes massive amounts of memory.  One way to
 * handle large amounts of memory is to use Zortech's __handle
 * pointer type.  So that my code will run with other compilers
 * as well, the handle stuff gets redefined when using other
 * compilers.
 */
#ifdef __ZTC__
#include <handle.h>
#else
#define __handle
#define handle_calloc( a )        calloc( (a), 1 )
#define handle_realloc( a, b )    realloc( (a), (b) )
#define handle_free( a )          free( (a) )
#endif

/* A context table contains a list of the counts for all symbols
 * that have been seen in the defined context.  For example, a
 * context of "Zor" might have only had 2 different characters
 * appear.  't' might have appeared 10 times, and 'l' might have
 * appeared once.  These two counts are stored in the context
 * table.  The counts are stored in the STATS structure.  All of
 * the counts for a given context are stored in and array of STATS.
 * As new characters are added to a particular contexts, the STATS
 * array will grow.  Sometimes, the STATS array will shrink
 * after flushing the model.
 */
typedef struct {
                unsigned char symbol;
                unsigned char counts;
               } STATS;

/*
 * Each context has to have links to higher order contexts.  These
 * links are used to navigate through the context tables.  For example,
 * to find the context table for "ABC", I start at the order 0 table,
 * then find the pointer to the "A" context table by looking through
 * then LINKS array.  At that table, we find the "B" link and go to
 * that table.  The process continues until the destination table is
 * found.  The table pointed to by the LINKS array corresponds to the
 * symbol found at the same offset in the STATS table.  The reason that
 * LINKS is in a separate structure instead of being combined with
 * STATS is to save space.  All of the leaf context nodes don't need
 * next pointers, since they are in the highest order context.  In the
 * leaf nodes, the LINKS array is a NULL pointers.
 */
typedef struct {
                 struct context *next;
               } LINKS;

/*
 * The CONTEXT structure holds all of the know information about
 * a particular context.  The links and stats pointers are discussed
 * immediately above here.  The max_index element gives the maximum
 * index that can be applied to the stats or link array.  When the
 * table is first created, and stats is set to NULL, max_index is set
 * to -1.  As soon as single element is added to stats, max_index is
 * incremented to 0.
 *
 * The lesser context pointer is a navigational aid.  It points to
 * the context that is one less than the current order.  For example,
 * if the current context is "ABC", the lesser_context pointer will
 * point to "BC".  The reason for maintaining this pointer is that
 * this particular bit of table searching is done frequently, but
 * the pointer only needs to be built once, when the context is
 * created.
 */
typedef struct context {
                         int max_index;
                         LINKS __handle *links;
                         STATS __handle *stats;
                         struct context *lesser_context;
                       } CONTEXT;
/*
 * max_order is the maximum order that will be maintained by this
 * program.  EXPAND-2 and COMP-2 both will modify this int based
 * on command line parameters.
 */
int max_order=3;
/*
 * *contexts[] is an array of current contexts.  If I want to find
 * the order 0 context for the current state of the model, I just
 * look at contexts[0].  This array of context pointers is set up
 * every time the model is updated.
 */
CONTEXT **contexts;
/*
 * current_order contains the current order of the model.  It starts
 * at max_order, and is decremented every time an ESCAPE is sent.  It
 * will only go down to -1 for normal symbols, but can go to -2 for
 * EOF and FLUSH.
 */
int current_order;
/*
 * This variable tells COMP-2.C that the FLUSH symbol can be
 * sent using this model.
 */
int flushing_enabled=1;
/*
 * This table contains the cumulative totals for the current context.
 * Because this program is using exclusion, totals has to be calculated
 * every time a context is used.  The scoreboard array keeps track of
 * symbols that have appeared in higher order models, so that they
 * can be excluded from lower order context total calculations.
 */
short int totals[ 258 ];
char scoreboard[ 256 ];

/*
 * Local procedure declarations.
 */
void error_exit( char *message );
void update_table( CONTEXT *table, unsigned char symbol );
void rescale_table( CONTEXT *table );
void totalize_table( CONTEXT *table );
CONTEXT *shift_to_next_context( CONTEXT *table, unsigned char c, int order);
CONTEXT *allocate_next_order_table( CONTEXT *table,
                                    unsigned char symbol,
                                    CONTEXT *lesser_context );

/*
 * This routine has to get everything set up properly so that
 * the model can be maintained properly.  The first step is to create
 * the *contexts[] array used later to find current context tables.
 * The *contexts[] array indices go from -2 up to max_order, so
 * the table needs to be fiddled with a little.  This routine then
 * has to create the special order -2 and order -1 tables by hand,
 * since they aren't quite like other tables.  Then the current
 * context is set to \0, \0, \0, ... and the appropriate tables
 * are built to support that context.  The current order is set
 * to max_order, the scoreboard is cleared, and the system is
 * ready to go.
 */

void initialize_model()
{
    int i;
    CONTEXT *null_table;
    CONTEXT *control_table;

    current_order = max_order;
    contexts = (CONTEXT **) calloc( sizeof( CONTEXT * ), 10 );
    if ( contexts == NULL )
        error_exit( "Failure #1: allocating context table!" );
    contexts += 2;
    null_table = (CONTEXT *) calloc( sizeof( CONTEXT ), 1 );
    if ( null_table == NULL )
        error_exit( "Failure #2: allocating null table!" );
    null_table->max_index = -1;
    contexts[ -1 ] = null_table;
    for ( i = 0 ; i <= max_order ; i++ )
        contexts[ i ] = allocate_next_order_table( contexts[ i-1 ],
                                               0,
                                               contexts[ i-1 ] );
    handle_free( (char __handle *) null_table->stats );
    null_table->stats =
         (STATS __handle *) handle_calloc( sizeof( STATS ) * 256 );
    if ( null_table->stats == NULL )
        error_exit( "Failure #3: allocating null table!" );
    null_table->max_index = 255;
    for ( i=0 ; i < 256 ; i++ )
    {
        null_table->stats[ i ].symbol = (unsigned char) i;
        null_table->stats[ i ].counts = 1;
    }

    control_table = (CONTEXT *) calloc( sizeof(CONTEXT), 1 );
    if ( control_table == NULL )
        error_exit( "Failure #4: allocating null table!" );
    control_table->stats =
         (STATS __handle *) handle_calloc( sizeof( STATS ) * 2 );
    if ( control_table->stats == NULL )
        error_exit( "Failure #5: allocating null table!" );
    contexts[ -2 ] = control_table;
    control_table->max_index = 1;
    control_table->stats[ 0 ].symbol = -FLUSH;
    control_table->stats[ 0 ].counts = 1;
    control_table->stats[ 1 ].symbol =- DONE;
    control_table->stats[ 1 ].counts = 1;

    for ( i = 0 ; i < 256 ; i++ )
        scoreboard[ i ] = 0;
}
/*
 * This is a utility routine used to create new tables when a new
 * context is created.  It gets a pointer to the current context,
 * and gets the symbol that needs to be added to it.  It also needs
 * a pointer to the lesser context for the table that is to be
 * created.  For example, if the current context was "ABC", and the
 * symbol 'D' was read in, add_character_to_model would need to
 * create the new context "BCD".  This routine would get called
 * with a pointer to "BC", the symbol 'D', and a pointer to context
 * "CD".  This routine then creates a new table for "BCD", adds it
 * to the link table for "BC", and gives "BCD" a back pointer to
 * "CD".  Note that finding the lesser context is a difficult
 * task, and isn't done here.  This routine mainly worries about
 * modifying the stats and links fields in the current context.
 */

CONTEXT *allocate_next_order_table( CONTEXT *table,
                                    unsigned char symbol,
                                    CONTEXT *lesser_context )
{
    CONTEXT *new_table;
    int i;
    unsigned int new_size;

    for ( i = 0 ; i <= table->max_index ; i++ )
        if ( table->stats[ i ].symbol == symbol )
            break;
    if ( i > table->max_index )
    {
        table->max_index++;
        new_size = sizeof( LINKS );
        new_size *= table->max_index + 1;
        if ( table->links == NULL )
            table->links = (LINKS __handle *) handle_calloc( new_size );
        else
            table->links = (LINKS __handle *)
                 handle_realloc( (char __handle *) table->links, new_size );
        new_size = sizeof( STATS );
        new_size *= table->max_index + 1;
        if ( table->stats == NULL )
            table->stats = (STATS __handle *) handle_calloc( new_size );
        else
            table->stats = (STATS __handle *)
                handle_realloc( (char __handle *) table->stats, new_size );
        if ( table->links == NULL )
            error_exit( "Failure #6: allocating new table" );
        if ( table->stats == NULL )
            error_exit( "Failure #7: allocating new table" );
        table->stats[ i ].symbol = symbol;
        table->stats[ i ].counts = 0;
    }
    new_table = (CONTEXT *) calloc( sizeof( CONTEXT ), 1 );
    if ( new_table == NULL )
        error_exit( "Failure #8: allocating new table" );
    new_table->max_index = -1;
    table->links[ i ].next = new_table;
    new_table->lesser_context = lesser_context;
    return( new_table );
}

/*
 * This routine is called to increment the counts for the current
 * contexts.  It is called after a character has been encoded or
 * decoded.  All it does is call update_table for each of the
 * current contexts, which does the work of incrementing the count.
 * This particular version of update_model() practices update exclusion,
 * which means that if lower order models weren't used to encode
 * or decode the character, they don't get their counts updated.
 * This seems to improve compression performance quite a bit.
 * To disable update exclusion, the loop would be changed to run
 * from 0 to max_order, instead of current_order to max_order.
 */
void update_model( int symbol )
{
    int i;
    int local_order;

    if ( current_order < 0 )
        local_order = 0;
    else
        local_order = current_order;
    if ( symbol >= 0 )
    {
        while ( local_order <= max_order )
        {
            if ( symbol >= 0 )
                update_table( contexts[ local_order ], (unsigned char) symbol );
            local_order++;
        }
    }
    current_order = max_order;
    for ( i = 0 ; i < 256 ; i++ )
        scoreboard[ i ] = 0;
}
/*
 * This routine is called to update the count for a particular symbol
 * in a particular table.  The table is one of the current contexts,
 * and the symbol is the last symbol encoded or decoded.  In principle
 * this is a fairly simple routine, but a couple of complications make
 * things a little messier.  First of all, the given table may not
 * already have the symbol defined in its statistics table.  If it
 * doesn't, the stats table has to grow and have the new guy added
 * to it.  Secondly, the symbols are kept in sorted order by count
 * in the table so as that the table can be trimmed during the flush
 * operation.  When this symbol is incremented, it might have to be moved
 * up to reflect its new rank.  Finally, since the counters are only
 * bytes, if the count reaches 255, the table absolutely must be rescaled
 * to get the counts back down to a reasonable level.
 */
void update_table( CONTEXT *table, unsigned char symbol )
{
    int i;
    int index;
    unsigned char temp;
    CONTEXT *temp_ptr;
    unsigned int new_size;
/*
 * First, find the symbol in the appropriate context table.  The first
 * symbol in the table is the most active, so start there.
 */
    index = 0;
    while ( index <= table->max_index &&
            table->stats[index].symbol != symbol )
        index++;
    if ( index > table->max_index )
    {
        table->max_index++;
        new_size = sizeof( LINKS );
        new_size *= table->max_index + 1;
        if ( current_order < max_order )
        {
            if ( table->max_index == 0 )
                table->links = (LINKS __handle *) handle_calloc( new_size );
            else
                table->links = (LINKS __handle *)
                   handle_realloc( (char __handle *) table->links, new_size );
            if ( table->links == NULL )
                error_exit( "Error #9: reallocating table space!" );
            table->links[ index ].next = NULL;
        }
        new_size = sizeof( STATS );
        new_size *= table->max_index + 1;
        if (table->max_index==0)
            table->stats = (STATS __handle *) handle_calloc( new_size );
        else
            table->stats = (STATS __handle *)
                handle_realloc( (char __handle *) table->stats, new_size );
        if ( table->stats == NULL )
            error_exit( "Error #10: reallocating table space!" );
        table->stats[ index ].symbol = symbol;
        table->stats[ index ].counts = 0;
    }
/*
 * Now I move the symbol to the front of its list.
 */
    i = index;
    while ( i > 0 &&
            table->stats[ index ].counts == table->stats[ i-1 ].counts )
        i--;
    if ( i != index )
    {
        temp = table->stats[ index ].symbol;
        table->stats[ index ].symbol = table->stats[ i ].symbol;
        table->stats[ i ].symbol = temp;
        if ( table->links != NULL )
        {
            temp_ptr = table->links[ index ].next;
            table->links[ index ].next = table->links[ i ].next;
            table->links[ i ].next = temp_ptr;
        }
        index = i;
    }
/*
 * The switch has been performed, now I can update the counts
 */
    table->stats[ index ].counts++;
    if ( table->stats[ index ].counts == 255 )
        rescale_table( table );
}

/*
 * This routine is called when a given symbol needs to be encoded.
 * It is the job of this routine to find the symbol in the context
 * table associated with the current table, and return the low and
 * high counts associated with that symbol, as well as the scale.
 * Finding the table is simple.  Unfortunately, once I find the table,
 * I have to build the table of cumulative counts, which is
 * expensive, and is done elsewhere.  If the symbol is found in the
 * table, the appropriate counts are returned.  If the symbols is
 * not found, the ESCAPE symbol probabilities are returned, and
 * the current order is reduced.  Note also the kludge to support
 * the order -2 character set, which consists of negative numbers
 * instead of unsigned chars.  This insures that no match will every
 * be found for the EOF or FLUSH symbols in any "normal" table.
 */
int convert_int_to_symbol( int c, SYMBOL *s )
{
    int i;
    CONTEXT *table;

    table = contexts[ current_order ];
    totalize_table( table );
    s->scale = totals[ 0 ];
    if ( current_order == -2 )
        c = -c;
    for ( i = 0 ; i <= table->max_index ; i++ )
    {
        if ( c == (int) table->stats[ i ].symbol )
        {
            if ( table->stats[ i ].counts == 0 )
                break;
            s->low_count = totals[ i+2 ];
            s->high_count = totals[ i+1 ];
            return( 0 );
        }
    }
    s->low_count = totals[ 1 ];
    s->high_count = totals[ 0 ];
    current_order--;
    return( 1 );
}
/*
 * This routine is called when decoding an arithmetic number.  In
 * order to decode the present symbol, the current scale in the
 * model must be determined.  This requires looking up the current
 * table, then building the totals table.  Once that is done, the
 * cumulative total table has the symbol scale at element 0.
 */
void get_symbol_scale( SYMBOL *s )
{
    CONTEXT *table;

    table = contexts[ current_order ];
    totalize_table( table );
    s->scale = totals[ 0 ];
}

/*
 * This routine is called during decoding.  It is given a count that
 * came out of the arithmetic decoder, and has to find the symbol that
 * matches the count.  The cumulative totals are already stored in the
 * totals[] table, form the call to get_symbol_scale, so this routine
 * just has to look through that table.  Once the match is found,
 * the appropriate character is returned to the caller.  Two possible
 * complications.  First, the character might be the ESCAPE character,
 * in which case the current_order has to be decremented.  The other
 * complication is that the order might be -2, in which case we return
 * the negative of the symbol so it isn't confused with a normal
 * symbol.
 */
int convert_symbol_to_int( int count, SYMBOL *s)
{
    int c;
    CONTEXT *table;

    table = contexts[ current_order ];
    for ( c = 0; count < totals[ c ] ; c++ )
        ;
    s->high_count = totals[ c-1 ];
    s->low_count = totals[ c ];
    if ( c == 1 )
    {
        current_order--;
        return( ESCAPE );
    }
    if ( current_order < -1 )
        return( (int) -table->stats[ c-2 ].symbol );
    else
        return( table->stats[ c-2 ].symbol );
}


/*
 * After the model has been updated for a new character, this routine
 * is called to "shift" into the new context.  For example, if the
 * last context was "ABC", and the symbol 'D' had just been processed,
 * this routine would want to update the context pointers to that
 * contexts[1]=="D", contexts[2]=="CD" and contexts[3]=="BCD".  The
 * potential problem is that some of these tables may not exist.
 * The way this is handled is by the shift_to_next_context routine.
 * It is passed a pointer to the "ABC" context, along with the symbol
 * 'D', and its job is to return a pointer to "BCD".  Once we have
 * "BCD", we can follow the lesser context pointers in order to get
 * the pointers to "CD" and "C".  The hard work was done in
 * shift_to_context().
 */
void add_character_to_model( int c )
{
    int i;
    if ( max_order < 0 || c < 0 )
       return;
    contexts[ max_order ] =
       shift_to_next_context( contexts[ max_order ],
                              (unsigned char) c, max_order );
    for ( i = max_order-1 ; i > 0 ; i-- )
        contexts[ i ] = contexts[ i+1 ]->lesser_context;
}

/*
 * This routine is called when adding a new character to the model. From
 * the previous example, if the current context was "ABC", and the new
 * symbol was 'D', this routine would get called with a pointer to
 * context table "ABC", and symbol 'D', with order max_order.  What this
 * routine needs to do then is to find the context table "BCD".  This
 * should be an easy job, and it is if the table already exists.  All
 * we have to in that case is follow the back pointer from "ABC" to "BC".
 * We then search the link table of "BC" until we find the linke to "D".
 * That link points to "BCD", and that value is then returned to the
 * caller.  The problem crops up when "BC" doesn't have a pointer to
 * "BCD".  This generally means that the "BCD" context has not appeared
 * yet.  When this happens, it means a new table has to be created and
 * added to the "BC" table.  That can be done with a single call to
 * the allocate_new_table routine.  The only problem is that the
 * allocate_new_table routine wants to know what the lesser context for
 * the new table is going to be.  In other words, when I create "BCD",
 * I need to know where "CD" is located.  In order to find "CD", I
 * have to recursively call shift_to_next_context, passing it a pointer
 * to context "C" and they symbol 'D'.  It then returns a pointer to
 * "CD", which I use to create the "BCD" table.  The recursion is guaranteed
 * to end if it ever gets to order -1, because the null table is
 * guaranteed to have a for every symbol to the order 0 table.  This is
 * the most complicated part of the modeling program, but it is
 * necessary for performance reasons.
 */
CONTEXT *shift_to_next_context( CONTEXT *table, unsigned char c, int order)
{
    int i;
    CONTEXT *new_lesser;
/*
 * First, try to find the new context by backing up to the lesser
 * context and searching its link table.  If I find the link, we take
 * a quick and easy exit, returning the link.  Note that their is a
 * special Kludge for context order 0.  We know for a fact that
 * the lesser context pointer at order 0 points to the null table,
 * order -1, and we know that the -1 table only has a single link
 * pointer, which points back to the order 0 table.
 */
    table = table->lesser_context;
    if ( order == 0 )
        return( table->links[ 0 ].next );
    for ( i = 0 ; i <= table->max_index ; i++ )
        if ( table->stats[ i ].symbol == c )
            if ( table->links[ i ].next != NULL )
                return( table->links[ i ].next );
            else
                break;
/*
 * If I get here, it means the new context did not exist.  I have to
 * create the new context, add a link to it here, and add the backwards
 * link to *his* previous context.  Creating the table and adding it to
 * this table is pretty easy, but adding the back pointer isn't.  Since
 * creating the new back pointer isn't easy, I duck my responsibility
 * and recurse to myself in order to pick it up.
 */
    new_lesser = shift_to_next_context( table, c, order-1 );
/*
 * Now that I have the back pointer for this table, I can make a call
 * to a utility to allocate the new table.
 */
    table = allocate_next_order_table( table, c, new_lesser );
    return( table );
}

/*
 * Rescaling the table needs to be done for one of three reasons.
 * First, if the maximum count for the table has exceeded 16383, it
 * means that arithmetic coding using 16 and 32 bit registers might
 * no longer work.  Secondly, if an individual symbol count has
 * reached 255, it will no longer fit in a byte.  Third, if the
 * current model isn't compressing well, the compressor program may
 * want to rescale all tables in order to give more weight to newer
 * statistics.  All this routine does is divide each count by 2.
 * If any counts drop to 0, the counters can be removed from the
 * stats table, but only if this is a leaf context.  Otherwise, we
 * might cut a link to a higher order table.
 */
void rescale_table( CONTEXT *table )
{
    int i;

    if ( table->max_index == -1 )
        return;
    for ( i = 0 ; i <= table->max_index ; i++ )
        table->stats[ i ].counts /= 2;
    if ( table->stats[ table->max_index ].counts == 0 &&
         table->links == NULL )
    {
        while ( table->stats[ table->max_index ].counts == 0 &&
                table->max_index >= 0 )
            table->max_index--;
        if ( table->max_index == -1 )
        {
            handle_free( (char __handle *) table->stats );
            table->stats = NULL;
        }
        else
        {
            table->stats = (STATS __handle *)
                handle_realloc( (char __handle *) table->stats,
                                 sizeof( STATS ) * ( table->max_index + 1 ) );
            if ( table->stats == NULL )
                error_exit( "Error #11: reallocating stats space!" );
        }
    }
}

/*
 * This routine has the job of creating a cumulative totals table for
 * a given context.  The cumulative low and high for symbol c are going to
 * be stored in totals[c+2] and totals[c+1].  Locations 0 and 1 are
 * reserved for the special ESCAPE symbol.  The ESCAPE symbol
 * count is calculated dynamically, and changes based on what the
 * current context looks like.  Note also that this routine ignores
 * any counts for symbols that have already showed up in the scoreboard,
 * and it adds all new symbols found here to the scoreboard.  This
 * allows us to exclude counts of symbols that have already appeared in
 * higher order contexts, improving compression quite a bit.
 */
void totalize_table( CONTEXT *table )
{
    int i;
    unsigned char max;

    for ( ; ; )
    {
        max = 0;
        i = table->max_index + 2;
        totals[ i ] = 0;
        for ( ; i > 1 ; i-- )
        {
            totals[ i-1 ] = totals[ i ];
            if ( table->stats[ i-2 ].counts )
                if ( ( current_order == -2 ) ||
                     scoreboard[ table->stats[ i-2 ].symbol ] == 0 )
                     totals[ i-1 ] += table->stats[ i-2 ].counts;
            if ( table->stats[ i-2 ].counts > max )
                max = table->stats[ i-2 ].counts;
        }
/*
 * Here is where the escape calculation needs to take place.
 */
        if ( max == 0 )
            totals[ 0 ] = 1;
        else
        {
            totals[ 0 ] = (short int) ( 256 - table->max_index );
            totals[ 0 ] *= table->max_index;
            totals[ 0 ] /= 256;
            totals[ 0 ] /= max;
            totals[ 0 ]++;
            totals[ 0 ] += totals[ 1 ];
        }
        if ( totals[ 0 ] < MAXIMUM_SCALE )
            break;
        rescale_table( table );
    }
    for ( i = 0 ; i < table->max_index ; i++ )
	if (table->stats[i].counts != 0)
            scoreboard[ table->stats[ i ].symbol ] = 1;
}

/*
 * This routine is called when the entire model is to be flushed.
 * This is done in an attempt to improve the compression ratio by
 * giving greater weight to upcoming statistics.  This routine
 * starts at the given table, and recursively calls itself to
 * rescale every table in its list of links.  The table itself
 * is then rescaled.
 */
void recursive_flush( CONTEXT *table )
{
    int i;

    if ( table->links != NULL )
        for ( i = 0 ; i <= table->max_index ; i++ )
            if ( table->links[ i ].next != NULL )
                recursive_flush( table->links[ i ].next );
    rescale_table( table );
}

/*
 * This routine is called to flush the whole table, which it does
 * by calling the recursive flush routine starting at the order 0
 * table.
 */
void flush_model()
{
    recursive_flush( contexts[ 0 ] );
}

void error_exit( char *message)
{
    putc( '\n', stdout );
    puts( message );
    exit( -1 );
}


