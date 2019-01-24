`timescale 1ns/1ps

`define ENABLED_REGEX_netbios_6 TRUE

module netbios_6_verilog(clk,
                    rst_n,
                    char_in,
                    char_in_vld,
                    state_in,
                    state_in_vld,
                    state_out,
                    accept_out);
   // The clock and reset info.
    input clk, rst_n;
    // Input character, and state, if being set.
    input [7:0] char_in;
    input [10:0] state_in;
    // char_in_vld should be true if there's a character to process.
    // state_in_vld should be true if the outside world is overwriting our state.
    input char_in_vld, state_in_vld;
    // state_out is our current state.
    output [10:0] state_out;
    // Accept out is true if the character triggered a regex match.
    output accept_out;
    // A register for the current state.
    reg [10:0] cur_state;


`ifdef ENABLED_REGEX_netbios_6

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd2;
    1: charMap = 8'd0;
    2: charMap = 8'd0;
    3: charMap = 8'd0;
    4: charMap = 8'd0;
    5: charMap = 8'd0;
    6: charMap = 8'd0;
    7: charMap = 8'd0;
    8: charMap = 8'd0;
    9: charMap = 8'd0;
    10: charMap = 8'd0;
    11: charMap = 8'd0;
    12: charMap = 8'd0;
    13: charMap = 8'd0;
    14: charMap = 8'd0;
    15: charMap = 8'd0;
    16: charMap = 8'd0;
    17: charMap = 8'd0;
    18: charMap = 8'd0;
    19: charMap = 8'd0;
    20: charMap = 8'd0;
    21: charMap = 8'd0;
    22: charMap = 8'd0;
    23: charMap = 8'd0;
    24: charMap = 8'd0;
    25: charMap = 8'd0;
    26: charMap = 8'd0;
    27: charMap = 8'd0;
    28: charMap = 8'd0;
    29: charMap = 8'd0;
    30: charMap = 8'd0;
    31: charMap = 8'd0;
    32: charMap = 8'd7;
    33: charMap = 8'd0;
    34: charMap = 8'd0;
    35: charMap = 8'd0;
    36: charMap = 8'd0;
    37: charMap = 8'd0;
    38: charMap = 8'd0;
    39: charMap = 8'd0;
    40: charMap = 8'd0;
    41: charMap = 8'd0;
    42: charMap = 8'd0;
    43: charMap = 8'd0;
    44: charMap = 8'd0;
    45: charMap = 8'd0;
    46: charMap = 8'd0;
    47: charMap = 8'd0;
    48: charMap = 8'd0;
    49: charMap = 8'd0;
    50: charMap = 8'd0;
    51: charMap = 8'd0;
    52: charMap = 8'd0;
    53: charMap = 8'd12;
    54: charMap = 8'd0;
    55: charMap = 8'd0;
    56: charMap = 8'd0;
    57: charMap = 8'd0;
    58: charMap = 8'd0;
    59: charMap = 8'd0;
    60: charMap = 8'd0;
    61: charMap = 8'd0;
    62: charMap = 8'd0;
    63: charMap = 8'd0;
    64: charMap = 8'd0;
    65: charMap = 8'd0;
    66: charMap = 8'd0;
    67: charMap = 8'd13;
    68: charMap = 8'd0;
    69: charMap = 8'd0;
    70: charMap = 8'd0;
    71: charMap = 8'd0;
    72: charMap = 8'd0;
    73: charMap = 8'd0;
    74: charMap = 8'd0;
    75: charMap = 8'd0;
    76: charMap = 8'd0;
    77: charMap = 8'd8;
    78: charMap = 8'd0;
    79: charMap = 8'd0;
    80: charMap = 8'd14;
    81: charMap = 8'd0;
    82: charMap = 8'd0;
    83: charMap = 8'd3;
    84: charMap = 8'd0;
    85: charMap = 8'd0;
    86: charMap = 8'd0;
    87: charMap = 8'd0;
    88: charMap = 8'd0;
    89: charMap = 8'd0;
    90: charMap = 8'd0;
    91: charMap = 8'd0;
    92: charMap = 8'd1;
    93: charMap = 8'd0;
    94: charMap = 8'd0;
    95: charMap = 8'd0;
    96: charMap = 8'd0;
    97: charMap = 8'd5;
    98: charMap = 8'd0;
    99: charMap = 8'd0;
    100: charMap = 8'd0;
    101: charMap = 8'd9;
    102: charMap = 8'd0;
    103: charMap = 8'd16;
    104: charMap = 8'd0;
    105: charMap = 8'd0;
    106: charMap = 8'd0;
    107: charMap = 8'd0;
    108: charMap = 8'd0;
    109: charMap = 8'd17;
    110: charMap = 8'd10;
    111: charMap = 8'd15;
    112: charMap = 8'd19;
    113: charMap = 8'd0;
    114: charMap = 8'd6;
    115: charMap = 8'd18;
    116: charMap = 8'd4;
    117: charMap = 8'd11;
    118: charMap = 8'd0;
    119: charMap = 8'd0;
    120: charMap = 8'd0;
    121: charMap = 8'd0;
    122: charMap = 8'd0;
    123: charMap = 8'd0;
    124: charMap = 8'd0;
    125: charMap = 8'd0;
    126: charMap = 8'd0;
    127: charMap = 8'd0;
    128: charMap = 8'd0;
    129: charMap = 8'd0;
    130: charMap = 8'd0;
    131: charMap = 8'd0;
    132: charMap = 8'd0;
    133: charMap = 8'd0;
    134: charMap = 8'd0;
    135: charMap = 8'd0;
    136: charMap = 8'd0;
    137: charMap = 8'd0;
    138: charMap = 8'd0;
    139: charMap = 8'd0;
    140: charMap = 8'd0;
    141: charMap = 8'd0;
    142: charMap = 8'd0;
    143: charMap = 8'd0;
    144: charMap = 8'd0;
    145: charMap = 8'd0;
    146: charMap = 8'd0;
    147: charMap = 8'd0;
    148: charMap = 8'd0;
    149: charMap = 8'd0;
    150: charMap = 8'd0;
    151: charMap = 8'd0;
    152: charMap = 8'd0;
    153: charMap = 8'd0;
    154: charMap = 8'd0;
    155: charMap = 8'd0;
    156: charMap = 8'd0;
    157: charMap = 8'd0;
    158: charMap = 8'd0;
    159: charMap = 8'd0;
    160: charMap = 8'd0;
    161: charMap = 8'd0;
    162: charMap = 8'd0;
    163: charMap = 8'd0;
    164: charMap = 8'd0;
    165: charMap = 8'd0;
    166: charMap = 8'd0;
    167: charMap = 8'd0;
    168: charMap = 8'd0;
    169: charMap = 8'd0;
    170: charMap = 8'd0;
    171: charMap = 8'd0;
    172: charMap = 8'd0;
    173: charMap = 8'd0;
    174: charMap = 8'd0;
    175: charMap = 8'd0;
    176: charMap = 8'd0;
    177: charMap = 8'd0;
    178: charMap = 8'd0;
    179: charMap = 8'd0;
    180: charMap = 8'd0;
    181: charMap = 8'd0;
    182: charMap = 8'd0;
    183: charMap = 8'd0;
    184: charMap = 8'd0;
    185: charMap = 8'd0;
    186: charMap = 8'd0;
    187: charMap = 8'd0;
    188: charMap = 8'd0;
    189: charMap = 8'd0;
    190: charMap = 8'd0;
    191: charMap = 8'd0;
    192: charMap = 8'd0;
    193: charMap = 8'd0;
    194: charMap = 8'd0;
    195: charMap = 8'd0;
    196: charMap = 8'd0;
    197: charMap = 8'd0;
    198: charMap = 8'd0;
    199: charMap = 8'd0;
    200: charMap = 8'd0;
    201: charMap = 8'd0;
    202: charMap = 8'd0;
    203: charMap = 8'd0;
    204: charMap = 8'd0;
    205: charMap = 8'd0;
    206: charMap = 8'd0;
    207: charMap = 8'd0;
    208: charMap = 8'd0;
    209: charMap = 8'd0;
    210: charMap = 8'd0;
    211: charMap = 8'd0;
    212: charMap = 8'd0;
    213: charMap = 8'd0;
    214: charMap = 8'd0;
    215: charMap = 8'd0;
    216: charMap = 8'd0;
    217: charMap = 8'd0;
    218: charMap = 8'd0;
    219: charMap = 8'd0;
    220: charMap = 8'd0;
    221: charMap = 8'd0;
    222: charMap = 8'd0;
    223: charMap = 8'd0;
    224: charMap = 8'd0;
    225: charMap = 8'd0;
    226: charMap = 8'd0;
    227: charMap = 8'd0;
    228: charMap = 8'd0;
    229: charMap = 8'd0;
    230: charMap = 8'd0;
    231: charMap = 8'd0;
    232: charMap = 8'd0;
    233: charMap = 8'd0;
    234: charMap = 8'd0;
    235: charMap = 8'd0;
    236: charMap = 8'd0;
    237: charMap = 8'd0;
    238: charMap = 8'd0;
    239: charMap = 8'd0;
    240: charMap = 8'd0;
    241: charMap = 8'd0;
    242: charMap = 8'd0;
    243: charMap = 8'd0;
    244: charMap = 8'd0;
    245: charMap = 8'd0;
    246: charMap = 8'd0;
    247: charMap = 8'd0;
    248: charMap = 8'd0;
    249: charMap = 8'd0;
    250: charMap = 8'd0;
    251: charMap = 8'd0;
    252: charMap = 8'd0;
    253: charMap = 8'd0;
    254: charMap = 8'd0;
    255: charMap = 8'd0;
    default: charMap = 8'bX;
  endcase
end
endfunction

function [10:0] stateMap;
  input [10:0] instate;
begin
  case( instate )
    0: stateMap = 11'd0;
    1: stateMap = 11'd1;
    2: stateMap = 11'd1;
    3: stateMap = 11'd2;
    4: stateMap = 11'd3;
    5: stateMap = 11'd4;
    6: stateMap = 11'd5;
    7: stateMap = 11'd6;
    8: stateMap = 11'd7;
    9: stateMap = 11'd8;
    10: stateMap = 11'd9;
    11: stateMap = 11'd10;
    12: stateMap = 11'd11;
    13: stateMap = 11'd12;
    14: stateMap = 11'd13;
    15: stateMap = 11'd14;
    16: stateMap = 11'd15;
    17: stateMap = 11'd16;
    18: stateMap = 11'd17;
    19: stateMap = 11'd18;
    20: stateMap = 11'd19;
    21: stateMap = 11'd20;
    22: stateMap = 11'd21;
    23: stateMap = 11'd22;
    24: stateMap = 11'd23;
    25: stateMap = 11'd24;
    26: stateMap = 11'd25;
    27: stateMap = 11'd26;
    28: stateMap = 11'd27;
    29: stateMap = 11'd28;
    30: stateMap = 11'd29;
    31: stateMap = 11'd30;
    32: stateMap = 11'd31;
    33: stateMap = 11'd32;
    34: stateMap = 11'd33;
    35: stateMap = 11'd34;
    36: stateMap = 11'd35;
    37: stateMap = 11'd36;
    38: stateMap = 11'd37;
    39: stateMap = 11'd38;
    40: stateMap = 11'd39;
    41: stateMap = 11'd40;
    42: stateMap = 11'd41;
    43: stateMap = 11'd42;
    44: stateMap = 11'd43;
    45: stateMap = 11'd44;
    46: stateMap = 11'd45;
    47: stateMap = 11'd46;
    48: stateMap = 11'd47;
    49: stateMap = 11'd48;
    50: stateMap = 11'd49;
    51: stateMap = 11'd50;
    52: stateMap = 11'd51;
    53: stateMap = 11'd52;
    54: stateMap = 11'd53;
    55: stateMap = 11'd54;
    56: stateMap = 11'd55;
    57: stateMap = 11'd56;
    58: stateMap = 11'd57;
    59: stateMap = 11'd58;
    60: stateMap = 11'd59;
    61: stateMap = 11'd60;
    default: stateMap = 11'bX;
  endcase
end
endfunction

function acceptStates;
  input [10:0] instate;
begin
  case( instate )
    0: acceptStates = 1'b0;
    1: acceptStates = 1'b1;
    2: acceptStates = 1'b1;
    3: acceptStates = 1'b0;
    4: acceptStates = 1'b0;
    5: acceptStates = 1'b0;
    6: acceptStates = 1'b0;
    7: acceptStates = 1'b0;
    8: acceptStates = 1'b0;
    9: acceptStates = 1'b0;
    10: acceptStates = 1'b0;
    11: acceptStates = 1'b0;
    12: acceptStates = 1'b0;
    13: acceptStates = 1'b0;
    14: acceptStates = 1'b0;
    15: acceptStates = 1'b0;
    16: acceptStates = 1'b0;
    17: acceptStates = 1'b0;
    18: acceptStates = 1'b0;
    19: acceptStates = 1'b0;
    20: acceptStates = 1'b0;
    21: acceptStates = 1'b0;
    22: acceptStates = 1'b0;
    23: acceptStates = 1'b0;
    24: acceptStates = 1'b0;
    25: acceptStates = 1'b0;
    26: acceptStates = 1'b0;
    27: acceptStates = 1'b0;
    28: acceptStates = 1'b0;
    29: acceptStates = 1'b0;
    30: acceptStates = 1'b0;
    31: acceptStates = 1'b0;
    32: acceptStates = 1'b0;
    33: acceptStates = 1'b0;
    34: acceptStates = 1'b0;
    35: acceptStates = 1'b0;
    36: acceptStates = 1'b0;
    37: acceptStates = 1'b0;
    38: acceptStates = 1'b0;
    39: acceptStates = 1'b0;
    40: acceptStates = 1'b0;
    41: acceptStates = 1'b0;
    42: acceptStates = 1'b0;
    43: acceptStates = 1'b0;
    44: acceptStates = 1'b0;
    45: acceptStates = 1'b0;
    46: acceptStates = 1'b0;
    47: acceptStates = 1'b0;
    48: acceptStates = 1'b0;
    49: acceptStates = 1'b0;
    50: acceptStates = 1'b0;
    51: acceptStates = 1'b0;
    52: acceptStates = 1'b0;
    53: acceptStates = 1'b0;
    54: acceptStates = 1'b0;
    55: acceptStates = 1'b0;
    56: acceptStates = 1'b0;
    57: acceptStates = 1'b0;
    58: acceptStates = 1'b0;
    59: acceptStates = 1'b0;
    60: acceptStates = 1'b0;
    61: acceptStates = 1'b0;
    default: acceptStates = 1'bX;
  endcase
end
endfunction

function [10:0] stateTransition;
  input [10:0] mapped_state;
  input [7:0]  mapped_char;
begin
  case( mapped_state )
    0: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd52;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd1;
      default: stateTransition = 11'bX;
    endcase
    1: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd4;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd6;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd53;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd7;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd9;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd54;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd61;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd56;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd57;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd58;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd26;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd27;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd29;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd30;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd31;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd32;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd33;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd59;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd37;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd39;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd40;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd41;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd43;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd44;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd46;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd48;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd50;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd2;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd55;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd60;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    default: stateTransition = 11'bX;
  endcase
end
endfunction

`else

