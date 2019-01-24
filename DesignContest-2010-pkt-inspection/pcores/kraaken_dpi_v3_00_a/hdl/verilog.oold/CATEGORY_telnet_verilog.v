`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_telnet TRUE

module CATEGORY_telnet_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_telnet

function [7:0] charMap;
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
    9: charMap = 8'd3;
    10: charMap = 8'd0;
    11: charMap = 8'd3;
    12: charMap = 8'd3;
    13: charMap = 8'd0;
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
    43: charMap = 8'd3;
    44: charMap = 8'd3;
    45: charMap = 8'd3;
    46: charMap = 8'd3;
    47: charMap = 8'd3;
    48: charMap = 8'd3;
    49: charMap = 8'd3;
    50: charMap = 8'd3;
    51: charMap = 8'd3;
    52: charMap = 8'd3;
    53: charMap = 8'd3;
    54: charMap = 8'd3;
    55: charMap = 8'd3;
    56: charMap = 8'd3;
    57: charMap = 8'd3;
    58: charMap = 8'd3;
    59: charMap = 8'd3;
    60: charMap = 8'd3;
    61: charMap = 8'd3;
    62: charMap = 8'd3;
    63: charMap = 8'd3;
    64: charMap = 8'd3;
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
    81: charMap = 8'd3;
    82: charMap = 8'd3;
    83: charMap = 8'd3;
    84: charMap = 8'd3;
    85: charMap = 8'd3;
    86: charMap = 8'd3;
    87: charMap = 8'd3;
    88: charMap = 8'd3;
    89: charMap = 8'd3;
    90: charMap = 8'd3;
    91: charMap = 8'd3;
    92: charMap = 8'd3;
    93: charMap = 8'd3;
    94: charMap = 8'd3;
    95: charMap = 8'd3;
    96: charMap = 8'd3;
    97: charMap = 8'd3;
    98: charMap = 8'd3;
    99: charMap = 8'd3;
    100: charMap = 8'd3;
    101: charMap = 8'd3;
    102: charMap = 8'd3;
    103: charMap = 8'd3;
    104: charMap = 8'd3;
    105: charMap = 8'd3;
    106: charMap = 8'd3;
    107: charMap = 8'd3;
    108: charMap = 8'd3;
    109: charMap = 8'd3;
    110: charMap = 8'd3;
    111: charMap = 8'd3;
    112: charMap = 8'd3;
    113: charMap = 8'd3;
    114: charMap = 8'd3;
    115: charMap = 8'd3;
    116: charMap = 8'd3;
    117: charMap = 8'd3;
    118: charMap = 8'd3;
    119: charMap = 8'd3;
    120: charMap = 8'd3;
    121: charMap = 8'd3;
    122: charMap = 8'd3;
    123: charMap = 8'd3;
    124: charMap = 8'd3;
    125: charMap = 8'd3;
    126: charMap = 8'd3;
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
    251: charMap = 8'd2;
    252: charMap = 8'd2;
    253: charMap = 8'd2;
    254: charMap = 8'd2;
    255: charMap = 8'd1;
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
      2: stateTransition = 11'd4;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd5;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd6;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd7;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd8;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd0;
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
