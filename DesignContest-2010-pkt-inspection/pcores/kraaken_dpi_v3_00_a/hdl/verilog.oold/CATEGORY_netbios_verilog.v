`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_netbios TRUE

module CATEGORY_netbios_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_netbios

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd2;
    1: charMap = 8'd2;
    2: charMap = 8'd2;
    3: charMap = 8'd2;
    4: charMap = 8'd2;
    5: charMap = 8'd2;
    6: charMap = 8'd2;
    7: charMap = 8'd2;
    8: charMap = 8'd2;
    9: charMap = 8'd2;
    10: charMap = 8'd0;
    11: charMap = 8'd2;
    12: charMap = 8'd2;
    13: charMap = 8'd0;
    14: charMap = 8'd2;
    15: charMap = 8'd2;
    16: charMap = 8'd2;
    17: charMap = 8'd2;
    18: charMap = 8'd2;
    19: charMap = 8'd2;
    20: charMap = 8'd2;
    21: charMap = 8'd2;
    22: charMap = 8'd2;
    23: charMap = 8'd2;
    24: charMap = 8'd2;
    25: charMap = 8'd2;
    26: charMap = 8'd2;
    27: charMap = 8'd2;
    28: charMap = 8'd2;
    29: charMap = 8'd2;
    30: charMap = 8'd2;
    31: charMap = 8'd2;
    32: charMap = 8'd2;
    33: charMap = 8'd2;
    34: charMap = 8'd2;
    35: charMap = 8'd2;
    36: charMap = 8'd2;
    37: charMap = 8'd2;
    38: charMap = 8'd2;
    39: charMap = 8'd2;
    40: charMap = 8'd2;
    41: charMap = 8'd2;
    42: charMap = 8'd2;
    43: charMap = 8'd2;
    44: charMap = 8'd2;
    45: charMap = 8'd2;
    46: charMap = 8'd2;
    47: charMap = 8'd2;
    48: charMap = 8'd2;
    49: charMap = 8'd2;
    50: charMap = 8'd2;
    51: charMap = 8'd2;
    52: charMap = 8'd2;
    53: charMap = 8'd2;
    54: charMap = 8'd2;
    55: charMap = 8'd2;
    56: charMap = 8'd2;
    57: charMap = 8'd2;
    58: charMap = 8'd2;
    59: charMap = 8'd2;
    60: charMap = 8'd2;
    61: charMap = 8'd2;
    62: charMap = 8'd2;
    63: charMap = 8'd2;
    64: charMap = 8'd2;
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
    81: charMap = 8'd2;
    82: charMap = 8'd2;
    83: charMap = 8'd2;
    84: charMap = 8'd2;
    85: charMap = 8'd2;
    86: charMap = 8'd2;
    87: charMap = 8'd2;
    88: charMap = 8'd2;
    89: charMap = 8'd2;
    90: charMap = 8'd2;
    91: charMap = 8'd2;
    92: charMap = 8'd2;
    93: charMap = 8'd2;
    94: charMap = 8'd2;
    95: charMap = 8'd2;
    96: charMap = 8'd2;
    97: charMap = 8'd2;
    98: charMap = 8'd2;
    99: charMap = 8'd2;
    100: charMap = 8'd2;
    101: charMap = 8'd2;
    102: charMap = 8'd2;
    103: charMap = 8'd2;
    104: charMap = 8'd2;
    105: charMap = 8'd2;
    106: charMap = 8'd2;
    107: charMap = 8'd2;
    108: charMap = 8'd2;
    109: charMap = 8'd2;
    110: charMap = 8'd2;
    111: charMap = 8'd2;
    112: charMap = 8'd2;
    113: charMap = 8'd2;
    114: charMap = 8'd2;
    115: charMap = 8'd2;
    116: charMap = 8'd2;
    117: charMap = 8'd2;
    118: charMap = 8'd2;
    119: charMap = 8'd2;
    120: charMap = 8'd2;
    121: charMap = 8'd2;
    122: charMap = 8'd2;
    123: charMap = 8'd2;
    124: charMap = 8'd2;
    125: charMap = 8'd2;
    126: charMap = 8'd2;
    127: charMap = 8'd2;
    128: charMap = 8'd2;
    129: charMap = 8'd1;
    130: charMap = 8'd2;
    131: charMap = 8'd2;
    132: charMap = 8'd2;
    133: charMap = 8'd2;
    134: charMap = 8'd2;
    135: charMap = 8'd2;
    136: charMap = 8'd2;
    137: charMap = 8'd2;
    138: charMap = 8'd2;
    139: charMap = 8'd2;
    140: charMap = 8'd2;
    141: charMap = 8'd2;
    142: charMap = 8'd2;
    143: charMap = 8'd2;
    144: charMap = 8'd2;
    145: charMap = 8'd2;
    146: charMap = 8'd2;
    147: charMap = 8'd2;
    148: charMap = 8'd2;
    149: charMap = 8'd2;
    150: charMap = 8'd2;
    151: charMap = 8'd2;
    152: charMap = 8'd2;
    153: charMap = 8'd2;
    154: charMap = 8'd2;
    155: charMap = 8'd2;
    156: charMap = 8'd2;
    157: charMap = 8'd2;
    158: charMap = 8'd2;
    159: charMap = 8'd2;
    160: charMap = 8'd2;
    161: charMap = 8'd2;
    162: charMap = 8'd2;
    163: charMap = 8'd2;
    164: charMap = 8'd2;
    165: charMap = 8'd2;
    166: charMap = 8'd2;
    167: charMap = 8'd2;
    168: charMap = 8'd2;
    169: charMap = 8'd2;
    170: charMap = 8'd2;
    171: charMap = 8'd2;
    172: charMap = 8'd2;
    173: charMap = 8'd2;
    174: charMap = 8'd2;
    175: charMap = 8'd2;
    176: charMap = 8'd2;
    177: charMap = 8'd2;
    178: charMap = 8'd2;
    179: charMap = 8'd2;
    180: charMap = 8'd2;
    181: charMap = 8'd2;
    182: charMap = 8'd2;
    183: charMap = 8'd2;
    184: charMap = 8'd2;
    185: charMap = 8'd2;
    186: charMap = 8'd2;
    187: charMap = 8'd2;
    188: charMap = 8'd2;
    189: charMap = 8'd2;
    190: charMap = 8'd2;
    191: charMap = 8'd2;
    192: charMap = 8'd2;
    193: charMap = 8'd2;
    194: charMap = 8'd2;
    195: charMap = 8'd2;
    196: charMap = 8'd2;
    197: charMap = 8'd2;
    198: charMap = 8'd2;
    199: charMap = 8'd2;
    200: charMap = 8'd2;
    201: charMap = 8'd2;
    202: charMap = 8'd2;
    203: charMap = 8'd2;
    204: charMap = 8'd2;
    205: charMap = 8'd2;
    206: charMap = 8'd2;
    207: charMap = 8'd2;
    208: charMap = 8'd2;
    209: charMap = 8'd2;
    210: charMap = 8'd2;
    211: charMap = 8'd2;
    212: charMap = 8'd2;
    213: charMap = 8'd2;
    214: charMap = 8'd2;
    215: charMap = 8'd2;
    216: charMap = 8'd2;
    217: charMap = 8'd2;
    218: charMap = 8'd2;
    219: charMap = 8'd2;
    220: charMap = 8'd2;
    221: charMap = 8'd2;
    222: charMap = 8'd2;
    223: charMap = 8'd2;
    224: charMap = 8'd2;
    225: charMap = 8'd2;
    226: charMap = 8'd2;
    227: charMap = 8'd2;
    228: charMap = 8'd2;
    229: charMap = 8'd2;
    230: charMap = 8'd2;
    231: charMap = 8'd2;
    232: charMap = 8'd2;
    233: charMap = 8'd2;
    234: charMap = 8'd2;
    235: charMap = 8'd2;
    236: charMap = 8'd2;
    237: charMap = 8'd2;
    238: charMap = 8'd2;
    239: charMap = 8'd2;
    240: charMap = 8'd2;
    241: charMap = 8'd2;
    242: charMap = 8'd2;
    243: charMap = 8'd2;
    244: charMap = 8'd2;
    245: charMap = 8'd2;
    246: charMap = 8'd2;
    247: charMap = 8'd2;
    248: charMap = 8'd2;
    249: charMap = 8'd2;
    250: charMap = 8'd2;
    251: charMap = 8'd2;
    252: charMap = 8'd2;
    253: charMap = 8'd2;
    254: charMap = 8'd2;
    255: charMap = 8'd2;
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
    8: stateMap = 11'd6;
    9: stateMap = 11'd7;
    10: stateMap = 11'd8;
    11: stateMap = 11'd2;
    12: stateMap = 11'd9;
    13: stateMap = 11'd10;
    14: stateMap = 11'd11;
    15: stateMap = 11'd12;
    16: stateMap = 11'd13;
    17: stateMap = 11'd14;
    18: stateMap = 11'd15;
    19: stateMap = 11'd16;
    20: stateMap = 11'd17;
    21: stateMap = 11'd18;
    22: stateMap = 11'd19;
    23: stateMap = 11'd20;
    24: stateMap = 11'd21;
    25: stateMap = 11'd22;
    26: stateMap = 11'd23;
    27: stateMap = 11'd24;
    28: stateMap = 11'd25;
    29: stateMap = 11'd26;
    30: stateMap = 11'd27;
    31: stateMap = 11'd28;
    32: stateMap = 11'd29;
    33: stateMap = 11'd30;
    34: stateMap = 11'd31;
    35: stateMap = 11'd32;
    36: stateMap = 11'd33;
    37: stateMap = 11'd34;
    38: stateMap = 11'd35;
    39: stateMap = 11'd36;
    40: stateMap = 11'd37;
    41: stateMap = 11'd38;
    42: stateMap = 11'd39;
    43: stateMap = 11'd40;
    44: stateMap = 11'd41;
    45: stateMap = 11'd42;
    46: stateMap = 11'd43;
    47: stateMap = 11'd44;
    48: stateMap = 11'd45;
    49: stateMap = 11'd46;
    50: stateMap = 11'd47;
    51: stateMap = 11'd48;
    52: stateMap = 11'd49;
    53: stateMap = 11'd50;
    54: stateMap = 11'd51;
    55: stateMap = 11'd52;
    56: stateMap = 11'd53;
    57: stateMap = 11'd54;
    58: stateMap = 11'd55;
    59: stateMap = 11'd56;
    60: stateMap = 11'd57;
    61: stateMap = 11'd58;
    62: stateMap = 11'd59;
    63: stateMap = 11'd60;
    64: stateMap = 11'd61;
    65: stateMap = 11'd62;
    66: stateMap = 11'd63;
    67: stateMap = 11'd64;
    68: stateMap = 11'd65;
    69: stateMap = 11'd66;
    70: stateMap = 11'd67;
    71: stateMap = 11'd68;
    72: stateMap = 11'd69;
    73: stateMap = 11'd70;
    74: stateMap = 11'd71;
    75: stateMap = 11'd72;
    76: stateMap = 11'd73;
    77: stateMap = 11'd74;
    78: stateMap = 11'd75;
    79: stateMap = 11'd76;
    80: stateMap = 11'd77;
    81: stateMap = 11'd78;
    82: stateMap = 11'd79;
    83: stateMap = 11'd80;
    84: stateMap = 11'd81;
    85: stateMap = 11'd82;
    86: stateMap = 11'd83;
    87: stateMap = 11'd84;
    88: stateMap = 11'd85;
    89: stateMap = 11'd86;
    90: stateMap = 11'd87;
    91: stateMap = 11'd88;
    92: stateMap = 11'd89;
    93: stateMap = 11'd90;
    94: stateMap = 11'd91;
    95: stateMap = 11'd92;
    96: stateMap = 11'd93;
    97: stateMap = 11'd94;
    98: stateMap = 11'd95;
    99: stateMap = 11'd96;
    100: stateMap = 11'd97;
    101: stateMap = 11'd98;
    102: stateMap = 11'd99;
    103: stateMap = 11'd100;
    104: stateMap = 11'd101;
    105: stateMap = 11'd102;
    106: stateMap = 11'd103;
    107: stateMap = 11'd104;
    108: stateMap = 11'd105;
    109: stateMap = 11'd106;
    110: stateMap = 11'd107;
    111: stateMap = 11'd108;
    112: stateMap = 11'd109;
    113: stateMap = 11'd110;
    114: stateMap = 11'd111;
    115: stateMap = 11'd112;
    116: stateMap = 11'd113;
    117: stateMap = 11'd114;
    118: stateMap = 11'd115;
    119: stateMap = 11'd116;
    120: stateMap = 11'd117;
    121: stateMap = 11'd118;
    122: stateMap = 11'd119;
    123: stateMap = 11'd120;
    124: stateMap = 11'd121;
    125: stateMap = 11'd122;
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
    8: acceptStates = 1'b1;
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
    116: acceptStates = 1'b0;
    117: acceptStates = 1'b0;
    118: acceptStates = 1'b0;
    119: acceptStates = 1'b0;
    120: acceptStates = 1'b0;
    121: acceptStates = 1'b0;
    122: acceptStates = 1'b0;
    123: acceptStates = 1'b0;
    124: acceptStates = 1'b0;
    125: acceptStates = 1'b0;
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
      4: stateTransition = 11'd1;
      default: stateTransition = 11'bX;
    endcase
    1: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd125;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd4;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd124;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd6;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd121;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd10;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd32;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd35;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd37;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd38;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd39;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd40;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd41;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd43;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd44;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd45;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd47;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd48;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd49;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd50;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd51;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd52;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd53;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd54;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd55;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd56;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd57;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd58;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd59;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd60;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd61;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd62;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd63;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd64;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd65;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd66;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    67: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd67;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    68: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd68;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    69: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd69;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    70: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd70;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    71: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd71;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    72: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd72;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    73: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd73;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    74: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd74;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    75: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd75;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    76: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd76;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    77: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd77;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    78: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd78;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    79: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd79;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    80: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd80;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    81: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd81;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    82: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd82;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    83: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd83;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    84: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd84;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    85: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd85;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    86: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd86;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    87: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd87;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    88: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd88;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    89: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd89;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    90: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd90;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    91: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd91;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    92: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd92;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    93: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd93;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    94: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd94;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    95: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd95;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    96: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd96;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    97: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd97;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    98: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd98;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    99: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd99;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    100: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd100;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    101: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd101;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    102: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd102;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    103: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd103;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    104: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd104;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    105: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd105;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    106: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd106;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    107: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd107;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    108: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd108;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    109: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd109;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    110: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd110;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    111: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd111;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    112: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd112;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    113: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd113;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    114: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd114;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    115: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd115;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    116: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd116;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    117: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd117;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    118: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd120;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    119: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd118;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    120: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd119;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    121: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd122;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    122: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd123;
      4: stateTransition = 11'd0;
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
