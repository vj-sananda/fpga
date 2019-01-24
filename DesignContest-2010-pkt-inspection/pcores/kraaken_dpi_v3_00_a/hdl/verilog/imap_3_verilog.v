`timescale 1ns/1ps

`define ENABLED_REGEX_imap_3 TRUE

module imap_3_verilog(clk,
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


`ifdef ENABLED_REGEX_imap_3

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
    9: charMap = 8'd11;
    10: charMap = 8'd1;
    11: charMap = 8'd11;
    12: charMap = 8'd10;
    13: charMap = 8'd11;
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
    32: charMap = 8'd11;
    33: charMap = 8'd10;
    34: charMap = 8'd10;
    35: charMap = 8'd10;
    36: charMap = 8'd10;
    37: charMap = 8'd10;
    38: charMap = 8'd10;
    39: charMap = 8'd10;
    40: charMap = 8'd10;
    41: charMap = 8'd10;
    42: charMap = 8'd10;
    43: charMap = 8'd10;
    44: charMap = 8'd10;
    45: charMap = 8'd10;
    46: charMap = 8'd10;
    47: charMap = 8'd10;
    48: charMap = 8'd10;
    49: charMap = 8'd10;
    50: charMap = 8'd10;
    51: charMap = 8'd10;
    52: charMap = 8'd10;
    53: charMap = 8'd10;
    54: charMap = 8'd10;
    55: charMap = 8'd10;
    56: charMap = 8'd10;
    57: charMap = 8'd10;
    58: charMap = 8'd10;
    59: charMap = 8'd10;
    60: charMap = 8'd10;
    61: charMap = 8'd10;
    62: charMap = 8'd10;
    63: charMap = 8'd10;
    64: charMap = 8'd10;
    65: charMap = 8'd2;
    66: charMap = 8'd10;
    67: charMap = 8'd9;
    68: charMap = 8'd10;
    69: charMap = 8'd6;
    70: charMap = 8'd10;
    71: charMap = 8'd10;
    72: charMap = 8'd5;
    73: charMap = 8'd8;
    74: charMap = 8'd10;
    75: charMap = 8'd10;
    76: charMap = 8'd10;
    77: charMap = 8'd10;
    78: charMap = 8'd7;
    79: charMap = 8'd10;
    80: charMap = 8'd10;
    81: charMap = 8'd10;
    82: charMap = 8'd10;
    83: charMap = 8'd10;
    84: charMap = 8'd4;
    85: charMap = 8'd3;
    86: charMap = 8'd10;
    87: charMap = 8'd10;
    88: charMap = 8'd10;
    89: charMap = 8'd10;
    90: charMap = 8'd10;
    91: charMap = 8'd10;
    92: charMap = 8'd10;
    93: charMap = 8'd10;
    94: charMap = 8'd10;
    95: charMap = 8'd10;
    96: charMap = 8'd10;
    97: charMap = 8'd2;
    98: charMap = 8'd10;
    99: charMap = 8'd9;
    100: charMap = 8'd10;
    101: charMap = 8'd6;
    102: charMap = 8'd10;
    103: charMap = 8'd10;
    104: charMap = 8'd5;
    105: charMap = 8'd8;
    106: charMap = 8'd10;
    107: charMap = 8'd10;
    108: charMap = 8'd10;
    109: charMap = 8'd10;
    110: charMap = 8'd7;
    111: charMap = 8'd10;
    112: charMap = 8'd10;
    113: charMap = 8'd10;
    114: charMap = 8'd10;
    115: charMap = 8'd10;
    116: charMap = 8'd4;
    117: charMap = 8'd3;
    118: charMap = 8'd10;
    119: charMap = 8'd10;
    120: charMap = 8'd10;
    121: charMap = 8'd10;
    122: charMap = 8'd10;
    123: charMap = 8'd10;
    124: charMap = 8'd10;
    125: charMap = 8'd10;
    126: charMap = 8'd10;
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
    62: stateMap = 11'd61;
    63: stateMap = 11'd62;
    64: stateMap = 11'd63;
    65: stateMap = 11'd64;
    66: stateMap = 11'd65;
    67: stateMap = 11'd66;
    68: stateMap = 11'd67;
    69: stateMap = 11'd68;
    70: stateMap = 11'd69;
    71: stateMap = 11'd70;
    72: stateMap = 11'd71;
    73: stateMap = 11'd72;
    74: stateMap = 11'd73;
    75: stateMap = 11'd74;
    76: stateMap = 11'd75;
    77: stateMap = 11'd76;
    78: stateMap = 11'd77;
    79: stateMap = 11'd78;
    80: stateMap = 11'd79;
    81: stateMap = 11'd80;
    82: stateMap = 11'd81;
    83: stateMap = 11'd82;
    84: stateMap = 11'd83;
    85: stateMap = 11'd84;
    86: stateMap = 11'd85;
    87: stateMap = 11'd86;
    88: stateMap = 11'd87;
    89: stateMap = 11'd88;
    90: stateMap = 11'd89;
    91: stateMap = 11'd90;
    92: stateMap = 11'd91;
    93: stateMap = 11'd92;
    94: stateMap = 11'd93;
    95: stateMap = 11'd94;
    96: stateMap = 11'd95;
    97: stateMap = 11'd96;
    98: stateMap = 11'd97;
    99: stateMap = 11'd98;
    100: stateMap = 11'd99;
    101: stateMap = 11'd100;
    102: stateMap = 11'd101;
    103: stateMap = 11'd102;
    104: stateMap = 11'd103;
    105: stateMap = 11'd104;
    106: stateMap = 11'd105;
    107: stateMap = 11'd106;
    108: stateMap = 11'd107;
    109: stateMap = 11'd108;
    110: stateMap = 11'd109;
    111: stateMap = 11'd110;
    112: stateMap = 11'd111;
    113: stateMap = 11'd112;
    114: stateMap = 11'd113;
    115: stateMap = 11'd114;
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
    62: acceptStates = 1'b0;
    63: acceptStates = 1'b0;
    64: acceptStates = 1'b0;
    65: acceptStates = 1'b0;
    66: acceptStates = 1'b0;
    67: acceptStates = 1'b0;
    68: acceptStates = 1'b0;
    69: acceptStates = 1'b0;
    70: acceptStates = 1'b0;
    71: acceptStates = 1'b0;
    72: acceptStates = 1'b0;
    73: acceptStates = 1'b0;
    74: acceptStates = 1'b0;
    75: acceptStates = 1'b0;
    76: acceptStates = 1'b0;
    77: acceptStates = 1'b0;
    78: acceptStates = 1'b0;
    79: acceptStates = 1'b0;
    80: acceptStates = 1'b0;
    81: acceptStates = 1'b0;
    82: acceptStates = 1'b0;
    83: acceptStates = 1'b0;
    84: acceptStates = 1'b0;
    85: acceptStates = 1'b0;
    86: acceptStates = 1'b0;
    87: acceptStates = 1'b0;
    88: acceptStates = 1'b0;
    89: acceptStates = 1'b0;
    90: acceptStates = 1'b0;
    91: acceptStates = 1'b0;
    92: acceptStates = 1'b0;
    93: acceptStates = 1'b0;
    94: acceptStates = 1'b0;
    95: acceptStates = 1'b0;
    96: acceptStates = 1'b0;
    97: acceptStates = 1'b0;
    98: acceptStates = 1'b0;
    99: acceptStates = 1'b0;
    100: acceptStates = 1'b0;
    101: acceptStates = 1'b0;
    102: acceptStates = 1'b0;
    103: acceptStates = 1'b0;
    104: acceptStates = 1'b0;
    105: acceptStates = 1'b0;
    106: acceptStates = 1'b0;
    107: acceptStates = 1'b0;
    108: acceptStates = 1'b0;
    109: acceptStates = 1'b0;
    110: acceptStates = 1'b0;
    111: acceptStates = 1'b0;
    112: acceptStates = 1'b0;
    113: acceptStates = 1'b0;
    114: acceptStates = 1'b0;
    115: acceptStates = 1'b0;
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
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd15;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd16;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd115;
      3: stateTransition = 11'd115;
      4: stateTransition = 11'd115;
      5: stateTransition = 11'd115;
      6: stateTransition = 11'd115;
      7: stateTransition = 11'd115;
      8: stateTransition = 11'd115;
      9: stateTransition = 11'd115;
      10: stateTransition = 11'd115;
      11: stateTransition = 11'd115;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd2;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd2;
      8: stateTransition = 11'd2;
      9: stateTransition = 11'd2;
      10: stateTransition = 11'd2;
      11: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd17;
      8: stateTransition = 11'd17;
      9: stateTransition = 11'd17;
      10: stateTransition = 11'd17;
      11: stateTransition = 11'd17;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd18;
      7: stateTransition = 11'd18;
      8: stateTransition = 11'd18;
      9: stateTransition = 11'd18;
      10: stateTransition = 11'd18;
      11: stateTransition = 11'd18;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd19;
      5: stateTransition = 11'd19;
      6: stateTransition = 11'd19;
      7: stateTransition = 11'd19;
      8: stateTransition = 11'd19;
      9: stateTransition = 11'd19;
      10: stateTransition = 11'd19;
      11: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd20;
      6: stateTransition = 11'd20;
      7: stateTransition = 11'd20;
      8: stateTransition = 11'd20;
      9: stateTransition = 11'd20;
      10: stateTransition = 11'd20;
      11: stateTransition = 11'd20;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd21;
      7: stateTransition = 11'd21;
      8: stateTransition = 11'd21;
      9: stateTransition = 11'd21;
      10: stateTransition = 11'd21;
      11: stateTransition = 11'd21;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd22;
      5: stateTransition = 11'd22;
      6: stateTransition = 11'd22;
      7: stateTransition = 11'd22;
      8: stateTransition = 11'd22;
      9: stateTransition = 11'd22;
      10: stateTransition = 11'd22;
      11: stateTransition = 11'd22;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd23;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd23;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      10: stateTransition = 11'd23;
      11: stateTransition = 11'd23;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd24;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      10: stateTransition = 11'd24;
      11: stateTransition = 11'd24;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
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
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd26;
      5: stateTransition = 11'd26;
      6: stateTransition = 11'd26;
      7: stateTransition = 11'd26;
      8: stateTransition = 11'd26;
      9: stateTransition = 11'd26;
      10: stateTransition = 11'd26;
      11: stateTransition = 11'd26;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd27;
      6: stateTransition = 11'd27;
      7: stateTransition = 11'd27;
      8: stateTransition = 11'd27;
      9: stateTransition = 11'd27;
      10: stateTransition = 11'd27;
      11: stateTransition = 11'd27;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd28;
      5: stateTransition = 11'd28;
      6: stateTransition = 11'd28;
      7: stateTransition = 11'd28;
      8: stateTransition = 11'd28;
      9: stateTransition = 11'd28;
      10: stateTransition = 11'd28;
      11: stateTransition = 11'd28;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
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
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd30;
      5: stateTransition = 11'd30;
      6: stateTransition = 11'd30;
      7: stateTransition = 11'd30;
      8: stateTransition = 11'd30;
      9: stateTransition = 11'd30;
      10: stateTransition = 11'd30;
      11: stateTransition = 11'd30;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd31;
      5: stateTransition = 11'd31;
      6: stateTransition = 11'd31;
      7: stateTransition = 11'd31;
      8: stateTransition = 11'd31;
      9: stateTransition = 11'd31;
      10: stateTransition = 11'd31;
      11: stateTransition = 11'd31;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd32;
      3: stateTransition = 11'd32;
      4: stateTransition = 11'd32;
      5: stateTransition = 11'd32;
      6: stateTransition = 11'd32;
      7: stateTransition = 11'd32;
      8: stateTransition = 11'd32;
      9: stateTransition = 11'd32;
      10: stateTransition = 11'd32;
      11: stateTransition = 11'd32;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd33;
      5: stateTransition = 11'd33;
      6: stateTransition = 11'd33;
      7: stateTransition = 11'd33;
      8: stateTransition = 11'd33;
      9: stateTransition = 11'd33;
      10: stateTransition = 11'd33;
      11: stateTransition = 11'd33;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd34;
      5: stateTransition = 11'd34;
      6: stateTransition = 11'd34;
      7: stateTransition = 11'd34;
      8: stateTransition = 11'd34;
      9: stateTransition = 11'd34;
      10: stateTransition = 11'd34;
      11: stateTransition = 11'd34;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd35;
      4: stateTransition = 11'd35;
      5: stateTransition = 11'd35;
      6: stateTransition = 11'd35;
      7: stateTransition = 11'd35;
      8: stateTransition = 11'd35;
      9: stateTransition = 11'd35;
      10: stateTransition = 11'd35;
      11: stateTransition = 11'd35;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd36;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd36;
      5: stateTransition = 11'd36;
      6: stateTransition = 11'd36;
      7: stateTransition = 11'd36;
      8: stateTransition = 11'd36;
      9: stateTransition = 11'd36;
      10: stateTransition = 11'd36;
      11: stateTransition = 11'd36;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd37;
      4: stateTransition = 11'd37;
      5: stateTransition = 11'd37;
      6: stateTransition = 11'd37;
      7: stateTransition = 11'd37;
      8: stateTransition = 11'd37;
      9: stateTransition = 11'd37;
      10: stateTransition = 11'd37;
      11: stateTransition = 11'd37;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd38;
      4: stateTransition = 11'd38;
      5: stateTransition = 11'd38;
      6: stateTransition = 11'd38;
      7: stateTransition = 11'd38;
      8: stateTransition = 11'd38;
      9: stateTransition = 11'd38;
      10: stateTransition = 11'd38;
      11: stateTransition = 11'd38;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd39;
      3: stateTransition = 11'd39;
      4: stateTransition = 11'd39;
      5: stateTransition = 11'd39;
      6: stateTransition = 11'd39;
      7: stateTransition = 11'd39;
      8: stateTransition = 11'd39;
      9: stateTransition = 11'd39;
      10: stateTransition = 11'd39;
      11: stateTransition = 11'd39;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd40;
      3: stateTransition = 11'd40;
      4: stateTransition = 11'd40;
      5: stateTransition = 11'd40;
      6: stateTransition = 11'd40;
      7: stateTransition = 11'd40;
      8: stateTransition = 11'd40;
      9: stateTransition = 11'd40;
      10: stateTransition = 11'd40;
      11: stateTransition = 11'd40;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd41;
      3: stateTransition = 11'd41;
      4: stateTransition = 11'd41;
      5: stateTransition = 11'd41;
      6: stateTransition = 11'd41;
      7: stateTransition = 11'd41;
      8: stateTransition = 11'd41;
      9: stateTransition = 11'd41;
      10: stateTransition = 11'd41;
      11: stateTransition = 11'd41;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd42;
      5: stateTransition = 11'd42;
      6: stateTransition = 11'd42;
      7: stateTransition = 11'd42;
      8: stateTransition = 11'd42;
      9: stateTransition = 11'd42;
      10: stateTransition = 11'd42;
      11: stateTransition = 11'd42;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd43;
      4: stateTransition = 11'd43;
      5: stateTransition = 11'd43;
      6: stateTransition = 11'd43;
      7: stateTransition = 11'd43;
      8: stateTransition = 11'd43;
      9: stateTransition = 11'd43;
      10: stateTransition = 11'd43;
      11: stateTransition = 11'd43;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd44;
      4: stateTransition = 11'd44;
      5: stateTransition = 11'd44;
      6: stateTransition = 11'd44;
      7: stateTransition = 11'd44;
      8: stateTransition = 11'd44;
      9: stateTransition = 11'd44;
      10: stateTransition = 11'd44;
      11: stateTransition = 11'd44;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd45;
      4: stateTransition = 11'd45;
      5: stateTransition = 11'd45;
      6: stateTransition = 11'd45;
      7: stateTransition = 11'd45;
      8: stateTransition = 11'd45;
      9: stateTransition = 11'd45;
      10: stateTransition = 11'd45;
      11: stateTransition = 11'd45;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd46;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd46;
      5: stateTransition = 11'd46;
      6: stateTransition = 11'd46;
      7: stateTransition = 11'd46;
      8: stateTransition = 11'd46;
      9: stateTransition = 11'd46;
      10: stateTransition = 11'd46;
      11: stateTransition = 11'd46;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd47;
      4: stateTransition = 11'd47;
      5: stateTransition = 11'd47;
      6: stateTransition = 11'd47;
      7: stateTransition = 11'd47;
      8: stateTransition = 11'd47;
      9: stateTransition = 11'd47;
      10: stateTransition = 11'd47;
      11: stateTransition = 11'd47;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd48;
      3: stateTransition = 11'd48;
      4: stateTransition = 11'd48;
      5: stateTransition = 11'd48;
      6: stateTransition = 11'd48;
      7: stateTransition = 11'd48;
      8: stateTransition = 11'd48;
      9: stateTransition = 11'd48;
      10: stateTransition = 11'd48;
      11: stateTransition = 11'd48;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd49;
      4: stateTransition = 11'd49;
      5: stateTransition = 11'd49;
      6: stateTransition = 11'd49;
      7: stateTransition = 11'd49;
      8: stateTransition = 11'd49;
      9: stateTransition = 11'd49;
      10: stateTransition = 11'd49;
      11: stateTransition = 11'd49;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd50;
      4: stateTransition = 11'd50;
      5: stateTransition = 11'd50;
      6: stateTransition = 11'd50;
      7: stateTransition = 11'd50;
      8: stateTransition = 11'd50;
      9: stateTransition = 11'd50;
      10: stateTransition = 11'd50;
      11: stateTransition = 11'd50;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd51;
      4: stateTransition = 11'd51;
      5: stateTransition = 11'd51;
      6: stateTransition = 11'd51;
      7: stateTransition = 11'd51;
      8: stateTransition = 11'd51;
      9: stateTransition = 11'd51;
      10: stateTransition = 11'd51;
      11: stateTransition = 11'd51;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd52;
      3: stateTransition = 11'd52;
      4: stateTransition = 11'd52;
      5: stateTransition = 11'd52;
      6: stateTransition = 11'd52;
      7: stateTransition = 11'd52;
      8: stateTransition = 11'd52;
      9: stateTransition = 11'd52;
      10: stateTransition = 11'd52;
      11: stateTransition = 11'd52;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd53;
      3: stateTransition = 11'd53;
      4: stateTransition = 11'd53;
      5: stateTransition = 11'd53;
      6: stateTransition = 11'd53;
      7: stateTransition = 11'd53;
      8: stateTransition = 11'd53;
      9: stateTransition = 11'd53;
      10: stateTransition = 11'd53;
      11: stateTransition = 11'd53;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd54;
      3: stateTransition = 11'd54;
      4: stateTransition = 11'd54;
      5: stateTransition = 11'd54;
      6: stateTransition = 11'd54;
      7: stateTransition = 11'd54;
      8: stateTransition = 11'd54;
      9: stateTransition = 11'd54;
      10: stateTransition = 11'd54;
      11: stateTransition = 11'd54;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd55;
      4: stateTransition = 11'd55;
      5: stateTransition = 11'd55;
      6: stateTransition = 11'd55;
      7: stateTransition = 11'd55;
      8: stateTransition = 11'd55;
      9: stateTransition = 11'd55;
      10: stateTransition = 11'd55;
      11: stateTransition = 11'd55;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd56;
      3: stateTransition = 11'd56;
      4: stateTransition = 11'd56;
      5: stateTransition = 11'd56;
      6: stateTransition = 11'd56;
      7: stateTransition = 11'd56;
      8: stateTransition = 11'd56;
      9: stateTransition = 11'd56;
      10: stateTransition = 11'd56;
      11: stateTransition = 11'd56;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd57;
      3: stateTransition = 11'd57;
      4: stateTransition = 11'd57;
      5: stateTransition = 11'd57;
      6: stateTransition = 11'd57;
      7: stateTransition = 11'd57;
      8: stateTransition = 11'd57;
      9: stateTransition = 11'd57;
      10: stateTransition = 11'd57;
      11: stateTransition = 11'd57;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd58;
      3: stateTransition = 11'd58;
      4: stateTransition = 11'd58;
      5: stateTransition = 11'd58;
      6: stateTransition = 11'd58;
      7: stateTransition = 11'd58;
      8: stateTransition = 11'd58;
      9: stateTransition = 11'd58;
      10: stateTransition = 11'd58;
      11: stateTransition = 11'd58;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd59;
      3: stateTransition = 11'd59;
      4: stateTransition = 11'd59;
      5: stateTransition = 11'd59;
      6: stateTransition = 11'd59;
      7: stateTransition = 11'd59;
      8: stateTransition = 11'd59;
      9: stateTransition = 11'd59;
      10: stateTransition = 11'd59;
      11: stateTransition = 11'd59;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd60;
      3: stateTransition = 11'd60;
      4: stateTransition = 11'd60;
      5: stateTransition = 11'd60;
      6: stateTransition = 11'd60;
      7: stateTransition = 11'd60;
      8: stateTransition = 11'd60;
      9: stateTransition = 11'd60;
      10: stateTransition = 11'd60;
      11: stateTransition = 11'd60;
      default: stateTransition = 11'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd61;
      3: stateTransition = 11'd61;
      4: stateTransition = 11'd61;
      5: stateTransition = 11'd61;
      6: stateTransition = 11'd61;
      7: stateTransition = 11'd61;
      8: stateTransition = 11'd61;
      9: stateTransition = 11'd61;
      10: stateTransition = 11'd61;
      11: stateTransition = 11'd61;
      default: stateTransition = 11'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd62;
      3: stateTransition = 11'd62;
      4: stateTransition = 11'd62;
      5: stateTransition = 11'd62;
      6: stateTransition = 11'd62;
      7: stateTransition = 11'd62;
      8: stateTransition = 11'd62;
      9: stateTransition = 11'd62;
      10: stateTransition = 11'd62;
      11: stateTransition = 11'd62;
      default: stateTransition = 11'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd63;
      3: stateTransition = 11'd63;
      4: stateTransition = 11'd63;
      5: stateTransition = 11'd63;
      6: stateTransition = 11'd63;
      7: stateTransition = 11'd63;
      8: stateTransition = 11'd63;
      9: stateTransition = 11'd63;
      10: stateTransition = 11'd63;
      11: stateTransition = 11'd63;
      default: stateTransition = 11'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd64;
      3: stateTransition = 11'd64;
      4: stateTransition = 11'd64;
      5: stateTransition = 11'd64;
      6: stateTransition = 11'd64;
      7: stateTransition = 11'd64;
      8: stateTransition = 11'd64;
      9: stateTransition = 11'd64;
      10: stateTransition = 11'd64;
      11: stateTransition = 11'd64;
      default: stateTransition = 11'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd65;
      3: stateTransition = 11'd65;
      4: stateTransition = 11'd65;
      5: stateTransition = 11'd65;
      6: stateTransition = 11'd65;
      7: stateTransition = 11'd65;
      8: stateTransition = 11'd65;
      9: stateTransition = 11'd65;
      10: stateTransition = 11'd65;
      11: stateTransition = 11'd65;
      default: stateTransition = 11'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd66;
      3: stateTransition = 11'd66;
      4: stateTransition = 11'd66;
      5: stateTransition = 11'd66;
      6: stateTransition = 11'd66;
      7: stateTransition = 11'd66;
      8: stateTransition = 11'd66;
      9: stateTransition = 11'd66;
      10: stateTransition = 11'd66;
      11: stateTransition = 11'd66;
      default: stateTransition = 11'bX;
    endcase
    67: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd67;
      4: stateTransition = 11'd67;
      5: stateTransition = 11'd67;
      6: stateTransition = 11'd67;
      7: stateTransition = 11'd67;
      8: stateTransition = 11'd67;
      9: stateTransition = 11'd67;
      10: stateTransition = 11'd67;
      11: stateTransition = 11'd67;
      default: stateTransition = 11'bX;
    endcase
    68: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd68;
      3: stateTransition = 11'd68;
      4: stateTransition = 11'd68;
      5: stateTransition = 11'd68;
      6: stateTransition = 11'd68;
      7: stateTransition = 11'd68;
      8: stateTransition = 11'd68;
      9: stateTransition = 11'd68;
      10: stateTransition = 11'd68;
      11: stateTransition = 11'd68;
      default: stateTransition = 11'bX;
    endcase
    69: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd69;
      3: stateTransition = 11'd69;
      4: stateTransition = 11'd69;
      5: stateTransition = 11'd69;
      6: stateTransition = 11'd69;
      7: stateTransition = 11'd69;
      8: stateTransition = 11'd69;
      9: stateTransition = 11'd69;
      10: stateTransition = 11'd69;
      11: stateTransition = 11'd69;
      default: stateTransition = 11'bX;
    endcase
    70: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd70;
      3: stateTransition = 11'd70;
      4: stateTransition = 11'd70;
      5: stateTransition = 11'd70;
      6: stateTransition = 11'd70;
      7: stateTransition = 11'd70;
      8: stateTransition = 11'd70;
      9: stateTransition = 11'd70;
      10: stateTransition = 11'd70;
      11: stateTransition = 11'd70;
      default: stateTransition = 11'bX;
    endcase
    71: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd71;
      3: stateTransition = 11'd71;
      4: stateTransition = 11'd71;
      5: stateTransition = 11'd71;
      6: stateTransition = 11'd71;
      7: stateTransition = 11'd71;
      8: stateTransition = 11'd71;
      9: stateTransition = 11'd71;
      10: stateTransition = 11'd71;
      11: stateTransition = 11'd71;
      default: stateTransition = 11'bX;
    endcase
    72: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd72;
      3: stateTransition = 11'd72;
      4: stateTransition = 11'd72;
      5: stateTransition = 11'd72;
      6: stateTransition = 11'd72;
      7: stateTransition = 11'd72;
      8: stateTransition = 11'd72;
      9: stateTransition = 11'd72;
      10: stateTransition = 11'd72;
      11: stateTransition = 11'd72;
      default: stateTransition = 11'bX;
    endcase
    73: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd73;
      4: stateTransition = 11'd73;
      5: stateTransition = 11'd73;
      6: stateTransition = 11'd73;
      7: stateTransition = 11'd73;
      8: stateTransition = 11'd73;
      9: stateTransition = 11'd73;
      10: stateTransition = 11'd73;
      11: stateTransition = 11'd73;
      default: stateTransition = 11'bX;
    endcase
    74: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd74;
      3: stateTransition = 11'd74;
      4: stateTransition = 11'd74;
      5: stateTransition = 11'd74;
      6: stateTransition = 11'd74;
      7: stateTransition = 11'd74;
      8: stateTransition = 11'd74;
      9: stateTransition = 11'd74;
      10: stateTransition = 11'd74;
      11: stateTransition = 11'd74;
      default: stateTransition = 11'bX;
    endcase
    75: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd75;
      3: stateTransition = 11'd75;
      4: stateTransition = 11'd75;
      5: stateTransition = 11'd75;
      6: stateTransition = 11'd75;
      7: stateTransition = 11'd75;
      8: stateTransition = 11'd75;
      9: stateTransition = 11'd75;
      10: stateTransition = 11'd75;
      11: stateTransition = 11'd75;
      default: stateTransition = 11'bX;
    endcase
    76: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd76;
      3: stateTransition = 11'd76;
      4: stateTransition = 11'd76;
      5: stateTransition = 11'd76;
      6: stateTransition = 11'd76;
      7: stateTransition = 11'd76;
      8: stateTransition = 11'd76;
      9: stateTransition = 11'd76;
      10: stateTransition = 11'd76;
      11: stateTransition = 11'd76;
      default: stateTransition = 11'bX;
    endcase
    77: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd77;
      4: stateTransition = 11'd77;
      5: stateTransition = 11'd77;
      6: stateTransition = 11'd77;
      7: stateTransition = 11'd77;
      8: stateTransition = 11'd77;
      9: stateTransition = 11'd77;
      10: stateTransition = 11'd77;
      11: stateTransition = 11'd77;
      default: stateTransition = 11'bX;
    endcase
    78: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd78;
      3: stateTransition = 11'd78;
      4: stateTransition = 11'd78;
      5: stateTransition = 11'd78;
      6: stateTransition = 11'd78;
      7: stateTransition = 11'd78;
      8: stateTransition = 11'd78;
      9: stateTransition = 11'd78;
      10: stateTransition = 11'd78;
      11: stateTransition = 11'd78;
      default: stateTransition = 11'bX;
    endcase
    79: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd79;
      3: stateTransition = 11'd79;
      4: stateTransition = 11'd79;
      5: stateTransition = 11'd79;
      6: stateTransition = 11'd79;
      7: stateTransition = 11'd79;
      8: stateTransition = 11'd79;
      9: stateTransition = 11'd79;
      10: stateTransition = 11'd79;
      11: stateTransition = 11'd79;
      default: stateTransition = 11'bX;
    endcase
    80: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd80;
      4: stateTransition = 11'd80;
      5: stateTransition = 11'd80;
      6: stateTransition = 11'd80;
      7: stateTransition = 11'd80;
      8: stateTransition = 11'd80;
      9: stateTransition = 11'd80;
      10: stateTransition = 11'd80;
      11: stateTransition = 11'd80;
      default: stateTransition = 11'bX;
    endcase
    81: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd81;
      3: stateTransition = 11'd81;
      4: stateTransition = 11'd81;
      5: stateTransition = 11'd81;
      6: stateTransition = 11'd81;
      7: stateTransition = 11'd81;
      8: stateTransition = 11'd81;
      9: stateTransition = 11'd81;
      10: stateTransition = 11'd81;
      11: stateTransition = 11'd81;
      default: stateTransition = 11'bX;
    endcase
    82: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd82;
      3: stateTransition = 11'd82;
      4: stateTransition = 11'd82;
      5: stateTransition = 11'd82;
      6: stateTransition = 11'd82;
      7: stateTransition = 11'd82;
      8: stateTransition = 11'd82;
      9: stateTransition = 11'd82;
      10: stateTransition = 11'd82;
      11: stateTransition = 11'd82;
      default: stateTransition = 11'bX;
    endcase
    83: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd83;
      3: stateTransition = 11'd83;
      4: stateTransition = 11'd83;
      5: stateTransition = 11'd83;
      6: stateTransition = 11'd83;
      7: stateTransition = 11'd83;
      8: stateTransition = 11'd83;
      9: stateTransition = 11'd83;
      10: stateTransition = 11'd83;
      11: stateTransition = 11'd83;
      default: stateTransition = 11'bX;
    endcase
    84: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd84;
      3: stateTransition = 11'd84;
      4: stateTransition = 11'd84;
      5: stateTransition = 11'd84;
      6: stateTransition = 11'd84;
      7: stateTransition = 11'd84;
      8: stateTransition = 11'd84;
      9: stateTransition = 11'd84;
      10: stateTransition = 11'd84;
      11: stateTransition = 11'd84;
      default: stateTransition = 11'bX;
    endcase
    85: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd85;
      3: stateTransition = 11'd85;
      4: stateTransition = 11'd85;
      5: stateTransition = 11'd85;
      6: stateTransition = 11'd85;
      7: stateTransition = 11'd85;
      8: stateTransition = 11'd85;
      9: stateTransition = 11'd85;
      10: stateTransition = 11'd85;
      11: stateTransition = 11'd85;
      default: stateTransition = 11'bX;
    endcase
    86: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd86;
      3: stateTransition = 11'd86;
      4: stateTransition = 11'd86;
      5: stateTransition = 11'd86;
      6: stateTransition = 11'd86;
      7: stateTransition = 11'd86;
      8: stateTransition = 11'd86;
      9: stateTransition = 11'd86;
      10: stateTransition = 11'd86;
      11: stateTransition = 11'd86;
      default: stateTransition = 11'bX;
    endcase
    87: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd87;
      3: stateTransition = 11'd87;
      4: stateTransition = 11'd87;
      5: stateTransition = 11'd87;
      6: stateTransition = 11'd87;
      7: stateTransition = 11'd87;
      8: stateTransition = 11'd87;
      9: stateTransition = 11'd87;
      10: stateTransition = 11'd87;
      11: stateTransition = 11'd87;
      default: stateTransition = 11'bX;
    endcase
    88: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd88;
      3: stateTransition = 11'd88;
      4: stateTransition = 11'd88;
      5: stateTransition = 11'd88;
      6: stateTransition = 11'd88;
      7: stateTransition = 11'd88;
      8: stateTransition = 11'd88;
      9: stateTransition = 11'd88;
      10: stateTransition = 11'd88;
      11: stateTransition = 11'd88;
      default: stateTransition = 11'bX;
    endcase
    89: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd89;
      3: stateTransition = 11'd89;
      4: stateTransition = 11'd89;
      5: stateTransition = 11'd89;
      6: stateTransition = 11'd89;
      7: stateTransition = 11'd89;
      8: stateTransition = 11'd89;
      9: stateTransition = 11'd89;
      10: stateTransition = 11'd89;
      11: stateTransition = 11'd89;
      default: stateTransition = 11'bX;
    endcase
    90: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd90;
      4: stateTransition = 11'd90;
      5: stateTransition = 11'd90;
      6: stateTransition = 11'd90;
      7: stateTransition = 11'd90;
      8: stateTransition = 11'd90;
      9: stateTransition = 11'd90;
      10: stateTransition = 11'd90;
      11: stateTransition = 11'd90;
      default: stateTransition = 11'bX;
    endcase
    91: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd91;
      3: stateTransition = 11'd91;
      4: stateTransition = 11'd91;
      5: stateTransition = 11'd91;
      6: stateTransition = 11'd91;
      7: stateTransition = 11'd91;
      8: stateTransition = 11'd91;
      9: stateTransition = 11'd91;
      10: stateTransition = 11'd91;
      11: stateTransition = 11'd91;
      default: stateTransition = 11'bX;
    endcase
    92: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd92;
      3: stateTransition = 11'd92;
      4: stateTransition = 11'd92;
      5: stateTransition = 11'd92;
      6: stateTransition = 11'd92;
      7: stateTransition = 11'd92;
      8: stateTransition = 11'd92;
      9: stateTransition = 11'd92;
      10: stateTransition = 11'd92;
      11: stateTransition = 11'd92;
      default: stateTransition = 11'bX;
    endcase
    93: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd93;
      3: stateTransition = 11'd93;
      4: stateTransition = 11'd93;
      5: stateTransition = 11'd93;
      6: stateTransition = 11'd93;
      7: stateTransition = 11'd93;
      8: stateTransition = 11'd93;
      9: stateTransition = 11'd93;
      10: stateTransition = 11'd93;
      11: stateTransition = 11'd93;
      default: stateTransition = 11'bX;
    endcase
    94: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd94;
      3: stateTransition = 11'd94;
      4: stateTransition = 11'd94;
      5: stateTransition = 11'd94;
      6: stateTransition = 11'd94;
      7: stateTransition = 11'd94;
      8: stateTransition = 11'd94;
      9: stateTransition = 11'd94;
      10: stateTransition = 11'd94;
      11: stateTransition = 11'd94;
      default: stateTransition = 11'bX;
    endcase
    95: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd95;
      3: stateTransition = 11'd95;
      4: stateTransition = 11'd95;
      5: stateTransition = 11'd95;
      6: stateTransition = 11'd95;
      7: stateTransition = 11'd95;
      8: stateTransition = 11'd95;
      9: stateTransition = 11'd95;
      10: stateTransition = 11'd95;
      11: stateTransition = 11'd95;
      default: stateTransition = 11'bX;
    endcase
    96: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd96;
      3: stateTransition = 11'd96;
      4: stateTransition = 11'd96;
      5: stateTransition = 11'd96;
      6: stateTransition = 11'd96;
      7: stateTransition = 11'd96;
      8: stateTransition = 11'd96;
      9: stateTransition = 11'd96;
      10: stateTransition = 11'd96;
      11: stateTransition = 11'd96;
      default: stateTransition = 11'bX;
    endcase
    97: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd97;
      3: stateTransition = 11'd97;
      4: stateTransition = 11'd97;
      5: stateTransition = 11'd97;
      6: stateTransition = 11'd97;
      7: stateTransition = 11'd97;
      8: stateTransition = 11'd97;
      9: stateTransition = 11'd97;
      10: stateTransition = 11'd97;
      11: stateTransition = 11'd97;
      default: stateTransition = 11'bX;
    endcase
    98: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd98;
      3: stateTransition = 11'd98;
      4: stateTransition = 11'd98;
      5: stateTransition = 11'd98;
      6: stateTransition = 11'd98;
      7: stateTransition = 11'd98;
      8: stateTransition = 11'd98;
      9: stateTransition = 11'd98;
      10: stateTransition = 11'd98;
      11: stateTransition = 11'd98;
      default: stateTransition = 11'bX;
    endcase
    99: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd99;
      3: stateTransition = 11'd99;
      4: stateTransition = 11'd99;
      5: stateTransition = 11'd99;
      6: stateTransition = 11'd99;
      7: stateTransition = 11'd99;
      8: stateTransition = 11'd99;
      9: stateTransition = 11'd99;
      10: stateTransition = 11'd99;
      11: stateTransition = 11'd99;
      default: stateTransition = 11'bX;
    endcase
    100: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd100;
      3: stateTransition = 11'd100;
      4: stateTransition = 11'd100;
      5: stateTransition = 11'd100;
      6: stateTransition = 11'd100;
      7: stateTransition = 11'd100;
      8: stateTransition = 11'd100;
      9: stateTransition = 11'd100;
      10: stateTransition = 11'd100;
      11: stateTransition = 11'd100;
      default: stateTransition = 11'bX;
    endcase
    101: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd101;
      3: stateTransition = 11'd101;
      4: stateTransition = 11'd101;
      5: stateTransition = 11'd101;
      6: stateTransition = 11'd101;
      7: stateTransition = 11'd101;
      8: stateTransition = 11'd101;
      9: stateTransition = 11'd101;
      10: stateTransition = 11'd101;
      11: stateTransition = 11'd101;
      default: stateTransition = 11'bX;
    endcase
    102: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd102;
      3: stateTransition = 11'd102;
      4: stateTransition = 11'd102;
      5: stateTransition = 11'd102;
      6: stateTransition = 11'd102;
      7: stateTransition = 11'd102;
      8: stateTransition = 11'd102;
      9: stateTransition = 11'd102;
      10: stateTransition = 11'd102;
      11: stateTransition = 11'd102;
      default: stateTransition = 11'bX;
    endcase
    103: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd103;
      3: stateTransition = 11'd103;
      4: stateTransition = 11'd103;
      5: stateTransition = 11'd103;
      6: stateTransition = 11'd103;
      7: stateTransition = 11'd103;
      8: stateTransition = 11'd103;
      9: stateTransition = 11'd103;
      10: stateTransition = 11'd103;
      11: stateTransition = 11'd103;
      default: stateTransition = 11'bX;
    endcase
    104: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd104;
      3: stateTransition = 11'd104;
      4: stateTransition = 11'd104;
      5: stateTransition = 11'd104;
      6: stateTransition = 11'd104;
      7: stateTransition = 11'd104;
      8: stateTransition = 11'd104;
      9: stateTransition = 11'd104;
      10: stateTransition = 11'd104;
      11: stateTransition = 11'd104;
      default: stateTransition = 11'bX;
    endcase
    105: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd105;
      3: stateTransition = 11'd105;
      4: stateTransition = 11'd105;
      5: stateTransition = 11'd105;
      6: stateTransition = 11'd105;
      7: stateTransition = 11'd105;
      8: stateTransition = 11'd105;
      9: stateTransition = 11'd105;
      10: stateTransition = 11'd105;
      11: stateTransition = 11'd105;
      default: stateTransition = 11'bX;
    endcase
    106: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd106;
      3: stateTransition = 11'd106;
      4: stateTransition = 11'd106;
      5: stateTransition = 11'd106;
      6: stateTransition = 11'd106;
      7: stateTransition = 11'd106;
      8: stateTransition = 11'd106;
      9: stateTransition = 11'd106;
      10: stateTransition = 11'd106;
      11: stateTransition = 11'd106;
      default: stateTransition = 11'bX;
    endcase
    107: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd107;
      3: stateTransition = 11'd107;
      4: stateTransition = 11'd107;
      5: stateTransition = 11'd107;
      6: stateTransition = 11'd107;
      7: stateTransition = 11'd107;
      8: stateTransition = 11'd107;
      9: stateTransition = 11'd107;
      10: stateTransition = 11'd107;
      11: stateTransition = 11'd107;
      default: stateTransition = 11'bX;
    endcase
    108: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd108;
      3: stateTransition = 11'd108;
      4: stateTransition = 11'd108;
      5: stateTransition = 11'd108;
      6: stateTransition = 11'd108;
      7: stateTransition = 11'd108;
      8: stateTransition = 11'd108;
      9: stateTransition = 11'd108;
      10: stateTransition = 11'd108;
      11: stateTransition = 11'd108;
      default: stateTransition = 11'bX;
    endcase
    109: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd109;
      3: stateTransition = 11'd109;
      4: stateTransition = 11'd109;
      5: stateTransition = 11'd109;
      6: stateTransition = 11'd109;
      7: stateTransition = 11'd109;
      8: stateTransition = 11'd109;
      9: stateTransition = 11'd109;
      10: stateTransition = 11'd109;
      11: stateTransition = 11'd109;
      default: stateTransition = 11'bX;
    endcase
    110: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd110;
      3: stateTransition = 11'd110;
      4: stateTransition = 11'd110;
      5: stateTransition = 11'd110;
      6: stateTransition = 11'd110;
      7: stateTransition = 11'd110;
      8: stateTransition = 11'd110;
      9: stateTransition = 11'd110;
      10: stateTransition = 11'd110;
      11: stateTransition = 11'd110;
      default: stateTransition = 11'bX;
    endcase
    111: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd111;
      3: stateTransition = 11'd111;
      4: stateTransition = 11'd111;
      5: stateTransition = 11'd111;
      6: stateTransition = 11'd111;
      7: stateTransition = 11'd111;
      8: stateTransition = 11'd111;
      9: stateTransition = 11'd111;
      10: stateTransition = 11'd111;
      11: stateTransition = 11'd111;
      default: stateTransition = 11'bX;
    endcase
    112: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd112;
      3: stateTransition = 11'd112;
      4: stateTransition = 11'd112;
      5: stateTransition = 11'd112;
      6: stateTransition = 11'd112;
      7: stateTransition = 11'd112;
      8: stateTransition = 11'd112;
      9: stateTransition = 11'd112;
      10: stateTransition = 11'd112;
      11: stateTransition = 11'd112;
      default: stateTransition = 11'bX;
    endcase
    113: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd113;
      3: stateTransition = 11'd113;
      4: stateTransition = 11'd113;
      5: stateTransition = 11'd113;
      6: stateTransition = 11'd113;
      7: stateTransition = 11'd113;
      8: stateTransition = 11'd113;
      9: stateTransition = 11'd113;
      10: stateTransition = 11'd113;
      11: stateTransition = 11'd113;
      default: stateTransition = 11'bX;
    endcase
    114: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd114;
      3: stateTransition = 11'd114;
      4: stateTransition = 11'd114;
      5: stateTransition = 11'd114;
      6: stateTransition = 11'd114;
      7: stateTransition = 11'd114;
      8: stateTransition = 11'd114;
      9: stateTransition = 11'd114;
      10: stateTransition = 11'd114;
      11: stateTransition = 11'd114;
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
