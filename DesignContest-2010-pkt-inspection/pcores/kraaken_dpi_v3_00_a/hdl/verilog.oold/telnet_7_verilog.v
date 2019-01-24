`timescale 1ns/1ps

`define ENABLED_REGEX_telnet_7 TRUE

module telnet_7_verilog(clk,
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


`ifdef ENABLED_REGEX_telnet_7

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd0;
    1: charMap = 8'd2;
    2: charMap = 8'd1;
    3: charMap = 8'd2;
    4: charMap = 8'd0;
    5: charMap = 8'd0;
    6: charMap = 8'd0;
    7: charMap = 8'd0;
    8: charMap = 8'd0;
    9: charMap = 8'd0;
    10: charMap = 8'd0;
    11: charMap = 8'd0;
    12: charMap = 8'd0;
    13: charMap = 8'd0;
    14: charMap = 8'd0;
    15: charMap = 8'd0;
    16: charMap = 8'd0;
    17: charMap = 8'd0;
    18: charMap = 8'd0;
    19: charMap = 8'd0;
    20: charMap = 8'd0;
    21: charMap = 8'd0;
    22: charMap = 8'd0;
    23: charMap = 8'd0;
    24: charMap = 8'd0;
    25: charMap = 8'd0;
    26: charMap = 8'd0;
    27: charMap = 8'd0;
    28: charMap = 8'd0;
    29: charMap = 8'd0;
    30: charMap = 8'd0;
    31: charMap = 8'd0;
    32: charMap = 8'd0;
    33: charMap = 8'd0;
    34: charMap = 8'd0;
    35: charMap = 8'd0;
    36: charMap = 8'd0;
    37: charMap = 8'd0;
    38: charMap = 8'd0;
    39: charMap = 8'd0;
    40: charMap = 8'd0;
    41: charMap = 8'd0;
    42: charMap = 8'd0;
    43: charMap = 8'd0;
    44: charMap = 8'd0;
    45: charMap = 8'd0;
    46: charMap = 8'd0;
    47: charMap = 8'd0;
    48: charMap = 8'd0;
    49: charMap = 8'd0;
    50: charMap = 8'd0;
    51: charMap = 8'd0;
    52: charMap = 8'd0;
    53: charMap = 8'd0;
    54: charMap = 8'd0;
    55: charMap = 8'd0;
    56: charMap = 8'd0;
    57: charMap = 8'd0;
    58: charMap = 8'd0;
    59: charMap = 8'd0;
    60: charMap = 8'd0;
    61: charMap = 8'd0;
    62: charMap = 8'd0;
    63: charMap = 8'd0;
    64: charMap = 8'd0;
    65: charMap = 8'd0;
    66: charMap = 8'd0;
    67: charMap = 8'd0;
    68: charMap = 8'd0;
    69: charMap = 8'd0;
    70: charMap = 8'd0;
    71: charMap = 8'd0;
    72: charMap = 8'd0;
    73: charMap = 8'd0;
    74: charMap = 8'd0;
    75: charMap = 8'd0;
    76: charMap = 8'd0;
    77: charMap = 8'd0;
    78: charMap = 8'd0;
    79: charMap = 8'd0;
    80: charMap = 8'd0;
    81: charMap = 8'd0;
    82: charMap = 8'd0;
    83: charMap = 8'd0;
    84: charMap = 8'd0;
    85: charMap = 8'd0;
    86: charMap = 8'd0;
    87: charMap = 8'd0;
    88: charMap = 8'd0;
    89: charMap = 8'd0;
    90: charMap = 8'd0;
    91: charMap = 8'd0;
    92: charMap = 8'd0;
    93: charMap = 8'd0;
    94: charMap = 8'd0;
    95: charMap = 8'd0;
    96: charMap = 8'd0;
    97: charMap = 8'd0;
    98: charMap = 8'd0;
    99: charMap = 8'd0;
    100: charMap = 8'd0;
    101: charMap = 8'd0;
    102: charMap = 8'd0;
    103: charMap = 8'd0;
    104: charMap = 8'd0;
    105: charMap = 8'd0;
    106: charMap = 8'd0;
    107: charMap = 8'd0;
    108: charMap = 8'd0;
    109: charMap = 8'd0;
    110: charMap = 8'd0;
    111: charMap = 8'd0;
    112: charMap = 8'd0;
    113: charMap = 8'd0;
    114: charMap = 8'd0;
    115: charMap = 8'd0;
    116: charMap = 8'd0;
    117: charMap = 8'd0;
    118: charMap = 8'd0;
    119: charMap = 8'd0;
    120: charMap = 8'd0;
    121: charMap = 8'd0;
    122: charMap = 8'd0;
    123: charMap = 8'd0;
    124: charMap = 8'd0;
    125: charMap = 8'd0;
    126: charMap = 8'd0;
    127: charMap = 8'd0;
    128: charMap = 8'd0;
    129: charMap = 8'd0;
    130: charMap = 8'd0;
    131: charMap = 8'd0;
    132: charMap = 8'd0;
    133: charMap = 8'd0;
    134: charMap = 8'd0;
    135: charMap = 8'd0;
    136: charMap = 8'd0;
    137: charMap = 8'd0;
    138: charMap = 8'd0;
    139: charMap = 8'd0;
    140: charMap = 8'd0;
    141: charMap = 8'd0;
    142: charMap = 8'd0;
    143: charMap = 8'd0;
    144: charMap = 8'd0;
    145: charMap = 8'd0;
    146: charMap = 8'd0;
    147: charMap = 8'd0;
    148: charMap = 8'd0;
    149: charMap = 8'd0;
    150: charMap = 8'd0;
    151: charMap = 8'd0;
    152: charMap = 8'd0;
    153: charMap = 8'd0;
    154: charMap = 8'd0;
    155: charMap = 8'd0;
    156: charMap = 8'd0;
    157: charMap = 8'd0;
    158: charMap = 8'd0;
    159: charMap = 8'd0;
    160: charMap = 8'd0;
    161: charMap = 8'd0;
    162: charMap = 8'd0;
    163: charMap = 8'd0;
    164: charMap = 8'd0;
    165: charMap = 8'd0;
    166: charMap = 8'd0;
    167: charMap = 8'd0;
    168: charMap = 8'd0;
    169: charMap = 8'd0;
    170: charMap = 8'd0;
    171: charMap = 8'd0;
    172: charMap = 8'd0;
    173: charMap = 8'd0;
    174: charMap = 8'd0;
    175: charMap = 8'd0;
    176: charMap = 8'd0;
    177: charMap = 8'd0;
    178: charMap = 8'd0;
    179: charMap = 8'd0;
    180: charMap = 8'd0;
    181: charMap = 8'd0;
    182: charMap = 8'd0;
    183: charMap = 8'd0;
    184: charMap = 8'd0;
    185: charMap = 8'd0;
    186: charMap = 8'd0;
    187: charMap = 8'd0;
    188: charMap = 8'd0;
    189: charMap = 8'd0;
    190: charMap = 8'd0;
    191: charMap = 8'd0;
    192: charMap = 8'd0;
    193: charMap = 8'd0;
    194: charMap = 8'd0;
    195: charMap = 8'd0;
    196: charMap = 8'd0;
    197: charMap = 8'd0;
    198: charMap = 8'd0;
    199: charMap = 8'd0;
    200: charMap = 8'd0;
    201: charMap = 8'd0;
    202: charMap = 8'd0;
    203: charMap = 8'd0;
    204: charMap = 8'd0;
    205: charMap = 8'd0;
    206: charMap = 8'd0;
    207: charMap = 8'd0;
    208: charMap = 8'd0;
    209: charMap = 8'd0;
    210: charMap = 8'd0;
    211: charMap = 8'd0;
    212: charMap = 8'd0;
    213: charMap = 8'd0;
    214: charMap = 8'd0;
    215: charMap = 8'd0;
    216: charMap = 8'd0;
    217: charMap = 8'd0;
    218: charMap = 8'd0;
    219: charMap = 8'd0;
    220: charMap = 8'd0;
    221: charMap = 8'd0;
    222: charMap = 8'd0;
    223: charMap = 8'd0;
    224: charMap = 8'd0;
    225: charMap = 8'd0;
    226: charMap = 8'd0;
    227: charMap = 8'd0;
    228: charMap = 8'd0;
    229: charMap = 8'd0;
    230: charMap = 8'd0;
    231: charMap = 8'd0;
    232: charMap = 8'd0;
    233: charMap = 8'd0;
    234: charMap = 8'd0;
    235: charMap = 8'd0;
    236: charMap = 8'd0;
    237: charMap = 8'd0;
    238: charMap = 8'd0;
    239: charMap = 8'd0;
    240: charMap = 8'd0;
    241: charMap = 8'd0;
    242: charMap = 8'd0;
    243: charMap = 8'd0;
    244: charMap = 8'd0;
    245: charMap = 8'd0;
    246: charMap = 8'd0;
    247: charMap = 8'd0;
    248: charMap = 8'd0;
    249: charMap = 8'd0;
    250: charMap = 8'd0;
    251: charMap = 8'd0;
    252: charMap = 8'd0;
    253: charMap = 8'd0;
    254: charMap = 8'd0;
    255: charMap = 8'd3;
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
    204: stateMap = 11'd6;
    205: stateMap = 11'd203;
    206: stateMap = 11'd8;
    207: stateMap = 11'd204;
    208: stateMap = 11'd10;
    209: stateMap = 11'd205;
    210: stateMap = 11'd12;
    211: stateMap = 11'd206;
    212: stateMap = 11'd14;
    213: stateMap = 11'd207;
    214: stateMap = 11'd16;
    215: stateMap = 11'd208;
    216: stateMap = 11'd18;
    217: stateMap = 11'd209;
    218: stateMap = 11'd20;
    219: stateMap = 11'd210;
    220: stateMap = 11'd22;
    221: stateMap = 11'd211;
    222: stateMap = 11'd24;
    223: stateMap = 11'd212;
    224: stateMap = 11'd26;
    225: stateMap = 11'd213;
    226: stateMap = 11'd28;
    227: stateMap = 11'd214;
    228: stateMap = 11'd30;
    229: stateMap = 11'd215;
    230: stateMap = 11'd32;
    231: stateMap = 11'd216;
    232: stateMap = 11'd34;
    233: stateMap = 11'd217;
    234: stateMap = 11'd36;
    235: stateMap = 11'd218;
    236: stateMap = 11'd38;
    237: stateMap = 11'd219;
    238: stateMap = 11'd40;
    239: stateMap = 11'd220;
    240: stateMap = 11'd42;
    241: stateMap = 11'd221;
    242: stateMap = 11'd44;
    243: stateMap = 11'd222;
    244: stateMap = 11'd46;
    245: stateMap = 11'd223;
    246: stateMap = 11'd48;
    247: stateMap = 11'd224;
    248: stateMap = 11'd50;
    249: stateMap = 11'd225;
    250: stateMap = 11'd52;
    251: stateMap = 11'd226;
    252: stateMap = 11'd54;
    253: stateMap = 11'd227;
    254: stateMap = 11'd56;
    255: stateMap = 11'd228;
    256: stateMap = 11'd58;
    257: stateMap = 11'd229;
    258: stateMap = 11'd60;
    259: stateMap = 11'd230;
    260: stateMap = 11'd62;
    261: stateMap = 11'd231;
    262: stateMap = 11'd64;
    263: stateMap = 11'd232;
    264: stateMap = 11'd66;
    265: stateMap = 11'd233;
    266: stateMap = 11'd68;
    267: stateMap = 11'd234;
    268: stateMap = 11'd70;
    269: stateMap = 11'd235;
    270: stateMap = 11'd72;
    271: stateMap = 11'd236;
    272: stateMap = 11'd74;
    273: stateMap = 11'd237;
    274: stateMap = 11'd76;
    275: stateMap = 11'd238;
    276: stateMap = 11'd78;
    277: stateMap = 11'd239;
    278: stateMap = 11'd80;
    279: stateMap = 11'd240;
    280: stateMap = 11'd82;
    281: stateMap = 11'd241;
    282: stateMap = 11'd84;
    283: stateMap = 11'd242;
    284: stateMap = 11'd86;
    285: stateMap = 11'd243;
    286: stateMap = 11'd88;
    287: stateMap = 11'd244;
    288: stateMap = 11'd90;
    289: stateMap = 11'd245;
    290: stateMap = 11'd92;
    291: stateMap = 11'd246;
    292: stateMap = 11'd94;
    293: stateMap = 11'd247;
    294: stateMap = 11'd96;
    295: stateMap = 11'd248;
    296: stateMap = 11'd98;
    297: stateMap = 11'd249;
    298: stateMap = 11'd100;
    299: stateMap = 11'd250;
    300: stateMap = 11'd102;
    301: stateMap = 11'd251;
    302: stateMap = 11'd104;
    303: stateMap = 11'd252;
    304: stateMap = 11'd106;
    305: stateMap = 11'd253;
    306: stateMap = 11'd108;
    307: stateMap = 11'd254;
    308: stateMap = 11'd110;
    309: stateMap = 11'd255;
    310: stateMap = 11'd112;
    311: stateMap = 11'd256;
    312: stateMap = 11'd114;
    313: stateMap = 11'd257;
    314: stateMap = 11'd116;
    315: stateMap = 11'd258;
    316: stateMap = 11'd118;
    317: stateMap = 11'd259;
    318: stateMap = 11'd120;
    319: stateMap = 11'd260;
    320: stateMap = 11'd122;
    321: stateMap = 11'd261;
    322: stateMap = 11'd124;
    323: stateMap = 11'd262;
    324: stateMap = 11'd126;
    325: stateMap = 11'd263;
    326: stateMap = 11'd128;
    327: stateMap = 11'd264;
    328: stateMap = 11'd130;
    329: stateMap = 11'd265;
    330: stateMap = 11'd132;
    331: stateMap = 11'd266;
    332: stateMap = 11'd134;
    333: stateMap = 11'd267;
    334: stateMap = 11'd136;
    335: stateMap = 11'd268;
    336: stateMap = 11'd138;
    337: stateMap = 11'd269;
    338: stateMap = 11'd140;
    339: stateMap = 11'd270;
    340: stateMap = 11'd142;
    341: stateMap = 11'd271;
    342: stateMap = 11'd144;
    343: stateMap = 11'd272;
    344: stateMap = 11'd146;
    345: stateMap = 11'd273;
    346: stateMap = 11'd148;
    347: stateMap = 11'd274;
    348: stateMap = 11'd150;
    349: stateMap = 11'd275;
    350: stateMap = 11'd152;
    351: stateMap = 11'd276;
    352: stateMap = 11'd154;
    353: stateMap = 11'd277;
    354: stateMap = 11'd156;
    355: stateMap = 11'd278;
    356: stateMap = 11'd158;
    357: stateMap = 11'd279;
    358: stateMap = 11'd160;
    359: stateMap = 11'd280;
    360: stateMap = 11'd162;
    361: stateMap = 11'd281;
    362: stateMap = 11'd164;
    363: stateMap = 11'd282;
    364: stateMap = 11'd166;
    365: stateMap = 11'd283;
    366: stateMap = 11'd168;
    367: stateMap = 11'd284;
    368: stateMap = 11'd170;
    369: stateMap = 11'd285;
    370: stateMap = 11'd172;
    371: stateMap = 11'd286;
    372: stateMap = 11'd174;
    373: stateMap = 11'd287;
    374: stateMap = 11'd176;
    375: stateMap = 11'd288;
    376: stateMap = 11'd178;
    377: stateMap = 11'd289;
    378: stateMap = 11'd180;
    379: stateMap = 11'd290;
    380: stateMap = 11'd182;
    381: stateMap = 11'd291;
    382: stateMap = 11'd184;
    383: stateMap = 11'd292;
    384: stateMap = 11'd186;
    385: stateMap = 11'd293;
    386: stateMap = 11'd188;
    387: stateMap = 11'd294;
    388: stateMap = 11'd190;
    389: stateMap = 11'd295;
    390: stateMap = 11'd192;
    391: stateMap = 11'd296;
    392: stateMap = 11'd194;
    393: stateMap = 11'd297;
    394: stateMap = 11'd196;
    395: stateMap = 11'd298;
    396: stateMap = 11'd198;
    397: stateMap = 11'd299;
    398: stateMap = 11'd200;
    399: stateMap = 11'd300;
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
    310: acceptStates = 1'b0;
    311: acceptStates = 1'b0;
    312: acceptStates = 1'b0;
    313: acceptStates = 1'b0;
    314: acceptStates = 1'b0;
    315: acceptStates = 1'b0;
    316: acceptStates = 1'b0;
    317: acceptStates = 1'b0;
    318: acceptStates = 1'b0;
    319: acceptStates = 1'b0;
    320: acceptStates = 1'b0;
    321: acceptStates = 1'b0;
    322: acceptStates = 1'b0;
    323: acceptStates = 1'b0;
    324: acceptStates = 1'b0;
    325: acceptStates = 1'b0;
    326: acceptStates = 1'b0;
    327: acceptStates = 1'b0;
    328: acceptStates = 1'b0;
    329: acceptStates = 1'b0;
    330: acceptStates = 1'b0;
    331: acceptStates = 1'b0;
    332: acceptStates = 1'b0;
    333: acceptStates = 1'b0;
    334: acceptStates = 1'b0;
    335: acceptStates = 1'b0;
    336: acceptStates = 1'b0;
    337: acceptStates = 1'b0;
    338: acceptStates = 1'b0;
    339: acceptStates = 1'b0;
    340: acceptStates = 1'b0;
    341: acceptStates = 1'b0;
    342: acceptStates = 1'b0;
    343: acceptStates = 1'b0;
    344: acceptStates = 1'b0;
    345: acceptStates = 1'b0;
    346: acceptStates = 1'b0;
    347: acceptStates = 1'b0;
    348: acceptStates = 1'b0;
    349: acceptStates = 1'b0;
    350: acceptStates = 1'b0;
    351: acceptStates = 1'b0;
    352: acceptStates = 1'b0;
    353: acceptStates = 1'b0;
    354: acceptStates = 1'b0;
    355: acceptStates = 1'b0;
    356: acceptStates = 1'b0;
    357: acceptStates = 1'b0;
    358: acceptStates = 1'b0;
    359: acceptStates = 1'b0;
    360: acceptStates = 1'b0;
    361: acceptStates = 1'b0;
    362: acceptStates = 1'b0;
    363: acceptStates = 1'b0;
    364: acceptStates = 1'b0;
    365: acceptStates = 1'b0;
    366: acceptStates = 1'b0;
    367: acceptStates = 1'b0;
    368: acceptStates = 1'b0;
    369: acceptStates = 1'b0;
    370: acceptStates = 1'b0;
    371: acceptStates = 1'b0;
    372: acceptStates = 1'b0;
    373: acceptStates = 1'b0;
    374: acceptStates = 1'b0;
    375: acceptStates = 1'b0;
    376: acceptStates = 1'b0;
    377: acceptStates = 1'b0;
    378: acceptStates = 1'b0;
    379: acceptStates = 1'b0;
    380: acceptStates = 1'b0;
    381: acceptStates = 1'b0;
    382: acceptStates = 1'b0;
    383: acceptStates = 1'b0;
    384: acceptStates = 1'b0;
    385: acceptStates = 1'b0;
    386: acceptStates = 1'b0;
    387: acceptStates = 1'b0;
    388: acceptStates = 1'b0;
    389: acceptStates = 1'b0;
    390: acceptStates = 1'b0;
    391: acceptStates = 1'b0;
    392: acceptStates = 1'b0;
    393: acceptStates = 1'b0;
    394: acceptStates = 1'b0;
    395: acceptStates = 1'b0;
    396: acceptStates = 1'b0;
    397: acceptStates = 1'b0;
    398: acceptStates = 1'b0;
    399: acceptStates = 1'b0;
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
      1: stateTransition = 11'd4;
      2: stateTransition = 11'd4;
      3: stateTransition = 11'd5;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd6;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd4;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd7;
      2: stateTransition = 11'd7;
      3: stateTransition = 11'd205;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd8;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd9;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd207;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd209;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd12;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd13;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd211;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd14;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd15;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd213;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd16;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd17;
      3: stateTransition = 11'd215;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd19;
      3: stateTransition = 11'd217;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd20;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd21;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd219;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd22;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd23;
      3: stateTransition = 11'd221;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd25;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd223;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd26;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd27;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd225;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd29;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd227;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd30;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd31;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd229;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd33;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd231;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd35;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd233;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd36;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd37;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd235;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd38;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd39;
      2: stateTransition = 11'd39;
      3: stateTransition = 11'd237;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd40;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd41;
      2: stateTransition = 11'd41;
      3: stateTransition = 11'd239;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd42;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd43;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd241;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd44;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd45;
      2: stateTransition = 11'd45;
      3: stateTransition = 11'd243;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd46;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd47;
      2: stateTransition = 11'd47;
      3: stateTransition = 11'd245;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd48;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd49;
      2: stateTransition = 11'd49;
      3: stateTransition = 11'd247;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd50;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd51;
      2: stateTransition = 11'd51;
      3: stateTransition = 11'd249;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd52;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd53;
      2: stateTransition = 11'd53;
      3: stateTransition = 11'd251;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd55;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd253;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd56;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd57;
      2: stateTransition = 11'd57;
      3: stateTransition = 11'd255;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd58;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd59;
      2: stateTransition = 11'd59;
      3: stateTransition = 11'd257;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd60;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd61;
      2: stateTransition = 11'd61;
      3: stateTransition = 11'd259;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd62;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd63;
      2: stateTransition = 11'd63;
      3: stateTransition = 11'd261;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd64;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd65;
      2: stateTransition = 11'd65;
      3: stateTransition = 11'd263;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd66;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd67;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd265;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd68;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    67: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd69;
      2: stateTransition = 11'd69;
      3: stateTransition = 11'd267;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    68: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd70;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    69: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd71;
      2: stateTransition = 11'd71;
      3: stateTransition = 11'd269;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    70: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd72;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    71: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd73;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd271;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    72: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd74;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    73: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd75;
      2: stateTransition = 11'd75;
      3: stateTransition = 11'd273;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    74: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd76;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    75: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd77;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd275;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    76: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd78;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    77: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd79;
      2: stateTransition = 11'd79;
      3: stateTransition = 11'd277;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    78: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd80;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    79: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd81;
      2: stateTransition = 11'd81;
      3: stateTransition = 11'd279;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    80: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd82;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    81: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd83;
      2: stateTransition = 11'd83;
      3: stateTransition = 11'd281;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    82: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd84;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    83: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd85;
      2: stateTransition = 11'd85;
      3: stateTransition = 11'd283;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    84: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd86;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    85: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd87;
      2: stateTransition = 11'd87;
      3: stateTransition = 11'd285;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    86: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    87: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd89;
      2: stateTransition = 11'd89;
      3: stateTransition = 11'd287;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    88: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd90;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    89: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd91;
      2: stateTransition = 11'd91;
      3: stateTransition = 11'd289;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    90: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd92;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    91: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd93;
      2: stateTransition = 11'd93;
      3: stateTransition = 11'd291;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    92: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd94;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    93: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd95;
      2: stateTransition = 11'd95;
      3: stateTransition = 11'd293;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    94: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd96;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    95: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd97;
      3: stateTransition = 11'd295;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    96: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd98;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    97: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd99;
      2: stateTransition = 11'd99;
      3: stateTransition = 11'd297;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    98: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd100;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    99: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd101;
      2: stateTransition = 11'd101;
      3: stateTransition = 11'd299;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    100: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd102;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    101: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd103;
      2: stateTransition = 11'd103;
      3: stateTransition = 11'd301;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    102: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    103: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd105;
      2: stateTransition = 11'd105;
      3: stateTransition = 11'd303;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    104: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    105: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd107;
      2: stateTransition = 11'd107;
      3: stateTransition = 11'd305;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    106: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd108;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    107: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd109;
      2: stateTransition = 11'd109;
      3: stateTransition = 11'd307;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    108: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd110;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    109: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd111;
      2: stateTransition = 11'd111;
      3: stateTransition = 11'd309;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    110: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    111: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd113;
      2: stateTransition = 11'd113;
      3: stateTransition = 11'd311;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    112: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd114;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    113: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd115;
      3: stateTransition = 11'd313;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    114: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd116;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    115: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd117;
      2: stateTransition = 11'd117;
      3: stateTransition = 11'd315;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    116: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd118;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    117: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd119;
      2: stateTransition = 11'd119;
      3: stateTransition = 11'd317;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    118: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd120;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    119: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd121;
      3: stateTransition = 11'd319;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    120: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd122;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    121: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd123;
      3: stateTransition = 11'd321;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    122: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd124;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    123: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd125;
      2: stateTransition = 11'd125;
      3: stateTransition = 11'd323;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    124: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    125: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd127;
      2: stateTransition = 11'd127;
      3: stateTransition = 11'd325;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    126: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd128;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    127: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd129;
      2: stateTransition = 11'd129;
      3: stateTransition = 11'd327;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    128: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    129: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd131;
      2: stateTransition = 11'd131;
      3: stateTransition = 11'd329;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    130: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd132;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    131: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd133;
      2: stateTransition = 11'd133;
      3: stateTransition = 11'd331;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    132: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    133: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd135;
      2: stateTransition = 11'd135;
      3: stateTransition = 11'd333;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    134: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd136;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    135: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd137;
      2: stateTransition = 11'd137;
      3: stateTransition = 11'd335;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    136: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd138;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    137: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd139;
      2: stateTransition = 11'd139;
      3: stateTransition = 11'd337;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    138: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd140;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    139: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd141;
      3: stateTransition = 11'd339;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    140: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd142;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    141: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd143;
      3: stateTransition = 11'd341;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    142: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd144;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    143: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd145;
      2: stateTransition = 11'd145;
      3: stateTransition = 11'd343;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    144: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd146;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    145: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd147;
      2: stateTransition = 11'd147;
      3: stateTransition = 11'd345;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    146: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd148;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    147: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd149;
      2: stateTransition = 11'd149;
      3: stateTransition = 11'd347;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    148: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd150;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    149: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd151;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd349;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    150: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    151: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd153;
      2: stateTransition = 11'd153;
      3: stateTransition = 11'd351;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    152: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd154;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    153: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd155;
      2: stateTransition = 11'd155;
      3: stateTransition = 11'd353;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    154: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd156;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    155: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd157;
      2: stateTransition = 11'd157;
      3: stateTransition = 11'd355;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    156: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd158;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    157: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd159;
      2: stateTransition = 11'd159;
      3: stateTransition = 11'd357;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    158: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd160;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    159: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd161;
      2: stateTransition = 11'd161;
      3: stateTransition = 11'd359;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    160: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd162;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    161: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd163;
      2: stateTransition = 11'd163;
      3: stateTransition = 11'd361;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    162: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd164;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    163: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd165;
      2: stateTransition = 11'd165;
      3: stateTransition = 11'd363;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    164: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd166;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    165: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd167;
      2: stateTransition = 11'd167;
      3: stateTransition = 11'd365;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    166: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd168;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    167: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd169;
      2: stateTransition = 11'd169;
      3: stateTransition = 11'd367;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    168: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd170;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    169: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd171;
      2: stateTransition = 11'd171;
      3: stateTransition = 11'd369;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    170: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd172;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    171: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd173;
      2: stateTransition = 11'd173;
      3: stateTransition = 11'd371;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    172: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd174;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    173: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd175;
      2: stateTransition = 11'd175;
      3: stateTransition = 11'd373;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    174: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd176;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    175: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd177;
      2: stateTransition = 11'd177;
      3: stateTransition = 11'd375;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    176: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd178;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    177: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd179;
      2: stateTransition = 11'd179;
      3: stateTransition = 11'd377;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    178: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd180;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    179: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd181;
      2: stateTransition = 11'd181;
      3: stateTransition = 11'd379;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    180: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd182;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    181: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd183;
      2: stateTransition = 11'd183;
      3: stateTransition = 11'd381;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    182: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd184;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    183: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd185;
      2: stateTransition = 11'd185;
      3: stateTransition = 11'd383;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    184: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd186;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    185: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd187;
      2: stateTransition = 11'd187;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    186: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd188;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    187: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd189;
      2: stateTransition = 11'd189;
      3: stateTransition = 11'd387;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    188: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd190;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    189: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd191;
      2: stateTransition = 11'd191;
      3: stateTransition = 11'd389;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    190: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd192;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    191: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd193;
      2: stateTransition = 11'd193;
      3: stateTransition = 11'd391;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    192: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd194;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    193: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd195;
      2: stateTransition = 11'd195;
      3: stateTransition = 11'd393;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    194: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd196;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    195: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd197;
      2: stateTransition = 11'd197;
      3: stateTransition = 11'd395;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    196: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd198;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    197: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd199;
      2: stateTransition = 11'd199;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    198: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd200;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    199: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd201;
      2: stateTransition = 11'd201;
      3: stateTransition = 11'd399;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    200: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd202;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    201: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd2;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd203;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    202: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    203: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd204;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    204: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd206;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    205: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd208;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    206: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd210;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    207: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd212;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    208: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd214;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    209: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd216;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    210: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd218;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    211: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd220;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    212: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd222;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    213: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd224;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    214: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd226;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    215: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd228;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    216: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd230;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    217: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd232;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    218: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd234;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    219: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd236;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    220: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd238;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    221: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd240;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    222: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd242;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    223: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd244;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    224: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd246;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    225: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd248;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    226: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd250;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    227: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd252;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    228: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd254;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    229: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd256;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    230: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd258;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    231: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd260;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    232: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd262;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    233: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd264;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    234: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd266;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    235: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd268;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    236: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd270;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    237: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd272;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    238: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd274;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    239: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd276;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    240: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd278;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    241: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd280;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    242: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd282;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    243: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd284;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    244: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd286;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    245: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd288;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    246: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd290;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    247: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd292;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    248: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd294;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    249: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd296;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    250: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd298;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    251: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd300;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    252: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd302;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    253: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd304;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    254: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd306;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    255: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd308;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    256: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd310;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    257: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd312;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    258: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd314;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    259: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd316;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    260: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd318;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    261: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd320;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    262: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd322;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    263: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd324;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    264: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd326;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    265: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd328;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    266: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd330;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    267: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd332;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    268: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd334;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    269: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd336;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    270: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd338;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    271: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd340;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    272: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd342;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    273: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd344;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    274: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd346;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    275: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd348;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    276: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd350;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    277: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd352;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    278: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd354;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    279: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd356;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    280: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd358;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    281: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd360;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    282: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd362;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    283: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd364;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    284: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd366;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    285: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd368;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    286: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd370;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    287: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    288: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd374;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    289: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    290: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd378;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    291: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd380;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    292: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd382;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    293: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    294: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd386;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    295: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd388;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    296: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd390;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    297: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd392;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    298: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd394;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    299: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd396;
      4: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    300: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd398;
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
