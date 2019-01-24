`timescale 1ns/1ps

`define ENABLED_REGEX_pop3_8 TRUE

module pop3_8_verilog(clk,
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


`ifdef ENABLED_REGEX_pop3_8

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd6;
    1: charMap = 8'd6;
    2: charMap = 8'd6;
    3: charMap = 8'd6;
    4: charMap = 8'd6;
    5: charMap = 8'd6;
    6: charMap = 8'd6;
    7: charMap = 8'd6;
    8: charMap = 8'd6;
    9: charMap = 8'd7;
    10: charMap = 8'd5;
    11: charMap = 8'd7;
    12: charMap = 8'd6;
    13: charMap = 8'd7;
    14: charMap = 8'd6;
    15: charMap = 8'd6;
    16: charMap = 8'd6;
    17: charMap = 8'd6;
    18: charMap = 8'd6;
    19: charMap = 8'd6;
    20: charMap = 8'd6;
    21: charMap = 8'd6;
    22: charMap = 8'd6;
    23: charMap = 8'd6;
    24: charMap = 8'd6;
    25: charMap = 8'd6;
    26: charMap = 8'd6;
    27: charMap = 8'd6;
    28: charMap = 8'd6;
    29: charMap = 8'd6;
    30: charMap = 8'd6;
    31: charMap = 8'd6;
    32: charMap = 8'd7;
    33: charMap = 8'd6;
    34: charMap = 8'd6;
    35: charMap = 8'd6;
    36: charMap = 8'd6;
    37: charMap = 8'd6;
    38: charMap = 8'd6;
    39: charMap = 8'd6;
    40: charMap = 8'd6;
    41: charMap = 8'd6;
    42: charMap = 8'd6;
    43: charMap = 8'd6;
    44: charMap = 8'd6;
    45: charMap = 8'd6;
    46: charMap = 8'd6;
    47: charMap = 8'd6;
    48: charMap = 8'd6;
    49: charMap = 8'd6;
    50: charMap = 8'd6;
    51: charMap = 8'd6;
    52: charMap = 8'd6;
    53: charMap = 8'd6;
    54: charMap = 8'd6;
    55: charMap = 8'd6;
    56: charMap = 8'd6;
    57: charMap = 8'd6;
    58: charMap = 8'd6;
    59: charMap = 8'd6;
    60: charMap = 8'd6;
    61: charMap = 8'd6;
    62: charMap = 8'd6;
    63: charMap = 8'd6;
    64: charMap = 8'd6;
    65: charMap = 8'd1;
    66: charMap = 8'd6;
    67: charMap = 8'd6;
    68: charMap = 8'd6;
    69: charMap = 8'd6;
    70: charMap = 8'd6;
    71: charMap = 8'd6;
    72: charMap = 8'd4;
    73: charMap = 8'd6;
    74: charMap = 8'd6;
    75: charMap = 8'd6;
    76: charMap = 8'd6;
    77: charMap = 8'd6;
    78: charMap = 8'd6;
    79: charMap = 8'd6;
    80: charMap = 8'd6;
    81: charMap = 8'd6;
    82: charMap = 8'd6;
    83: charMap = 8'd6;
    84: charMap = 8'd3;
    85: charMap = 8'd2;
    86: charMap = 8'd6;
    87: charMap = 8'd6;
    88: charMap = 8'd6;
    89: charMap = 8'd6;
    90: charMap = 8'd6;
    91: charMap = 8'd6;
    92: charMap = 8'd6;
    93: charMap = 8'd6;
    94: charMap = 8'd6;
    95: charMap = 8'd6;
    96: charMap = 8'd6;
    97: charMap = 8'd1;
    98: charMap = 8'd6;
    99: charMap = 8'd6;
    100: charMap = 8'd6;
    101: charMap = 8'd6;
    102: charMap = 8'd6;
    103: charMap = 8'd6;
    104: charMap = 8'd4;
    105: charMap = 8'd6;
    106: charMap = 8'd6;
    107: charMap = 8'd6;
    108: charMap = 8'd6;
    109: charMap = 8'd6;
    110: charMap = 8'd6;
    111: charMap = 8'd6;
    112: charMap = 8'd6;
    113: charMap = 8'd6;
    114: charMap = 8'd6;
    115: charMap = 8'd6;
    116: charMap = 8'd3;
    117: charMap = 8'd2;
    118: charMap = 8'd6;
    119: charMap = 8'd6;
    120: charMap = 8'd6;
    121: charMap = 8'd6;
    122: charMap = 8'd6;
    123: charMap = 8'd6;
    124: charMap = 8'd6;
    125: charMap = 8'd6;
    126: charMap = 8'd6;
    127: charMap = 8'd6;
    128: charMap = 8'd6;
    129: charMap = 8'd6;
    130: charMap = 8'd6;
    131: charMap = 8'd6;
    132: charMap = 8'd6;
    133: charMap = 8'd6;
    134: charMap = 8'd6;
    135: charMap = 8'd6;
    136: charMap = 8'd6;
    137: charMap = 8'd6;
    138: charMap = 8'd6;
    139: charMap = 8'd6;
    140: charMap = 8'd6;
    141: charMap = 8'd6;
    142: charMap = 8'd6;
    143: charMap = 8'd6;
    144: charMap = 8'd6;
    145: charMap = 8'd6;
    146: charMap = 8'd6;
    147: charMap = 8'd6;
    148: charMap = 8'd6;
    149: charMap = 8'd6;
    150: charMap = 8'd6;
    151: charMap = 8'd6;
    152: charMap = 8'd6;
    153: charMap = 8'd6;
    154: charMap = 8'd6;
    155: charMap = 8'd6;
    156: charMap = 8'd6;
    157: charMap = 8'd6;
    158: charMap = 8'd6;
    159: charMap = 8'd6;
    160: charMap = 8'd6;
    161: charMap = 8'd6;
    162: charMap = 8'd6;
    163: charMap = 8'd6;
    164: charMap = 8'd6;
    165: charMap = 8'd6;
    166: charMap = 8'd6;
    167: charMap = 8'd6;
    168: charMap = 8'd6;
    169: charMap = 8'd6;
    170: charMap = 8'd6;
    171: charMap = 8'd6;
    172: charMap = 8'd6;
    173: charMap = 8'd6;
    174: charMap = 8'd6;
    175: charMap = 8'd6;
    176: charMap = 8'd6;
    177: charMap = 8'd6;
    178: charMap = 8'd6;
    179: charMap = 8'd6;
    180: charMap = 8'd6;
    181: charMap = 8'd6;
    182: charMap = 8'd6;
    183: charMap = 8'd6;
    184: charMap = 8'd6;
    185: charMap = 8'd6;
    186: charMap = 8'd6;
    187: charMap = 8'd6;
    188: charMap = 8'd6;
    189: charMap = 8'd6;
    190: charMap = 8'd6;
    191: charMap = 8'd6;
    192: charMap = 8'd6;
    193: charMap = 8'd6;
    194: charMap = 8'd6;
    195: charMap = 8'd6;
    196: charMap = 8'd6;
    197: charMap = 8'd6;
    198: charMap = 8'd6;
    199: charMap = 8'd6;
    200: charMap = 8'd6;
    201: charMap = 8'd6;
    202: charMap = 8'd6;
    203: charMap = 8'd6;
    204: charMap = 8'd6;
    205: charMap = 8'd6;
    206: charMap = 8'd6;
    207: charMap = 8'd6;
    208: charMap = 8'd6;
    209: charMap = 8'd6;
    210: charMap = 8'd6;
    211: charMap = 8'd6;
    212: charMap = 8'd6;
    213: charMap = 8'd6;
    214: charMap = 8'd6;
    215: charMap = 8'd6;
    216: charMap = 8'd6;
    217: charMap = 8'd6;
    218: charMap = 8'd6;
    219: charMap = 8'd6;
    220: charMap = 8'd6;
    221: charMap = 8'd6;
    222: charMap = 8'd6;
    223: charMap = 8'd6;
    224: charMap = 8'd6;
    225: charMap = 8'd6;
    226: charMap = 8'd6;
    227: charMap = 8'd6;
    228: charMap = 8'd6;
    229: charMap = 8'd6;
    230: charMap = 8'd6;
    231: charMap = 8'd6;
    232: charMap = 8'd6;
    233: charMap = 8'd6;
    234: charMap = 8'd6;
    235: charMap = 8'd6;
    236: charMap = 8'd6;
    237: charMap = 8'd6;
    238: charMap = 8'd6;
    239: charMap = 8'd6;
    240: charMap = 8'd6;
    241: charMap = 8'd6;
    242: charMap = 8'd6;
    243: charMap = 8'd6;
    244: charMap = 8'd6;
    245: charMap = 8'd6;
    246: charMap = 8'd6;
    247: charMap = 8'd6;
    248: charMap = 8'd6;
    249: charMap = 8'd6;
    250: charMap = 8'd6;
    251: charMap = 8'd6;
    252: charMap = 8'd6;
    253: charMap = 8'd6;
    254: charMap = 8'd6;
    255: charMap = 8'd6;
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
      7: stateTransition = 11'd7;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd56;
      2: stateTransition = 11'd56;
      3: stateTransition = 11'd56;
      4: stateTransition = 11'd56;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd56;
      7: stateTransition = 11'd56;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd2;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd2;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd8;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd8;
      7: stateTransition = 11'd8;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd9;
      4: stateTransition = 11'd9;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd9;
      7: stateTransition = 11'd9;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd11;
      7: stateTransition = 11'd11;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd12;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd12;
      7: stateTransition = 11'd12;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd13;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd13;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd15;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd15;
      7: stateTransition = 11'd15;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd16;
      7: stateTransition = 11'd16;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd17;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd18;
      7: stateTransition = 11'd18;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd19;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd19;
      7: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd20;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd20;
      7: stateTransition = 11'd20;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd21;
      7: stateTransition = 11'd21;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd22;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd22;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd22;
      7: stateTransition = 11'd22;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd23;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd23;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd24;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd26;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd26;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd26;
      7: stateTransition = 11'd26;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd27;
      7: stateTransition = 11'd27;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd28;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd28;
      7: stateTransition = 11'd28;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd29;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd30;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd30;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd30;
      7: stateTransition = 11'd30;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd31;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd31;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd31;
      7: stateTransition = 11'd31;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd32;
      3: stateTransition = 11'd32;
      4: stateTransition = 11'd32;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd32;
      7: stateTransition = 11'd32;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd33;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd33;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd33;
      7: stateTransition = 11'd33;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd34;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd34;
      7: stateTransition = 11'd34;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd35;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd35;
      4: stateTransition = 11'd35;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd35;
      7: stateTransition = 11'd35;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd36;
      2: stateTransition = 11'd36;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd36;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd36;
      7: stateTransition = 11'd36;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd37;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd37;
      4: stateTransition = 11'd37;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd37;
      7: stateTransition = 11'd37;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd38;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd38;
      4: stateTransition = 11'd38;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd38;
      7: stateTransition = 11'd38;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd39;
      2: stateTransition = 11'd39;
      3: stateTransition = 11'd39;
      4: stateTransition = 11'd39;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd39;
      7: stateTransition = 11'd39;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd40;
      2: stateTransition = 11'd40;
      3: stateTransition = 11'd40;
      4: stateTransition = 11'd40;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd40;
      7: stateTransition = 11'd40;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd41;
      2: stateTransition = 11'd41;
      3: stateTransition = 11'd41;
      4: stateTransition = 11'd41;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd41;
      7: stateTransition = 11'd41;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd42;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd42;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd42;
      7: stateTransition = 11'd42;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd43;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd43;
      4: stateTransition = 11'd43;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd43;
      7: stateTransition = 11'd43;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd44;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd44;
      4: stateTransition = 11'd44;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd44;
      7: stateTransition = 11'd44;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd45;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd45;
      4: stateTransition = 11'd45;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd45;
      7: stateTransition = 11'd45;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd46;
      2: stateTransition = 11'd46;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd46;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd46;
      7: stateTransition = 11'd46;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd47;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd47;
      4: stateTransition = 11'd47;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd47;
      7: stateTransition = 11'd47;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd48;
      2: stateTransition = 11'd48;
      3: stateTransition = 11'd48;
      4: stateTransition = 11'd48;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd48;
      7: stateTransition = 11'd48;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd49;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd49;
      4: stateTransition = 11'd49;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd49;
      7: stateTransition = 11'd49;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd50;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd50;
      4: stateTransition = 11'd50;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd50;
      7: stateTransition = 11'd50;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd51;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd51;
      4: stateTransition = 11'd51;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd51;
      7: stateTransition = 11'd51;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd52;
      2: stateTransition = 11'd52;
      3: stateTransition = 11'd52;
      4: stateTransition = 11'd52;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd52;
      7: stateTransition = 11'd52;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd53;
      2: stateTransition = 11'd53;
      3: stateTransition = 11'd53;
      4: stateTransition = 11'd53;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd53;
      7: stateTransition = 11'd53;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd54;
      3: stateTransition = 11'd54;
      4: stateTransition = 11'd54;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd54;
      7: stateTransition = 11'd54;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd55;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd55;
      4: stateTransition = 11'd55;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd55;
      7: stateTransition = 11'd55;
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
