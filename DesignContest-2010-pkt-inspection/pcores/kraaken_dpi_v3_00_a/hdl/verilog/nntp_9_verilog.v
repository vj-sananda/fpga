`timescale 1ns/1ps

`define ENABLED_REGEX_nntp_9 TRUE

module nntp_9_verilog(clk,
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


`ifdef ENABLED_REGEX_nntp_9

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd8;
    1: charMap = 8'd8;
    2: charMap = 8'd8;
    3: charMap = 8'd8;
    4: charMap = 8'd8;
    5: charMap = 8'd8;
    6: charMap = 8'd8;
    7: charMap = 8'd8;
    8: charMap = 8'd8;
    9: charMap = 8'd8;
    10: charMap = 8'd12;
    11: charMap = 8'd8;
    12: charMap = 8'd8;
    13: charMap = 8'd11;
    14: charMap = 8'd8;
    15: charMap = 8'd8;
    16: charMap = 8'd8;
    17: charMap = 8'd8;
    18: charMap = 8'd8;
    19: charMap = 8'd8;
    20: charMap = 8'd8;
    21: charMap = 8'd8;
    22: charMap = 8'd8;
    23: charMap = 8'd8;
    24: charMap = 8'd8;
    25: charMap = 8'd8;
    26: charMap = 8'd8;
    27: charMap = 8'd8;
    28: charMap = 8'd8;
    29: charMap = 8'd8;
    30: charMap = 8'd8;
    31: charMap = 8'd8;
    32: charMap = 8'd8;
    33: charMap = 8'd8;
    34: charMap = 8'd8;
    35: charMap = 8'd8;
    36: charMap = 8'd8;
    37: charMap = 8'd8;
    38: charMap = 8'd8;
    39: charMap = 8'd8;
    40: charMap = 8'd8;
    41: charMap = 8'd8;
    42: charMap = 8'd8;
    43: charMap = 8'd8;
    44: charMap = 8'd8;
    45: charMap = 8'd8;
    46: charMap = 8'd8;
    47: charMap = 8'd8;
    48: charMap = 8'd8;
    49: charMap = 8'd8;
    50: charMap = 8'd8;
    51: charMap = 8'd8;
    52: charMap = 8'd8;
    53: charMap = 8'd8;
    54: charMap = 8'd8;
    55: charMap = 8'd8;
    56: charMap = 8'd8;
    57: charMap = 8'd8;
    58: charMap = 8'd10;
    59: charMap = 8'd8;
    60: charMap = 8'd8;
    61: charMap = 8'd8;
    62: charMap = 8'd8;
    63: charMap = 8'd8;
    64: charMap = 8'd8;
    65: charMap = 8'd2;
    66: charMap = 8'd8;
    67: charMap = 8'd8;
    68: charMap = 8'd8;
    69: charMap = 8'd4;
    70: charMap = 8'd8;
    71: charMap = 8'd8;
    72: charMap = 8'd5;
    73: charMap = 8'd6;
    74: charMap = 8'd8;
    75: charMap = 8'd3;
    76: charMap = 8'd8;
    77: charMap = 8'd8;
    78: charMap = 8'd8;
    79: charMap = 8'd8;
    80: charMap = 8'd9;
    81: charMap = 8'd8;
    82: charMap = 8'd8;
    83: charMap = 8'd7;
    84: charMap = 8'd1;
    85: charMap = 8'd8;
    86: charMap = 8'd8;
    87: charMap = 8'd8;
    88: charMap = 8'd8;
    89: charMap = 8'd8;
    90: charMap = 8'd8;
    91: charMap = 8'd8;
    92: charMap = 8'd8;
    93: charMap = 8'd8;
    94: charMap = 8'd8;
    95: charMap = 8'd8;
    96: charMap = 8'd8;
    97: charMap = 8'd2;
    98: charMap = 8'd8;
    99: charMap = 8'd8;
    100: charMap = 8'd8;
    101: charMap = 8'd4;
    102: charMap = 8'd8;
    103: charMap = 8'd8;
    104: charMap = 8'd5;
    105: charMap = 8'd6;
    106: charMap = 8'd8;
    107: charMap = 8'd3;
    108: charMap = 8'd8;
    109: charMap = 8'd8;
    110: charMap = 8'd8;
    111: charMap = 8'd8;
    112: charMap = 8'd9;
    113: charMap = 8'd8;
    114: charMap = 8'd8;
    115: charMap = 8'd7;
    116: charMap = 8'd1;
    117: charMap = 8'd8;
    118: charMap = 8'd8;
    119: charMap = 8'd8;
    120: charMap = 8'd8;
    121: charMap = 8'd8;
    122: charMap = 8'd8;
    123: charMap = 8'd8;
    124: charMap = 8'd8;
    125: charMap = 8'd8;
    126: charMap = 8'd8;
    127: charMap = 8'd8;
    128: charMap = 8'd8;
    129: charMap = 8'd8;
    130: charMap = 8'd8;
    131: charMap = 8'd8;
    132: charMap = 8'd8;
    133: charMap = 8'd8;
    134: charMap = 8'd8;
    135: charMap = 8'd8;
    136: charMap = 8'd8;
    137: charMap = 8'd8;
    138: charMap = 8'd8;
    139: charMap = 8'd8;
    140: charMap = 8'd8;
    141: charMap = 8'd8;
    142: charMap = 8'd8;
    143: charMap = 8'd8;
    144: charMap = 8'd8;
    145: charMap = 8'd8;
    146: charMap = 8'd8;
    147: charMap = 8'd8;
    148: charMap = 8'd8;
    149: charMap = 8'd8;
    150: charMap = 8'd8;
    151: charMap = 8'd8;
    152: charMap = 8'd8;
    153: charMap = 8'd8;
    154: charMap = 8'd8;
    155: charMap = 8'd8;
    156: charMap = 8'd8;
    157: charMap = 8'd8;
    158: charMap = 8'd8;
    159: charMap = 8'd8;
    160: charMap = 8'd8;
    161: charMap = 8'd8;
    162: charMap = 8'd8;
    163: charMap = 8'd8;
    164: charMap = 8'd8;
    165: charMap = 8'd8;
    166: charMap = 8'd8;
    167: charMap = 8'd8;
    168: charMap = 8'd8;
    169: charMap = 8'd8;
    170: charMap = 8'd8;
    171: charMap = 8'd8;
    172: charMap = 8'd8;
    173: charMap = 8'd8;
    174: charMap = 8'd8;
    175: charMap = 8'd8;
    176: charMap = 8'd8;
    177: charMap = 8'd8;
    178: charMap = 8'd8;
    179: charMap = 8'd8;
    180: charMap = 8'd8;
    181: charMap = 8'd8;
    182: charMap = 8'd8;
    183: charMap = 8'd8;
    184: charMap = 8'd8;
    185: charMap = 8'd8;
    186: charMap = 8'd8;
    187: charMap = 8'd8;
    188: charMap = 8'd8;
    189: charMap = 8'd8;
    190: charMap = 8'd8;
    191: charMap = 8'd8;
    192: charMap = 8'd8;
    193: charMap = 8'd8;
    194: charMap = 8'd8;
    195: charMap = 8'd8;
    196: charMap = 8'd8;
    197: charMap = 8'd8;
    198: charMap = 8'd8;
    199: charMap = 8'd8;
    200: charMap = 8'd8;
    201: charMap = 8'd8;
    202: charMap = 8'd8;
    203: charMap = 8'd8;
    204: charMap = 8'd8;
    205: charMap = 8'd8;
    206: charMap = 8'd8;
    207: charMap = 8'd8;
    208: charMap = 8'd8;
    209: charMap = 8'd8;
    210: charMap = 8'd8;
    211: charMap = 8'd8;
    212: charMap = 8'd8;
    213: charMap = 8'd8;
    214: charMap = 8'd8;
    215: charMap = 8'd8;
    216: charMap = 8'd8;
    217: charMap = 8'd8;
    218: charMap = 8'd8;
    219: charMap = 8'd8;
    220: charMap = 8'd8;
    221: charMap = 8'd8;
    222: charMap = 8'd8;
    223: charMap = 8'd8;
    224: charMap = 8'd8;
    225: charMap = 8'd8;
    226: charMap = 8'd8;
    227: charMap = 8'd8;
    228: charMap = 8'd8;
    229: charMap = 8'd8;
    230: charMap = 8'd8;
    231: charMap = 8'd8;
    232: charMap = 8'd8;
    233: charMap = 8'd8;
    234: charMap = 8'd8;
    235: charMap = 8'd8;
    236: charMap = 8'd8;
    237: charMap = 8'd8;
    238: charMap = 8'd8;
    239: charMap = 8'd8;
    240: charMap = 8'd8;
    241: charMap = 8'd8;
    242: charMap = 8'd8;
    243: charMap = 8'd8;
    244: charMap = 8'd8;
    245: charMap = 8'd8;
    246: charMap = 8'd8;
    247: charMap = 8'd8;
    248: charMap = 8'd8;
    249: charMap = 8'd8;
    250: charMap = 8'd8;
    251: charMap = 8'd8;
    252: charMap = 8'd8;
    253: charMap = 8'd8;
    254: charMap = 8'd8;
    255: charMap = 8'd8;
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
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
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
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd7;
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
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd8;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
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
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd10;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
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
      10: stateTransition = 11'd11;
      11: stateTransition = 11'd12;
      12: stateTransition = 11'd13;
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
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd13;
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
      12: stateTransition = 11'd2;
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
      12: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd11;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd10;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd10;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd10;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd10;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
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
