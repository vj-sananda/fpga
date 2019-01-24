#include "canscid-types.h"
#include <iostream>
#include <fstream>
#include <cstdlib>
using namespace std;

// 50 MB of flits, + 50 MB of tags is the default.
int flitQueueSize = 1310720;

#ifdef PLATFORM_X86

#include <time.h>

// Open a binary file from the disk and read it in for the benchmark data.

PACKET_FLIT* readBenchmarkData()
{ 
    PACKET_FLIT* q = new PACKET_FLIT[flitQueueSize];
    
    char* benchmark_name = getenv("CANSCID_BENCHMARK");
    
    if (benchmark_name == NULL)
    {
        fprintf(stderr, "CANSCID_BENCHMARK environment variable is not set!\n");
        std::exit(1);
    }
    
    ifstream infile(benchmark_name, ios::in | ios::binary);
    if (!infile.is_open())
    {
        fprintf(stderr, "Error opening benchmark file: %s\n", benchmark_name);
        std::exit(1);
    }
    
    // If we are on a little-endian platform this will do.
    // People porting to big-endian will have to do more work here.
    infile.read((char*)q, flitQueueSize * sizeof(PACKET_FLIT));

    infile.close();
    return q;   
}

PACKET_FLIT* flitQueue = readBenchmarkData();

static double time_start, time_end;

void startTiming()
{
    time_start = clock();
}

void endTiming()
{
    time_end = clock();
}

double getProcessingTime()
{
    return (time_end - time_start) / CLOCKS_PER_SEC;
}

#elif PLATFORM_XILINX_MB

// Set a pointer to a given location. XMD will set the memory at this location to the test data.
PACKET_FLIT* flitQueue = (PACKET_FLIT*) 0x98000000;

// Magic pointer to our counter device.
unsigned* counter = (unsigned*)0x83000000;

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

#endif
