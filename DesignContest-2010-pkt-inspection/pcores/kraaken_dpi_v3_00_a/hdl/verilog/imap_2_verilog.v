`timescale 1ns/1ps

`define ENABLED_REGEX_imap_2 TRUE

module imap_2_verilog(clk,
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


`ifdef ENABLED_REGEX_imap_2

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd13;
    1: charMap = 8'd13;
    2: charMap = 8'd13;
    3: charMap = 8'd13;
    4: charMap = 8'd13;
    5: charMap = 8'd13;
    6: charMap = 8'd13;
    7: charMap = 8'd13;
    8: charMap = 8'd13;
    9: charMap = 8'd1;
    10: charMap = 8'd12;
    11: charMap = 8'd1;
    12: charMap = 8'd13;
    13: charMap = 8'd11;
    14: charMap = 8'd13;
    15: charMap = 8'd13;
    16: charMap = 8'd13;
    17: charMap = 8'd13;
    18: charMap = 8'd13;
    19: charMap = 8'd13;
    20: charMap = 8'd13;
    21: charMap = 8'd13;
    22: charMap = 8'd13;
    23: charMap = 8'd13;
    24: charMap = 8'd13;
    25: charMap = 8'd13;
    26: charMap = 8'd13;
    27: charMap = 8'd13;
    28: charMap = 8'd13;
    29: charMap = 8'd13;
    30: charMap = 8'd13;
    31: charMap = 8'd13;
    32: charMap = 8'd1;
    33: charMap = 8'd13;
    34: charMap = 8'd13;
    35: charMap = 8'd13;
    36: charMap = 8'd13;
    37: charMap = 8'd14;
    38: charMap = 8'd13;
    39: charMap = 8'd13;
    40: charMap = 8'd13;
    41: charMap = 8'd13;
    42: charMap = 8'd13;
    43: charMap = 8'd13;
    44: charMap = 8'd13;
    45: charMap = 8'd13;
    46: charMap = 8'd13;
    47: charMap = 8'd13;
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
    58: charMap = 8'd13;
    59: charMap = 8'd13;
    60: charMap = 8'd13;
    61: charMap = 8'd13;
    62: charMap = 8'd13;
    63: charMap = 8'd13;
    64: charMap = 8'd13;
    65: charMap = 8'd7;
    66: charMap = 8'd7;
    67: charMap = 8'd7;
    68: charMap = 8'd7;
    69: charMap = 8'd7;
    70: charMap = 8'd7;
    71: charMap = 8'd4;
    72: charMap = 8'd7;
    73: charMap = 8'd5;
    74: charMap = 8'd7;
    75: charMap = 8'd7;
    76: charMap = 8'd2;
    77: charMap = 8'd7;
    78: charMap = 8'd6;
    79: charMap = 8'd3;
    80: charMap = 8'd7;
    81: charMap = 8'd7;
    82: charMap = 8'd7;
    83: charMap = 8'd7;
    84: charMap = 8'd7;
    85: charMap = 8'd7;
    86: charMap = 8'd7;
    87: charMap = 8'd7;
    88: charMap = 8'd7;
    89: charMap = 8'd7;
    90: charMap = 8'd7;
    91: charMap = 8'd13;
    92: charMap = 8'd13;
    93: charMap = 8'd13;
    94: charMap = 8'd13;
    95: charMap = 8'd7;
    96: charMap = 8'd13;
    97: charMap = 8'd7;
    98: charMap = 8'd7;
    99: charMap = 8'd7;
    100: charMap = 8'd7;
    101: charMap = 8'd7;
    102: charMap = 8'd7;
    103: charMap = 8'd4;
    104: charMap = 8'd7;
    105: charMap = 8'd5;
    106: charMap = 8'd7;
    107: charMap = 8'd7;
    108: charMap = 8'd2;
    109: charMap = 8'd7;
    110: charMap = 8'd6;
    111: charMap = 8'd3;
    112: charMap = 8'd7;
    113: charMap = 8'd7;
    114: charMap = 8'd7;
    115: charMap = 8'd7;
    116: charMap = 8'd7;
    117: charMap = 8'd7;
    118: charMap = 8'd7;
    119: charMap = 8'd7;
    120: charMap = 8'd7;
    121: charMap = 8'd7;
    122: charMap = 8'd7;
    123: charMap = 8'd8;
    124: charMap = 8'd13;
    125: charMap = 8'd10;
    126: charMap = 8'd13;
    127: charMap = 8'd13;
    128: charMap = 8'd13;
    129: charMap = 8'd13;
    130: charMap = 8'd13;
    131: charMap = 8'd13;
    132: charMap = 8'd13;
    133: charMap = 8'd13;
    134: charMap = 8'd13;
    135: charMap = 8'd13;
    136: charMap = 8'd13;
    137: charMap = 8'd13;
    138: charMap = 8'd13;
    139: charMap = 8'd13;
    140: charMap = 8'd13;
    141: charMap = 8'd13;
    142: charMap = 8'd13;
    143: charMap = 8'd13;
    144: charMap = 8'd13;
    145: charMap = 8'd13;
    146: charMap = 8'd13;
    147: charMap = 8'd13;
    148: charMap = 8'd13;
    149: charMap = 8'd13;
    150: charMap = 8'd13;
    151: charMap = 8'd13;
    152: charMap = 8'd13;
    153: charMap = 8'd13;
    154: charMap = 8'd13;
    155: charMap = 8'd13;
    156: charMap = 8'd13;
    157: charMap = 8'd13;
    158: charMap = 8'd13;
    159: charMap = 8'd13;
    160: charMap = 8'd13;
    161: charMap = 8'd13;
    162: charMap = 8'd13;
    163: charMap = 8'd13;
    164: charMap = 8'd13;
    165: charMap = 8'd13;
    166: charMap = 8'd13;
    167: charMap = 8'd13;
    168: charMap = 8'd13;
    169: charMap = 8'd13;
    170: charMap = 8'd13;
    171: charMap = 8'd13;
    172: charMap = 8'd13;
    173: charMap = 8'd13;
    174: charMap = 8'd13;
    175: charMap = 8'd13;
    176: charMap = 8'd13;
    177: charMap = 8'd13;
    178: charMap = 8'd13;
    179: charMap = 8'd13;
    180: charMap = 8'd13;
    181: charMap = 8'd13;
    182: charMap = 8'd13;
    183: charMap = 8'd13;
    184: charMap = 8'd13;
    185: charMap = 8'd13;
    186: charMap = 8'd13;
    187: charMap = 8'd13;
    188: charMap = 8'd13;
    189: charMap = 8'd13;
    190: charMap = 8'd13;
    191: charMap = 8'd13;
    192: charMap = 8'd13;
    193: charMap = 8'd13;
    194: charMap = 8'd13;
    195: charMap = 8'd13;
    196: charMap = 8'd13;
    197: charMap = 8'd13;
    198: charMap = 8'd13;
    199: charMap = 8'd13;
    200: charMap = 8'd13;
    201: charMap = 8'd13;
    202: charMap = 8'd13;
    203: charMap = 8'd13;
    204: charMap = 8'd13;
    205: charMap = 8'd13;
    206: charMap = 8'd13;
    207: charMap = 8'd13;
    208: charMap = 8'd13;
    209: charMap = 8'd13;
    210: charMap = 8'd13;
    211: charMap = 8'd13;
    212: charMap = 8'd13;
    213: charMap = 8'd13;
    214: charMap = 8'd13;
    215: charMap = 8'd13;
    216: charMap = 8'd13;
    217: charMap = 8'd13;
    218: charMap = 8'd13;
    219: charMap = 8'd13;
    220: charMap = 8'd13;
    221: charMap = 8'd13;
    222: charMap = 8'd13;
    223: charMap = 8'd13;
    224: charMap = 8'd13;
    225: charMap = 8'd13;
    226: charMap = 8'd13;
    227: charMap = 8'd13;
    228: charMap = 8'd13;
    229: charMap = 8'd13;
    230: charMap = 8'd13;
    231: charMap = 8'd13;
    232: charMap = 8'd13;
    233: charMap = 8'd13;
    234: charMap = 8'd13;
    235: charMap = 8'd13;
    236: charMap = 8'd13;
    237: charMap = 8'd13;
    238: charMap = 8'd13;
    239: charMap = 8'd13;
    240: charMap = 8'd13;
    241: charMap = 8'd13;
    242: charMap = 8'd13;
    243: charMap = 8'd13;
    244: charMap = 8'd13;
    245: charMap = 8'd13;
    246: charMap = 8'd13;
    247: charMap = 8'd13;
    248: charMap = 8'd13;
    249: charMap = 8'd13;
    250: charMap = 8'd13;
    251: charMap = 8'd13;
    252: charMap = 8'd13;
    253: charMap = 8'd13;
    254: charMap = 8'd13;
    255: charMap = 8'd13;
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
      11: stateTransition = 11'd3;
      12: stateTransition = 11'd3;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd9;
      12: stateTransition = 11'd9;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd10;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd10;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd10;
      6: stateTransition = 11'd10;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd10;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd11;
      12: stateTransition = 11'd11;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      8: stateTransition = 11'd12;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd14;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
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
      11: stateTransition = 11'd15;
      12: stateTransition = 11'd16;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
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
      12: stateTransition = 11'd16;
      13: stateTransition = 11'd0;
      14: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
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
      10: stateTransition = 11'd16;
      11: stateTransition = 11'd16;
      12: stateTransition = 11'd0;
      13: stateTransition = 11'd16;
      14: stateTransition = 11'd2;
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
