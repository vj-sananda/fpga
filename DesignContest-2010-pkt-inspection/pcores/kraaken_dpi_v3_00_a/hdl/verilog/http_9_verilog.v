`timescale 1ns/1ps

`define ENABLED_REGEX_http_9 TRUE

module http_9_verilog(clk,
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


`ifdef ENABLED_REGEX_http_9

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
    9: charMap = 8'd9;
    10: charMap = 8'd7;
    11: charMap = 8'd9;
    12: charMap = 8'd8;
    13: charMap = 8'd9;
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
    32: charMap = 8'd9;
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
    58: charMap = 8'd8;
    59: charMap = 8'd8;
    60: charMap = 8'd8;
    61: charMap = 8'd8;
    62: charMap = 8'd8;
    63: charMap = 8'd8;
    64: charMap = 8'd8;
    65: charMap = 8'd8;
    66: charMap = 8'd6;
    67: charMap = 8'd4;
    68: charMap = 8'd1;
    69: charMap = 8'd2;
    70: charMap = 8'd8;
    71: charMap = 8'd8;
    72: charMap = 8'd8;
    73: charMap = 8'd5;
    74: charMap = 8'd8;
    75: charMap = 8'd8;
    76: charMap = 8'd8;
    77: charMap = 8'd8;
    78: charMap = 8'd8;
    79: charMap = 8'd8;
    80: charMap = 8'd8;
    81: charMap = 8'd8;
    82: charMap = 8'd5;
    83: charMap = 8'd3;
    84: charMap = 8'd8;
    85: charMap = 8'd8;
    86: charMap = 8'd8;
    87: charMap = 8'd8;
    88: charMap = 8'd8;
    89: charMap = 8'd8;
    90: charMap = 8'd8;
    91: charMap = 8'd5;
    92: charMap = 8'd8;
    93: charMap = 8'd8;
    94: charMap = 8'd8;
    95: charMap = 8'd8;
    96: charMap = 8'd8;
    97: charMap = 8'd8;
    98: charMap = 8'd6;
    99: charMap = 8'd4;
    100: charMap = 8'd1;
    101: charMap = 8'd2;
    102: charMap = 8'd8;
    103: charMap = 8'd8;
    104: charMap = 8'd8;
    105: charMap = 8'd5;
    106: charMap = 8'd8;
    107: charMap = 8'd8;
    108: charMap = 8'd8;
    109: charMap = 8'd8;
    110: charMap = 8'd8;
    111: charMap = 8'd8;
    112: charMap = 8'd8;
    113: charMap = 8'd8;
    114: charMap = 8'd5;
    115: charMap = 8'd3;
    116: charMap = 8'd8;
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
    116: stateMap = 11'd115;
    117: stateMap = 11'd116;
    118: stateMap = 11'd117;
    119: stateMap = 11'd118;
    120: stateMap = 11'd119;
    121: stateMap = 11'd120;
    122: stateMap = 11'd121;
    123: stateMap = 11'd122;
    124: stateMap = 11'd123;
    125: stateMap = 11'd124;
    126: stateMap = 11'd125;
    127: stateMap = 11'd126;
    128: stateMap = 11'd127;
    129: stateMap = 11'd128;
    130: stateMap = 11'd129;
    131: stateMap = 11'd130;
    132: stateMap = 11'd131;
    133: stateMap = 11'd132;
    134: stateMap = 11'd133;
    135: stateMap = 11'd134;
    136: stateMap = 11'd135;
    137: stateMap = 11'd136;
    138: stateMap = 11'd137;
    139: stateMap = 11'd138;
    140: stateMap = 11'd139;
    141: stateMap = 11'd140;
    142: stateMap = 11'd141;
    143: stateMap = 11'd142;
    144: stateMap = 11'd143;
    145: stateMap = 11'd144;
    146: stateMap = 11'd145;
    147: stateMap = 11'd146;
    148: stateMap = 11'd147;
    149: stateMap = 11'd148;
    150: stateMap = 11'd149;
    151: stateMap = 11'd150;
    152: stateMap = 11'd151;
    153: stateMap = 11'd152;
    154: stateMap = 11'd153;
    155: stateMap = 11'd154;
    156: stateMap = 11'd155;
    157: stateMap = 11'd156;
    158: stateMap = 11'd157;
    159: stateMap = 11'd158;
    160: stateMap = 11'd159;
    161: stateMap = 11'd160;
    162: stateMap = 11'd161;
    163: stateMap = 11'd162;
    164: stateMap = 11'd163;
    165: stateMap = 11'd164;
    166: stateMap = 11'd165;
    167: stateMap = 11'd166;
    168: stateMap = 11'd167;
    169: stateMap = 11'd168;
    170: stateMap = 11'd169;
    171: stateMap = 11'd170;
    172: stateMap = 11'd171;
    173: stateMap = 11'd172;
    174: stateMap = 11'd173;
    175: stateMap = 11'd174;
    176: stateMap = 11'd175;
    177: stateMap = 11'd176;
    178: stateMap = 11'd177;
    179: stateMap = 11'd178;
    180: stateMap = 11'd179;
    181: stateMap = 11'd180;
    182: stateMap = 11'd181;
    183: stateMap = 11'd182;
    184: stateMap = 11'd183;
    185: stateMap = 11'd184;
    186: stateMap = 11'd185;
    187: stateMap = 11'd186;
    188: stateMap = 11'd187;
    189: stateMap = 11'd188;
    190: stateMap = 11'd189;
    191: stateMap = 11'd190;
    192: stateMap = 11'd191;
    193: stateMap = 11'd192;
    194: stateMap = 11'd193;
    195: stateMap = 11'd194;
    196: stateMap = 11'd195;
    197: stateMap = 11'd196;
    198: stateMap = 11'd197;
    199: stateMap = 11'd198;
    200: stateMap = 11'd199;
    201: stateMap = 11'd200;
    202: stateMap = 11'd201;
    203: stateMap = 11'd202;
    204: stateMap = 11'd203;
    205: stateMap = 11'd204;
    206: stateMap = 11'd205;
    207: stateMap = 11'd206;
    208: stateMap = 11'd207;
    209: stateMap = 11'd208;
    210: stateMap = 11'd209;
    211: stateMap = 11'd210;
    212: stateMap = 11'd211;
    213: stateMap = 11'd212;
    214: stateMap = 11'd213;
    215: stateMap = 11'd214;
    216: stateMap = 11'd215;
    217: stateMap = 11'd216;
    218: stateMap = 11'd217;
    219: stateMap = 11'd218;
    220: stateMap = 11'd219;
    221: stateMap = 11'd220;
    222: stateMap = 11'd221;
    223: stateMap = 11'd222;
    224: stateMap = 11'd223;
    225: stateMap = 11'd224;
    226: stateMap = 11'd225;
    227: stateMap = 11'd226;
    228: stateMap = 11'd227;
    229: stateMap = 11'd228;
    230: stateMap = 11'd229;
    231: stateMap = 11'd230;
    232: stateMap = 11'd231;
    233: stateMap = 11'd232;
    234: stateMap = 11'd233;
    235: stateMap = 11'd234;
    236: stateMap = 11'd235;
    237: stateMap = 11'd236;
    238: stateMap = 11'd237;
    239: stateMap = 11'd238;
    240: stateMap = 11'd239;
    241: stateMap = 11'd240;
    242: stateMap = 11'd241;
    243: stateMap = 11'd242;
    244: stateMap = 11'd243;
    245: stateMap = 11'd244;
    246: stateMap = 11'd245;
    247: stateMap = 11'd246;
    248: stateMap = 11'd247;
    249: stateMap = 11'd248;
    250: stateMap = 11'd249;
    251: stateMap = 11'd250;
    252: stateMap = 11'd251;
    253: stateMap = 11'd252;
    254: stateMap = 11'd253;
    255: stateMap = 11'd254;
    256: stateMap = 11'd255;
    257: stateMap = 11'd256;
    258: stateMap = 11'd257;
    259: stateMap = 11'd258;
    260: stateMap = 11'd259;
    261: stateMap = 11'd260;
    262: stateMap = 11'd261;
    263: stateMap = 11'd262;
    264: stateMap = 11'd263;
    265: stateMap = 11'd264;
    266: stateMap = 11'd265;
    267: stateMap = 11'd266;
    268: stateMap = 11'd267;
    269: stateMap = 11'd268;
    270: stateMap = 11'd269;
    271: stateMap = 11'd270;
    272: stateMap = 11'd271;
    273: stateMap = 11'd272;
    274: stateMap = 11'd273;
    275: stateMap = 11'd274;
    276: stateMap = 11'd275;
    277: stateMap = 11'd276;
    278: stateMap = 11'd277;
    279: stateMap = 11'd278;
    280: stateMap = 11'd279;
    281: stateMap = 11'd280;
    282: stateMap = 11'd281;
    283: stateMap = 11'd282;
    284: stateMap = 11'd283;
    285: stateMap = 11'd284;
    286: stateMap = 11'd285;
    287: stateMap = 11'd286;
    288: stateMap = 11'd287;
    289: stateMap = 11'd288;
    290: stateMap = 11'd289;
    291: stateMap = 11'd290;
    292: stateMap = 11'd291;
    293: stateMap = 11'd292;
    294: stateMap = 11'd293;
    295: stateMap = 11'd294;
    296: stateMap = 11'd295;
    297: stateMap = 11'd296;
    298: stateMap = 11'd297;
    299: stateMap = 11'd298;
    300: stateMap = 11'd299;
    301: stateMap = 11'd300;
    302: stateMap = 11'd301;
    303: stateMap = 11'd302;
    304: stateMap = 11'd303;
    305: stateMap = 11'd304;
    306: stateMap = 11'd305;
    307: stateMap = 11'd306;
    308: stateMap = 11'd307;
    309: stateMap = 11'd308;
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
    126: acceptStates = 1'b0;
    127: acceptStates = 1'b0;
    128: acceptStates = 1'b0;
    129: acceptStates = 1'b0;
    130: acceptStates = 1'b0;
    131: acceptStates = 1'b0;
    132: acceptStates = 1'b0;
    133: acceptStates = 1'b0;
    134: acceptStates = 1'b0;
    135: acceptStates = 1'b0;
    136: acceptStates = 1'b0;
    137: acceptStates = 1'b0;
    138: acceptStates = 1'b0;
    139: acceptStates = 1'b0;
    140: acceptStates = 1'b0;
    141: acceptStates = 1'b0;
    142: acceptStates = 1'b0;
    143: acceptStates = 1'b0;
    144: acceptStates = 1'b0;
    145: acceptStates = 1'b0;
    146: acceptStates = 1'b0;
    147: acceptStates = 1'b0;
    148: acceptStates = 1'b0;
    149: acceptStates = 1'b0;
    150: acceptStates = 1'b0;
    151: acceptStates = 1'b0;
    152: acceptStates = 1'b0;
    153: acceptStates = 1'b0;
    154: acceptStates = 1'b0;
    155: acceptStates = 1'b0;
    156: acceptStates = 1'b0;
    157: acceptStates = 1'b0;
    158: acceptStates = 1'b0;
    159: acceptStates = 1'b0;
    160: acceptStates = 1'b0;
    161: acceptStates = 1'b0;
    162: acceptStates = 1'b0;
    163: acceptStates = 1'b0;
    164: acceptStates = 1'b0;
    165: acceptStates = 1'b0;
    166: acceptStates = 1'b0;
    167: acceptStates = 1'b0;
    168: acceptStates = 1'b0;
    169: acceptStates = 1'b0;
    170: acceptStates = 1'b0;
    171: acceptStates = 1'b0;
    172: acceptStates = 1'b0;
    173: acceptStates = 1'b0;
    174: acceptStates = 1'b0;
    175: acceptStates = 1'b0;
    176: acceptStates = 1'b0;
    177: acceptStates = 1'b0;
    178: acceptStates = 1'b0;
    179: acceptStates = 1'b0;
    180: acceptStates = 1'b0;
    181: acceptStates = 1'b0;
    182: acceptStates = 1'b0;
    183: acceptStates = 1'b0;
    184: acceptStates = 1'b0;
    185: acceptStates = 1'b0;
    186: acceptStates = 1'b0;
    187: acceptStates = 1'b0;
    188: acceptStates = 1'b0;
    189: acceptStates = 1'b0;
    190: acceptStates = 1'b0;
    191: acceptStates = 1'b0;
    192: acceptStates = 1'b0;
    193: acceptStates = 1'b0;
    194: acceptStates = 1'b0;
    195: acceptStates = 1'b0;
    196: acceptStates = 1'b0;
    197: acceptStates = 1'b0;
    198: acceptStates = 1'b0;
    199: acceptStates = 1'b0;
    200: acceptStates = 1'b0;
    201: acceptStates = 1'b0;
    202: acceptStates = 1'b0;
    203: acceptStates = 1'b0;
    204: acceptStates = 1'b0;
    205: acceptStates = 1'b0;
    206: acceptStates = 1'b0;
    207: acceptStates = 1'b0;
    208: acceptStates = 1'b0;
    209: acceptStates = 1'b0;
    210: acceptStates = 1'b0;
    211: acceptStates = 1'b0;
    212: acceptStates = 1'b0;
    213: acceptStates = 1'b0;
    214: acceptStates = 1'b0;
    215: acceptStates = 1'b0;
    216: acceptStates = 1'b0;
    217: acceptStates = 1'b0;
    218: acceptStates = 1'b0;
    219: acceptStates = 1'b0;
    220: acceptStates = 1'b0;
    221: acceptStates = 1'b0;
    222: acceptStates = 1'b0;
    223: acceptStates = 1'b0;
    224: acceptStates = 1'b0;
    225: acceptStates = 1'b0;
    226: acceptStates = 1'b0;
    227: acceptStates = 1'b0;
    228: acceptStates = 1'b0;
    229: acceptStates = 1'b0;
    230: acceptStates = 1'b0;
    231: acceptStates = 1'b0;
    232: acceptStates = 1'b0;
    233: acceptStates = 1'b0;
    234: acceptStates = 1'b0;
    235: acceptStates = 1'b0;
    236: acceptStates = 1'b0;
    237: acceptStates = 1'b0;
    238: acceptStates = 1'b0;
    239: acceptStates = 1'b0;
    240: acceptStates = 1'b0;
    241: acceptStates = 1'b0;
    242: acceptStates = 1'b0;
    243: acceptStates = 1'b0;
    244: acceptStates = 1'b0;
    245: acceptStates = 1'b0;
    246: acceptStates = 1'b0;
    247: acceptStates = 1'b0;
    248: acceptStates = 1'b0;
    249: acceptStates = 1'b0;
    250: acceptStates = 1'b0;
    251: acceptStates = 1'b0;
    252: acceptStates = 1'b0;
    253: acceptStates = 1'b0;
    254: acceptStates = 1'b0;
    255: acceptStates = 1'b0;
    256: acceptStates = 1'b0;
    257: acceptStates = 1'b0;
    258: acceptStates = 1'b0;
    259: acceptStates = 1'b0;
    260: acceptStates = 1'b0;
    261: acceptStates = 1'b0;
    262: acceptStates = 1'b0;
    263: acceptStates = 1'b0;
    264: acceptStates = 1'b0;
    265: acceptStates = 1'b0;
    266: acceptStates = 1'b0;
    267: acceptStates = 1'b0;
    268: acceptStates = 1'b0;
    269: acceptStates = 1'b0;
    270: acceptStates = 1'b0;
    271: acceptStates = 1'b0;
    272: acceptStates = 1'b0;
    273: acceptStates = 1'b0;
    274: acceptStates = 1'b0;
    275: acceptStates = 1'b0;
    276: acceptStates = 1'b0;
    277: acceptStates = 1'b0;
    278: acceptStates = 1'b0;
    279: acceptStates = 1'b0;
    280: acceptStates = 1'b0;
    281: acceptStates = 1'b0;
    282: acceptStates = 1'b0;
    283: acceptStates = 1'b0;
    284: acceptStates = 1'b0;
    285: acceptStates = 1'b0;
    286: acceptStates = 1'b0;
    287: acceptStates = 1'b0;
    288: acceptStates = 1'b0;
    289: acceptStates = 1'b0;
    290: acceptStates = 1'b0;
    291: acceptStates = 1'b0;
    292: acceptStates = 1'b0;
    293: acceptStates = 1'b0;
    294: acceptStates = 1'b0;
    295: acceptStates = 1'b0;
    296: acceptStates = 1'b0;
    297: acceptStates = 1'b0;
    298: acceptStates = 1'b0;
    299: acceptStates = 1'b0;
    300: acceptStates = 1'b0;
    301: acceptStates = 1'b0;
    302: acceptStates = 1'b0;
    303: acceptStates = 1'b0;
    304: acceptStates = 1'b0;
    305: acceptStates = 1'b0;
    306: acceptStates = 1'b0;
    307: acceptStates = 1'b0;
    308: acceptStates = 1'b0;
    309: acceptStates = 1'b0;
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
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
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
      9: stateTransition = 11'd10;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd309;
      2: stateTransition = 11'd309;
      3: stateTransition = 11'd309;
      4: stateTransition = 11'd309;
      5: stateTransition = 11'd309;
      6: stateTransition = 11'd309;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd309;
      9: stateTransition = 11'd309;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd2;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd2;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd2;
      9: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd11;
      6: stateTransition = 11'd11;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd11;
      9: stateTransition = 11'd11;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd12;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd12;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd12;
      9: stateTransition = 11'd12;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd13;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd13;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd13;
      9: stateTransition = 11'd13;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd14;
      9: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd15;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd15;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd15;
      9: stateTransition = 11'd15;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd16;
      6: stateTransition = 11'd16;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd16;
      9: stateTransition = 11'd16;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd17;
      4: stateTransition = 11'd17;
      5: stateTransition = 11'd17;
      6: stateTransition = 11'd17;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd17;
      9: stateTransition = 11'd17;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd18;
      3: stateTransition = 11'd18;
      4: stateTransition = 11'd18;
      5: stateTransition = 11'd18;
      6: stateTransition = 11'd18;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd18;
      9: stateTransition = 11'd18;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd19;
      4: stateTransition = 11'd19;
      5: stateTransition = 11'd19;
      6: stateTransition = 11'd19;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd19;
      9: stateTransition = 11'd19;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd20;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd20;
      4: stateTransition = 11'd20;
      5: stateTransition = 11'd20;
      6: stateTransition = 11'd20;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd20;
      9: stateTransition = 11'd20;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd21;
      4: stateTransition = 11'd21;
      5: stateTransition = 11'd21;
      6: stateTransition = 11'd21;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd21;
      9: stateTransition = 11'd21;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd22;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd22;
      4: stateTransition = 11'd22;
      5: stateTransition = 11'd22;
      6: stateTransition = 11'd22;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd22;
      9: stateTransition = 11'd22;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd23;
      4: stateTransition = 11'd23;
      5: stateTransition = 11'd23;
      6: stateTransition = 11'd23;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd23;
      9: stateTransition = 11'd23;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd24;
      3: stateTransition = 11'd24;
      4: stateTransition = 11'd24;
      5: stateTransition = 11'd24;
      6: stateTransition = 11'd24;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd24;
      9: stateTransition = 11'd24;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd25;
      4: stateTransition = 11'd25;
      5: stateTransition = 11'd25;
      6: stateTransition = 11'd25;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd25;
      9: stateTransition = 11'd25;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd26;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd26;
      4: stateTransition = 11'd26;
      5: stateTransition = 11'd26;
      6: stateTransition = 11'd26;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd26;
      9: stateTransition = 11'd26;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd27;
      4: stateTransition = 11'd27;
      5: stateTransition = 11'd27;
      6: stateTransition = 11'd27;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd27;
      9: stateTransition = 11'd27;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd28;
      3: stateTransition = 11'd28;
      4: stateTransition = 11'd28;
      5: stateTransition = 11'd28;
      6: stateTransition = 11'd28;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd28;
      9: stateTransition = 11'd28;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd29;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd29;
      9: stateTransition = 11'd29;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd30;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd30;
      4: stateTransition = 11'd30;
      5: stateTransition = 11'd30;
      6: stateTransition = 11'd30;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd30;
      9: stateTransition = 11'd30;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd31;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd31;
      4: stateTransition = 11'd31;
      5: stateTransition = 11'd31;
      6: stateTransition = 11'd31;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd31;
      9: stateTransition = 11'd31;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd32;
      3: stateTransition = 11'd32;
      4: stateTransition = 11'd32;
      5: stateTransition = 11'd32;
      6: stateTransition = 11'd32;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd32;
      9: stateTransition = 11'd32;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd33;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd33;
      5: stateTransition = 11'd33;
      6: stateTransition = 11'd33;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd33;
      9: stateTransition = 11'd33;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd34;
      3: stateTransition = 11'd34;
      4: stateTransition = 11'd34;
      5: stateTransition = 11'd34;
      6: stateTransition = 11'd34;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd34;
      9: stateTransition = 11'd34;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd35;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd35;
      4: stateTransition = 11'd35;
      5: stateTransition = 11'd35;
      6: stateTransition = 11'd35;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd35;
      9: stateTransition = 11'd35;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd36;
      2: stateTransition = 11'd36;
      3: stateTransition = 11'd36;
      4: stateTransition = 11'd36;
      5: stateTransition = 11'd36;
      6: stateTransition = 11'd36;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd36;
      9: stateTransition = 11'd36;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd37;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd37;
      4: stateTransition = 11'd37;
      5: stateTransition = 11'd37;
      6: stateTransition = 11'd37;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd37;
      9: stateTransition = 11'd37;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd38;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd38;
      4: stateTransition = 11'd38;
      5: stateTransition = 11'd38;
      6: stateTransition = 11'd38;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd38;
      9: stateTransition = 11'd38;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd39;
      2: stateTransition = 11'd39;
      3: stateTransition = 11'd39;
      4: stateTransition = 11'd39;
      5: stateTransition = 11'd39;
      6: stateTransition = 11'd39;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd39;
      9: stateTransition = 11'd39;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd40;
      2: stateTransition = 11'd40;
      3: stateTransition = 11'd40;
      4: stateTransition = 11'd40;
      5: stateTransition = 11'd40;
      6: stateTransition = 11'd40;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd40;
      9: stateTransition = 11'd40;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd41;
      2: stateTransition = 11'd41;
      3: stateTransition = 11'd41;
      4: stateTransition = 11'd41;
      5: stateTransition = 11'd41;
      6: stateTransition = 11'd41;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd41;
      9: stateTransition = 11'd41;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd42;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd42;
      5: stateTransition = 11'd42;
      6: stateTransition = 11'd42;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd42;
      9: stateTransition = 11'd42;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd43;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd43;
      4: stateTransition = 11'd43;
      5: stateTransition = 11'd43;
      6: stateTransition = 11'd43;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd43;
      9: stateTransition = 11'd43;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd44;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd44;
      4: stateTransition = 11'd44;
      5: stateTransition = 11'd44;
      6: stateTransition = 11'd44;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd44;
      9: stateTransition = 11'd44;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd45;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd45;
      4: stateTransition = 11'd45;
      5: stateTransition = 11'd45;
      6: stateTransition = 11'd45;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd45;
      9: stateTransition = 11'd45;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd46;
      2: stateTransition = 11'd46;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd46;
      5: stateTransition = 11'd46;
      6: stateTransition = 11'd46;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd46;
      9: stateTransition = 11'd46;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd47;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd47;
      4: stateTransition = 11'd47;
      5: stateTransition = 11'd47;
      6: stateTransition = 11'd47;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd47;
      9: stateTransition = 11'd47;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd48;
      2: stateTransition = 11'd48;
      3: stateTransition = 11'd48;
      4: stateTransition = 11'd48;
      5: stateTransition = 11'd48;
      6: stateTransition = 11'd48;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd48;
      9: stateTransition = 11'd48;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd49;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd49;
      4: stateTransition = 11'd49;
      5: stateTransition = 11'd49;
      6: stateTransition = 11'd49;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd49;
      9: stateTransition = 11'd49;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd50;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd50;
      4: stateTransition = 11'd50;
      5: stateTransition = 11'd50;
      6: stateTransition = 11'd50;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd50;
      9: stateTransition = 11'd50;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd51;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd51;
      4: stateTransition = 11'd51;
      5: stateTransition = 11'd51;
      6: stateTransition = 11'd51;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd51;
      9: stateTransition = 11'd51;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd52;
      2: stateTransition = 11'd52;
      3: stateTransition = 11'd52;
      4: stateTransition = 11'd52;
      5: stateTransition = 11'd52;
      6: stateTransition = 11'd52;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd52;
      9: stateTransition = 11'd52;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd53;
      2: stateTransition = 11'd53;
      3: stateTransition = 11'd53;
      4: stateTransition = 11'd53;
      5: stateTransition = 11'd53;
      6: stateTransition = 11'd53;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd53;
      9: stateTransition = 11'd53;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd54;
      3: stateTransition = 11'd54;
      4: stateTransition = 11'd54;
      5: stateTransition = 11'd54;
      6: stateTransition = 11'd54;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd54;
      9: stateTransition = 11'd54;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd55;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd55;
      4: stateTransition = 11'd55;
      5: stateTransition = 11'd55;
      6: stateTransition = 11'd55;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd55;
      9: stateTransition = 11'd55;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd56;
      2: stateTransition = 11'd56;
      3: stateTransition = 11'd56;
      4: stateTransition = 11'd56;
      5: stateTransition = 11'd56;
      6: stateTransition = 11'd56;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd56;
      9: stateTransition = 11'd56;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd57;
      2: stateTransition = 11'd57;
      3: stateTransition = 11'd57;
      4: stateTransition = 11'd57;
      5: stateTransition = 11'd57;
      6: stateTransition = 11'd57;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd57;
      9: stateTransition = 11'd57;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd58;
      2: stateTransition = 11'd58;
      3: stateTransition = 11'd58;
      4: stateTransition = 11'd58;
      5: stateTransition = 11'd58;
      6: stateTransition = 11'd58;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd58;
      9: stateTransition = 11'd58;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd59;
      2: stateTransition = 11'd59;
      3: stateTransition = 11'd59;
      4: stateTransition = 11'd59;
      5: stateTransition = 11'd59;
      6: stateTransition = 11'd59;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd59;
      9: stateTransition = 11'd59;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd60;
      2: stateTransition = 11'd60;
      3: stateTransition = 11'd60;
      4: stateTransition = 11'd60;
      5: stateTransition = 11'd60;
      6: stateTransition = 11'd60;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd60;
      9: stateTransition = 11'd60;
      default: stateTransition = 11'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd61;
      2: stateTransition = 11'd61;
      3: stateTransition = 11'd61;
      4: stateTransition = 11'd61;
      5: stateTransition = 11'd61;
      6: stateTransition = 11'd61;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd61;
      9: stateTransition = 11'd61;
      default: stateTransition = 11'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd62;
      2: stateTransition = 11'd62;
      3: stateTransition = 11'd62;
      4: stateTransition = 11'd62;
      5: stateTransition = 11'd62;
      6: stateTransition = 11'd62;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd62;
      9: stateTransition = 11'd62;
      default: stateTransition = 11'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd63;
      2: stateTransition = 11'd63;
      3: stateTransition = 11'd63;
      4: stateTransition = 11'd63;
      5: stateTransition = 11'd63;
      6: stateTransition = 11'd63;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd63;
      9: stateTransition = 11'd63;
      default: stateTransition = 11'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd64;
      2: stateTransition = 11'd64;
      3: stateTransition = 11'd64;
      4: stateTransition = 11'd64;
      5: stateTransition = 11'd64;
      6: stateTransition = 11'd64;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd64;
      9: stateTransition = 11'd64;
      default: stateTransition = 11'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd65;
      2: stateTransition = 11'd65;
      3: stateTransition = 11'd65;
      4: stateTransition = 11'd65;
      5: stateTransition = 11'd65;
      6: stateTransition = 11'd65;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd65;
      9: stateTransition = 11'd65;
      default: stateTransition = 11'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd66;
      2: stateTransition = 11'd66;
      3: stateTransition = 11'd66;
      4: stateTransition = 11'd66;
      5: stateTransition = 11'd66;
      6: stateTransition = 11'd66;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd66;
      9: stateTransition = 11'd66;
      default: stateTransition = 11'bX;
    endcase
    67: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd67;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd67;
      4: stateTransition = 11'd67;
      5: stateTransition = 11'd67;
      6: stateTransition = 11'd67;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd67;
      9: stateTransition = 11'd67;
      default: stateTransition = 11'bX;
    endcase
    68: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd68;
      2: stateTransition = 11'd68;
      3: stateTransition = 11'd68;
      4: stateTransition = 11'd68;
      5: stateTransition = 11'd68;
      6: stateTransition = 11'd68;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd68;
      9: stateTransition = 11'd68;
      default: stateTransition = 11'bX;
    endcase
    69: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd69;
      2: stateTransition = 11'd69;
      3: stateTransition = 11'd69;
      4: stateTransition = 11'd69;
      5: stateTransition = 11'd69;
      6: stateTransition = 11'd69;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd69;
      9: stateTransition = 11'd69;
      default: stateTransition = 11'bX;
    endcase
    70: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd70;
      2: stateTransition = 11'd70;
      3: stateTransition = 11'd70;
      4: stateTransition = 11'd70;
      5: stateTransition = 11'd70;
      6: stateTransition = 11'd70;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd70;
      9: stateTransition = 11'd70;
      default: stateTransition = 11'bX;
    endcase
    71: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd71;
      2: stateTransition = 11'd71;
      3: stateTransition = 11'd71;
      4: stateTransition = 11'd71;
      5: stateTransition = 11'd71;
      6: stateTransition = 11'd71;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd71;
      9: stateTransition = 11'd71;
      default: stateTransition = 11'bX;
    endcase
    72: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd72;
      2: stateTransition = 11'd72;
      3: stateTransition = 11'd72;
      4: stateTransition = 11'd72;
      5: stateTransition = 11'd72;
      6: stateTransition = 11'd72;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd72;
      9: stateTransition = 11'd72;
      default: stateTransition = 11'bX;
    endcase
    73: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd73;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd73;
      4: stateTransition = 11'd73;
      5: stateTransition = 11'd73;
      6: stateTransition = 11'd73;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd73;
      9: stateTransition = 11'd73;
      default: stateTransition = 11'bX;
    endcase
    74: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd74;
      2: stateTransition = 11'd74;
      3: stateTransition = 11'd74;
      4: stateTransition = 11'd74;
      5: stateTransition = 11'd74;
      6: stateTransition = 11'd74;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd74;
      9: stateTransition = 11'd74;
      default: stateTransition = 11'bX;
    endcase
    75: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd75;
      2: stateTransition = 11'd75;
      3: stateTransition = 11'd75;
      4: stateTransition = 11'd75;
      5: stateTransition = 11'd75;
      6: stateTransition = 11'd75;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd75;
      9: stateTransition = 11'd75;
      default: stateTransition = 11'bX;
    endcase
    76: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd76;
      2: stateTransition = 11'd76;
      3: stateTransition = 11'd76;
      4: stateTransition = 11'd76;
      5: stateTransition = 11'd76;
      6: stateTransition = 11'd76;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd76;
      9: stateTransition = 11'd76;
      default: stateTransition = 11'bX;
    endcase
    77: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd77;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd77;
      4: stateTransition = 11'd77;
      5: stateTransition = 11'd77;
      6: stateTransition = 11'd77;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd77;
      9: stateTransition = 11'd77;
      default: stateTransition = 11'bX;
    endcase
    78: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd78;
      2: stateTransition = 11'd78;
      3: stateTransition = 11'd78;
      4: stateTransition = 11'd78;
      5: stateTransition = 11'd78;
      6: stateTransition = 11'd78;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd78;
      9: stateTransition = 11'd78;
      default: stateTransition = 11'bX;
    endcase
    79: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd79;
      2: stateTransition = 11'd79;
      3: stateTransition = 11'd79;
      4: stateTransition = 11'd79;
      5: stateTransition = 11'd79;
      6: stateTransition = 11'd79;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd79;
      9: stateTransition = 11'd79;
      default: stateTransition = 11'bX;
    endcase
    80: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd80;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd80;
      4: stateTransition = 11'd80;
      5: stateTransition = 11'd80;
      6: stateTransition = 11'd80;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd80;
      9: stateTransition = 11'd80;
      default: stateTransition = 11'bX;
    endcase
    81: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd81;
      2: stateTransition = 11'd81;
      3: stateTransition = 11'd81;
      4: stateTransition = 11'd81;
      5: stateTransition = 11'd81;
      6: stateTransition = 11'd81;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd81;
      9: stateTransition = 11'd81;
      default: stateTransition = 11'bX;
    endcase
    82: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd82;
      2: stateTransition = 11'd82;
      3: stateTransition = 11'd82;
      4: stateTransition = 11'd82;
      5: stateTransition = 11'd82;
      6: stateTransition = 11'd82;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd82;
      9: stateTransition = 11'd82;
      default: stateTransition = 11'bX;
    endcase
    83: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd83;
      2: stateTransition = 11'd83;
      3: stateTransition = 11'd83;
      4: stateTransition = 11'd83;
      5: stateTransition = 11'd83;
      6: stateTransition = 11'd83;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd83;
      9: stateTransition = 11'd83;
      default: stateTransition = 11'bX;
    endcase
    84: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd84;
      2: stateTransition = 11'd84;
      3: stateTransition = 11'd84;
      4: stateTransition = 11'd84;
      5: stateTransition = 11'd84;
      6: stateTransition = 11'd84;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd84;
      9: stateTransition = 11'd84;
      default: stateTransition = 11'bX;
    endcase
    85: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd85;
      2: stateTransition = 11'd85;
      3: stateTransition = 11'd85;
      4: stateTransition = 11'd85;
      5: stateTransition = 11'd85;
      6: stateTransition = 11'd85;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd85;
      9: stateTransition = 11'd85;
      default: stateTransition = 11'bX;
    endcase
    86: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd86;
      2: stateTransition = 11'd86;
      3: stateTransition = 11'd86;
      4: stateTransition = 11'd86;
      5: stateTransition = 11'd86;
      6: stateTransition = 11'd86;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd86;
      9: stateTransition = 11'd86;
      default: stateTransition = 11'bX;
    endcase
    87: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd87;
      2: stateTransition = 11'd87;
      3: stateTransition = 11'd87;
      4: stateTransition = 11'd87;
      5: stateTransition = 11'd87;
      6: stateTransition = 11'd87;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd87;
      9: stateTransition = 11'd87;
      default: stateTransition = 11'bX;
    endcase
    88: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd88;
      3: stateTransition = 11'd88;
      4: stateTransition = 11'd88;
      5: stateTransition = 11'd88;
      6: stateTransition = 11'd88;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd88;
      9: stateTransition = 11'd88;
      default: stateTransition = 11'bX;
    endcase
    89: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd89;
      2: stateTransition = 11'd89;
      3: stateTransition = 11'd89;
      4: stateTransition = 11'd89;
      5: stateTransition = 11'd89;
      6: stateTransition = 11'd89;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd89;
      9: stateTransition = 11'd89;
      default: stateTransition = 11'bX;
    endcase
    90: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd90;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd90;
      4: stateTransition = 11'd90;
      5: stateTransition = 11'd90;
      6: stateTransition = 11'd90;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd90;
      9: stateTransition = 11'd90;
      default: stateTransition = 11'bX;
    endcase
    91: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd91;
      2: stateTransition = 11'd91;
      3: stateTransition = 11'd91;
      4: stateTransition = 11'd91;
      5: stateTransition = 11'd91;
      6: stateTransition = 11'd91;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd91;
      9: stateTransition = 11'd91;
      default: stateTransition = 11'bX;
    endcase
    92: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd92;
      2: stateTransition = 11'd92;
      3: stateTransition = 11'd92;
      4: stateTransition = 11'd92;
      5: stateTransition = 11'd92;
      6: stateTransition = 11'd92;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd92;
      9: stateTransition = 11'd92;
      default: stateTransition = 11'bX;
    endcase
    93: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd93;
      2: stateTransition = 11'd93;
      3: stateTransition = 11'd93;
      4: stateTransition = 11'd93;
      5: stateTransition = 11'd93;
      6: stateTransition = 11'd93;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd93;
      9: stateTransition = 11'd93;
      default: stateTransition = 11'bX;
    endcase
    94: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd94;
      2: stateTransition = 11'd94;
      3: stateTransition = 11'd94;
      4: stateTransition = 11'd94;
      5: stateTransition = 11'd94;
      6: stateTransition = 11'd94;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd94;
      9: stateTransition = 11'd94;
      default: stateTransition = 11'bX;
    endcase
    95: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd95;
      2: stateTransition = 11'd95;
      3: stateTransition = 11'd95;
      4: stateTransition = 11'd95;
      5: stateTransition = 11'd95;
      6: stateTransition = 11'd95;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd95;
      9: stateTransition = 11'd95;
      default: stateTransition = 11'bX;
    endcase
    96: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd96;
      2: stateTransition = 11'd96;
      3: stateTransition = 11'd96;
      4: stateTransition = 11'd96;
      5: stateTransition = 11'd96;
      6: stateTransition = 11'd96;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd96;
      9: stateTransition = 11'd96;
      default: stateTransition = 11'bX;
    endcase
    97: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd97;
      3: stateTransition = 11'd97;
      4: stateTransition = 11'd97;
      5: stateTransition = 11'd97;
      6: stateTransition = 11'd97;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd97;
      9: stateTransition = 11'd97;
      default: stateTransition = 11'bX;
    endcase
    98: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd98;
      2: stateTransition = 11'd98;
      3: stateTransition = 11'd98;
      4: stateTransition = 11'd98;
      5: stateTransition = 11'd98;
      6: stateTransition = 11'd98;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd98;
      9: stateTransition = 11'd98;
      default: stateTransition = 11'bX;
    endcase
    99: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd99;
      2: stateTransition = 11'd99;
      3: stateTransition = 11'd99;
      4: stateTransition = 11'd99;
      5: stateTransition = 11'd99;
      6: stateTransition = 11'd99;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd99;
      9: stateTransition = 11'd99;
      default: stateTransition = 11'bX;
    endcase
    100: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd100;
      2: stateTransition = 11'd100;
      3: stateTransition = 11'd100;
      4: stateTransition = 11'd100;
      5: stateTransition = 11'd100;
      6: stateTransition = 11'd100;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd100;
      9: stateTransition = 11'd100;
      default: stateTransition = 11'bX;
    endcase
    101: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd101;
      2: stateTransition = 11'd101;
      3: stateTransition = 11'd101;
      4: stateTransition = 11'd101;
      5: stateTransition = 11'd101;
      6: stateTransition = 11'd101;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd101;
      9: stateTransition = 11'd101;
      default: stateTransition = 11'bX;
    endcase
    102: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd102;
      2: stateTransition = 11'd102;
      3: stateTransition = 11'd102;
      4: stateTransition = 11'd102;
      5: stateTransition = 11'd102;
      6: stateTransition = 11'd102;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd102;
      9: stateTransition = 11'd102;
      default: stateTransition = 11'bX;
    endcase
    103: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd103;
      2: stateTransition = 11'd103;
      3: stateTransition = 11'd103;
      4: stateTransition = 11'd103;
      5: stateTransition = 11'd103;
      6: stateTransition = 11'd103;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd103;
      9: stateTransition = 11'd103;
      default: stateTransition = 11'bX;
    endcase
    104: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd104;
      3: stateTransition = 11'd104;
      4: stateTransition = 11'd104;
      5: stateTransition = 11'd104;
      6: stateTransition = 11'd104;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd104;
      9: stateTransition = 11'd104;
      default: stateTransition = 11'bX;
    endcase
    105: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd105;
      2: stateTransition = 11'd105;
      3: stateTransition = 11'd105;
      4: stateTransition = 11'd105;
      5: stateTransition = 11'd105;
      6: stateTransition = 11'd105;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd105;
      9: stateTransition = 11'd105;
      default: stateTransition = 11'bX;
    endcase
    106: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd106;
      3: stateTransition = 11'd106;
      4: stateTransition = 11'd106;
      5: stateTransition = 11'd106;
      6: stateTransition = 11'd106;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd106;
      9: stateTransition = 11'd106;
      default: stateTransition = 11'bX;
    endcase
    107: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd107;
      2: stateTransition = 11'd107;
      3: stateTransition = 11'd107;
      4: stateTransition = 11'd107;
      5: stateTransition = 11'd107;
      6: stateTransition = 11'd107;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd107;
      9: stateTransition = 11'd107;
      default: stateTransition = 11'bX;
    endcase
    108: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd108;
      2: stateTransition = 11'd108;
      3: stateTransition = 11'd108;
      4: stateTransition = 11'd108;
      5: stateTransition = 11'd108;
      6: stateTransition = 11'd108;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd108;
      9: stateTransition = 11'd108;
      default: stateTransition = 11'bX;
    endcase
    109: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd109;
      2: stateTransition = 11'd109;
      3: stateTransition = 11'd109;
      4: stateTransition = 11'd109;
      5: stateTransition = 11'd109;
      6: stateTransition = 11'd109;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd109;
      9: stateTransition = 11'd109;
      default: stateTransition = 11'bX;
    endcase
    110: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd110;
      2: stateTransition = 11'd110;
      3: stateTransition = 11'd110;
      4: stateTransition = 11'd110;
      5: stateTransition = 11'd110;
      6: stateTransition = 11'd110;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd110;
      9: stateTransition = 11'd110;
      default: stateTransition = 11'bX;
    endcase
    111: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd111;
      2: stateTransition = 11'd111;
      3: stateTransition = 11'd111;
      4: stateTransition = 11'd111;
      5: stateTransition = 11'd111;
      6: stateTransition = 11'd111;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd111;
      9: stateTransition = 11'd111;
      default: stateTransition = 11'bX;
    endcase
    112: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd112;
      3: stateTransition = 11'd112;
      4: stateTransition = 11'd112;
      5: stateTransition = 11'd112;
      6: stateTransition = 11'd112;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd112;
      9: stateTransition = 11'd112;
      default: stateTransition = 11'bX;
    endcase
    113: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd113;
      2: stateTransition = 11'd113;
      3: stateTransition = 11'd113;
      4: stateTransition = 11'd113;
      5: stateTransition = 11'd113;
      6: stateTransition = 11'd113;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd113;
      9: stateTransition = 11'd113;
      default: stateTransition = 11'bX;
    endcase
    114: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd114;
      2: stateTransition = 11'd114;
      3: stateTransition = 11'd114;
      4: stateTransition = 11'd114;
      5: stateTransition = 11'd114;
      6: stateTransition = 11'd114;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd114;
      9: stateTransition = 11'd114;
      default: stateTransition = 11'bX;
    endcase
    115: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd115;
      3: stateTransition = 11'd115;
      4: stateTransition = 11'd115;
      5: stateTransition = 11'd115;
      6: stateTransition = 11'd115;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd115;
      9: stateTransition = 11'd115;
      default: stateTransition = 11'bX;
    endcase
    116: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd116;
      2: stateTransition = 11'd116;
      3: stateTransition = 11'd116;
      4: stateTransition = 11'd116;
      5: stateTransition = 11'd116;
      6: stateTransition = 11'd116;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd116;
      9: stateTransition = 11'd116;
      default: stateTransition = 11'bX;
    endcase
    117: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd117;
      2: stateTransition = 11'd117;
      3: stateTransition = 11'd117;
      4: stateTransition = 11'd117;
      5: stateTransition = 11'd117;
      6: stateTransition = 11'd117;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd117;
      9: stateTransition = 11'd117;
      default: stateTransition = 11'bX;
    endcase
    118: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd118;
      2: stateTransition = 11'd118;
      3: stateTransition = 11'd118;
      4: stateTransition = 11'd118;
      5: stateTransition = 11'd118;
      6: stateTransition = 11'd118;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd118;
      9: stateTransition = 11'd118;
      default: stateTransition = 11'bX;
    endcase
    119: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd119;
      2: stateTransition = 11'd119;
      3: stateTransition = 11'd119;
      4: stateTransition = 11'd119;
      5: stateTransition = 11'd119;
      6: stateTransition = 11'd119;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd119;
      9: stateTransition = 11'd119;
      default: stateTransition = 11'bX;
    endcase
    120: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd120;
      2: stateTransition = 11'd120;
      3: stateTransition = 11'd120;
      4: stateTransition = 11'd120;
      5: stateTransition = 11'd120;
      6: stateTransition = 11'd120;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd120;
      9: stateTransition = 11'd120;
      default: stateTransition = 11'bX;
    endcase
    121: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd121;
      3: stateTransition = 11'd121;
      4: stateTransition = 11'd121;
      5: stateTransition = 11'd121;
      6: stateTransition = 11'd121;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd121;
      9: stateTransition = 11'd121;
      default: stateTransition = 11'bX;
    endcase
    122: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd122;
      2: stateTransition = 11'd122;
      3: stateTransition = 11'd122;
      4: stateTransition = 11'd122;
      5: stateTransition = 11'd122;
      6: stateTransition = 11'd122;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd122;
      9: stateTransition = 11'd122;
      default: stateTransition = 11'bX;
    endcase
    123: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd123;
      3: stateTransition = 11'd123;
      4: stateTransition = 11'd123;
      5: stateTransition = 11'd123;
      6: stateTransition = 11'd123;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd123;
      9: stateTransition = 11'd123;
      default: stateTransition = 11'bX;
    endcase
    124: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd124;
      2: stateTransition = 11'd124;
      3: stateTransition = 11'd124;
      4: stateTransition = 11'd124;
      5: stateTransition = 11'd124;
      6: stateTransition = 11'd124;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd124;
      9: stateTransition = 11'd124;
      default: stateTransition = 11'bX;
    endcase
    125: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd125;
      2: stateTransition = 11'd125;
      3: stateTransition = 11'd125;
      4: stateTransition = 11'd125;
      5: stateTransition = 11'd125;
      6: stateTransition = 11'd125;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd125;
      9: stateTransition = 11'd125;
      default: stateTransition = 11'bX;
    endcase
    126: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd126;
      3: stateTransition = 11'd126;
      4: stateTransition = 11'd126;
      5: stateTransition = 11'd126;
      6: stateTransition = 11'd126;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd126;
      9: stateTransition = 11'd126;
      default: stateTransition = 11'bX;
    endcase
    127: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd127;
      2: stateTransition = 11'd127;
      3: stateTransition = 11'd127;
      4: stateTransition = 11'd127;
      5: stateTransition = 11'd127;
      6: stateTransition = 11'd127;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd127;
      9: stateTransition = 11'd127;
      default: stateTransition = 11'bX;
    endcase
    128: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd128;
      2: stateTransition = 11'd128;
      3: stateTransition = 11'd128;
      4: stateTransition = 11'd128;
      5: stateTransition = 11'd128;
      6: stateTransition = 11'd128;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd128;
      9: stateTransition = 11'd128;
      default: stateTransition = 11'bX;
    endcase
    129: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd129;
      2: stateTransition = 11'd129;
      3: stateTransition = 11'd129;
      4: stateTransition = 11'd129;
      5: stateTransition = 11'd129;
      6: stateTransition = 11'd129;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd129;
      9: stateTransition = 11'd129;
      default: stateTransition = 11'bX;
    endcase
    130: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd130;
      3: stateTransition = 11'd130;
      4: stateTransition = 11'd130;
      5: stateTransition = 11'd130;
      6: stateTransition = 11'd130;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd130;
      9: stateTransition = 11'd130;
      default: stateTransition = 11'bX;
    endcase
    131: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd131;
      2: stateTransition = 11'd131;
      3: stateTransition = 11'd131;
      4: stateTransition = 11'd131;
      5: stateTransition = 11'd131;
      6: stateTransition = 11'd131;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd131;
      9: stateTransition = 11'd131;
      default: stateTransition = 11'bX;
    endcase
    132: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd132;
      2: stateTransition = 11'd132;
      3: stateTransition = 11'd132;
      4: stateTransition = 11'd132;
      5: stateTransition = 11'd132;
      6: stateTransition = 11'd132;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd132;
      9: stateTransition = 11'd132;
      default: stateTransition = 11'bX;
    endcase
    133: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd133;
      2: stateTransition = 11'd133;
      3: stateTransition = 11'd133;
      4: stateTransition = 11'd133;
      5: stateTransition = 11'd133;
      6: stateTransition = 11'd133;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd133;
      9: stateTransition = 11'd133;
      default: stateTransition = 11'bX;
    endcase
    134: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd134;
      3: stateTransition = 11'd134;
      4: stateTransition = 11'd134;
      5: stateTransition = 11'd134;
      6: stateTransition = 11'd134;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd134;
      9: stateTransition = 11'd134;
      default: stateTransition = 11'bX;
    endcase
    135: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd135;
      2: stateTransition = 11'd135;
      3: stateTransition = 11'd135;
      4: stateTransition = 11'd135;
      5: stateTransition = 11'd135;
      6: stateTransition = 11'd135;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd135;
      9: stateTransition = 11'd135;
      default: stateTransition = 11'bX;
    endcase
    136: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd136;
      2: stateTransition = 11'd136;
      3: stateTransition = 11'd136;
      4: stateTransition = 11'd136;
      5: stateTransition = 11'd136;
      6: stateTransition = 11'd136;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd136;
      9: stateTransition = 11'd136;
      default: stateTransition = 11'bX;
    endcase
    137: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd137;
      2: stateTransition = 11'd137;
      3: stateTransition = 11'd137;
      4: stateTransition = 11'd137;
      5: stateTransition = 11'd137;
      6: stateTransition = 11'd137;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd137;
      9: stateTransition = 11'd137;
      default: stateTransition = 11'bX;
    endcase
    138: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd138;
      2: stateTransition = 11'd138;
      3: stateTransition = 11'd138;
      4: stateTransition = 11'd138;
      5: stateTransition = 11'd138;
      6: stateTransition = 11'd138;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd138;
      9: stateTransition = 11'd138;
      default: stateTransition = 11'bX;
    endcase
    139: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd139;
      2: stateTransition = 11'd139;
      3: stateTransition = 11'd139;
      4: stateTransition = 11'd139;
      5: stateTransition = 11'd139;
      6: stateTransition = 11'd139;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd139;
      9: stateTransition = 11'd139;
      default: stateTransition = 11'bX;
    endcase
    140: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd140;
      2: stateTransition = 11'd140;
      3: stateTransition = 11'd140;
      4: stateTransition = 11'd140;
      5: stateTransition = 11'd140;
      6: stateTransition = 11'd140;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd140;
      9: stateTransition = 11'd140;
      default: stateTransition = 11'bX;
    endcase
    141: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd141;
      3: stateTransition = 11'd141;
      4: stateTransition = 11'd141;
      5: stateTransition = 11'd141;
      6: stateTransition = 11'd141;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd141;
      9: stateTransition = 11'd141;
      default: stateTransition = 11'bX;
    endcase
    142: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd142;
      2: stateTransition = 11'd142;
      3: stateTransition = 11'd142;
      4: stateTransition = 11'd142;
      5: stateTransition = 11'd142;
      6: stateTransition = 11'd142;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd142;
      9: stateTransition = 11'd142;
      default: stateTransition = 11'bX;
    endcase
    143: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd143;
      3: stateTransition = 11'd143;
      4: stateTransition = 11'd143;
      5: stateTransition = 11'd143;
      6: stateTransition = 11'd143;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd143;
      9: stateTransition = 11'd143;
      default: stateTransition = 11'bX;
    endcase
    144: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd144;
      2: stateTransition = 11'd144;
      3: stateTransition = 11'd144;
      4: stateTransition = 11'd144;
      5: stateTransition = 11'd144;
      6: stateTransition = 11'd144;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd144;
      9: stateTransition = 11'd144;
      default: stateTransition = 11'bX;
    endcase
    145: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd145;
      2: stateTransition = 11'd145;
      3: stateTransition = 11'd145;
      4: stateTransition = 11'd145;
      5: stateTransition = 11'd145;
      6: stateTransition = 11'd145;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd145;
      9: stateTransition = 11'd145;
      default: stateTransition = 11'bX;
    endcase
    146: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd146;
      2: stateTransition = 11'd146;
      3: stateTransition = 11'd146;
      4: stateTransition = 11'd146;
      5: stateTransition = 11'd146;
      6: stateTransition = 11'd146;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd146;
      9: stateTransition = 11'd146;
      default: stateTransition = 11'bX;
    endcase
    147: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd147;
      2: stateTransition = 11'd147;
      3: stateTransition = 11'd147;
      4: stateTransition = 11'd147;
      5: stateTransition = 11'd147;
      6: stateTransition = 11'd147;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd147;
      9: stateTransition = 11'd147;
      default: stateTransition = 11'bX;
    endcase
    148: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd148;
      2: stateTransition = 11'd148;
      3: stateTransition = 11'd148;
      4: stateTransition = 11'd148;
      5: stateTransition = 11'd148;
      6: stateTransition = 11'd148;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd148;
      9: stateTransition = 11'd148;
      default: stateTransition = 11'bX;
    endcase
    149: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd149;
      2: stateTransition = 11'd149;
      3: stateTransition = 11'd149;
      4: stateTransition = 11'd149;
      5: stateTransition = 11'd149;
      6: stateTransition = 11'd149;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd149;
      9: stateTransition = 11'd149;
      default: stateTransition = 11'bX;
    endcase
    150: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd150;
      2: stateTransition = 11'd150;
      3: stateTransition = 11'd150;
      4: stateTransition = 11'd150;
      5: stateTransition = 11'd150;
      6: stateTransition = 11'd150;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd150;
      9: stateTransition = 11'd150;
      default: stateTransition = 11'bX;
    endcase
    151: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd151;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd151;
      4: stateTransition = 11'd151;
      5: stateTransition = 11'd151;
      6: stateTransition = 11'd151;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd151;
      9: stateTransition = 11'd151;
      default: stateTransition = 11'bX;
    endcase
    152: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd152;
      3: stateTransition = 11'd152;
      4: stateTransition = 11'd152;
      5: stateTransition = 11'd152;
      6: stateTransition = 11'd152;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd152;
      9: stateTransition = 11'd152;
      default: stateTransition = 11'bX;
    endcase
    153: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd153;
      2: stateTransition = 11'd153;
      3: stateTransition = 11'd153;
      4: stateTransition = 11'd153;
      5: stateTransition = 11'd153;
      6: stateTransition = 11'd153;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd153;
      9: stateTransition = 11'd153;
      default: stateTransition = 11'bX;
    endcase
    154: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd154;
      2: stateTransition = 11'd154;
      3: stateTransition = 11'd154;
      4: stateTransition = 11'd154;
      5: stateTransition = 11'd154;
      6: stateTransition = 11'd154;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd154;
      9: stateTransition = 11'd154;
      default: stateTransition = 11'bX;
    endcase
    155: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd155;
      2: stateTransition = 11'd155;
      3: stateTransition = 11'd155;
      4: stateTransition = 11'd155;
      5: stateTransition = 11'd155;
      6: stateTransition = 11'd155;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd155;
      9: stateTransition = 11'd155;
      default: stateTransition = 11'bX;
    endcase
    156: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd156;
      2: stateTransition = 11'd156;
      3: stateTransition = 11'd156;
      4: stateTransition = 11'd156;
      5: stateTransition = 11'd156;
      6: stateTransition = 11'd156;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd156;
      9: stateTransition = 11'd156;
      default: stateTransition = 11'bX;
    endcase
    157: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd157;
      2: stateTransition = 11'd157;
      3: stateTransition = 11'd157;
      4: stateTransition = 11'd157;
      5: stateTransition = 11'd157;
      6: stateTransition = 11'd157;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd157;
      9: stateTransition = 11'd157;
      default: stateTransition = 11'bX;
    endcase
    158: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd158;
      2: stateTransition = 11'd158;
      3: stateTransition = 11'd158;
      4: stateTransition = 11'd158;
      5: stateTransition = 11'd158;
      6: stateTransition = 11'd158;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd158;
      9: stateTransition = 11'd158;
      default: stateTransition = 11'bX;
    endcase
    159: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd159;
      2: stateTransition = 11'd159;
      3: stateTransition = 11'd159;
      4: stateTransition = 11'd159;
      5: stateTransition = 11'd159;
      6: stateTransition = 11'd159;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd159;
      9: stateTransition = 11'd159;
      default: stateTransition = 11'bX;
    endcase
    160: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd160;
      2: stateTransition = 11'd160;
      3: stateTransition = 11'd160;
      4: stateTransition = 11'd160;
      5: stateTransition = 11'd160;
      6: stateTransition = 11'd160;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd160;
      9: stateTransition = 11'd160;
      default: stateTransition = 11'bX;
    endcase
    161: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd161;
      2: stateTransition = 11'd161;
      3: stateTransition = 11'd161;
      4: stateTransition = 11'd161;
      5: stateTransition = 11'd161;
      6: stateTransition = 11'd161;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd161;
      9: stateTransition = 11'd161;
      default: stateTransition = 11'bX;
    endcase
    162: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd162;
      2: stateTransition = 11'd162;
      3: stateTransition = 11'd162;
      4: stateTransition = 11'd162;
      5: stateTransition = 11'd162;
      6: stateTransition = 11'd162;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd162;
      9: stateTransition = 11'd162;
      default: stateTransition = 11'bX;
    endcase
    163: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd163;
      2: stateTransition = 11'd163;
      3: stateTransition = 11'd163;
      4: stateTransition = 11'd163;
      5: stateTransition = 11'd163;
      6: stateTransition = 11'd163;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd163;
      9: stateTransition = 11'd163;
      default: stateTransition = 11'bX;
    endcase
    164: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd164;
      2: stateTransition = 11'd164;
      3: stateTransition = 11'd164;
      4: stateTransition = 11'd164;
      5: stateTransition = 11'd164;
      6: stateTransition = 11'd164;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd164;
      9: stateTransition = 11'd164;
      default: stateTransition = 11'bX;
    endcase
    165: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd165;
      2: stateTransition = 11'd165;
      3: stateTransition = 11'd165;
      4: stateTransition = 11'd165;
      5: stateTransition = 11'd165;
      6: stateTransition = 11'd165;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd165;
      9: stateTransition = 11'd165;
      default: stateTransition = 11'bX;
    endcase
    166: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd166;
      2: stateTransition = 11'd166;
      3: stateTransition = 11'd166;
      4: stateTransition = 11'd166;
      5: stateTransition = 11'd166;
      6: stateTransition = 11'd166;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd166;
      9: stateTransition = 11'd166;
      default: stateTransition = 11'bX;
    endcase
    167: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd167;
      2: stateTransition = 11'd167;
      3: stateTransition = 11'd167;
      4: stateTransition = 11'd167;
      5: stateTransition = 11'd167;
      6: stateTransition = 11'd167;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd167;
      9: stateTransition = 11'd167;
      default: stateTransition = 11'bX;
    endcase
    168: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd168;
      2: stateTransition = 11'd168;
      3: stateTransition = 11'd168;
      4: stateTransition = 11'd168;
      5: stateTransition = 11'd168;
      6: stateTransition = 11'd168;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd168;
      9: stateTransition = 11'd168;
      default: stateTransition = 11'bX;
    endcase
    169: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd169;
      2: stateTransition = 11'd169;
      3: stateTransition = 11'd169;
      4: stateTransition = 11'd169;
      5: stateTransition = 11'd169;
      6: stateTransition = 11'd169;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd169;
      9: stateTransition = 11'd169;
      default: stateTransition = 11'bX;
    endcase
    170: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd170;
      2: stateTransition = 11'd170;
      3: stateTransition = 11'd170;
      4: stateTransition = 11'd170;
      5: stateTransition = 11'd170;
      6: stateTransition = 11'd170;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd170;
      9: stateTransition = 11'd170;
      default: stateTransition = 11'bX;
    endcase
    171: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd171;
      2: stateTransition = 11'd171;
      3: stateTransition = 11'd171;
      4: stateTransition = 11'd171;
      5: stateTransition = 11'd171;
      6: stateTransition = 11'd171;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd171;
      9: stateTransition = 11'd171;
      default: stateTransition = 11'bX;
    endcase
    172: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd172;
      2: stateTransition = 11'd172;
      3: stateTransition = 11'd172;
      4: stateTransition = 11'd172;
      5: stateTransition = 11'd172;
      6: stateTransition = 11'd172;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd172;
      9: stateTransition = 11'd172;
      default: stateTransition = 11'bX;
    endcase
    173: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd173;
      2: stateTransition = 11'd173;
      3: stateTransition = 11'd173;
      4: stateTransition = 11'd173;
      5: stateTransition = 11'd173;
      6: stateTransition = 11'd173;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd173;
      9: stateTransition = 11'd173;
      default: stateTransition = 11'bX;
    endcase
    174: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd174;
      2: stateTransition = 11'd174;
      3: stateTransition = 11'd174;
      4: stateTransition = 11'd174;
      5: stateTransition = 11'd174;
      6: stateTransition = 11'd174;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd174;
      9: stateTransition = 11'd174;
      default: stateTransition = 11'bX;
    endcase
    175: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd175;
      2: stateTransition = 11'd175;
      3: stateTransition = 11'd175;
      4: stateTransition = 11'd175;
      5: stateTransition = 11'd175;
      6: stateTransition = 11'd175;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd175;
      9: stateTransition = 11'd175;
      default: stateTransition = 11'bX;
    endcase
    176: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd176;
      2: stateTransition = 11'd176;
      3: stateTransition = 11'd176;
      4: stateTransition = 11'd176;
      5: stateTransition = 11'd176;
      6: stateTransition = 11'd176;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd176;
      9: stateTransition = 11'd176;
      default: stateTransition = 11'bX;
    endcase
    177: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd177;
      2: stateTransition = 11'd177;
      3: stateTransition = 11'd177;
      4: stateTransition = 11'd177;
      5: stateTransition = 11'd177;
      6: stateTransition = 11'd177;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd177;
      9: stateTransition = 11'd177;
      default: stateTransition = 11'bX;
    endcase
    178: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd178;
      2: stateTransition = 11'd178;
      3: stateTransition = 11'd178;
      4: stateTransition = 11'd178;
      5: stateTransition = 11'd178;
      6: stateTransition = 11'd178;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd178;
      9: stateTransition = 11'd178;
      default: stateTransition = 11'bX;
    endcase
    179: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd179;
      2: stateTransition = 11'd179;
      3: stateTransition = 11'd179;
      4: stateTransition = 11'd179;
      5: stateTransition = 11'd179;
      6: stateTransition = 11'd179;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd179;
      9: stateTransition = 11'd179;
      default: stateTransition = 11'bX;
    endcase
    180: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd180;
      2: stateTransition = 11'd180;
      3: stateTransition = 11'd180;
      4: stateTransition = 11'd180;
      5: stateTransition = 11'd180;
      6: stateTransition = 11'd180;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd180;
      9: stateTransition = 11'd180;
      default: stateTransition = 11'bX;
    endcase
    181: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd181;
      2: stateTransition = 11'd181;
      3: stateTransition = 11'd181;
      4: stateTransition = 11'd181;
      5: stateTransition = 11'd181;
      6: stateTransition = 11'd181;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd181;
      9: stateTransition = 11'd181;
      default: stateTransition = 11'bX;
    endcase
    182: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd182;
      2: stateTransition = 11'd182;
      3: stateTransition = 11'd182;
      4: stateTransition = 11'd182;
      5: stateTransition = 11'd182;
      6: stateTransition = 11'd182;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd182;
      9: stateTransition = 11'd182;
      default: stateTransition = 11'bX;
    endcase
    183: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd183;
      2: stateTransition = 11'd183;
      3: stateTransition = 11'd183;
      4: stateTransition = 11'd183;
      5: stateTransition = 11'd183;
      6: stateTransition = 11'd183;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd183;
      9: stateTransition = 11'd183;
      default: stateTransition = 11'bX;
    endcase
    184: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd184;
      2: stateTransition = 11'd184;
      3: stateTransition = 11'd184;
      4: stateTransition = 11'd184;
      5: stateTransition = 11'd184;
      6: stateTransition = 11'd184;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd184;
      9: stateTransition = 11'd184;
      default: stateTransition = 11'bX;
    endcase
    185: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd185;
      2: stateTransition = 11'd185;
      3: stateTransition = 11'd185;
      4: stateTransition = 11'd185;
      5: stateTransition = 11'd185;
      6: stateTransition = 11'd185;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd185;
      9: stateTransition = 11'd185;
      default: stateTransition = 11'bX;
    endcase
    186: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd186;
      2: stateTransition = 11'd186;
      3: stateTransition = 11'd186;
      4: stateTransition = 11'd186;
      5: stateTransition = 11'd186;
      6: stateTransition = 11'd186;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd186;
      9: stateTransition = 11'd186;
      default: stateTransition = 11'bX;
    endcase
    187: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd187;
      2: stateTransition = 11'd187;
      3: stateTransition = 11'd187;
      4: stateTransition = 11'd187;
      5: stateTransition = 11'd187;
      6: stateTransition = 11'd187;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd187;
      9: stateTransition = 11'd187;
      default: stateTransition = 11'bX;
    endcase
    188: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd188;
      2: stateTransition = 11'd188;
      3: stateTransition = 11'd188;
      4: stateTransition = 11'd188;
      5: stateTransition = 11'd188;
      6: stateTransition = 11'd188;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd188;
      9: stateTransition = 11'd188;
      default: stateTransition = 11'bX;
    endcase
    189: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd189;
      2: stateTransition = 11'd189;
      3: stateTransition = 11'd189;
      4: stateTransition = 11'd189;
      5: stateTransition = 11'd189;
      6: stateTransition = 11'd189;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd189;
      9: stateTransition = 11'd189;
      default: stateTransition = 11'bX;
    endcase
    190: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd190;
      2: stateTransition = 11'd190;
      3: stateTransition = 11'd190;
      4: stateTransition = 11'd190;
      5: stateTransition = 11'd190;
      6: stateTransition = 11'd190;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd190;
      9: stateTransition = 11'd190;
      default: stateTransition = 11'bX;
    endcase
    191: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd191;
      2: stateTransition = 11'd191;
      3: stateTransition = 11'd191;
      4: stateTransition = 11'd191;
      5: stateTransition = 11'd191;
      6: stateTransition = 11'd191;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd191;
      9: stateTransition = 11'd191;
      default: stateTransition = 11'bX;
    endcase
    192: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd192;
      2: stateTransition = 11'd192;
      3: stateTransition = 11'd192;
      4: stateTransition = 11'd192;
      5: stateTransition = 11'd192;
      6: stateTransition = 11'd192;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd192;
      9: stateTransition = 11'd192;
      default: stateTransition = 11'bX;
    endcase
    193: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd193;
      2: stateTransition = 11'd193;
      3: stateTransition = 11'd193;
      4: stateTransition = 11'd193;
      5: stateTransition = 11'd193;
      6: stateTransition = 11'd193;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd193;
      9: stateTransition = 11'd193;
      default: stateTransition = 11'bX;
    endcase
    194: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd194;
      2: stateTransition = 11'd194;
      3: stateTransition = 11'd194;
      4: stateTransition = 11'd194;
      5: stateTransition = 11'd194;
      6: stateTransition = 11'd194;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd194;
      9: stateTransition = 11'd194;
      default: stateTransition = 11'bX;
    endcase
    195: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd195;
      2: stateTransition = 11'd195;
      3: stateTransition = 11'd195;
      4: stateTransition = 11'd195;
      5: stateTransition = 11'd195;
      6: stateTransition = 11'd195;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd195;
      9: stateTransition = 11'd195;
      default: stateTransition = 11'bX;
    endcase
    196: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd196;
      2: stateTransition = 11'd196;
      3: stateTransition = 11'd196;
      4: stateTransition = 11'd196;
      5: stateTransition = 11'd196;
      6: stateTransition = 11'd196;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd196;
      9: stateTransition = 11'd196;
      default: stateTransition = 11'bX;
    endcase
    197: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd197;
      2: stateTransition = 11'd197;
      3: stateTransition = 11'd197;
      4: stateTransition = 11'd197;
      5: stateTransition = 11'd197;
      6: stateTransition = 11'd197;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd197;
      9: stateTransition = 11'd197;
      default: stateTransition = 11'bX;
    endcase
    198: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd198;
      2: stateTransition = 11'd198;
      3: stateTransition = 11'd198;
      4: stateTransition = 11'd198;
      5: stateTransition = 11'd198;
      6: stateTransition = 11'd198;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd198;
      9: stateTransition = 11'd198;
      default: stateTransition = 11'bX;
    endcase
    199: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd199;
      2: stateTransition = 11'd199;
      3: stateTransition = 11'd199;
      4: stateTransition = 11'd199;
      5: stateTransition = 11'd199;
      6: stateTransition = 11'd199;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd199;
      9: stateTransition = 11'd199;
      default: stateTransition = 11'bX;
    endcase
    200: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd200;
      2: stateTransition = 11'd200;
      3: stateTransition = 11'd200;
      4: stateTransition = 11'd200;
      5: stateTransition = 11'd200;
      6: stateTransition = 11'd200;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd200;
      9: stateTransition = 11'd200;
      default: stateTransition = 11'bX;
    endcase
    201: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd201;
      2: stateTransition = 11'd201;
      3: stateTransition = 11'd201;
      4: stateTransition = 11'd201;
      5: stateTransition = 11'd201;
      6: stateTransition = 11'd201;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd201;
      9: stateTransition = 11'd201;
      default: stateTransition = 11'bX;
    endcase
    202: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd202;
      2: stateTransition = 11'd202;
      3: stateTransition = 11'd202;
      4: stateTransition = 11'd202;
      5: stateTransition = 11'd202;
      6: stateTransition = 11'd202;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd202;
      9: stateTransition = 11'd202;
      default: stateTransition = 11'bX;
    endcase
    203: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd203;
      2: stateTransition = 11'd203;
      3: stateTransition = 11'd203;
      4: stateTransition = 11'd203;
      5: stateTransition = 11'd203;
      6: stateTransition = 11'd203;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd203;
      9: stateTransition = 11'd203;
      default: stateTransition = 11'bX;
    endcase
    204: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd204;
      2: stateTransition = 11'd204;
      3: stateTransition = 11'd204;
      4: stateTransition = 11'd204;
      5: stateTransition = 11'd204;
      6: stateTransition = 11'd204;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd204;
      9: stateTransition = 11'd204;
      default: stateTransition = 11'bX;
    endcase
    205: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd205;
      2: stateTransition = 11'd205;
      3: stateTransition = 11'd205;
      4: stateTransition = 11'd205;
      5: stateTransition = 11'd205;
      6: stateTransition = 11'd205;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd205;
      9: stateTransition = 11'd205;
      default: stateTransition = 11'bX;
    endcase
    206: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd206;
      2: stateTransition = 11'd206;
      3: stateTransition = 11'd206;
      4: stateTransition = 11'd206;
      5: stateTransition = 11'd206;
      6: stateTransition = 11'd206;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd206;
      9: stateTransition = 11'd206;
      default: stateTransition = 11'bX;
    endcase
    207: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd207;
      2: stateTransition = 11'd207;
      3: stateTransition = 11'd207;
      4: stateTransition = 11'd207;
      5: stateTransition = 11'd207;
      6: stateTransition = 11'd207;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd207;
      9: stateTransition = 11'd207;
      default: stateTransition = 11'bX;
    endcase
    208: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd208;
      2: stateTransition = 11'd208;
      3: stateTransition = 11'd208;
      4: stateTransition = 11'd208;
      5: stateTransition = 11'd208;
      6: stateTransition = 11'd208;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd208;
      9: stateTransition = 11'd208;
      default: stateTransition = 11'bX;
    endcase
    209: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd209;
      2: stateTransition = 11'd209;
      3: stateTransition = 11'd209;
      4: stateTransition = 11'd209;
      5: stateTransition = 11'd209;
      6: stateTransition = 11'd209;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd209;
      9: stateTransition = 11'd209;
      default: stateTransition = 11'bX;
    endcase
    210: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd210;
      2: stateTransition = 11'd210;
      3: stateTransition = 11'd210;
      4: stateTransition = 11'd210;
      5: stateTransition = 11'd210;
      6: stateTransition = 11'd210;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd210;
      9: stateTransition = 11'd210;
      default: stateTransition = 11'bX;
    endcase
    211: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd211;
      2: stateTransition = 11'd211;
      3: stateTransition = 11'd211;
      4: stateTransition = 11'd211;
      5: stateTransition = 11'd211;
      6: stateTransition = 11'd211;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd211;
      9: stateTransition = 11'd211;
      default: stateTransition = 11'bX;
    endcase
    212: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd212;
      2: stateTransition = 11'd212;
      3: stateTransition = 11'd212;
      4: stateTransition = 11'd212;
      5: stateTransition = 11'd212;
      6: stateTransition = 11'd212;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd212;
      9: stateTransition = 11'd212;
      default: stateTransition = 11'bX;
    endcase
    213: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd213;
      2: stateTransition = 11'd213;
      3: stateTransition = 11'd213;
      4: stateTransition = 11'd213;
      5: stateTransition = 11'd213;
      6: stateTransition = 11'd213;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd213;
      9: stateTransition = 11'd213;
      default: stateTransition = 11'bX;
    endcase
    214: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd214;
      2: stateTransition = 11'd214;
      3: stateTransition = 11'd214;
      4: stateTransition = 11'd214;
      5: stateTransition = 11'd214;
      6: stateTransition = 11'd214;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd214;
      9: stateTransition = 11'd214;
      default: stateTransition = 11'bX;
    endcase
    215: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd215;
      2: stateTransition = 11'd215;
      3: stateTransition = 11'd215;
      4: stateTransition = 11'd215;
      5: stateTransition = 11'd215;
      6: stateTransition = 11'd215;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd215;
      9: stateTransition = 11'd215;
      default: stateTransition = 11'bX;
    endcase
    216: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd216;
      2: stateTransition = 11'd216;
      3: stateTransition = 11'd216;
      4: stateTransition = 11'd216;
      5: stateTransition = 11'd216;
      6: stateTransition = 11'd216;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd216;
      9: stateTransition = 11'd216;
      default: stateTransition = 11'bX;
    endcase
    217: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd217;
      2: stateTransition = 11'd217;
      3: stateTransition = 11'd217;
      4: stateTransition = 11'd217;
      5: stateTransition = 11'd217;
      6: stateTransition = 11'd217;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd217;
      9: stateTransition = 11'd217;
      default: stateTransition = 11'bX;
    endcase
    218: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd218;
      2: stateTransition = 11'd218;
      3: stateTransition = 11'd218;
      4: stateTransition = 11'd218;
      5: stateTransition = 11'd218;
      6: stateTransition = 11'd218;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd218;
      9: stateTransition = 11'd218;
      default: stateTransition = 11'bX;
    endcase
    219: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd219;
      2: stateTransition = 11'd219;
      3: stateTransition = 11'd219;
      4: stateTransition = 11'd219;
      5: stateTransition = 11'd219;
      6: stateTransition = 11'd219;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd219;
      9: stateTransition = 11'd219;
      default: stateTransition = 11'bX;
    endcase
    220: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd220;
      2: stateTransition = 11'd220;
      3: stateTransition = 11'd220;
      4: stateTransition = 11'd220;
      5: stateTransition = 11'd220;
      6: stateTransition = 11'd220;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd220;
      9: stateTransition = 11'd220;
      default: stateTransition = 11'bX;
    endcase
    221: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd221;
      2: stateTransition = 11'd221;
      3: stateTransition = 11'd221;
      4: stateTransition = 11'd221;
      5: stateTransition = 11'd221;
      6: stateTransition = 11'd221;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd221;
      9: stateTransition = 11'd221;
      default: stateTransition = 11'bX;
    endcase
    222: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd222;
      2: stateTransition = 11'd222;
      3: stateTransition = 11'd222;
      4: stateTransition = 11'd222;
      5: stateTransition = 11'd222;
      6: stateTransition = 11'd222;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd222;
      9: stateTransition = 11'd222;
      default: stateTransition = 11'bX;
    endcase
    223: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd223;
      2: stateTransition = 11'd223;
      3: stateTransition = 11'd223;
      4: stateTransition = 11'd223;
      5: stateTransition = 11'd223;
      6: stateTransition = 11'd223;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd223;
      9: stateTransition = 11'd223;
      default: stateTransition = 11'bX;
    endcase
    224: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd224;
      2: stateTransition = 11'd224;
      3: stateTransition = 11'd224;
      4: stateTransition = 11'd224;
      5: stateTransition = 11'd224;
      6: stateTransition = 11'd224;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd224;
      9: stateTransition = 11'd224;
      default: stateTransition = 11'bX;
    endcase
    225: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd225;
      2: stateTransition = 11'd225;
      3: stateTransition = 11'd225;
      4: stateTransition = 11'd225;
      5: stateTransition = 11'd225;
      6: stateTransition = 11'd225;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd225;
      9: stateTransition = 11'd225;
      default: stateTransition = 11'bX;
    endcase
    226: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd226;
      2: stateTransition = 11'd226;
      3: stateTransition = 11'd226;
      4: stateTransition = 11'd226;
      5: stateTransition = 11'd226;
      6: stateTransition = 11'd226;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd226;
      9: stateTransition = 11'd226;
      default: stateTransition = 11'bX;
    endcase
    227: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd227;
      2: stateTransition = 11'd227;
      3: stateTransition = 11'd227;
      4: stateTransition = 11'd227;
      5: stateTransition = 11'd227;
      6: stateTransition = 11'd227;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd227;
      9: stateTransition = 11'd227;
      default: stateTransition = 11'bX;
    endcase
    228: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd228;
      2: stateTransition = 11'd228;
      3: stateTransition = 11'd228;
      4: stateTransition = 11'd228;
      5: stateTransition = 11'd228;
      6: stateTransition = 11'd228;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd228;
      9: stateTransition = 11'd228;
      default: stateTransition = 11'bX;
    endcase
    229: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd229;
      3: stateTransition = 11'd229;
      4: stateTransition = 11'd229;
      5: stateTransition = 11'd229;
      6: stateTransition = 11'd229;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd229;
      9: stateTransition = 11'd229;
      default: stateTransition = 11'bX;
    endcase
    230: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd230;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd230;
      4: stateTransition = 11'd230;
      5: stateTransition = 11'd230;
      6: stateTransition = 11'd230;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd230;
      9: stateTransition = 11'd230;
      default: stateTransition = 11'bX;
    endcase
    231: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd231;
      2: stateTransition = 11'd231;
      3: stateTransition = 11'd231;
      4: stateTransition = 11'd231;
      5: stateTransition = 11'd231;
      6: stateTransition = 11'd231;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd231;
      9: stateTransition = 11'd231;
      default: stateTransition = 11'bX;
    endcase
    232: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd232;
      2: stateTransition = 11'd232;
      3: stateTransition = 11'd232;
      4: stateTransition = 11'd232;
      5: stateTransition = 11'd232;
      6: stateTransition = 11'd232;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd232;
      9: stateTransition = 11'd232;
      default: stateTransition = 11'bX;
    endcase
    233: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd233;
      2: stateTransition = 11'd233;
      3: stateTransition = 11'd233;
      4: stateTransition = 11'd233;
      5: stateTransition = 11'd233;
      6: stateTransition = 11'd233;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd233;
      9: stateTransition = 11'd233;
      default: stateTransition = 11'bX;
    endcase
    234: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd234;
      2: stateTransition = 11'd234;
      3: stateTransition = 11'd234;
      4: stateTransition = 11'd234;
      5: stateTransition = 11'd234;
      6: stateTransition = 11'd234;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd234;
      9: stateTransition = 11'd234;
      default: stateTransition = 11'bX;
    endcase
    235: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd235;
      2: stateTransition = 11'd235;
      3: stateTransition = 11'd235;
      4: stateTransition = 11'd235;
      5: stateTransition = 11'd235;
      6: stateTransition = 11'd235;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd235;
      9: stateTransition = 11'd235;
      default: stateTransition = 11'bX;
    endcase
    236: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd236;
      2: stateTransition = 11'd236;
      3: stateTransition = 11'd236;
      4: stateTransition = 11'd236;
      5: stateTransition = 11'd236;
      6: stateTransition = 11'd236;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd236;
      9: stateTransition = 11'd236;
      default: stateTransition = 11'bX;
    endcase
    237: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd237;
      2: stateTransition = 11'd237;
      3: stateTransition = 11'd237;
      4: stateTransition = 11'd237;
      5: stateTransition = 11'd237;
      6: stateTransition = 11'd237;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd237;
      9: stateTransition = 11'd237;
      default: stateTransition = 11'bX;
    endcase
    238: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd238;
      2: stateTransition = 11'd238;
      3: stateTransition = 11'd238;
      4: stateTransition = 11'd238;
      5: stateTransition = 11'd238;
      6: stateTransition = 11'd238;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd238;
      9: stateTransition = 11'd238;
      default: stateTransition = 11'bX;
    endcase
    239: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd239;
      2: stateTransition = 11'd239;
      3: stateTransition = 11'd239;
      4: stateTransition = 11'd239;
      5: stateTransition = 11'd239;
      6: stateTransition = 11'd239;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd239;
      9: stateTransition = 11'd239;
      default: stateTransition = 11'bX;
    endcase
    240: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd240;
      2: stateTransition = 11'd240;
      3: stateTransition = 11'd240;
      4: stateTransition = 11'd240;
      5: stateTransition = 11'd240;
      6: stateTransition = 11'd240;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd240;
      9: stateTransition = 11'd240;
      default: stateTransition = 11'bX;
    endcase
    241: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd241;
      2: stateTransition = 11'd241;
      3: stateTransition = 11'd241;
      4: stateTransition = 11'd241;
      5: stateTransition = 11'd241;
      6: stateTransition = 11'd241;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd241;
      9: stateTransition = 11'd241;
      default: stateTransition = 11'bX;
    endcase
    242: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd242;
      2: stateTransition = 11'd242;
      3: stateTransition = 11'd242;
      4: stateTransition = 11'd242;
      5: stateTransition = 11'd242;
      6: stateTransition = 11'd242;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd242;
      9: stateTransition = 11'd242;
      default: stateTransition = 11'bX;
    endcase
    243: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd243;
      2: stateTransition = 11'd243;
      3: stateTransition = 11'd243;
      4: stateTransition = 11'd243;
      5: stateTransition = 11'd243;
      6: stateTransition = 11'd243;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd243;
      9: stateTransition = 11'd243;
      default: stateTransition = 11'bX;
    endcase
    244: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd244;
      2: stateTransition = 11'd244;
      3: stateTransition = 11'd244;
      4: stateTransition = 11'd244;
      5: stateTransition = 11'd244;
      6: stateTransition = 11'd244;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd244;
      9: stateTransition = 11'd244;
      default: stateTransition = 11'bX;
    endcase
    245: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd245;
      2: stateTransition = 11'd245;
      3: stateTransition = 11'd245;
      4: stateTransition = 11'd245;
      5: stateTransition = 11'd245;
      6: stateTransition = 11'd245;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd245;
      9: stateTransition = 11'd245;
      default: stateTransition = 11'bX;
    endcase
    246: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd246;
      2: stateTransition = 11'd246;
      3: stateTransition = 11'd246;
      4: stateTransition = 11'd246;
      5: stateTransition = 11'd246;
      6: stateTransition = 11'd246;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd246;
      9: stateTransition = 11'd246;
      default: stateTransition = 11'bX;
    endcase
    247: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd247;
      2: stateTransition = 11'd247;
      3: stateTransition = 11'd247;
      4: stateTransition = 11'd247;
      5: stateTransition = 11'd247;
      6: stateTransition = 11'd247;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd247;
      9: stateTransition = 11'd247;
      default: stateTransition = 11'bX;
    endcase
    248: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd248;
      2: stateTransition = 11'd248;
      3: stateTransition = 11'd248;
      4: stateTransition = 11'd248;
      5: stateTransition = 11'd248;
      6: stateTransition = 11'd248;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd248;
      9: stateTransition = 11'd248;
      default: stateTransition = 11'bX;
    endcase
    249: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd249;
      2: stateTransition = 11'd249;
      3: stateTransition = 11'd249;
      4: stateTransition = 11'd249;
      5: stateTransition = 11'd249;
      6: stateTransition = 11'd249;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd249;
      9: stateTransition = 11'd249;
      default: stateTransition = 11'bX;
    endcase
    250: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd250;
      2: stateTransition = 11'd250;
      3: stateTransition = 11'd250;
      4: stateTransition = 11'd250;
      5: stateTransition = 11'd250;
      6: stateTransition = 11'd250;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd250;
      9: stateTransition = 11'd250;
      default: stateTransition = 11'bX;
    endcase
    251: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd251;
      2: stateTransition = 11'd251;
      3: stateTransition = 11'd251;
      4: stateTransition = 11'd251;
      5: stateTransition = 11'd251;
      6: stateTransition = 11'd251;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd251;
      9: stateTransition = 11'd251;
      default: stateTransition = 11'bX;
    endcase
    252: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd252;
      2: stateTransition = 11'd252;
      3: stateTransition = 11'd252;
      4: stateTransition = 11'd252;
      5: stateTransition = 11'd252;
      6: stateTransition = 11'd252;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd252;
      9: stateTransition = 11'd252;
      default: stateTransition = 11'bX;
    endcase
    253: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd253;
      2: stateTransition = 11'd253;
      3: stateTransition = 11'd253;
      4: stateTransition = 11'd253;
      5: stateTransition = 11'd253;
      6: stateTransition = 11'd253;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd253;
      9: stateTransition = 11'd253;
      default: stateTransition = 11'bX;
    endcase
    254: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd254;
      2: stateTransition = 11'd254;
      3: stateTransition = 11'd254;
      4: stateTransition = 11'd254;
      5: stateTransition = 11'd254;
      6: stateTransition = 11'd254;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd254;
      9: stateTransition = 11'd254;
      default: stateTransition = 11'bX;
    endcase
    255: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd255;
      2: stateTransition = 11'd255;
      3: stateTransition = 11'd255;
      4: stateTransition = 11'd255;
      5: stateTransition = 11'd255;
      6: stateTransition = 11'd255;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd255;
      9: stateTransition = 11'd255;
      default: stateTransition = 11'bX;
    endcase
    256: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd256;
      2: stateTransition = 11'd256;
      3: stateTransition = 11'd256;
      4: stateTransition = 11'd256;
      5: stateTransition = 11'd256;
      6: stateTransition = 11'd256;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd256;
      9: stateTransition = 11'd256;
      default: stateTransition = 11'bX;
    endcase
    257: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd257;
      2: stateTransition = 11'd257;
      3: stateTransition = 11'd257;
      4: stateTransition = 11'd257;
      5: stateTransition = 11'd257;
      6: stateTransition = 11'd257;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd257;
      9: stateTransition = 11'd257;
      default: stateTransition = 11'bX;
    endcase
    258: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd258;
      2: stateTransition = 11'd258;
      3: stateTransition = 11'd258;
      4: stateTransition = 11'd258;
      5: stateTransition = 11'd258;
      6: stateTransition = 11'd258;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd258;
      9: stateTransition = 11'd258;
      default: stateTransition = 11'bX;
    endcase
    259: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd259;
      2: stateTransition = 11'd259;
      3: stateTransition = 11'd259;
      4: stateTransition = 11'd259;
      5: stateTransition = 11'd259;
      6: stateTransition = 11'd259;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd259;
      9: stateTransition = 11'd259;
      default: stateTransition = 11'bX;
    endcase
    260: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd260;
      2: stateTransition = 11'd260;
      3: stateTransition = 11'd260;
      4: stateTransition = 11'd260;
      5: stateTransition = 11'd260;
      6: stateTransition = 11'd260;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd260;
      9: stateTransition = 11'd260;
      default: stateTransition = 11'bX;
    endcase
    261: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd261;
      2: stateTransition = 11'd261;
      3: stateTransition = 11'd261;
      4: stateTransition = 11'd261;
      5: stateTransition = 11'd261;
      6: stateTransition = 11'd261;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd261;
      9: stateTransition = 11'd261;
      default: stateTransition = 11'bX;
    endcase
    262: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd262;
      2: stateTransition = 11'd262;
      3: stateTransition = 11'd262;
      4: stateTransition = 11'd262;
      5: stateTransition = 11'd262;
      6: stateTransition = 11'd262;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd262;
      9: stateTransition = 11'd262;
      default: stateTransition = 11'bX;
    endcase
    263: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd263;
      2: stateTransition = 11'd263;
      3: stateTransition = 11'd263;
      4: stateTransition = 11'd263;
      5: stateTransition = 11'd263;
      6: stateTransition = 11'd263;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd263;
      9: stateTransition = 11'd263;
      default: stateTransition = 11'bX;
    endcase
    264: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd264;
      2: stateTransition = 11'd264;
      3: stateTransition = 11'd264;
      4: stateTransition = 11'd264;
      5: stateTransition = 11'd264;
      6: stateTransition = 11'd264;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd264;
      9: stateTransition = 11'd264;
      default: stateTransition = 11'bX;
    endcase
    265: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd265;
      2: stateTransition = 11'd265;
      3: stateTransition = 11'd265;
      4: stateTransition = 11'd265;
      5: stateTransition = 11'd265;
      6: stateTransition = 11'd265;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd265;
      9: stateTransition = 11'd265;
      default: stateTransition = 11'bX;
    endcase
    266: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd266;
      2: stateTransition = 11'd266;
      3: stateTransition = 11'd266;
      4: stateTransition = 11'd266;
      5: stateTransition = 11'd266;
      6: stateTransition = 11'd266;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd266;
      9: stateTransition = 11'd266;
      default: stateTransition = 11'bX;
    endcase
    267: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd267;
      2: stateTransition = 11'd267;
      3: stateTransition = 11'd267;
      4: stateTransition = 11'd267;
      5: stateTransition = 11'd267;
      6: stateTransition = 11'd267;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd267;
      9: stateTransition = 11'd267;
      default: stateTransition = 11'bX;
    endcase
    268: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd268;
      2: stateTransition = 11'd268;
      3: stateTransition = 11'd268;
      4: stateTransition = 11'd268;
      5: stateTransition = 11'd268;
      6: stateTransition = 11'd268;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd268;
      9: stateTransition = 11'd268;
      default: stateTransition = 11'bX;
    endcase
    269: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd269;
      2: stateTransition = 11'd269;
      3: stateTransition = 11'd269;
      4: stateTransition = 11'd269;
      5: stateTransition = 11'd269;
      6: stateTransition = 11'd269;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd269;
      9: stateTransition = 11'd269;
      default: stateTransition = 11'bX;
    endcase
    270: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd270;
      2: stateTransition = 11'd270;
      3: stateTransition = 11'd270;
      4: stateTransition = 11'd270;
      5: stateTransition = 11'd270;
      6: stateTransition = 11'd270;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd270;
      9: stateTransition = 11'd270;
      default: stateTransition = 11'bX;
    endcase
    271: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd271;
      2: stateTransition = 11'd271;
      3: stateTransition = 11'd271;
      4: stateTransition = 11'd271;
      5: stateTransition = 11'd271;
      6: stateTransition = 11'd271;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd271;
      9: stateTransition = 11'd271;
      default: stateTransition = 11'bX;
    endcase
    272: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd272;
      2: stateTransition = 11'd272;
      3: stateTransition = 11'd272;
      4: stateTransition = 11'd272;
      5: stateTransition = 11'd272;
      6: stateTransition = 11'd272;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd272;
      9: stateTransition = 11'd272;
      default: stateTransition = 11'bX;
    endcase
    273: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd273;
      2: stateTransition = 11'd273;
      3: stateTransition = 11'd273;
      4: stateTransition = 11'd273;
      5: stateTransition = 11'd273;
      6: stateTransition = 11'd273;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd273;
      9: stateTransition = 11'd273;
      default: stateTransition = 11'bX;
    endcase
    274: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd274;
      2: stateTransition = 11'd274;
      3: stateTransition = 11'd274;
      4: stateTransition = 11'd274;
      5: stateTransition = 11'd274;
      6: stateTransition = 11'd274;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd274;
      9: stateTransition = 11'd274;
      default: stateTransition = 11'bX;
    endcase
    275: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd275;
      2: stateTransition = 11'd275;
      3: stateTransition = 11'd275;
      4: stateTransition = 11'd275;
      5: stateTransition = 11'd275;
      6: stateTransition = 11'd275;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd275;
      9: stateTransition = 11'd275;
      default: stateTransition = 11'bX;
    endcase
    276: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd276;
      2: stateTransition = 11'd276;
      3: stateTransition = 11'd276;
      4: stateTransition = 11'd276;
      5: stateTransition = 11'd276;
      6: stateTransition = 11'd276;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd276;
      9: stateTransition = 11'd276;
      default: stateTransition = 11'bX;
    endcase
    277: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd277;
      2: stateTransition = 11'd277;
      3: stateTransition = 11'd277;
      4: stateTransition = 11'd277;
      5: stateTransition = 11'd277;
      6: stateTransition = 11'd277;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd277;
      9: stateTransition = 11'd277;
      default: stateTransition = 11'bX;
    endcase
    278: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd278;
      2: stateTransition = 11'd278;
      3: stateTransition = 11'd278;
      4: stateTransition = 11'd278;
      5: stateTransition = 11'd278;
      6: stateTransition = 11'd278;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd278;
      9: stateTransition = 11'd278;
      default: stateTransition = 11'bX;
    endcase
    279: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd279;
      2: stateTransition = 11'd279;
      3: stateTransition = 11'd279;
      4: stateTransition = 11'd279;
      5: stateTransition = 11'd279;
      6: stateTransition = 11'd279;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd279;
      9: stateTransition = 11'd279;
      default: stateTransition = 11'bX;
    endcase
    280: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd280;
      2: stateTransition = 11'd280;
      3: stateTransition = 11'd280;
      4: stateTransition = 11'd280;
      5: stateTransition = 11'd280;
      6: stateTransition = 11'd280;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd280;
      9: stateTransition = 11'd280;
      default: stateTransition = 11'bX;
    endcase
    281: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd281;
      2: stateTransition = 11'd281;
      3: stateTransition = 11'd281;
      4: stateTransition = 11'd281;
      5: stateTransition = 11'd281;
      6: stateTransition = 11'd281;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd281;
      9: stateTransition = 11'd281;
      default: stateTransition = 11'bX;
    endcase
    282: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd282;
      2: stateTransition = 11'd282;
      3: stateTransition = 11'd282;
      4: stateTransition = 11'd282;
      5: stateTransition = 11'd282;
      6: stateTransition = 11'd282;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd282;
      9: stateTransition = 11'd282;
      default: stateTransition = 11'bX;
    endcase
    283: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd283;
      3: stateTransition = 11'd283;
      4: stateTransition = 11'd283;
      5: stateTransition = 11'd283;
      6: stateTransition = 11'd283;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd283;
      9: stateTransition = 11'd283;
      default: stateTransition = 11'bX;
    endcase
    284: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd284;
      2: stateTransition = 11'd284;
      3: stateTransition = 11'd284;
      4: stateTransition = 11'd284;
      5: stateTransition = 11'd284;
      6: stateTransition = 11'd284;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd284;
      9: stateTransition = 11'd284;
      default: stateTransition = 11'bX;
    endcase
    285: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd285;
      2: stateTransition = 11'd285;
      3: stateTransition = 11'd285;
      4: stateTransition = 11'd285;
      5: stateTransition = 11'd285;
      6: stateTransition = 11'd285;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd285;
      9: stateTransition = 11'd285;
      default: stateTransition = 11'bX;
    endcase
    286: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd286;
      2: stateTransition = 11'd286;
      3: stateTransition = 11'd286;
      4: stateTransition = 11'd286;
      5: stateTransition = 11'd286;
      6: stateTransition = 11'd286;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd286;
      9: stateTransition = 11'd286;
      default: stateTransition = 11'bX;
    endcase
    287: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd287;
      2: stateTransition = 11'd287;
      3: stateTransition = 11'd287;
      4: stateTransition = 11'd287;
      5: stateTransition = 11'd287;
      6: stateTransition = 11'd287;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd287;
      9: stateTransition = 11'd287;
      default: stateTransition = 11'bX;
    endcase
    288: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd288;
      2: stateTransition = 11'd288;
      3: stateTransition = 11'd288;
      4: stateTransition = 11'd288;
      5: stateTransition = 11'd288;
      6: stateTransition = 11'd288;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd288;
      9: stateTransition = 11'd288;
      default: stateTransition = 11'bX;
    endcase
    289: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd289;
      2: stateTransition = 11'd289;
      3: stateTransition = 11'd289;
      4: stateTransition = 11'd289;
      5: stateTransition = 11'd289;
      6: stateTransition = 11'd289;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd289;
      9: stateTransition = 11'd289;
      default: stateTransition = 11'bX;
    endcase
    290: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd290;
      2: stateTransition = 11'd290;
      3: stateTransition = 11'd290;
      4: stateTransition = 11'd290;
      5: stateTransition = 11'd290;
      6: stateTransition = 11'd290;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd290;
      9: stateTransition = 11'd290;
      default: stateTransition = 11'bX;
    endcase
    291: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd291;
      2: stateTransition = 11'd291;
      3: stateTransition = 11'd291;
      4: stateTransition = 11'd291;
      5: stateTransition = 11'd291;
      6: stateTransition = 11'd291;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd291;
      9: stateTransition = 11'd291;
      default: stateTransition = 11'bX;
    endcase
    292: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd292;
      2: stateTransition = 11'd292;
      3: stateTransition = 11'd292;
      4: stateTransition = 11'd292;
      5: stateTransition = 11'd292;
      6: stateTransition = 11'd292;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd292;
      9: stateTransition = 11'd292;
      default: stateTransition = 11'bX;
    endcase
    293: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd293;
      2: stateTransition = 11'd293;
      3: stateTransition = 11'd293;
      4: stateTransition = 11'd293;
      5: stateTransition = 11'd293;
      6: stateTransition = 11'd293;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd293;
      9: stateTransition = 11'd293;
      default: stateTransition = 11'bX;
    endcase
    294: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd294;
      2: stateTransition = 11'd294;
      3: stateTransition = 11'd294;
      4: stateTransition = 11'd294;
      5: stateTransition = 11'd294;
      6: stateTransition = 11'd294;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd294;
      9: stateTransition = 11'd294;
      default: stateTransition = 11'bX;
    endcase
    295: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd295;
      2: stateTransition = 11'd295;
      3: stateTransition = 11'd295;
      4: stateTransition = 11'd295;
      5: stateTransition = 11'd295;
      6: stateTransition = 11'd295;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd295;
      9: stateTransition = 11'd295;
      default: stateTransition = 11'bX;
    endcase
    296: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd296;
      3: stateTransition = 11'd296;
      4: stateTransition = 11'd296;
      5: stateTransition = 11'd296;
      6: stateTransition = 11'd296;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd296;
      9: stateTransition = 11'd296;
      default: stateTransition = 11'bX;
    endcase
    297: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd297;
      2: stateTransition = 11'd297;
      3: stateTransition = 11'd297;
      4: stateTransition = 11'd297;
      5: stateTransition = 11'd297;
      6: stateTransition = 11'd297;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd297;
      9: stateTransition = 11'd297;
      default: stateTransition = 11'bX;
    endcase
    298: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd298;
      2: stateTransition = 11'd298;
      3: stateTransition = 11'd298;
      4: stateTransition = 11'd298;
      5: stateTransition = 11'd298;
      6: stateTransition = 11'd298;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd298;
      9: stateTransition = 11'd298;
      default: stateTransition = 11'bX;
    endcase
    299: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd299;
      2: stateTransition = 11'd299;
      3: stateTransition = 11'd299;
      4: stateTransition = 11'd299;
      5: stateTransition = 11'd299;
      6: stateTransition = 11'd299;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd299;
      9: stateTransition = 11'd299;
      default: stateTransition = 11'bX;
    endcase
    300: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd300;
      2: stateTransition = 11'd300;
      3: stateTransition = 11'd300;
      4: stateTransition = 11'd300;
      5: stateTransition = 11'd300;
      6: stateTransition = 11'd300;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd300;
      9: stateTransition = 11'd300;
      default: stateTransition = 11'bX;
    endcase
    301: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd301;
      2: stateTransition = 11'd301;
      3: stateTransition = 11'd301;
      4: stateTransition = 11'd301;
      5: stateTransition = 11'd301;
      6: stateTransition = 11'd301;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd301;
      9: stateTransition = 11'd301;
      default: stateTransition = 11'bX;
    endcase
    302: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd302;
      2: stateTransition = 11'd302;
      3: stateTransition = 11'd302;
      4: stateTransition = 11'd302;
      5: stateTransition = 11'd302;
      6: stateTransition = 11'd302;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd302;
      9: stateTransition = 11'd302;
      default: stateTransition = 11'bX;
    endcase
    303: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd303;
      2: stateTransition = 11'd303;
      3: stateTransition = 11'd303;
      4: stateTransition = 11'd303;
      5: stateTransition = 11'd303;
      6: stateTransition = 11'd303;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd303;
      9: stateTransition = 11'd303;
      default: stateTransition = 11'bX;
    endcase
    304: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd304;
      2: stateTransition = 11'd304;
      3: stateTransition = 11'd304;
      4: stateTransition = 11'd304;
      5: stateTransition = 11'd304;
      6: stateTransition = 11'd304;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd304;
      9: stateTransition = 11'd304;
      default: stateTransition = 11'bX;
    endcase
    305: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd305;
      2: stateTransition = 11'd305;
      3: stateTransition = 11'd305;
      4: stateTransition = 11'd305;
      5: stateTransition = 11'd305;
      6: stateTransition = 11'd305;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd305;
      9: stateTransition = 11'd305;
      default: stateTransition = 11'bX;
    endcase
    306: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd306;
      3: stateTransition = 11'd306;
      4: stateTransition = 11'd306;
      5: stateTransition = 11'd306;
      6: stateTransition = 11'd306;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd306;
      9: stateTransition = 11'd306;
      default: stateTransition = 11'bX;
    endcase
    307: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd307;
      2: stateTransition = 11'd307;
      3: stateTransition = 11'd307;
      4: stateTransition = 11'd307;
      5: stateTransition = 11'd307;
      6: stateTransition = 11'd307;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd307;
      9: stateTransition = 11'd307;
      default: stateTransition = 11'bX;
    endcase
    308: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd308;
      2: stateTransition = 11'd308;
      3: stateTransition = 11'd308;
      4: stateTransition = 11'd308;
      5: stateTransition = 11'd308;
      6: stateTransition = 11'd308;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd308;
      9: stateTransition = 11'd308;
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
