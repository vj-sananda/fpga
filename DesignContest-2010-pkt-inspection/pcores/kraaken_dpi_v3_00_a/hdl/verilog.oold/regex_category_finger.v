`timescale 1ns/1ps
module regex_category_finger(clk,
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
    input [7:0] char_in, state_in;
    // char_in_vld should be true if there's a character to process.
    // state_in_vld should be true if the outside world is overwriting our state.
    input char_in_vld, state_in_vld;
    // state_out is our current state.
    output [7:0] state_out;
    // Accept out is true if the character triggered a regex match.
    output accept_out;
    // A register for the current state.
    reg [7:0] cur_state;


`ifdef ENABLED_REGEX_CATEGORY_finger

function charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd3;
    1: charMap = 8'd3;
    2: charMap = 8'd3;
    3: charMap = 8'd3;
    4: charMap = 8'd3;
    5: charMap = 8'd3;
    6: charMap = 8'd3;
    7: charMap = 8'd3;
    8: charMap = 8'd3;
    9: charMap = 8'd2;
    10: charMap = 8'd11;
    11: charMap = 8'd2;
    12: charMap = 8'd2;
    13: charMap = 8'd11;
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
    32: charMap = 8'd10;
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
    58: charMap = 8'd9;
    59: charMap = 8'd2;
    60: charMap = 8'd2;
    61: charMap = 8'd2;
    62: charMap = 8'd2;
    63: charMap = 8'd2;
    64: charMap = 8'd2;
    65: charMap = 8'd12;
    66: charMap = 8'd1;
    67: charMap = 8'd17;
    68: charMap = 8'd15;
    69: charMap = 8'd14;
    70: charMap = 8'd1;
    71: charMap = 8'd6;
    72: charMap = 8'd1;
    73: charMap = 8'd7;
    74: charMap = 8'd1;
    75: charMap = 8'd1;
    76: charMap = 8'd4;
    77: charMap = 8'd13;
    78: charMap = 8'd8;
    79: charMap = 8'd5;
    80: charMap = 8'd1;
    81: charMap = 8'd1;
    82: charMap = 8'd16;
    83: charMap = 8'd1;
    84: charMap = 8'd18;
    85: charMap = 8'd1;
    86: charMap = 8'd1;
    87: charMap = 8'd1;
    88: charMap = 8'd1;
    89: charMap = 8'd19;
    90: charMap = 8'd1;
    91: charMap = 8'd2;
    92: charMap = 8'd2;
    93: charMap = 8'd2;
    94: charMap = 8'd2;
    95: charMap = 8'd2;
    96: charMap = 8'd2;
    97: charMap = 8'd12;
    98: charMap = 8'd1;
    99: charMap = 8'd17;
    100: charMap = 8'd15;
    101: charMap = 8'd14;
    102: charMap = 8'd1;
    103: charMap = 8'd6;
    104: charMap = 8'd1;
    105: charMap = 8'd7;
    106: charMap = 8'd1;
    107: charMap = 8'd1;
    108: charMap = 8'd4;
    109: charMap = 8'd13;
    110: charMap = 8'd8;
    111: charMap = 8'd5;
    112: charMap = 8'd1;
    113: charMap = 8'd1;
    114: charMap = 8'd16;
    115: charMap = 8'd1;
    116: charMap = 8'd18;
    117: charMap = 8'd1;
    118: charMap = 8'd1;
    119: charMap = 8'd1;
    120: charMap = 8'd1;
    121: charMap = 8'd19;
    122: charMap = 8'd1;
    123: charMap = 8'd2;
    124: charMap = 8'd2;
    125: charMap = 8'd2;
    126: charMap = 8'd2;
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

function stateMap;
  input [7:0] instate;
