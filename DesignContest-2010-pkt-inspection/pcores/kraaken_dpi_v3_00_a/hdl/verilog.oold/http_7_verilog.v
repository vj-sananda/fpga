`timescale 1ns/1ps

`define ENABLED_REGEX_http_7 TRUE

module http_7_verilog(clk,
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


`ifdef ENABLED_REGEX_http_7

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
    32: charMap = 8'd3;
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
    47: charMap = 8'd1;
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
    65: charMap = 8'd2;
    66: charMap = 8'd2;
    67: charMap = 8'd2;
    68: charMap = 8'd2;
    69: charMap = 8'd2;
    70: charMap = 8'd2;
    71: charMap = 8'd2;
    72: charMap = 8'd2;
    73: charMap = 8'd2;
    74: charMap = 8'd2;
    75: charMap = 8'd2;
    76: charMap = 8'd2;
    77: charMap = 8'd2;
    78: charMap = 8'd2;
    79: charMap = 8'd2;
    80: charMap = 8'd2;
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
    108: charMap = 8'd5;
    109: charMap = 8'd2;
    110: charMap = 8'd2;
    111: charMap = 8'd2;
    112: charMap = 8'd4;
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
    129: charMap = 8'd2;
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
    3: stateMap = 11'd2;
    4: stateMap = 11'd3;
    5: stateMap = 11'd4;
    6: stateMap = 11'd5;
    7: stateMap = 11'd6;
    8: stateMap = 11'd7;
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
      6: stateTransition = 11'd1;
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
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd3;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd3;
      5: stateTransition = 11'd3;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd3;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd3;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd3;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd4;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd3;
      2: stateTransition = 11'd3;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd4;
      5: stateTransition = 11'd3;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd6;
      2: stateTransition = 11'd6;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd5;
      5: stateTransition = 11'd6;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd6;
      2: stateTransition = 11'd6;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd6;
      5: stateTransition = 11'd6;
      6: stateTransition = 11'd0;
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
