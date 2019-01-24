`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_gopher TRUE

module CATEGORY_gopher_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_gopher

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd10;
    1: charMap = 8'd10;
    2: charMap = 8'd10;
    3: charMap = 8'd10;
    4: charMap = 8'd10;
    5: charMap = 8'd10;
    6: charMap = 8'd10;
    7: charMap = 8'd10;
    8: charMap = 8'd10;
    9: charMap = 8'd4;
    10: charMap = 8'd1;
    11: charMap = 8'd11;
    12: charMap = 8'd11;
    13: charMap = 8'd1;
    14: charMap = 8'd10;
    15: charMap = 8'd10;
    16: charMap = 8'd10;
    17: charMap = 8'd10;
    18: charMap = 8'd10;
    19: charMap = 8'd10;
    20: charMap = 8'd10;
    21: charMap = 8'd10;
    22: charMap = 8'd10;
    23: charMap = 8'd10;
    24: charMap = 8'd10;
    25: charMap = 8'd10;
    26: charMap = 8'd10;
    27: charMap = 8'd10;
    28: charMap = 8'd10;
    29: charMap = 8'd10;
    30: charMap = 8'd10;
    31: charMap = 8'd10;
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
    42: charMap = 8'd3;
    43: charMap = 8'd2;
    44: charMap = 8'd2;
    45: charMap = 8'd3;
    46: charMap = 8'd7;
    47: charMap = 8'd3;
    48: charMap = 8'd5;
    49: charMap = 8'd6;
    50: charMap = 8'd6;
    51: charMap = 8'd6;
    52: charMap = 8'd6;
    53: charMap = 8'd6;
    54: charMap = 8'd6;
    55: charMap = 8'd6;
    56: charMap = 8'd6;
    57: charMap = 8'd6;
    58: charMap = 8'd3;
    59: charMap = 8'd3;
    60: charMap = 8'd3;
    61: charMap = 8'd3;
    62: charMap = 8'd3;
    63: charMap = 8'd3;
    64: charMap = 8'd3;
    65: charMap = 8'd8;
    66: charMap = 8'd8;
    67: charMap = 8'd8;
    68: charMap = 8'd8;
    69: charMap = 8'd8;
    70: charMap = 8'd8;
    71: charMap = 8'd8;
    72: charMap = 8'd8;
    73: charMap = 8'd8;
    74: charMap = 8'd8;
    75: charMap = 8'd8;
    76: charMap = 8'd8;
    77: charMap = 8'd8;
    78: charMap = 8'd8;
    79: charMap = 8'd8;
    80: charMap = 8'd8;
    81: charMap = 8'd8;
    82: charMap = 8'd8;
    83: charMap = 8'd8;
    84: charMap = 8'd8;
    85: charMap = 8'd8;
    86: charMap = 8'd8;
    87: charMap = 8'd8;
    88: charMap = 8'd8;
    89: charMap = 8'd8;
    90: charMap = 8'd8;
    91: charMap = 8'd3;
    92: charMap = 8'd3;
    93: charMap = 8'd3;
    94: charMap = 8'd3;
    95: charMap = 8'd3;
    96: charMap = 8'd3;
    97: charMap = 8'd8;
    98: charMap = 8'd8;
    99: charMap = 8'd8;
    100: charMap = 8'd8;
    101: charMap = 8'd8;
    102: charMap = 8'd8;
    103: charMap = 8'd9;
    104: charMap = 8'd8;
    105: charMap = 8'd9;
    106: charMap = 8'd8;
    107: charMap = 8'd8;
    108: charMap = 8'd8;
    109: charMap = 8'd8;
    110: charMap = 8'd8;
    111: charMap = 8'd8;
    112: charMap = 8'd8;
    113: charMap = 8'd8;
    114: charMap = 8'd8;
    115: charMap = 8'd8;
    116: charMap = 8'd9;
    117: charMap = 8'd8;
    118: charMap = 8'd8;
    119: charMap = 8'd8;
    120: charMap = 8'd8;
    121: charMap = 8'd8;
    122: charMap = 8'd8;
    123: charMap = 8'd3;
    124: charMap = 8'd3;
    125: charMap = 8'd3;
    126: charMap = 8'd3;
    127: charMap = 8'd10;
    128: charMap = 8'd10;
    129: charMap = 8'd10;
    130: charMap = 8'd10;
    131: charMap = 8'd10;
    132: charMap = 8'd10;
    133: charMap = 8'd10;
    134: charMap = 8'd10;
    135: charMap = 8'd10;
    136: charMap = 8'd10;
    137: charMap = 8'd10;
    138: charMap = 8'd10;
    139: charMap = 8'd10;
    140: charMap = 8'd10;
    141: charMap = 8'd10;
    142: charMap = 8'd10;
    143: charMap = 8'd10;
    144: charMap = 8'd10;
    145: charMap = 8'd10;
    146: charMap = 8'd10;
    147: charMap = 8'd10;
    148: charMap = 8'd10;
    149: charMap = 8'd10;
    150: charMap = 8'd10;
    151: charMap = 8'd10;
    152: charMap = 8'd10;
    153: charMap = 8'd10;
    154: charMap = 8'd10;
    155: charMap = 8'd10;
    156: charMap = 8'd10;
    157: charMap = 8'd10;
    158: charMap = 8'd10;
    159: charMap = 8'd10;
    160: charMap = 8'd10;
    161: charMap = 8'd10;
    162: charMap = 8'd10;
    163: charMap = 8'd10;
    164: charMap = 8'd10;
    165: charMap = 8'd10;
    166: charMap = 8'd10;
    167: charMap = 8'd10;
    168: charMap = 8'd10;
    169: charMap = 8'd10;
    170: charMap = 8'd10;
    171: charMap = 8'd10;
    172: charMap = 8'd10;
    173: charMap = 8'd10;
    174: charMap = 8'd10;
    175: charMap = 8'd10;
    176: charMap = 8'd10;
    177: charMap = 8'd10;
    178: charMap = 8'd10;
    179: charMap = 8'd10;
    180: charMap = 8'd10;
    181: charMap = 8'd10;
    182: charMap = 8'd10;
    183: charMap = 8'd10;
    184: charMap = 8'd10;
    185: charMap = 8'd10;
    186: charMap = 8'd10;
    187: charMap = 8'd10;
    188: charMap = 8'd10;
    189: charMap = 8'd10;
    190: charMap = 8'd10;
    191: charMap = 8'd10;
    192: charMap = 8'd10;
    193: charMap = 8'd10;
    194: charMap = 8'd10;
    195: charMap = 8'd10;
    196: charMap = 8'd10;
    197: charMap = 8'd10;
    198: charMap = 8'd10;
    199: charMap = 8'd10;
    200: charMap = 8'd10;
    201: charMap = 8'd10;
    202: charMap = 8'd10;
    203: charMap = 8'd10;
    204: charMap = 8'd10;
    205: charMap = 8'd10;
    206: charMap = 8'd10;
    207: charMap = 8'd10;
    208: charMap = 8'd10;
    209: charMap = 8'd10;
    210: charMap = 8'd10;
    211: charMap = 8'd10;
    212: charMap = 8'd10;
    213: charMap = 8'd10;
    214: charMap = 8'd10;
    215: charMap = 8'd10;
    216: charMap = 8'd10;
    217: charMap = 8'd10;
    218: charMap = 8'd10;
    219: charMap = 8'd10;
    220: charMap = 8'd10;
    221: charMap = 8'd10;
    222: charMap = 8'd10;
    223: charMap = 8'd10;
    224: charMap = 8'd10;
    225: charMap = 8'd10;
    226: charMap = 8'd10;
    227: charMap = 8'd10;
    228: charMap = 8'd10;
    229: charMap = 8'd10;
    230: charMap = 8'd10;
    231: charMap = 8'd10;
    232: charMap = 8'd10;
    233: charMap = 8'd10;
    234: charMap = 8'd10;
    235: charMap = 8'd10;
    236: charMap = 8'd10;
    237: charMap = 8'd10;
    238: charMap = 8'd10;
    239: charMap = 8'd10;
    240: charMap = 8'd10;
    241: charMap = 8'd10;
    242: charMap = 8'd10;
    243: charMap = 8'd10;
    244: charMap = 8'd10;
    245: charMap = 8'd10;
    246: charMap = 8'd10;
    247: charMap = 8'd10;
    248: charMap = 8'd10;
    249: charMap = 8'd10;
    250: charMap = 8'd10;
    251: charMap = 8'd10;
    252: charMap = 8'd10;
    253: charMap = 8'd10;
    254: charMap = 8'd10;
    255: charMap = 8'd10;
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
    14: stateMap = 11'd13;
    15: stateMap = 11'd14;
    16: stateMap = 11'd15;
    17: stateMap = 11'd16;
    18: stateMap = 11'd17;
    19: stateMap = 11'd18;
    20: stateMap = 11'd19;
    21: stateMap = 11'd20;
    22: stateMap = 11'd21;
    23: stateMap = 11'd2;
    24: stateMap = 11'd16;
    25: stateMap = 11'd22;
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
    17: acceptStates = 1'b1;
    18: acceptStates = 1'b0;
    19: acceptStates = 1'b0;
    20: acceptStates = 1'b0;
    21: acceptStates = 1'b0;
    22: acceptStates = 1'b0;
    23: acceptStates = 1'b0;
    24: acceptStates = 1'b0;
    25: acceptStates = 1'b0;
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
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd3;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd5;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd5;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd3;
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
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd3;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd5;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd5;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd3;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd5;
      6: stateTransition = 11'd5;
      7: stateTransition = 11'd5;
      8: stateTransition = 11'd5;
      9: stateTransition = 11'd5;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd5;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd7;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd8;
      5: stateTransition = 11'd22;
      6: stateTransition = 11'd22;
      7: stateTransition = 11'd9;
      8: stateTransition = 11'd22;
      9: stateTransition = 11'd22;
      10: stateTransition = 11'd10;
      11: stateTransition = 11'd7;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd19;
      6: stateTransition = 11'd19;
      7: stateTransition = 11'd19;
      8: stateTransition = 11'd19;
      9: stateTransition = 11'd19;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd13;
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd12;
      7: stateTransition = 11'd12;
      8: stateTransition = 11'd12;
      9: stateTransition = 11'd12;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd12;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
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
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd6;
      9: stateTransition = 11'd6;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd4;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd4;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd6;
      9: stateTransition = 11'd6;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd18;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd18;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd25;
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