begin
  case( instate )
    0: stateMap = 8'd0;
    1: stateMap = 8'd1;
    2: stateMap = 8'd2;
    3: stateMap = 8'd3;
    4: stateMap = 8'd4;
    5: stateMap = 8'd5;
    6: stateMap = 8'd6;
    7: stateMap = 8'd7;
    8: stateMap = 8'd8;
    9: stateMap = 8'd9;
    10: stateMap = 8'd10;
    11: stateMap = 8'd11;
    12: stateMap = 8'd12;
    13: stateMap = 8'd13;
    14: stateMap = 8'd14;
    15: stateMap = 8'd15;
    16: stateMap = 8'd16;
    17: stateMap = 8'd17;
    18: stateMap = 8'd18;
    19: stateMap = 8'd19;
    20: stateMap = 8'd20;
    21: stateMap = 8'd21;
    22: stateMap = 8'd22;
    23: stateMap = 8'd23;
    24: stateMap = 8'd24;
    25: stateMap = 8'd25;
    26: stateMap = 8'd26;
    27: stateMap = 8'd27;
    28: stateMap = 8'd28;
    29: stateMap = 8'd29;
    30: stateMap = 8'd30;
    31: stateMap = 8'd31;
    32: stateMap = 8'd30;
    33: stateMap = 8'd32;
    34: stateMap = 8'd33;
    35: stateMap = 8'd34;
    36: stateMap = 8'd35;
    37: stateMap = 8'd36;
    38: stateMap = 8'd37;
    39: stateMap = 8'd38;
    40: stateMap = 8'd39;
    41: stateMap = 8'd40;
    42: stateMap = 8'd41;
    43: stateMap = 8'd42;
    44: stateMap = 8'd43;
    45: stateMap = 8'd41;
    46: stateMap = 8'd42;
    47: stateMap = 8'd44;
    48: stateMap = 8'd45;
    49: stateMap = 8'd46;
    50: stateMap = 8'd47;
    51: stateMap = 8'd48;
    52: stateMap = 8'd49;
    53: stateMap = 8'd50;
    54: stateMap = 8'd4;
    55: stateMap = 8'd51;
    56: stateMap = 8'd52;
    57: stateMap = 8'd53;
    58: stateMap = 8'd54;
    59: stateMap = 8'd55;
    60: stateMap = 8'd56;
    61: stateMap = 8'd57;
    62: stateMap = 8'd58;
    63: stateMap = 8'd59;
    64: stateMap = 8'd60;
    65: stateMap = 8'd61;
    66: stateMap = 8'd62;
    67: stateMap = 8'd63;
    68: stateMap = 8'd2;
    69: stateMap = 8'd64;
    70: stateMap = 8'd65;
    71: stateMap = 8'd66;
    default: stateMap = 8'bX;
  endcase
end
endfunction

function acceptStates;
  input [7:0] instate;
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
    default: acceptStates = 1'bX;
  endcase
end
endfunction

function stateTransition;
  input [7:0] mapped_state, mapped_char;
