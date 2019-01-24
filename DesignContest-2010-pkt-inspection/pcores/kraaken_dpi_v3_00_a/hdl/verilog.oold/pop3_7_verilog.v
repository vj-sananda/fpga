`timescale 1ns/1ps

`define ENABLED_REGEX_pop3_7 TRUE

module pop3_7_verilog(clk,
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


`ifdef ENABLED_REGEX_pop3_7

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
    65: charMap = 8'd6;
    66: charMap = 8'd6;
    67: charMap = 8'd6;
    68: charMap = 8'd6;
    69: charMap = 8'd3;
    70: charMap = 8'd6;
    71: charMap = 8'd6;
    72: charMap = 8'd6;
    73: charMap = 8'd6;
    74: charMap = 8'd6;
    75: charMap = 8'd6;
    76: charMap = 8'd6;
    77: charMap = 8'd6;
    78: charMap = 8'd6;
    79: charMap = 8'd6;
    80: charMap = 8'd6;
    81: charMap = 8'd6;
    82: charMap = 8'd1;
    83: charMap = 8'd2;
    84: charMap = 8'd4;
    85: charMap = 8'd6;
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
    97: charMap = 8'd6;
    98: charMap = 8'd6;
    99: charMap = 8'd6;
    100: charMap = 8'd6;
    101: charMap = 8'd3;
    102: charMap = 8'd6;
    103: charMap = 8'd6;
    104: charMap = 8'd6;
    105: charMap = 8'd6;
    106: charMap = 8'd6;
    107: charMap = 8'd6;
    108: charMap = 8'd6;
    109: charMap = 8'd6;
    110: charMap = 8'd6;
    111: charMap = 8'd6;
    112: charMap = 8'd6;
    113: charMap = 8'd6;
    114: charMap = 8'd1;
    115: charMap = 8'd2;
    116: charMap = 8'd4;
    117: charMap = 8'd6;
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
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd16;
      7: stateTransition = 11'd16;
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
