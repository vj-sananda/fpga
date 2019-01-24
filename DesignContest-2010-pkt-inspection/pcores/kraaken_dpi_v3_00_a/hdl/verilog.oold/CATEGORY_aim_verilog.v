`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_aim TRUE

module CATEGORY_aim_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_aim

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd3;
    1: charMap = 8'd6;
    2: charMap = 8'd2;
    3: charMap = 8'd4;
    4: charMap = 8'd3;
    5: charMap = 8'd3;
    6: charMap = 8'd3;
    7: charMap = 8'd3;
    8: charMap = 8'd3;
    9: charMap = 8'd3;
    10: charMap = 8'd0;
    11: charMap = 8'd5;
    12: charMap = 8'd3;
    13: charMap = 8'd0;
    14: charMap = 8'd3;
    15: charMap = 8'd3;
    16: charMap = 8'd3;
    17: charMap = 8'd3;
    18: charMap = 8'd3;
    19: charMap = 8'd3;
    20: charMap = 8'd3;
    21: charMap = 8'd3;
    22: charMap = 8'd3;
    23: charMap = 8'd3;
    24: charMap = 8'd3;
    25: charMap = 8'd3;
    26: charMap = 8'd3;
    27: charMap = 8'd3;
    28: charMap = 8'd3;
    29: charMap = 8'd3;
    30: charMap = 8'd3;
    31: charMap = 8'd3;
    32: charMap = 8'd3;
    33: charMap = 8'd3;
    34: charMap = 8'd3;
    35: charMap = 8'd3;
    36: charMap = 8'd3;
    37: charMap = 8'd3;
    38: charMap = 8'd3;
    39: charMap = 8'd3;
    40: charMap = 8'd3;
    41: charMap = 8'd3;
    42: charMap = 8'd1;
    43: charMap = 8'd3;
    44: charMap = 8'd3;
    45: charMap = 8'd3;
    46: charMap = 8'd3;
    47: charMap = 8'd3;
    48: charMap = 8'd19;
    49: charMap = 8'd3;
    50: charMap = 8'd3;
    51: charMap = 8'd3;
    52: charMap = 8'd3;
    53: charMap = 8'd3;
    54: charMap = 8'd3;
    55: charMap = 8'd3;
    56: charMap = 8'd3;
    57: charMap = 8'd3;
    58: charMap = 8'd3;
    59: charMap = 8'd3;
    60: charMap = 8'd3;
    61: charMap = 8'd3;
    62: charMap = 8'd3;
    63: charMap = 8'd3;
    64: charMap = 8'd3;
    65: charMap = 8'd3;
    66: charMap = 8'd3;
    67: charMap = 8'd3;
    68: charMap = 8'd3;
    69: charMap = 8'd3;
    70: charMap = 8'd3;
    71: charMap = 8'd3;
    72: charMap = 8'd3;
    73: charMap = 8'd3;
    74: charMap = 8'd3;
    75: charMap = 8'd3;
    76: charMap = 8'd3;
    77: charMap = 8'd3;
    78: charMap = 8'd3;
    79: charMap = 8'd3;
    80: charMap = 8'd3;
    81: charMap = 8'd3;
    82: charMap = 8'd3;
    83: charMap = 8'd3;
    84: charMap = 8'd3;
    85: charMap = 8'd3;
    86: charMap = 8'd3;
    87: charMap = 8'd3;
    88: charMap = 8'd3;
    89: charMap = 8'd3;
    90: charMap = 8'd3;
    91: charMap = 8'd3;
    92: charMap = 8'd3;
    93: charMap = 8'd3;
    94: charMap = 8'd3;
    95: charMap = 8'd15;
    96: charMap = 8'd3;
    97: charMap = 8'd9;
    98: charMap = 8'd3;
    99: charMap = 8'd14;
    100: charMap = 8'd3;
    101: charMap = 8'd3;
    102: charMap = 8'd7;
    103: charMap = 8'd18;
    104: charMap = 8'd3;
    105: charMap = 8'd17;
    106: charMap = 8'd3;
    107: charMap = 8'd3;
    108: charMap = 8'd8;
    109: charMap = 8'd3;
    110: charMap = 8'd12;
    111: charMap = 8'd11;
    112: charMap = 8'd10;
    113: charMap = 8'd3;
    114: charMap = 8'd3;
    115: charMap = 8'd16;
    116: charMap = 8'd13;
    117: charMap = 8'd3;
    118: charMap = 8'd3;
    119: charMap = 8'd3;
    120: charMap = 8'd20;
    121: charMap = 8'd3;
    122: charMap = 8'd3;
    123: charMap = 8'd3;
    124: charMap = 8'd3;
    125: charMap = 8'd3;
    126: charMap = 8'd3;
    127: charMap = 8'd3;
    128: charMap = 8'd3;
    129: charMap = 8'd3;
    130: charMap = 8'd3;
    131: charMap = 8'd3;
    132: charMap = 8'd3;
    133: charMap = 8'd3;
    134: charMap = 8'd3;
    135: charMap = 8'd3;
    136: charMap = 8'd3;
    137: charMap = 8'd3;
    138: charMap = 8'd3;
    139: charMap = 8'd3;
    140: charMap = 8'd3;
    141: charMap = 8'd3;
    142: charMap = 8'd3;
    143: charMap = 8'd3;
    144: charMap = 8'd3;
    145: charMap = 8'd3;
    146: charMap = 8'd3;
    147: charMap = 8'd3;
    148: charMap = 8'd3;
    149: charMap = 8'd3;
    150: charMap = 8'd3;
    151: charMap = 8'd3;
    152: charMap = 8'd3;
    153: charMap = 8'd3;
    154: charMap = 8'd3;
    155: charMap = 8'd3;
    156: charMap = 8'd3;
    157: charMap = 8'd3;
    158: charMap = 8'd3;
    159: charMap = 8'd3;
    160: charMap = 8'd3;
    161: charMap = 8'd3;
    162: charMap = 8'd3;
    163: charMap = 8'd3;
    164: charMap = 8'd3;
    165: charMap = 8'd3;
    166: charMap = 8'd3;
    167: charMap = 8'd3;
    168: charMap = 8'd3;
    169: charMap = 8'd3;
    170: charMap = 8'd3;
    171: charMap = 8'd3;
    172: charMap = 8'd3;
    173: charMap = 8'd3;
    174: charMap = 8'd3;
    175: charMap = 8'd3;
    176: charMap = 8'd3;
    177: charMap = 8'd3;
    178: charMap = 8'd3;
    179: charMap = 8'd3;
    180: charMap = 8'd3;
    181: charMap = 8'd3;
    182: charMap = 8'd3;
    183: charMap = 8'd3;
    184: charMap = 8'd3;
    185: charMap = 8'd3;
    186: charMap = 8'd3;
    187: charMap = 8'd3;
    188: charMap = 8'd3;
    189: charMap = 8'd3;
    190: charMap = 8'd3;
    191: charMap = 8'd3;
    192: charMap = 8'd3;
    193: charMap = 8'd3;
    194: charMap = 8'd3;
    195: charMap = 8'd3;
    196: charMap = 8'd3;
    197: charMap = 8'd3;
    198: charMap = 8'd3;
    199: charMap = 8'd3;
    200: charMap = 8'd3;
    201: charMap = 8'd3;
    202: charMap = 8'd3;
    203: charMap = 8'd3;
    204: charMap = 8'd3;
    205: charMap = 8'd3;
    206: charMap = 8'd3;
    207: charMap = 8'd3;
    208: charMap = 8'd3;
    209: charMap = 8'd3;
    210: charMap = 8'd3;
    211: charMap = 8'd3;
    212: charMap = 8'd3;
    213: charMap = 8'd3;
    214: charMap = 8'd3;
    215: charMap = 8'd3;
    216: charMap = 8'd3;
    217: charMap = 8'd3;
    218: charMap = 8'd3;
    219: charMap = 8'd3;
    220: charMap = 8'd3;
    221: charMap = 8'd3;
    222: charMap = 8'd3;
    223: charMap = 8'd3;
    224: charMap = 8'd3;
    225: charMap = 8'd3;
    226: charMap = 8'd3;
    227: charMap = 8'd3;
    228: charMap = 8'd3;
    229: charMap = 8'd3;
    230: charMap = 8'd3;
    231: charMap = 8'd3;
    232: charMap = 8'd3;
    233: charMap = 8'd3;
    234: charMap = 8'd3;
    235: charMap = 8'd3;
    236: charMap = 8'd3;
    237: charMap = 8'd3;
    238: charMap = 8'd3;
    239: charMap = 8'd3;
    240: charMap = 8'd3;
    241: charMap = 8'd3;
    242: charMap = 8'd3;
    243: charMap = 8'd3;
    244: charMap = 8'd3;
    245: charMap = 8'd3;
    246: charMap = 8'd3;
    247: charMap = 8'd3;
    248: charMap = 8'd3;
    249: charMap = 8'd3;
    250: charMap = 8'd3;
    251: charMap = 8'd3;
    252: charMap = 8'd3;
    253: charMap = 8'd3;
    254: charMap = 8'd3;
    255: charMap = 8'd3;
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
    4: stateMap = 11'd4;
    5: stateMap = 11'd5;
    6: stateMap = 11'd1;
    7: stateMap = 11'd6;
    8: stateMap = 11'd4;
    9: stateMap = 11'd7;
    10: stateMap = 11'd8;
    11: stateMap = 11'd9;
    12: stateMap = 11'd10;
    13: stateMap = 11'd11;
    14: stateMap = 11'd12;
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
    31: stateMap = 11'd14;
    32: stateMap = 11'd27;
    33: stateMap = 11'd2;
    34: stateMap = 11'd29;
    35: stateMap = 11'd29;
    36: stateMap = 11'd21;
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
    6: acceptStates = 1'b1;
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
    31: acceptStates = 1'b1;
    32: acceptStates = 1'b1;
    33: acceptStates = 1'b0;
    34: acceptStates = 1'b0;
    35: acceptStates = 1'b1;
    36: acceptStates = 1'b1;
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
      7: stateTransition = 11'd5;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd7;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd1;
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
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd16;
      6: stateTransition = 11'd31;
      7: stateTransition = 11'd16;
      8: stateTransition = 11'd16;
      9: stateTransition = 11'd16;
      10: stateTransition = 11'd16;
      11: stateTransition = 11'd16;
      12: stateTransition = 11'd16;
      13: stateTransition = 11'd16;
      14: stateTransition = 11'd16;
      15: stateTransition = 11'd16;
      16: stateTransition = 11'd16;
      17: stateTransition = 11'd16;
      18: stateTransition = 11'd16;
      19: stateTransition = 11'd16;
      20: stateTransition = 11'd16;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd9;
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
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd8;
      6: stateTransition = 11'd8;
      7: stateTransition = 11'd8;
      8: stateTransition = 11'd8;
      9: stateTransition = 11'd8;
      10: stateTransition = 11'd8;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd8;
      13: stateTransition = 11'd8;
      14: stateTransition = 11'd8;
      15: stateTransition = 11'd8;
      16: stateTransition = 11'd8;
      17: stateTransition = 11'd8;
      18: stateTransition = 11'd8;
      19: stateTransition = 11'd8;
      20: stateTransition = 11'd8;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd10;
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
    6: case ( mapped_char ) 
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
      11: stateTransition = 11'd11;
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
      1: stateTransition = 11'd33;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd33;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd33;
      8: stateTransition = 11'd33;
      9: stateTransition = 11'd33;
      10: stateTransition = 11'd33;
      11: stateTransition = 11'd33;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd33;
      14: stateTransition = 11'd33;
      15: stateTransition = 11'd33;
      16: stateTransition = 11'd33;
      17: stateTransition = 11'd33;
      18: stateTransition = 11'd33;
      19: stateTransition = 11'd33;
      20: stateTransition = 11'd33;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd14;
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
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd15;
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
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd4;
      6: stateTransition = 11'd8;
      7: stateTransition = 11'd8;
      8: stateTransition = 11'd8;
      9: stateTransition = 11'd8;
      10: stateTransition = 11'd8;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd8;
      13: stateTransition = 11'd8;
      14: stateTransition = 11'd8;
      15: stateTransition = 11'd8;
      16: stateTransition = 11'd8;
      17: stateTransition = 11'd8;
      18: stateTransition = 11'd8;
      19: stateTransition = 11'd8;
      20: stateTransition = 11'd8;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd31;
      6: stateTransition = 11'd31;
      7: stateTransition = 11'd16;
      8: stateTransition = 11'd16;
      9: stateTransition = 11'd16;
      10: stateTransition = 11'd16;
      11: stateTransition = 11'd16;
      12: stateTransition = 11'd16;
      13: stateTransition = 11'd16;
      14: stateTransition = 11'd16;
      15: stateTransition = 11'd16;
      16: stateTransition = 11'd16;
      17: stateTransition = 11'd16;
      18: stateTransition = 11'd16;
      19: stateTransition = 11'd16;
      20: stateTransition = 11'd16;
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
      10: stateTransition = 11'd18;
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
    13: case ( mapped_char ) 
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
      15: stateTransition = 11'd19;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd34;
      6: stateTransition = 11'd35;
      7: stateTransition = 11'd34;
      8: stateTransition = 11'd34;
      9: stateTransition = 11'd34;
      10: stateTransition = 11'd34;
      11: stateTransition = 11'd34;
      12: stateTransition = 11'd34;
      13: stateTransition = 11'd34;
      14: stateTransition = 11'd34;
      15: stateTransition = 11'd34;
      16: stateTransition = 11'd34;
      17: stateTransition = 11'd34;
      18: stateTransition = 11'd34;
      19: stateTransition = 11'd34;
      20: stateTransition = 11'd34;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd35;
      6: stateTransition = 11'd35;
      7: stateTransition = 11'd34;
      8: stateTransition = 11'd34;
      9: stateTransition = 11'd34;
      10: stateTransition = 11'd34;
      11: stateTransition = 11'd34;
      12: stateTransition = 11'd34;
      13: stateTransition = 11'd34;
      14: stateTransition = 11'd34;
      15: stateTransition = 11'd34;
      16: stateTransition = 11'd34;
      17: stateTransition = 11'd34;
      18: stateTransition = 11'd34;
      19: stateTransition = 11'd34;
      20: stateTransition = 11'd34;
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
      11: stateTransition = 11'd21;
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
    17: case ( mapped_char ) 
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
      16: stateTransition = 11'd22;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd36;
      6: stateTransition = 11'd36;
      7: stateTransition = 11'd23;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd23;
      11: stateTransition = 11'd23;
      12: stateTransition = 11'd23;
      13: stateTransition = 11'd23;
      14: stateTransition = 11'd23;
      15: stateTransition = 11'd23;
      16: stateTransition = 11'd23;
      17: stateTransition = 11'd23;
      18: stateTransition = 11'd23;
      19: stateTransition = 11'd23;
      20: stateTransition = 11'd23;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
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
      12: stateTransition = 11'd6;
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
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd8;
      6: stateTransition = 11'd4;
      7: stateTransition = 11'd8;
      8: stateTransition = 11'd8;
      9: stateTransition = 11'd8;
      10: stateTransition = 11'd8;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd8;
      13: stateTransition = 11'd8;
      14: stateTransition = 11'd8;
      15: stateTransition = 11'd8;
      16: stateTransition = 11'd8;
      17: stateTransition = 11'd8;
      18: stateTransition = 11'd8;
      19: stateTransition = 11'd8;
      20: stateTransition = 11'd8;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd4;
      6: stateTransition = 11'd4;
      7: stateTransition = 11'd8;
      8: stateTransition = 11'd8;
      9: stateTransition = 11'd8;
      10: stateTransition = 11'd8;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd8;
      13: stateTransition = 11'd8;
      14: stateTransition = 11'd8;
      15: stateTransition = 11'd8;
      16: stateTransition = 11'd8;
      17: stateTransition = 11'd8;
      18: stateTransition = 11'd8;
      19: stateTransition = 11'd8;
      20: stateTransition = 11'd8;
      21: stateTransition = 11'd0;
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
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd26;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      21: stateTransition = 11'd0;
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
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd27;
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
    25: case ( mapped_char ) 
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
      11: stateTransition = 11'd28;
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
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd29;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd29;
      8: stateTransition = 11'd29;
      9: stateTransition = 11'd29;
      10: stateTransition = 11'd29;
      11: stateTransition = 11'd29;
      12: stateTransition = 11'd29;
      13: stateTransition = 11'd29;
      14: stateTransition = 11'd29;
      15: stateTransition = 11'd29;
      16: stateTransition = 11'd29;
      17: stateTransition = 11'd29;
      18: stateTransition = 11'd29;
      19: stateTransition = 11'd30;
      20: stateTransition = 11'd29;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd29;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd29;
      8: stateTransition = 11'd29;
      9: stateTransition = 11'd29;
      10: stateTransition = 11'd29;
      11: stateTransition = 11'd29;
      12: stateTransition = 11'd29;
      13: stateTransition = 11'd29;
      14: stateTransition = 11'd29;
      15: stateTransition = 11'd29;
      16: stateTransition = 11'd29;
      17: stateTransition = 11'd29;
      18: stateTransition = 11'd29;
      19: stateTransition = 11'd30;
      20: stateTransition = 11'd32;
      21: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd36;
      7: stateTransition = 11'd23;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd23;
      11: stateTransition = 11'd23;
      12: stateTransition = 11'd23;
      13: stateTransition = 11'd23;
      14: stateTransition = 11'd23;
      15: stateTransition = 11'd23;
      16: stateTransition = 11'd23;
      17: stateTransition = 11'd23;
      18: stateTransition = 11'd23;
      19: stateTransition = 11'd23;
      20: stateTransition = 11'd23;
      21: stateTransition = 11'd0;
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
