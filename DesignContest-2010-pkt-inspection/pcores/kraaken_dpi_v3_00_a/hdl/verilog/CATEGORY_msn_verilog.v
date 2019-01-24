`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_msn TRUE

module CATEGORY_msn_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_msn

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd0;
    1: charMap = 8'd0;
    2: charMap = 8'd0;
    3: charMap = 8'd0;
    4: charMap = 8'd0;
    5: charMap = 8'd0;
    6: charMap = 8'd0;
    7: charMap = 8'd0;
    8: charMap = 8'd0;
    9: charMap = 8'd11;
    10: charMap = 8'd14;
    11: charMap = 8'd11;
    12: charMap = 8'd11;
    13: charMap = 8'd13;
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
    32: charMap = 8'd4;
    33: charMap = 8'd17;
    34: charMap = 8'd17;
    35: charMap = 8'd17;
    36: charMap = 8'd17;
    37: charMap = 8'd17;
    38: charMap = 8'd17;
    39: charMap = 8'd17;
    40: charMap = 8'd17;
    41: charMap = 8'd17;
    42: charMap = 8'd17;
    43: charMap = 8'd17;
    44: charMap = 8'd17;
    45: charMap = 8'd17;
    46: charMap = 8'd18;
    47: charMap = 8'd17;
    48: charMap = 8'd5;
    49: charMap = 8'd16;
    50: charMap = 8'd10;
    51: charMap = 8'd10;
    52: charMap = 8'd10;
    53: charMap = 8'd10;
    54: charMap = 8'd10;
    55: charMap = 8'd10;
    56: charMap = 8'd10;
    57: charMap = 8'd10;
    58: charMap = 8'd17;
    59: charMap = 8'd17;
    60: charMap = 8'd17;
    61: charMap = 8'd17;
    62: charMap = 8'd17;
    63: charMap = 8'd17;
    64: charMap = 8'd17;
    65: charMap = 8'd17;
    66: charMap = 8'd17;
    67: charMap = 8'd17;
    68: charMap = 8'd17;
    69: charMap = 8'd17;
    70: charMap = 8'd17;
    71: charMap = 8'd17;
    72: charMap = 8'd17;
    73: charMap = 8'd17;
    74: charMap = 8'd17;
    75: charMap = 8'd17;
    76: charMap = 8'd17;
    77: charMap = 8'd17;
    78: charMap = 8'd17;
    79: charMap = 8'd17;
    80: charMap = 8'd17;
    81: charMap = 8'd17;
    82: charMap = 8'd17;
    83: charMap = 8'd17;
    84: charMap = 8'd17;
    85: charMap = 8'd17;
    86: charMap = 8'd17;
    87: charMap = 8'd17;
    88: charMap = 8'd17;
    89: charMap = 8'd17;
    90: charMap = 8'd17;
    91: charMap = 8'd17;
    92: charMap = 8'd17;
    93: charMap = 8'd17;
    94: charMap = 8'd17;
    95: charMap = 8'd17;
    96: charMap = 8'd17;
    97: charMap = 8'd19;
    98: charMap = 8'd17;
    99: charMap = 8'd12;
    100: charMap = 8'd17;
    101: charMap = 8'd2;
    102: charMap = 8'd17;
    103: charMap = 8'd17;
    104: charMap = 8'd17;
    105: charMap = 8'd17;
    106: charMap = 8'd17;
    107: charMap = 8'd17;
    108: charMap = 8'd17;
    109: charMap = 8'd6;
    110: charMap = 8'd8;
    111: charMap = 8'd17;
    112: charMap = 8'd9;
    113: charMap = 8'd17;
    114: charMap = 8'd3;
    115: charMap = 8'd7;
    116: charMap = 8'd17;
    117: charMap = 8'd15;
    118: charMap = 8'd1;
    119: charMap = 8'd17;
    120: charMap = 8'd17;
    121: charMap = 8'd17;
    122: charMap = 8'd17;
    123: charMap = 8'd17;
    124: charMap = 8'd17;
    125: charMap = 8'd17;
    126: charMap = 8'd17;
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
    25: stateMap = 11'd3;
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
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd5;
      16: stateTransition = 11'd0;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd6;
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
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd25;
      14: stateTransition = 11'd25;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
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
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd30;
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
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd8;
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
      3: stateTransition = 11'd9;
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
    7: case ( mapped_char ) 
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
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd10;
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
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd12;
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
      16: stateTransition = 11'd13;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd12;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd12;
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
      4: stateTransition = 11'd15;
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
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd16;
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
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd17;
      8: stateTransition = 11'd17;
      9: stateTransition = 11'd17;
      10: stateTransition = 11'd17;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd17;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd17;
      16: stateTransition = 11'd17;
      17: stateTransition = 11'd17;
      18: stateTransition = 11'd17;
      19: stateTransition = 11'd17;
      20: stateTransition = 11'd0;
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
      7: stateTransition = 11'd18;
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
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd19;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd17;
      8: stateTransition = 11'd17;
      9: stateTransition = 11'd17;
      10: stateTransition = 11'd17;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd17;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd17;
      16: stateTransition = 11'd17;
      17: stateTransition = 11'd17;
      18: stateTransition = 11'd17;
      19: stateTransition = 11'd17;
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
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd20;
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
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd21;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd21;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd21;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
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
      9: stateTransition = 11'd22;
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
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd21;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd23;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd21;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd21;
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
      10: stateTransition = 11'd24;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd24;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
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
      14: stateTransition = 11'd2;
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
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd29;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd29;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      15: stateTransition = 11'd0;
      16: stateTransition = 11'd29;
      17: stateTransition = 11'd0;
      18: stateTransition = 11'd0;
      19: stateTransition = 11'd0;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd25;
      14: stateTransition = 11'd4;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd11;
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
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd26;
      14: stateTransition = 11'd25;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd25;
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
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd27;
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
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd28;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd25;
      14: stateTransition = 11'd25;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd25;
      14: stateTransition = 11'd25;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
      20: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      10: stateTransition = 11'd25;
      11: stateTransition = 11'd25;
      12: stateTransition = 11'd33;
      13: stateTransition = 11'd25;
      14: stateTransition = 11'd25;
      15: stateTransition = 11'd25;
      16: stateTransition = 11'd25;
      17: stateTransition = 11'd25;
      18: stateTransition = 11'd25;
      19: stateTransition = 11'd25;
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