begin
  case( mapped_state )
    0: case ( mapped_char ) 
      0: stateTransition = 8'd1;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd0;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd3;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd0;
      10: stateTransition = 8'd0;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    1: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd0;
      2: stateTransition = 8'd0;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd0;
      5: stateTransition = 8'd0;
      6: stateTransition = 8'd0;
      7: stateTransition = 8'd0;
      8: stateTransition = 8'd0;
      9: stateTransition = 8'd0;
      10: stateTransition = 8'd0;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd0;
      13: stateTransition = 8'd0;
      14: stateTransition = 8'd0;
      15: stateTransition = 8'd0;
      16: stateTransition = 8'd0;
      17: stateTransition = 8'd0;
      18: stateTransition = 8'd0;
      19: stateTransition = 8'd0;
      default: stateTransition = 8'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd65;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd2;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd4;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd5;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd7;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd9;
      default: stateTransition = 8'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd8;
      default: stateTransition = 8'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd10;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd11;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd12;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd13;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd14;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd15;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd16;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd17;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd18;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd19;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd20;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd21;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd3;
      6: stateTransition = 8'd22;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd23;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd24;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd25;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd27;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd3;
      2: stateTransition = 8'd3;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd31;
      5: stateTransition = 8'd26;
      6: stateTransition = 8'd3;
      7: stateTransition = 8'd3;
      8: stateTransition = 8'd3;
      9: stateTransition = 8'd3;
      10: stateTransition = 8'd3;
      11: stateTransition = 8'd0;
      12: stateTransition = 8'd3;
      13: stateTransition = 8'd3;
      14: stateTransition = 8'd3;
      15: stateTransition = 8'd3;
      16: stateTransition = 8'd3;
      17: stateTransition = 8'd3;
      18: stateTransition = 8'd3;
      19: stateTransition = 8'd3;
      default: stateTransition = 8'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd28;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd29;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd30;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd35;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd33;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd34;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd36;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd37;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd38;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd47;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd40;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd65;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd41;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd39;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd49;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd43;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd50;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd51;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd52;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd54;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd42;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd5;
      6: stateTransition = 8'd44;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd48;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd54;
      2: stateTransition = 8'd54;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd54;
      5: stateTransition = 8'd54;
      6: stateTransition = 8'd54;
      7: stateTransition = 8'd54;
      8: stateTransition = 8'd47;
      9: stateTransition = 8'd54;
      10: stateTransition = 8'd45;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd54;
      13: stateTransition = 8'd54;
      14: stateTransition = 8'd54;
      15: stateTransition = 8'd54;
      16: stateTransition = 8'd54;
      17: stateTransition = 8'd54;
      18: stateTransition = 8'd54;
      19: stateTransition = 8'd54;
      default: stateTransition = 8'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd5;
      2: stateTransition = 8'd5;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd57;
      5: stateTransition = 8'd53;
      6: stateTransition = 8'd5;
      7: stateTransition = 8'd5;
      8: stateTransition = 8'd5;
      9: stateTransition = 8'd5;
      10: stateTransition = 8'd32;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd5;
      13: stateTransition = 8'd5;
      14: stateTransition = 8'd5;
      15: stateTransition = 8'd5;
      16: stateTransition = 8'd5;
      17: stateTransition = 8'd5;
      18: stateTransition = 8'd5;
      19: stateTransition = 8'd5;
      default: stateTransition = 8'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd56;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd55;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd55;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd58;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd59;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd60;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd61;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd62;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd68;
      6: stateTransition = 8'd63;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd64;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd68;
      2: stateTransition = 8'd68;
      3: stateTransition = 8'd3;
      4: stateTransition = 8'd69;
      5: stateTransition = 8'd66;
      6: stateTransition = 8'd68;
      7: stateTransition = 8'd68;
      8: stateTransition = 8'd68;
      9: stateTransition = 8'd68;
      10: stateTransition = 8'd46;
      11: stateTransition = 8'd54;
      12: stateTransition = 8'd68;
      13: stateTransition = 8'd68;
      14: stateTransition = 8'd68;
      15: stateTransition = 8'd68;
      16: stateTransition = 8'd68;
      17: stateTransition = 8'd68;
      18: stateTransition = 8'd68;
      19: stateTransition = 8'd68;
      default: stateTransition = 8'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd6;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd67;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 8'd0;
      1: stateTransition = 8'd6;
      2: stateTransition = 8'd6;
      3: stateTransition = 8'd0;
      4: stateTransition = 8'd6;
      5: stateTransition = 8'd6;
      6: stateTransition = 8'd6;
      7: stateTransition = 8'd6;
      8: stateTransition = 8'd70;
      9: stateTransition = 8'd6;
      10: stateTransition = 8'd71;
      11: stateTransition = 8'd6;
      12: stateTransition = 8'd6;
      13: stateTransition = 8'd6;
      14: stateTransition = 8'd6;
      15: stateTransition = 8'd6;
      16: stateTransition = 8'd6;
      17: stateTransition = 8'd6;
      18: stateTransition = 8'd6;
      19: stateTransition = 8'd6;
      default: stateTransition = 8'bX;
    endcase
    default: stateTransition = 8'bX;
  endcase
end
endfunction

`else

function charMap;
input [7:0] inchar;
begin
    charMap = inchar;
end
endfunction

function stateMap;
input [7:0] instate;
begin
    stateMap = instate;
end
endfunction

function acceptStates;
    input [7:0] inchar;
begin
    acceptStates = 1'b0;
end
endfunction

function stateTransition;
    input [7:0] instate, inchar;
begin
    stateTransition = instate;
end
endfunction

`endif

    // Invoke the DFA functions.
    wire [7:0] mapped_char, mapped_state;
    wire [7:0] next_state;
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
