//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
(
  // -- add user ports below this line ---------------
  // --user ports added here 
  // -- add user ports above this line ---------------

  // -- do not edit below this line ------------------
  // -- bus protocol ports, do not add to or delete 
  bus2ip_clk,                     // bus to ip clock
  bus2ip_reset,                   // bus to ip reset
  bus2ip_data,                    // bus to ip data bus for user logic
  bus2ip_be,                      // bus to ip byte enables for user logic
  bus2ip_rdce,                    // bus to ip read chip enable for user logic
  bus2ip_wrce,                    // bus to ip write chip enable for user logic
  ip2bus_data,                    // ip to bus data bus for user logic
  ip2bus_ack,                     // ip to bus acknowledgement
  ip2bus_retry,                   // ip to bus retry response
  ip2bus_error,                   // ip to bus error response
  ip2bus_toutsup,                 // ip to bus timeout suppress
  ip2rfifo_wrreq,                 // ip to rfifo : ip write request
  ip2rfifo_data,                  // ip to rfifo : ip write data
  rfifo2ip_wrack,                 // rfifo to ip : rfifo write acknowledge
  rfifo2ip_almostfull,            // rfifo to ip : rfifo almost full
  rfifo2ip_full,                  // rfifo to ip : rfifo full
  rfifo2ip_vacancy,               // rfifo to ip : rfifo vacancy
  ip2wfifo_rdreq,                 // ip to wfifo : ip read request
  wfifo2ip_data,                  // wfifo to ip : wfifo read data
  wfifo2ip_rdack,                 // wfifo to ip : wfifo read acknowledge
  wfifo2ip_almostempty,           // wfifo to ip : wfifo almost empty
  wfifo2ip_empty,                 // wfifo to ip : wfifo empty
  wfifo2ip_occupancy              // wfifo to ip : wfifo occupancy
  // -- do not edit above this line ------------------
); // user_logic

// -- add user parameters below this line ------------
// --user parameters added here 
// -- add user parameters above this line ------------

parameter c_width=32 ; //code width from 1 to 32 bits
parameter p_width=32 ; //packed data width 32 bits
parameter p_width_msb=31 ; //packed data width 31 bits   
parameter cz_width=32 ; //code size width

// -- do not edit below this line --------------------
// -- bus protocol parameters, do not add to or delete
parameter c_dwidth                       = 32;
parameter c_num_ce                       = 2;
parameter c_rdfifo_dwidth                = 32;
parameter c_rdfifo_depth                 = 512;
parameter c_wrfifo_dwidth                = 32;
parameter c_wrfifo_depth                 = 512;
// -- do not edit above this line --------------------

// -- add user ports below this line -----------------
// --user ports added here 
// -- add user ports above this line -----------------

// -- do not edit below this line --------------------
// -- bus protocol ports, do not add to or delete
input                                     bus2ip_clk;
input                                     bus2ip_reset;
input      [0 : c_dwidth-1]               bus2ip_data;
input      [0 : c_dwidth/8-1]             bus2ip_be;
input      [0 : c_num_ce-1]               bus2ip_rdce;
input      [0 : c_num_ce-1]               bus2ip_wrce;
output     [0 : c_dwidth-1]               ip2bus_data;
output                                    ip2bus_ack;
output                                    ip2bus_retry;
output                                    ip2bus_error;
output                                    ip2bus_toutsup;
output                                    ip2rfifo_wrreq;
output     [0 : c_rdfifo_dwidth-1]        ip2rfifo_data;
input                                     rfifo2ip_wrack;
input                                     rfifo2ip_almostfull;
input                                     rfifo2ip_full;
input      [0 : 9]                        rfifo2ip_vacancy;
output                                    ip2wfifo_rdreq;
input      [0 : c_wrfifo_dwidth-1]        wfifo2ip_data;
input                                     wfifo2ip_rdack;
input                                     wfifo2ip_almostempty;
input                                     wfifo2ip_empty;
input      [0 : 9]                       wfifo2ip_occupancy;
// -- do not edit above this line --------------------

   
endmodule
