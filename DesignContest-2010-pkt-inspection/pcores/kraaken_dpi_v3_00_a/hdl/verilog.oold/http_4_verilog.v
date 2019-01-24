`timescale 1ns/1ps

`define ENABLED_REGEX_http_4 TRUE

module http_4_verilog(clk,
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


`ifdef ENABLED_REGEX_http_4

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd12;
    1: charMap = 8'd12;
    2: charMap = 8'd12;
    3: charMap = 8'd12;
    4: charMap = 8'd12;
    5: charMap = 8'd12;
    6: charMap = 8'd12;
    7: charMap = 8'd12;
    8: charMap = 8'd12;
    9: charMap = 8'd13;
    10: charMap = 8'd4;
    11: charMap = 8'd13;
    12: charMap = 8'd12;
    13: charMap = 8'd4;
    14: charMap = 8'd12;
    15: charMap = 8'd12;
    16: charMap = 8'd12;
    17: charMap = 8'd12;
    18: charMap = 8'd12;
    19: charMap = 8'd12;
    20: charMap = 8'd12;
    21: charMap = 8'd12;
    22: charMap = 8'd12;
    23: charMap = 8'd12;
    24: charMap = 8'd12;
    25: charMap = 8'd12;
    26: charMap = 8'd12;
    27: charMap = 8'd12;
    28: charMap = 8'd12;
    29: charMap = 8'd12;
    30: charMap = 8'd12;
    31: charMap = 8'd12;
    32: charMap = 8'd13;
    33: charMap = 8'd20;
    34: charMap = 8'd20;
    35: charMap = 8'd12;
    36: charMap = 8'd12;
    37: charMap = 8'd12;
    38: charMap = 8'd12;
    39: charMap = 8'd12;
    40: charMap = 8'd12;
    41: charMap = 8'd12;
    42: charMap = 8'd12;
    43: charMap = 8'd12;
    44: charMap = 8'd12;
    45: charMap = 8'd12;
    46: charMap = 8'd12;
    47: charMap = 8'd12;
    48: charMap = 8'd12;
    49: charMap = 8'd12;
    50: charMap = 8'd12;
    51: charMap = 8'd12;
    52: charMap = 8'd12;
    53: charMap = 8'd12;
    54: charMap = 8'd12;
    55: charMap = 8'd12;
    56: charMap = 8'd12;
    57: charMap = 8'd12;
    58: charMap = 8'd3;
    59: charMap = 8'd12;
    60: charMap = 8'd1;
    61: charMap = 8'd19;
    62: charMap = 8'd12;
    63: charMap = 8'd12;
    64: charMap = 8'd12;
    65: charMap = 8'd2;
    66: charMap = 8'd12;
    67: charMap = 8'd12;
    68: charMap = 8'd11;
    69: charMap = 8'd12;
    70: charMap = 8'd8;
    71: charMap = 8'd12;
    72: charMap = 8'd12;
    73: charMap = 8'd9;
    74: charMap = 8'd12;
    75: charMap = 8'd12;
    76: charMap = 8'd16;
    77: charMap = 8'd15;
    78: charMap = 8'd10;
    79: charMap = 8'd7;
    80: charMap = 8'd5;
    81: charMap = 8'd12;
    82: charMap = 8'd6;
    83: charMap = 8'd17;
    84: charMap = 8'd12;
    85: charMap = 8'd12;
    86: charMap = 8'd21;
    87: charMap = 8'd12;
    88: charMap = 8'd14;
    89: charMap = 8'd12;
    90: charMap = 8'd12;
    91: charMap = 8'd12;
    92: charMap = 8'd12;
    93: charMap = 8'd12;
    94: charMap = 8'd12;
    95: charMap = 8'd12;
    96: charMap = 8'd12;
    97: charMap = 8'd18;
    98: charMap = 8'd12;
    99: charMap = 8'd12;
    100: charMap = 8'd11;
    101: charMap = 8'd12;
    102: charMap = 8'd8;
    103: charMap = 8'd12;
    104: charMap = 8'd12;
    105: charMap = 8'd9;
    106: charMap = 8'd12;
    107: charMap = 8'd12;
    108: charMap = 8'd16;
    109: charMap = 8'd15;
    110: charMap = 8'd10;
    111: charMap = 8'd7;
    112: charMap = 8'd5;
    113: charMap = 8'd12;
    114: charMap = 8'd6;
    115: charMap = 8'd17;
    116: charMap = 8'd12;
    117: charMap = 8'd12;
    118: charMap = 8'd21;
    119: charMap = 8'd12;
    120: charMap = 8'd14;
    121: charMap = 8'd12;
    122: charMap = 8'd12;
    123: charMap = 8'd12;
    124: charMap = 8'd12;
    125: charMap = 8'd12;
    126: charMap = 8'd12;
    127: charMap = 8'd12;
    128: charMap = 8'd12;
    129: charMap = 8'd12;
    130: charMap = 8'd12;
    131: charMap = 8'd12;
    132: charMap = 8'd12;
    133: charMap = 8'd12;
    134: charMap = 8'd12;
    135: charMap = 8'd12;
    136: charMap = 8'd12;
    137: charMap = 8'd12;
    138: charMap = 8'd12;
    139: charMap = 8'd12;
    140: charMap = 8'd12;
    141: charMap = 8'd12;
    142: charMap = 8'd12;
    143: charMap = 8'd12;
    144: charMap = 8'd12;
    145: charMap = 8'd12;
    146: charMap = 8'd12;
    147: charMap = 8'd12;
    148: charMap = 8'd12;
    149: charMap = 8'd12;
    150: charMap = 8'd12;
    151: charMap = 8'd12;
    152: charMap = 8'd12;
    153: charMap = 8'd12;
    154: charMap = 8'd12;
    155: charMap = 8'd12;
    156: charMap = 8'd12;
    157: charMap = 8'd12;
    158: charMap = 8'd12;
    159: charMap = 8'd12;
    160: charMap = 8'd12;
    161: charMap = 8'd12;
    162: charMap = 8'd12;
    163: charMap = 8'd12;
    164: charMap = 8'd12;
    165: charMap = 8'd12;
    166: charMap = 8'd12;
    167: charMap = 8'd12;
    168: charMap = 8'd12;
    169: charMap = 8'd12;
    170: charMap = 8'd12;
    171: charMap = 8'd12;
    172: charMap = 8'd12;
    173: charMap = 8'd12;
    174: charMap = 8'd12;
    175: charMap = 8'd12;
    176: charMap = 8'd12;
    177: charMap = 8'd12;
    178: charMap = 8'd12;
    179: charMap = 8'd12;
    180: charMap = 8'd12;
    181: charMap = 8'd12;
    182: charMap = 8'd12;
    183: charMap = 8'd12;
    184: charMap = 8'd12;
    185: charMap = 8'd12;
    186: charMap = 8'd12;
    187: charMap = 8'd12;
    188: charMap = 8'd12;
    189: charMap = 8'd12;
    190: charMap = 8'd12;
    191: charMap = 8'd12;
    192: charMap = 8'd12;
    193: charMap = 8'd12;
    194: charMap = 8'd12;
    195: charMap = 8'd12;
    196: charMap = 8'd12;
    197: charMap = 8'd12;
    198: charMap = 8'd12;
    199: charMap = 8'd12;
    200: charMap = 8'd12;
    201: charMap = 8'd12;
    202: charMap = 8'd12;
    203: charMap = 8'd12;
    204: charMap = 8'd12;
    205: charMap = 8'd12;
    206: charMap = 8'd12;
    207: charMap = 8'd12;
    208: charMap = 8'd12;
    209: charMap = 8'd12;
    210: charMap = 8'd12;
    211: charMap = 8'd12;
    212: charMap = 8'd12;
    213: charMap = 8'd12;
    214: charMap = 8'd12;
    215: charMap = 8'd12;
    216: charMap = 8'd12;
    217: charMap = 8'd12;
    218: charMap = 8'd12;
    219: charMap = 8'd12;
    220: charMap = 8'd12;
    221: charMap = 8'd12;
    222: charMap = 8'd12;
    223: charMap = 8'd12;
    224: charMap = 8'd12;
    225: charMap = 8'd12;
    226: charMap = 8'd12;
    227: charMap = 8'd12;
    228: charMap = 8'd12;
    229: charMap = 8'd12;
    230: charMap = 8'd12;
    231: charMap = 8'd12;
    232: charMap = 8'd12;
    233: charMap = 8'd12;
    234: charMap = 8'd12;
    235: charMap = 8'd12;
    236: charMap = 8'd12;
    237: charMap = 8'd12;
    238: charMap = 8'd12;
    239: charMap = 8'd12;
    240: charMap = 8'd12;
    241: charMap = 8'd12;
    242: charMap = 8'd12;
    243: charMap = 8'd12;
    244: charMap = 8'd12;
    245: charMap = 8'd12;
    246: charMap = 8'd12;
    247: charMap = 8'd12;
    248: charMap = 8'd12;
    249: charMap = 8'd12;
    250: charMap = 8'd12;
    251: charMap = 8'd12;
    252: charMap = 8'd12;
    253: charMap = 8'd12;
    254: charMap = 8'd12;
    255: charMap = 8'd12;
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
    2: stateMap = 11'd2;
    3: stateMap = 11'd3;
    4: stateMap = 11'd1;
    5: stateMap = 11'd4;
    6: stateMap = 11'd5;
    7: stateMap = 11'd6;
    8: stateMap = 11'd7;
    9: stateMap = 11'd8;
    10: stateMap = 11'd9;
    11: stateMap = 11'd10;
    12: stateMap = 11'd11;
    13: stateMap = 11'd12;
    14: stateMap = 11'd2;
    15: stateMap = 11'd13;
    16: stateMap = 11'd14;
    17: stateMap = 11'd15;
    18: stateMap = 11'd16;
    19: stateMap = 11'd17;
    20: stateMap = 11'd18;
    21: stateMap = 11'd19;
    22: stateMap = 11'd20;
    23: stateMap = 11'd21;
    24: stateMap = 11'd22;
    25: stateMap = 11'd23;
    26: stateMap = 11'd24;
    27: stateMap = 11'd25;
    28: stateMap = 11'd26;
    29: stateMap = 11'd27;
    30: stateMap = 11'd28;
    31: stateMap = 11'd29;
    32: stateMap = 11'd30;
    33: stateMap = 11'd31;
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
    4: acceptStates = 1'b1;
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
      0: stateTransition = 11'd1;
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
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
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
      18: stateTransition = 11'd5;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd6;
      5: stateTransition = 11'd7;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd6;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd8;
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
      21: stateTransition = 11'd0;
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
      7: stateTransition = 11'd9;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd10;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd11;
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
      21: stateTransition = 11'd0;
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
      9: stateTransition = 11'd12;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
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
      10: stateTransition = 11'd13;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
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
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd15;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd32;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd16;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd17;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
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
      19: stateTransition = 11'd18;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
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
      11: stateTransition = 11'd19;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd23;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd20;
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
      18: stateTransition = 11'd20;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
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
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd22;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd2;
      21: stateTransition = 11'd14;
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
      20: stateTransition = 11'd4;
      21: stateTransition = 11'd0;
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
      11: stateTransition = 11'd19;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd21;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd24;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd27;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd26;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd27;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd28;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd29;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd14;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd30;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd14;
      13: stateTransition = 11'd14;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd31;
      16: stateTransition = 11'd14;
      17: stateTransition = 11'd14;
      18: stateTransition = 11'd14;
      19: stateTransition = 11'd14;
      20: stateTransition = 11'd14;
      21: stateTransition = 11'd14;
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
