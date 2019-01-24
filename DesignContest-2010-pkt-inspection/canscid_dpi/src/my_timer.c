
// Located in: microblaze_0/include/xparameters.h
#include "my_timer.h"

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//From Reference design
// Set a pointer to a given location. XMD will set the memory at this location to the test data.
//PACKET_FLIT* flitQueue = (PACKET_FLIT*) 0x98000000;

// Magic pointer to our counter device.
//unsigned* counter = (unsigned*)0x83000000;
unsigned* counter = (unsigned*)XPAR_MY_TIMER_0_BASEADDR;

void startTiming()
{
    counter[0] = 1;
    counter[1] = 1;
}

void endTiming()
{ 
    counter[2] = 1;
}

double getProcessingTime()
{

    unsigned c1 = counter[0];
    unsigned c2 = counter[1];
    long long unsigned c1L = (long long unsigned) c1;
    long long unsigned c2L = (long long unsigned) c2;
    long long unsigned c = (c2L << 32) + c1L;
    // debug_printf(DEBUG_HIGH_DETAIL, "Count: %llu %u %u\n", c, c2, c1);
    return (double) c / 125000000;
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

