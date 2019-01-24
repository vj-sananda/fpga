`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_ssl TRUE

module CATEGORY_ssl_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_ssl

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd1;
    1: charMap = 8'd4;
    2: charMap = 8'd1;
    3: charMap = 8'd3;
    4: charMap = 8'd1;
    5: charMap = 8'd1;
    6: charMap = 8'd1;
    7: charMap = 8'd1;
    8: charMap = 8'd1;
    9: charMap = 8'd1;
    10: charMap = 8'd0;
    11: charMap = 8'd5;
    12: charMap = 8'd1;
    13: charMap = 8'd0;
    14: charMap = 8'd1;
    15: charMap = 8'd1;
    16: charMap = 8'd1;
    17: charMap = 8'd1;
    18: charMap = 8'd1;
    19: charMap = 8'd1;
    20: charMap = 8'd1;
    21: charMap = 8'd1;
    22: charMap = 8'd2;
    23: charMap = 8'd1;
    24: charMap = 8'd1;
    25: charMap = 8'd1;
    26: charMap = 8'd1;
    27: charMap = 8'd1;
    28: charMap = 8'd1;
    29: charMap = 8'd1;
    30: charMap = 8'd1;
    31: charMap = 8'd1;
    32: charMap = 8'd1;
    33: charMap = 8'd1;
    34: charMap = 8'd1;
    35: charMap = 8'd1;
    36: charMap = 8'd1;
    37: charMap = 8'd1;
    38: charMap = 8'd1;
    39: charMap = 8'd1;
    40: charMap = 8'd1;
    41: charMap = 8'd1;
    42: charMap = 8'd1;
    43: charMap = 8'd1;
    44: charMap = 8'd1;
    45: charMap = 8'd1;
    46: charMap = 8'd1;
    47: charMap = 8'd1;
    48: charMap = 8'd1;
    49: charMap = 8'd1;
    50: charMap = 8'd1;
    51: charMap = 8'd1;
    52: charMap = 8'd1;
    53: charMap = 8'd1;
    54: charMap = 8'd1;
    55: charMap = 8'd1;
    56: charMap = 8'd1;
    57: charMap = 8'd1;
    58: charMap = 8'd1;
    59: charMap = 8'd1;
    60: charMap = 8'd1;
    61: charMap = 8'd1;
    62: charMap = 8'd1;
    63: charMap = 8'd1;
    64: charMap = 8'd1;
    65: charMap = 8'd1;
    66: charMap = 8'd1;
    67: charMap = 8'd1;
    68: charMap = 8'd1;
    69: charMap = 8'd1;
    70: charMap = 8'd1;
    71: charMap = 8'd1;
    72: charMap = 8'd1;
    73: charMap = 8'd1;
    74: charMap = 8'd1;
    75: charMap = 8'd1;
    76: charMap = 8'd1;
    77: charMap = 8'd1;
    78: charMap = 8'd1;
    79: charMap = 8'd1;
    80: charMap = 8'd1;
    81: charMap = 8'd1;
    82: charMap = 8'd1;
    83: charMap = 8'd1;
    84: charMap = 8'd1;
    85: charMap = 8'd1;
    86: charMap = 8'd1;
    87: charMap = 8'd1;
    88: charMap = 8'd1;
    89: charMap = 8'd1;
    90: charMap = 8'd1;
    91: charMap = 8'd1;
    92: charMap = 8'd1;
    93: charMap = 8'd1;
    94: charMap = 8'd1;
    95: charMap = 8'd1;
    96: charMap = 8'd1;
    97: charMap = 8'd1;
    98: charMap = 8'd1;
    99: charMap = 8'd1;
    100: charMap = 8'd1;
    101: charMap = 8'd1;
    102: charMap = 8'd1;
    103: charMap = 8'd1;
    104: charMap = 8'd1;
    105: charMap = 8'd1;
    106: charMap = 8'd1;
    107: charMap = 8'd1;
    108: charMap = 8'd1;
    109: charMap = 8'd1;
    110: charMap = 8'd1;
    111: charMap = 8'd1;
    112: charMap = 8'd1;
    113: charMap = 8'd1;
    114: charMap = 8'd1;
    115: charMap = 8'd1;
    116: charMap = 8'd1;
    117: charMap = 8'd1;
    118: charMap = 8'd1;
    119: charMap = 8'd1;
    120: charMap = 8'd1;
    121: charMap = 8'd1;
    122: charMap = 8'd1;
    123: charMap = 8'd1;
    124: charMap = 8'd1;
    125: charMap = 8'd1;
    126: charMap = 8'd1;
    127: charMap = 8'd1;
    128: charMap = 8'd1;
    129: charMap = 8'd1;
    130: charMap = 8'd1;
    131: charMap = 8'd1;
    132: charMap = 8'd1;
    133: charMap = 8'd1;
    134: charMap = 8'd1;
    135: charMap = 8'd1;
    136: charMap = 8'd1;
    137: charMap = 8'd1;
    138: charMap = 8'd1;
    139: charMap = 8'd1;
    140: charMap = 8'd1;
    141: charMap = 8'd1;
    142: charMap = 8'd1;
    143: charMap = 8'd1;
    144: charMap = 8'd1;
    145: charMap = 8'd1;
    146: charMap = 8'd1;
    147: charMap = 8'd1;
    148: charMap = 8'd1;
    149: charMap = 8'd1;
    150: charMap = 8'd1;
    151: charMap = 8'd1;
    152: charMap = 8'd1;
    153: charMap = 8'd1;
    154: charMap = 8'd1;
    155: charMap = 8'd1;
    156: charMap = 8'd1;
    157: charMap = 8'd1;
    158: charMap = 8'd1;
    159: charMap = 8'd1;
    160: charMap = 8'd1;
    161: charMap = 8'd1;
    162: charMap = 8'd1;
    163: charMap = 8'd1;
    164: charMap = 8'd1;
    165: charMap = 8'd1;
    166: charMap = 8'd1;
    167: charMap = 8'd1;
    168: charMap = 8'd1;
    169: charMap = 8'd1;
    170: charMap = 8'd1;
    171: charMap = 8'd1;
    172: charMap = 8'd1;
    173: charMap = 8'd1;
    174: charMap = 8'd1;
    175: charMap = 8'd1;
    176: charMap = 8'd1;
    177: charMap = 8'd1;
    178: charMap = 8'd1;
    179: charMap = 8'd1;
    180: charMap = 8'd1;
    181: charMap = 8'd1;
    182: charMap = 8'd1;
    183: charMap = 8'd1;
    184: charMap = 8'd1;
    185: charMap = 8'd1;
    186: charMap = 8'd1;
    187: charMap = 8'd1;
    188: charMap = 8'd1;
    189: charMap = 8'd1;
    190: charMap = 8'd1;
    191: charMap = 8'd1;
    192: charMap = 8'd1;
    193: charMap = 8'd1;
    194: charMap = 8'd1;
    195: charMap = 8'd1;
    196: charMap = 8'd1;
    197: charMap = 8'd1;
    198: charMap = 8'd1;
    199: charMap = 8'd1;
    200: charMap = 8'd1;
    201: charMap = 8'd1;
    202: charMap = 8'd1;
    203: charMap = 8'd1;
    204: charMap = 8'd1;
    205: charMap = 8'd1;
    206: charMap = 8'd1;
    207: charMap = 8'd1;
    208: charMap = 8'd1;
    209: charMap = 8'd1;
    210: charMap = 8'd1;
    211: charMap = 8'd1;
    212: charMap = 8'd1;
    213: charMap = 8'd1;
    214: charMap = 8'd1;
    215: charMap = 8'd1;
    216: charMap = 8'd1;
    217: charMap = 8'd1;
    218: charMap = 8'd1;
    219: charMap = 8'd1;
    220: charMap = 8'd1;
    221: charMap = 8'd1;
    222: charMap = 8'd1;
    223: charMap = 8'd1;
    224: charMap = 8'd1;
    225: charMap = 8'd1;
    226: charMap = 8'd1;
    227: charMap = 8'd1;
    228: charMap = 8'd1;
    229: charMap = 8'd1;
    230: charMap = 8'd1;
    231: charMap = 8'd1;
    232: charMap = 8'd1;
    233: charMap = 8'd1;
    234: charMap = 8'd1;
    235: charMap = 8'd1;
    236: charMap = 8'd1;
    237: charMap = 8'd1;
    238: charMap = 8'd1;
    239: charMap = 8'd1;
    240: charMap = 8'd1;
    241: charMap = 8'd1;
    242: charMap = 8'd1;
    243: charMap = 8'd1;
    244: charMap = 8'd1;
    245: charMap = 8'd1;
    246: charMap = 8'd1;
    247: charMap = 8'd1;
    248: charMap = 8'd1;
    249: charMap = 8'd1;
    250: charMap = 8'd1;
    251: charMap = 8'd1;
    252: charMap = 8'd1;
    253: charMap = 8'd1;
    254: charMap = 8'd1;
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
    2: stateMap = 11'd2;
    3: stateMap = 11'd3;
    4: stateMap = 11'd4;
    5: stateMap = 11'd5;
    6: stateMap = 11'd6;
    7: stateMap = 11'd7;
    8: stateMap = 11'd8;
    9: stateMap = 11'd9;
    10: stateMap = 11'd10;
    11: stateMap = 11'd11;
    12: stateMap = 11'd12;
    13: stateMap = 11'd13;
    14: stateMap = 11'd14;
    15: stateMap = 11'd14;
    16: stateMap = 11'd15;
    17: stateMap = 11'd16;
    18: stateMap = 11'd4;
    19: stateMap = 11'd17;
    20: stateMap = 11'd18;
    21: stateMap = 11'd14;
    22: stateMap = 11'd19;
    23: stateMap = 11'd20;
    24: stateMap = 11'd2;
    25: stateMap = 11'd21;
    26: stateMap = 11'd21;
    27: stateMap = 11'd2;
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
    8: acceptStates = 1'b0;
    9: acceptStates = 1'b0;
    10: acceptStates = 1'b0;
    11: acceptStates = 1'b0;
    12: acceptStates = 1'b0;
    13: acceptStates = 1'b0;
    14: acceptStates = 1'b0;
    15: acceptStates = 1'b1;
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
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd3;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd3;
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
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd6;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd5;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd23;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd4;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd6;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd5;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd10;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd5;
      2: stateTransition = 11'd6;
      3: stateTransition = 11'd8;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd5;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd2;
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
