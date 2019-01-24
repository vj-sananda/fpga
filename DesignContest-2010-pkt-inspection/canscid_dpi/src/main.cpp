#include "canscid-types.h"
#include "debug.h"
#include "canscid.h"
#include "simulated-ethernet.h"

// These timing functions are determined in a platform-specific manner.
extern void startTiming();
extern void endTiming();
extern double getProcessingTime();

static SIMULATED_ETHERNET simulatedEthernet;
static CANSCID canscid;

int 
main(int argc, char ** argv)
{
    
    canscid_printf("Starting stream processing...\n\n");
    startTiming();

    while (!simulatedEthernet.endOfAllStreams())
    {
        PACKET_FLIT next = simulatedEthernet.getNextFlit();
        canscid.process(next);
    }

    endTiming();
        
    canscid_printf("*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***\n\n");
    canscid_printf("Processing finished...\n\n");
    canscid_printf("Total suspicious packets: %d\n", canscid.getTotalSuspiciousPackets());
    canscid_printf("Total streams of each category:\n");

    for (int x = 0; x < NUM_CATEGORIES; x++)
    {
        canscid_printf("%15s: %8d (suspicious packets: %d)\n", categoryName((CONN_CATEGORY)x), canscid.getTotalStreamsForCategory((CONN_CATEGORY)x), canscid.getTotalSuspiciousPacketsForCategory((CONN_CATEGORY)x));
    }
    
    canscid_printf("  uncategorized: %8d (suspicious packets: %d)\n", canscid.getTotalStreamsUncategorized(), canscid.getTotalSuspiciousPacketsUncategorized());

    double proc_time = getProcessingTime();
    canscid_printf("Total processing time: %lf seconds\n", proc_time);
    
    int input_size_in_bits = simulatedEthernet.getInputSizeInBits();
    canscid_printf("Input size in bits: %d\n", input_size_in_bits);

    // Note: Speed calculations use 1,000 instead of 1,024. 
    // This is apparently a common misconception.
    double proc_rate = ((double) input_size_in_bits) / 1000000 / proc_time;
    canscid_printf("Average processing rate: %.6lf Mb/s\n", proc_rate);
    
    if (proc_rate >= REQUIRED_LINE_RATE)
    {
        canscid_printf("Application meets required line rate.\n");
    }
    else
    {
        canscid_printf("Application FAILED to meet required line rate.\n");
    }

    return 0;
}
