`timescale 1ns/1ps

`define ENABLED_REGEX_nntp_3 TRUE

module nntp_3_verilog(clk,
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


`ifdef ENABLED_REGEX_nntp_3

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd9;
    1: charMap = 8'd9;
    2: charMap = 8'd9;
    3: charMap = 8'd9;
    4: charMap = 8'd9;
    5: charMap = 8'd9;
    6: charMap = 8'd9;
    7: charMap = 8'd9;
    8: charMap = 8'd9;
    9: charMap = 8'd9;
    10: charMap = 8'd0;
    11: charMap = 8'd9;
    12: charMap = 8'd9;
    13: charMap = 8'd9;
    14: charMap = 8'd9;
    15: charMap = 8'd9;
    16: charMap = 8'd9;
    17: charMap = 8'd9;
    18: charMap = 8'd9;
    19: charMap = 8'd9;
    20: charMap = 8'd9;
    21: charMap = 8'd9;
    22: charMap = 8'd9;
    23: charMap = 8'd9;
    24: charMap = 8'd9;
    25: charMap = 8'd9;
    26: charMap = 8'd9;
    27: charMap = 8'd9;
    28: charMap = 8'd9;
    29: charMap = 8'd9;
    30: charMap = 8'd9;
    31: charMap = 8'd9;
    32: charMap = 8'd9;
    33: charMap = 8'd9;
    34: charMap = 8'd9;
    35: charMap = 8'd9;
    36: charMap = 8'd9;
    37: charMap = 8'd9;
    38: charMap = 8'd9;
    39: charMap = 8'd9;
    40: charMap = 8'd9;
    41: charMap = 8'd9;
    42: charMap = 8'd9;
    43: charMap = 8'd9;
    44: charMap = 8'd9;
    45: charMap = 8'd9;
    46: charMap = 8'd9;
    47: charMap = 8'd9;
    48: charMap = 8'd9;
    49: charMap = 8'd9;
    50: charMap = 8'd9;
    51: charMap = 8'd9;
    52: charMap = 8'd9;
    53: charMap = 8'd9;
    54: charMap = 8'd9;
    55: charMap = 8'd9;
    56: charMap = 8'd9;
    57: charMap = 8'd9;
    58: charMap = 8'd8;
    59: charMap = 8'd9;
    60: charMap = 8'd9;
    61: charMap = 8'd9;
    62: charMap = 8'd9;
    63: charMap = 8'd9;
    64: charMap = 8'd9;
    65: charMap = 8'd9;
    66: charMap = 8'd9;
    67: charMap = 8'd9;
    68: charMap = 8'd9;
    69: charMap = 8'd2;
    70: charMap = 8'd9;
    71: charMap = 8'd9;
    72: charMap = 8'd9;
    73: charMap = 8'd5;
    74: charMap = 8'd9;
    75: charMap = 8'd9;
    76: charMap = 8'd9;
    77: charMap = 8'd9;
    78: charMap = 8'd7;
    79: charMap = 8'd6;
    80: charMap = 8'd9;
    81: charMap = 8'd9;
    82: charMap = 8'd3;
    83: charMap = 8'd4;
    84: charMap = 8'd9;
    85: charMap = 8'd9;
    86: charMap = 8'd1;
    87: charMap = 8'd9;
    88: charMap = 8'd9;
    89: charMap = 8'd9;
    90: charMap = 8'd9;
    91: charMap = 8'd9;
    92: charMap = 8'd9;
    93: charMap = 8'd9;
    94: charMap = 8'd9;
    95: charMap = 8'd9;
    96: charMap = 8'd9;
    97: charMap = 8'd9;
    98: charMap = 8'd9;
    99: charMap = 8'd9;
    100: charMap = 8'd9;
    101: charMap = 8'd2;
    102: charMap = 8'd9;
    103: charMap = 8'd9;
    104: charMap = 8'd9;
    105: charMap = 8'd5;
    106: charMap = 8'd9;
    107: charMap = 8'd9;
    108: charMap = 8'd9;
    109: charMap = 8'd9;
    110: charMap = 8'd7;
    111: charMap = 8'd6;
    112: charMap = 8'd9;
    113: charMap = 8'd9;
    114: charMap = 8'd3;
    115: charMap = 8'd4;
    116: charMap = 8'd9;
    117: charMap = 8'd9;
    118: charMap = 8'd1;
    119: charMap = 8'd9;
    120: charMap = 8'd9;
    121: charMap = 8'd9;
    122: charMap = 8'd9;
    123: charMap = 8'd9;
    124: charMap = 8'd9;
    125: charMap = 8'd9;
    126: charMap = 8'd9;
    127: charMap = 8'd9;
    128: charMap = 8'd9;
    129: charMap = 8'd9;
    130: charMap = 8'd9;
    131: charMap = 8'd9;
    132: charMap = 8'd9;
    133: charMap = 8'd9;
    134: charMap = 8'd9;
    135: charMap = 8'd9;
    136: charMap = 8'd9;
    137: charMap = 8'd9;
    138: charMap = 8'd9;
    139: charMap = 8'd9;
    140: charMap = 8'd9;
    141: charMap = 8'd9;
    142: charMap = 8'd9;
    143: charMap = 8'd9;
    144: charMap = 8'd9;
    145: charMap = 8'd9;
    146: charMap = 8'd9;
    147: charMap = 8'd9;
    148: charMap = 8'd9;
    149: charMap = 8'd9;
    150: charMap = 8'd9;
    151: charMap = 8'd9;
    152: charMap = 8'd9;
    153: charMap = 8'd9;
    154: charMap = 8'd9;
    155: charMap = 8'd9;
    156: charMap = 8'd9;
    157: charMap = 8'd9;
    158: charMap = 8'd9;
    159: charMap = 8'd9;
    160: charMap = 8'd9;
    161: charMap = 8'd9;
    162: charMap = 8'd9;
    163: charMap = 8'd9;
    164: charMap = 8'd9;
    165: charMap = 8'd9;
    166: charMap = 8'd9;
    167: charMap = 8'd9;
    168: charMap = 8'd9;
    169: charMap = 8'd9;
    170: charMap = 8'd9;
    171: charMap = 8'd9;
    172: charMap = 8'd9;
    173: charMap = 8'd9;
    174: charMap = 8'd9;
    175: charMap = 8'd9;
    176: charMap = 8'd9;
    177: charMap = 8'd9;
    178: charMap = 8'd9;
    179: charMap = 8'd9;
    180: charMap = 8'd9;
    181: charMap = 8'd9;
    182: charMap = 8'd9;
    183: charMap = 8'd9;
    184: charMap = 8'd9;
    185: charMap = 8'd9;
    186: charMap = 8'd9;
    187: charMap = 8'd9;
    188: charMap = 8'd9;
    189: charMap = 8'd9;
    190: charMap = 8'd9;
    191: charMap = 8'd9;
    192: charMap = 8'd9;
    193: charMap = 8'd9;
    194: charMap = 8'd9;
    195: charMap = 8'd9;
    196: charMap = 8'd9;
    197: charMap = 8'd9;
    198: charMap = 8'd9;
    199: charMap = 8'd9;
    200: charMap = 8'd9;
    201: charMap = 8'd9;
    202: charMap = 8'd9;
    203: charMap = 8'd9;
    204: charMap = 8'd9;
    205: charMap = 8'd9;
    206: charMap = 8'd9;
    207: charMap = 8'd9;
    208: charMap = 8'd9;
    209: charMap = 8'd9;
    210: charMap = 8'd9;
    211: charMap = 8'd9;
    212: charMap = 8'd9;
    213: charMap = 8'd9;
    214: charMap = 8'd9;
    215: charMap = 8'd9;
    216: charMap = 8'd9;
    217: charMap = 8'd9;
    218: charMap = 8'd9;
    219: charMap = 8'd9;
    220: charMap = 8'd9;
    221: charMap = 8'd9;
    222: charMap = 8'd9;
    223: charMap = 8'd9;
    224: charMap = 8'd9;
    225: charMap = 8'd9;
    226: charMap = 8'd9;
    227: charMap = 8'd9;
    228: charMap = 8'd9;
    229: charMap = 8'd9;
    230: charMap = 8'd9;
    231: charMap = 8'd9;
    232: charMap = 8'd9;
    233: charMap = 8'd9;
    234: charMap = 8'd9;
    235: charMap = 8'd9;
    236: charMap = 8'd9;
    237: charMap = 8'd9;
    238: charMap = 8'd9;
    239: charMap = 8'd9;
    240: charMap = 8'd9;
    241: charMap = 8'd9;
    242: charMap = 8'd9;
    243: charMap = 8'd9;
    244: charMap = 8'd9;
    245: charMap = 8'd9;
    246: charMap = 8'd9;
    247: charMap = 8'd9;
    248: charMap = 8'd9;
    249: charMap = 8'd9;
    250: charMap = 8'd9;
    251: charMap = 8'd9;
    252: charMap = 8'd9;
    253: charMap = 8'd9;
    254: charMap = 8'd9;
    255: charMap = 8'd9;
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
      10: stateTransition = 11'd1;
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
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd6;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd7;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
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
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd30;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd30;
      5: stateTransition = 11'd30;
      6: stateTransition = 11'd30;
      7: stateTransition = 11'd30;
      8: stateTransition = 11'd30;
      9: stateTransition = 11'd30;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd2;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd2;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd2;
      8: stateTransition = 11'd2;
      9: stateTransition = 11'd2;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd11;
      6: stateTransition = 11'd11;
      7: stateTransition = 11'd11;
      8: stateTransition = 11'd11;
      9: stateTransition = 11'd11;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd12;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd12;
      7: stateTransition = 11'd12;
      8: stateTransition = 11'd12;
      9: stateTransition = 11'd12;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd13;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd13;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd13;
      8: stateTransition = 11'd13;
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd15;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd15;
      7: stateTransition = 11'd15;
      8: stateTransition = 11'd15;
      9: stateTransition = 11'd15;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd16;
      6: stateTransition = 11'd16;
      7: stateTransition = 11'd16;
      8: stateTransition = 11'd16;
      9: stateTransition = 11'd16;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd17;
      8: stateTransition = 11'd17;
      9: stateTransition = 11'd17;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd18;
      7: stateTransition = 11'd18;
      8: stateTransition = 11'd18;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd19;
      5: stateTransition = 11'd19;
      6: stateTransition = 11'd19;
      7: stateTransition = 11'd19;
      8: stateTransition = 11'd19;
      9: stateTransition = 11'd19;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd20;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd20;
      6: stateTransition = 11'd20;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd20;
      9: stateTransition = 11'd20;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd21;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd21;
      9: stateTransition = 11'd21;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd22;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd22;
      5: stateTransition = 11'd22;
      6: stateTransition = 11'd22;
      7: stateTransition = 11'd22;
      8: stateTransition = 11'd22;
      9: stateTransition = 11'd22;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd23;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd23;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd24;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
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
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd26;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd26;
      5: stateTransition = 11'd26;
      6: stateTransition = 11'd26;
      7: stateTransition = 11'd26;
      8: stateTransition = 11'd26;
      9: stateTransition = 11'd26;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd27;
      6: stateTransition = 11'd27;
      7: stateTransition = 11'd27;
      8: stateTransition = 11'd27;
      9: stateTransition = 11'd27;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd28;
      5: stateTransition = 11'd28;
      6: stateTransition = 11'd28;
      7: stateTransition = 11'd28;
      8: stateTransition = 11'd28;
      9: stateTransition = 11'd28;
      10: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
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
      10: stateTransition = 11'd0;
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
