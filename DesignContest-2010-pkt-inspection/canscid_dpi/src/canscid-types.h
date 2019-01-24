
#ifndef CANSCID_TYPES_H
#define CANSCID_TYPES_H

// Constants for the whole design. 
// These probably shouldn't change without a REALLY good reason.

#define MAX_ACTIVE_CONNECTIONS 64
#define REQUIRED_LINE_RATE 500

// A Connection ID.
typedef int CONN_ID; // should be Log(MAX_CONNECTIONS)

// The types of connections.

#define NUM_CATEGORIES 35

typedef enum 
{
  // Mandatory Categories:
  CONN_finger,
  CONN_ftp,
  CONN_http,
  CONN_imap,
  CONN_netbios,
  CONN_nntp,
  CONN_pop3,
  CONN_rlogin,
  CONN_smtp,
  CONN_telnet,
  // Optional Categories with no intrusion detection:
  CONN_aim,
  CONN_bittorrent,
  CONN_cvs,
  CONN_dhcp,
  CONN_directconnect,
  CONN_dns,
  CONN_fasttrack,
  CONN_freenet,
  CONN_gnutella,
  CONN_gopher,
  CONN_irc,
  CONN_jabber,
  CONN_msn,
  CONN_napster,
  CONN_sip,
  CONN_snmp,
  CONN_socks,
  CONN_ssh,
  CONN_ssl,
  CONN_subversion,
  CONN_tor,
  CONN_vnc,
  CONN_worldofwarcraft,
  CONN_yahoo,
  CONN_x11
} 
CONN_CATEGORY;

// Convenience typedefs for packets.
typedef int IP_ADDR; // should be 32 bits
typedef int PORTS; // should be {16 bits, 16 bits}
typedef int TCP_FLAGS; // should be 8 bits
typedef int TCP_SEQNO; // should be 32 bits
typedef int PAYLOAD_LEN; // should be 16 bits
typedef int PAYLOAD; // should be 32 bits

// A packet UID is just an absolute index of the packet
// in the incoming stream. Used for reporting error
// messages.

typedef int PACKET_UID; // should be 32 bits

// Each packet is passed as a series of FLITS.
// We represent each FLIT as a "tagged union" - IE
// a union where the tag indicates which type of data
// is currently present in the union.

// We hand-define the following enum, packing it into a single byte.

/*
typedef enum
{
    FLIT_SRC,       
    FLIT_DST,       
    FLIT_PORT_PAIR, 
    FLIT_FLAGS,     
    FLIT_PLEN,      
    FLIT_SEQNO,     
    FLIT_PAYLOAD    
}
PACKET_FLIT_TYPE;
*/

// The following code is uglier than this enum, but saves a lot of space,
// which can make a big difference if you're downloading over a serial
// cable.
typedef unsigned char PACKET_FLIT_TYPE;

// Flit is a 32-bit IP address of the source
#define FLIT_SRC 0
// Flit is a 32-bit IP address of the destination
#define FLIT_DST 1
// Flit is a 32-bit number representing 2 16-bit port ids (src, dst)
#define FLIT_PORT_PAIR 2
// Flit is TCP Flags. Used only to check for the FIN flag.
#define FLIT_FLAGS 3
// Flit is the Packet Length. The simulated ethernet inserts 
// a PLEN 0 Flit to indicate end-of-packet.
#define FLIT_PLEN 4
// Flit is the TCP sequence number. This can be ignored since
// we assume all packets arrive in order.
#define FLIT_SEQNO 5
// Flit is part of a packet payload.
#define FLIT_PAYLOAD 6

typedef union mkPACKET_FLIT_DATA
{
    IP_ADDR     src;
    IP_ADDR     dst;
    PORTS       ports;
    TCP_FLAGS   flags;
    PAYLOAD_LEN length;
    TCP_SEQNO   seqno;
    PAYLOAD     payload;
}
PACKET_FLIT_DATA;

struct mkPACKET_FLIT
{
    PACKET_FLIT_TYPE tag;
    PACKET_FLIT_DATA data;
}__attribute__((__packed__)); // The packed attribute means this fits in 5 bytes instead of 8.
typedef mkPACKET_FLIT PACKET_FLIT;

// Here is a code template you can use to switch
// on the PACKET_FLIT data type.

/*

// Check what we should do based on the flit tag.
switch (flit.tag)
{
    case FLIT_SRC:
    {
        IP_ADDR src = flit.data.src;
        // Do something...
        break;
    }
    case FLIT_DST:
    {
        IP_ADDR dst = flit.data.dst;
        // Do something...
        break;
    }
    case FLIT_PORT_PAIR:
    {
        PORTS p = flit.data.ports;
        // Do something...
        break;
    }
    case FLIT_FLAGS:
    {
        TCP_FLAGS f = flit.data.flags;
        // Do something...
        break;
    }
    case FLIT_PLEN:
    {
        PAYLOAD_LEN pl = flit.data.length;
        // Do something...
        break;
    }
    case FLIT_SEQNO:
    {
        TCP_SEQNO s = flit.data.seqno;
        // Do something... (probably ignore)
        break;
    }
    case FLIT_PAYLOAD:
    {
        PAYLOAD p = flit.data.payload;
        // Do something...
        break;
    }
}
*/


#endif