function [7:0] charMap;
input [7:0] inchar;
begin
    charMap = inchar;
end
endfunction

function [10:0] stateMap;
input [10:0] instate;
begin
    stateMap = instate;
end
endfunction

function acceptStates;
    input [10:0] instate;
begin
    acceptStates = 1'b0;
end
endfunction

function [10:0] stateTransition;
    input [10:0] instate;
    input [7:0]  inchar;
begin
    stateTransition = instate;
end
endfunction

`endif

    // Invoke the DFA functions.
    wire [7:0]  mapped_char;
    wire [10:0] mapped_state, next_state;
    wire next_accept;
    assign mapped_char = charMap(char_in);
    assign mapped_state = stateMap(cur_state);
    assign next_state = stateTransition(mapped_state, mapped_char);
    assign next_accept = acceptStates(next_state);
    // Update our outputs.
    assign accept_out = state_in_vld ? 1'b0 : char_in_vld ? next_accept : 1'b0;
    assign state_out = cur_state;
    // Update our local state.
    always @(posedge clk)
    begin
       if (!rst_n)
        begin
            cur_state <= 0;
        end
        else
        begin
            if (state_in_vld)
            begin
                cur_state <= state_in;
            end
            else if (char_in_vld)
            begin
                cur_state <= next_state;
            end
        end
    end
endmodule