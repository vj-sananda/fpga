`timescale 1ns/1ps

`define ENABLED_REGEX_CATEGORY_snmp TRUE

module CATEGORY_snmp_verilog(clk,
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


`ifdef ENABLED_REGEX_CATEGORY_snmp

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd4;
    1: charMap = 8'd2;
    2: charMap = 8'd1;
    3: charMap = 8'd6;
    4: charMap = 8'd3;
    5: charMap = 8'd4;
    6: charMap = 8'd9;
    7: charMap = 8'd4;
    8: charMap = 8'd4;
    9: charMap = 8'd4;
    10: charMap = 8'd0;
    11: charMap = 8'd4;
    12: charMap = 8'd4;
    13: charMap = 8'd0;
    14: charMap = 8'd4;
    15: charMap = 8'd4;
    16: charMap = 8'd4;
    17: charMap = 8'd4;
    18: charMap = 8'd4;
    19: charMap = 8'd4;
    20: charMap = 8'd4;
    21: charMap = 8'd4;
    22: charMap = 8'd4;
    23: charMap = 8'd4;
    24: charMap = 8'd4;
    25: charMap = 8'd4;
    26: charMap = 8'd4;
    27: charMap = 8'd4;
    28: charMap = 8'd4;
    29: charMap = 8'd4;
    30: charMap = 8'd4;
    31: charMap = 8'd4;
    32: charMap = 8'd4;
    33: charMap = 8'd4;
    34: charMap = 8'd4;
    35: charMap = 8'd4;
    36: charMap = 8'd4;
    37: charMap = 8'd4;
    38: charMap = 8'd4;
    39: charMap = 8'd4;
    40: charMap = 8'd4;
    41: charMap = 8'd4;
    42: charMap = 8'd4;
    43: charMap = 8'd4;
    44: charMap = 8'd4;
    45: charMap = 8'd4;
    46: charMap = 8'd4;
    47: charMap = 8'd4;
    48: charMap = 8'd7;
    49: charMap = 8'd4;
    50: charMap = 8'd4;
    51: charMap = 8'd4;
    52: charMap = 8'd4;
    53: charMap = 8'd4;
    54: charMap = 8'd4;
    55: charMap = 8'd4;
    56: charMap = 8'd4;
    57: charMap = 8'd4;
    58: charMap = 8'd4;
    59: charMap = 8'd4;
    60: charMap = 8'd4;
    61: charMap = 8'd4;
    62: charMap = 8'd4;
    63: charMap = 8'd4;
    64: charMap = 8'd10;
    65: charMap = 8'd4;
    66: charMap = 8'd4;
    67: charMap = 8'd11;
    68: charMap = 8'd4;
    69: charMap = 8'd4;
    70: charMap = 8'd4;
    71: charMap = 8'd4;
    72: charMap = 8'd4;
    73: charMap = 8'd4;
    74: charMap = 8'd4;
    75: charMap = 8'd4;
    76: charMap = 8'd4;
    77: charMap = 8'd4;
    78: charMap = 8'd4;
    79: charMap = 8'd4;
    80: charMap = 8'd4;
    81: charMap = 8'd4;
    82: charMap = 8'd4;
    83: charMap = 8'd4;
    84: charMap = 8'd4;
    85: charMap = 8'd4;
    86: charMap = 8'd4;
    87: charMap = 8'd4;
    88: charMap = 8'd4;
    89: charMap = 8'd4;
    90: charMap = 8'd4;
    91: charMap = 8'd4;
    92: charMap = 8'd4;
    93: charMap = 8'd4;
    94: charMap = 8'd4;
    95: charMap = 8'd4;
    96: charMap = 8'd4;
    97: charMap = 8'd4;
    98: charMap = 8'd4;
    99: charMap = 8'd4;
    100: charMap = 8'd4;
    101: charMap = 8'd4;
    102: charMap = 8'd4;
    103: charMap = 8'd4;
    104: charMap = 8'd4;
    105: charMap = 8'd4;
    106: charMap = 8'd4;
    107: charMap = 8'd4;
    108: charMap = 8'd4;
    109: charMap = 8'd4;
    110: charMap = 8'd4;
    111: charMap = 8'd4;
    112: charMap = 8'd4;
    113: charMap = 8'd4;
    114: charMap = 8'd4;
    115: charMap = 8'd4;
    116: charMap = 8'd4;
    117: charMap = 8'd4;
    118: charMap = 8'd4;
    119: charMap = 8'd4;
    120: charMap = 8'd4;
    121: charMap = 8'd4;
    122: charMap = 8'd4;
    123: charMap = 8'd4;
    124: charMap = 8'd4;
    125: charMap = 8'd4;
    126: charMap = 8'd4;
    127: charMap = 8'd4;
    128: charMap = 8'd4;
    129: charMap = 8'd4;
    130: charMap = 8'd4;
    131: charMap = 8'd4;
    132: charMap = 8'd4;
    133: charMap = 8'd4;
    134: charMap = 8'd4;
    135: charMap = 8'd4;
    136: charMap = 8'd4;
    137: charMap = 8'd4;
    138: charMap = 8'd4;
    139: charMap = 8'd4;
    140: charMap = 8'd4;
    141: charMap = 8'd4;
    142: charMap = 8'd4;
    143: charMap = 8'd4;
    144: charMap = 8'd4;
    145: charMap = 8'd4;
    146: charMap = 8'd4;
    147: charMap = 8'd4;
    148: charMap = 8'd4;
    149: charMap = 8'd4;
    150: charMap = 8'd4;
    151: charMap = 8'd4;
    152: charMap = 8'd4;
    153: charMap = 8'd4;
    154: charMap = 8'd4;
    155: charMap = 8'd4;
    156: charMap = 8'd4;
    157: charMap = 8'd4;
    158: charMap = 8'd4;
    159: charMap = 8'd4;
    160: charMap = 8'd5;
    161: charMap = 8'd5;
    162: charMap = 8'd5;
    163: charMap = 8'd5;
    164: charMap = 8'd8;
    165: charMap = 8'd4;
    166: charMap = 8'd4;
    167: charMap = 8'd4;
    168: charMap = 8'd4;
    169: charMap = 8'd4;
    170: charMap = 8'd4;
    171: charMap = 8'd4;
    172: charMap = 8'd4;
    173: charMap = 8'd4;
    174: charMap = 8'd4;
    175: charMap = 8'd4;
    176: charMap = 8'd4;
    177: charMap = 8'd4;
    178: charMap = 8'd4;
    179: charMap = 8'd4;
    180: charMap = 8'd4;
    181: charMap = 8'd4;
    182: charMap = 8'd4;
    183: charMap = 8'd4;
    184: charMap = 8'd4;
    185: charMap = 8'd4;
    186: charMap = 8'd4;
    187: charMap = 8'd4;
    188: charMap = 8'd4;
    189: charMap = 8'd4;
    190: charMap = 8'd4;
    191: charMap = 8'd4;
    192: charMap = 8'd4;
    193: charMap = 8'd4;
    194: charMap = 8'd4;
    195: charMap = 8'd4;
    196: charMap = 8'd4;
    197: charMap = 8'd4;
    198: charMap = 8'd4;
    199: charMap = 8'd4;
    200: charMap = 8'd4;
    201: charMap = 8'd4;
    202: charMap = 8'd4;
    203: charMap = 8'd4;
    204: charMap = 8'd4;
    205: charMap = 8'd4;
    206: charMap = 8'd4;
    207: charMap = 8'd4;
    208: charMap = 8'd4;
    209: charMap = 8'd4;
    210: charMap = 8'd4;
    211: charMap = 8'd4;
    212: charMap = 8'd4;
    213: charMap = 8'd4;
    214: charMap = 8'd4;
    215: charMap = 8'd4;
    216: charMap = 8'd4;
    217: charMap = 8'd4;
    218: charMap = 8'd4;
    219: charMap = 8'd4;
    220: charMap = 8'd4;
    221: charMap = 8'd4;
    222: charMap = 8'd4;
    223: charMap = 8'd4;
    224: charMap = 8'd4;
    225: charMap = 8'd4;
    226: charMap = 8'd4;
    227: charMap = 8'd4;
    228: charMap = 8'd4;
    229: charMap = 8'd4;
    230: charMap = 8'd4;
    231: charMap = 8'd4;
    232: charMap = 8'd4;
    233: charMap = 8'd4;
    234: charMap = 8'd4;
    235: charMap = 8'd4;
    236: charMap = 8'd4;
    237: charMap = 8'd4;
    238: charMap = 8'd4;
    239: charMap = 8'd4;
    240: charMap = 8'd4;
    241: charMap = 8'd4;
    242: charMap = 8'd4;
    243: charMap = 8'd4;
    244: charMap = 8'd4;
    245: charMap = 8'd4;
    246: charMap = 8'd4;
    247: charMap = 8'd4;
    248: charMap = 8'd4;
    249: charMap = 8'd4;
    250: charMap = 8'd4;
    251: charMap = 8'd4;
    252: charMap = 8'd4;
    253: charMap = 8'd4;
    254: charMap = 8'd4;
    255: charMap = 8'd4;
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
    13: stateMap = 11'd2;
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
    29: stateMap = 11'd8;
    30: stateMap = 11'd28;
    31: stateMap = 11'd29;
    32: stateMap = 11'd30;
    33: stateMap = 11'd31;
    34: stateMap = 11'd32;
    35: stateMap = 11'd33;
    36: stateMap = 11'd34;
    37: stateMap = 11'd35;
    38: stateMap = 11'd36;
    39: stateMap = 11'd37;
    40: stateMap = 11'd38;
    41: stateMap = 11'd39;
    42: stateMap = 11'd10;
    43: stateMap = 11'd40;
    44: stateMap = 11'd41;
    45: stateMap = 11'd42;
    46: stateMap = 11'd12;
    47: stateMap = 11'd43;
    48: stateMap = 11'd44;
    49: stateMap = 11'd45;
    50: stateMap = 11'd46;
    51: stateMap = 11'd47;
    52: stateMap = 11'd48;
    53: stateMap = 11'd49;
    54: stateMap = 11'd50;
    55: stateMap = 11'd51;
    56: stateMap = 11'd52;
    57: stateMap = 11'd53;
    58: stateMap = 11'd54;
    59: stateMap = 11'd13;
    60: stateMap = 11'd55;
    61: stateMap = 11'd56;
    62: stateMap = 11'd57;
    63: stateMap = 11'd58;
    64: stateMap = 11'd31;
    65: stateMap = 11'd59;
    66: stateMap = 11'd60;
    67: stateMap = 11'd61;
    68: stateMap = 11'd62;
    69: stateMap = 11'd63;
    70: stateMap = 11'd64;
    71: stateMap = 11'd65;
    72: stateMap = 11'd66;
    73: stateMap = 11'd67;
    74: stateMap = 11'd60;
    75: stateMap = 11'd68;
    76: stateMap = 11'd38;
    77: stateMap = 11'd69;
    78: stateMap = 11'd70;
    79: stateMap = 11'd62;
    80: stateMap = 11'd71;
    81: stateMap = 11'd72;
    82: stateMap = 11'd73;
    83: stateMap = 11'd74;
    84: stateMap = 11'd75;
    85: stateMap = 11'd76;
    86: stateMap = 11'd77;
    87: stateMap = 11'd78;
    88: stateMap = 11'd79;
    89: stateMap = 11'd80;
    90: stateMap = 11'd81;
    91: stateMap = 11'd82;
    92: stateMap = 11'd78;
    93: stateMap = 11'd83;
    94: stateMap = 11'd84;
    95: stateMap = 11'd85;
    96: stateMap = 11'd86;
    97: stateMap = 11'd87;
    98: stateMap = 11'd88;
    99: stateMap = 11'd89;
    100: stateMap = 11'd90;
    101: stateMap = 11'd91;
    102: stateMap = 11'd92;
    103: stateMap = 11'd93;
    104: stateMap = 11'd94;
    105: stateMap = 11'd95;
    106: stateMap = 11'd96;
    107: stateMap = 11'd97;
    108: stateMap = 11'd98;
    109: stateMap = 11'd99;
    110: stateMap = 11'd100;
    111: stateMap = 11'd101;
    112: stateMap = 11'd102;
    113: stateMap = 11'd103;
    114: stateMap = 11'd104;
    115: stateMap = 11'd105;
    116: stateMap = 11'd106;
    117: stateMap = 11'd107;
    118: stateMap = 11'd108;
    119: stateMap = 11'd109;
    120: stateMap = 11'd110;
    121: stateMap = 11'd111;
    122: stateMap = 11'd112;
    123: stateMap = 11'd113;
    124: stateMap = 11'd114;
    125: stateMap = 11'd115;
    126: stateMap = 11'd116;
    127: stateMap = 11'd117;
    128: stateMap = 11'd118;
    129: stateMap = 11'd119;
    130: stateMap = 11'd120;
    131: stateMap = 11'd121;
    132: stateMap = 11'd122;
    133: stateMap = 11'd123;
    134: stateMap = 11'd124;
    135: stateMap = 11'd125;
    136: stateMap = 11'd126;
    137: stateMap = 11'd127;
    138: stateMap = 11'd128;
    139: stateMap = 11'd129;
    140: stateMap = 11'd130;
    141: stateMap = 11'd131;
    142: stateMap = 11'd132;
    143: stateMap = 11'd133;
    144: stateMap = 11'd134;
    145: stateMap = 11'd135;
    146: stateMap = 11'd136;
    147: stateMap = 11'd137;
    148: stateMap = 11'd138;
    149: stateMap = 11'd139;
    150: stateMap = 11'd6;
    151: stateMap = 11'd140;
    152: stateMap = 11'd141;
    153: stateMap = 11'd137;
    154: stateMap = 11'd142;
    155: stateMap = 11'd143;
    156: stateMap = 11'd144;
    157: stateMap = 11'd145;
    158: stateMap = 11'd138;
    159: stateMap = 11'd146;
    160: stateMap = 11'd147;
    161: stateMap = 11'd148;
    162: stateMap = 11'd149;
    163: stateMap = 11'd150;
    164: stateMap = 11'd151;
    165: stateMap = 11'd152;
    166: stateMap = 11'd153;
    167: stateMap = 11'd154;
    168: stateMap = 11'd155;
    169: stateMap = 11'd156;
    170: stateMap = 11'd157;
    171: stateMap = 11'd158;
    172: stateMap = 11'd159;
    173: stateMap = 11'd160;
    174: stateMap = 11'd161;
    175: stateMap = 11'd162;
    176: stateMap = 11'd64;
    177: stateMap = 11'd163;
    178: stateMap = 11'd164;
    179: stateMap = 11'd165;
    180: stateMap = 11'd166;
    181: stateMap = 11'd167;
    182: stateMap = 11'd65;
    183: stateMap = 11'd168;
    184: stateMap = 11'd166;
    185: stateMap = 11'd169;
    186: stateMap = 11'd148;
    187: stateMap = 11'd149;
    188: stateMap = 11'd170;
    189: stateMap = 11'd171;
    190: stateMap = 11'd172;
    191: stateMap = 11'd173;
    192: stateMap = 11'd135;
    193: stateMap = 11'd165;
    194: stateMap = 11'd173;
    195: stateMap = 11'd174;
    196: stateMap = 11'd174;
    197: stateMap = 11'd175;
    198: stateMap = 11'd176;
    199: stateMap = 11'd177;
    200: stateMap = 11'd178;
    201: stateMap = 11'd179;
    202: stateMap = 11'd180;
    203: stateMap = 11'd181;
    204: stateMap = 11'd84;
    205: stateMap = 11'd182;
    206: stateMap = 11'd183;
    207: stateMap = 11'd163;
    208: stateMap = 11'd172;
    209: stateMap = 11'd177;
    210: stateMap = 11'd184;
    211: stateMap = 11'd185;
    212: stateMap = 11'd186;
    213: stateMap = 11'd187;
    214: stateMap = 11'd188;
    215: stateMap = 11'd189;
    216: stateMap = 11'd181;
    217: stateMap = 11'd190;
    218: stateMap = 11'd183;
    219: stateMap = 11'd191;
    220: stateMap = 11'd176;
    221: stateMap = 11'd192;
    222: stateMap = 11'd193;
    223: stateMap = 11'd182;
    224: stateMap = 11'd185;
    225: stateMap = 11'd194;
    226: stateMap = 11'd195;
    227: stateMap = 11'd196;
    228: stateMap = 11'd197;
    229: stateMap = 11'd198;
    230: stateMap = 11'd199;
    231: stateMap = 11'd200;
    232: stateMap = 11'd201;
    233: stateMap = 11'd202;
    234: stateMap = 11'd203;
    235: stateMap = 11'd204;
    236: stateMap = 11'd205;
    237: stateMap = 11'd103;
    238: stateMap = 11'd206;
    239: stateMap = 11'd207;
    240: stateMap = 11'd208;
    241: stateMap = 11'd209;
    242: stateMap = 11'd210;
    243: stateMap = 11'd211;
    244: stateMap = 11'd212;
    245: stateMap = 11'd213;
    246: stateMap = 11'd214;
    247: stateMap = 11'd215;
    248: stateMap = 11'd216;
    249: stateMap = 11'd217;
    250: stateMap = 11'd218;
    251: stateMap = 11'd219;
    252: stateMap = 11'd220;
    253: stateMap = 11'd221;
    254: stateMap = 11'd222;
    255: stateMap = 11'd223;
    256: stateMap = 11'd224;
    257: stateMap = 11'd225;
    258: stateMap = 11'd226;
    259: stateMap = 11'd227;
    260: stateMap = 11'd228;
    261: stateMap = 11'd229;
    262: stateMap = 11'd230;
    263: stateMap = 11'd231;
    264: stateMap = 11'd232;
    265: stateMap = 11'd233;
    266: stateMap = 11'd234;
    267: stateMap = 11'd235;
    268: stateMap = 11'd236;
    269: stateMap = 11'd237;
    270: stateMap = 11'd238;
    271: stateMap = 11'd239;
    272: stateMap = 11'd240;
    273: stateMap = 11'd241;
    274: stateMap = 11'd242;
    275: stateMap = 11'd243;
    276: stateMap = 11'd244;
    277: stateMap = 11'd245;
    278: stateMap = 11'd246;
    279: stateMap = 11'd247;
    280: stateMap = 11'd248;
    281: stateMap = 11'd249;
    282: stateMap = 11'd250;
    283: stateMap = 11'd251;
    284: stateMap = 11'd252;
    285: stateMap = 11'd253;
    286: stateMap = 11'd58;
    287: stateMap = 11'd254;
    288: stateMap = 11'd255;
    289: stateMap = 11'd256;
    290: stateMap = 11'd257;
    291: stateMap = 11'd258;
    292: stateMap = 11'd259;
    293: stateMap = 11'd260;
    294: stateMap = 11'd261;
    295: stateMap = 11'd262;
    296: stateMap = 11'd263;
    297: stateMap = 11'd264;
    298: stateMap = 11'd265;
    299: stateMap = 11'd266;
    300: stateMap = 11'd267;
    301: stateMap = 11'd268;
    302: stateMap = 11'd269;
    303: stateMap = 11'd270;
    304: stateMap = 11'd271;
    305: stateMap = 11'd272;
    306: stateMap = 11'd273;
    307: stateMap = 11'd274;
    308: stateMap = 11'd275;
    309: stateMap = 11'd276;
    310: stateMap = 11'd277;
    311: stateMap = 11'd278;
    312: stateMap = 11'd279;
    313: stateMap = 11'd280;
    314: stateMap = 11'd260;
    315: stateMap = 11'd281;
    316: stateMap = 11'd282;
    317: stateMap = 11'd283;
    318: stateMap = 11'd284;
    319: stateMap = 11'd285;
    320: stateMap = 11'd286;
    321: stateMap = 11'd134;
    322: stateMap = 11'd281;
    323: stateMap = 11'd287;
    324: stateMap = 11'd288;
    325: stateMap = 11'd289;
    326: stateMap = 11'd290;
    327: stateMap = 11'd291;
    328: stateMap = 11'd292;
    329: stateMap = 11'd289;
    330: stateMap = 11'd293;
    331: stateMap = 11'd294;
    332: stateMap = 11'd295;
    333: stateMap = 11'd296;
    334: stateMap = 11'd297;
    335: stateMap = 11'd298;
    336: stateMap = 11'd299;
    337: stateMap = 11'd300;
    338: stateMap = 11'd301;
    339: stateMap = 11'd302;
    340: stateMap = 11'd303;
    341: stateMap = 11'd304;
    342: stateMap = 11'd305;
    343: stateMap = 11'd306;
    344: stateMap = 11'd307;
    345: stateMap = 11'd308;
    346: stateMap = 11'd309;
    347: stateMap = 11'd310;
    348: stateMap = 11'd311;
    349: stateMap = 11'd312;
    350: stateMap = 11'd313;
    351: stateMap = 11'd314;
    352: stateMap = 11'd315;
    353: stateMap = 11'd316;
    354: stateMap = 11'd317;
    355: stateMap = 11'd318;
    356: stateMap = 11'd319;
    357: stateMap = 11'd320;
    358: stateMap = 11'd321;
    359: stateMap = 11'd322;
    360: stateMap = 11'd323;
    361: stateMap = 11'd324;
    362: stateMap = 11'd325;
    363: stateMap = 11'd326;
    364: stateMap = 11'd327;
    365: stateMap = 11'd328;
    366: stateMap = 11'd329;
    367: stateMap = 11'd330;
    368: stateMap = 11'd331;
    369: stateMap = 11'd332;
    370: stateMap = 11'd333;
    371: stateMap = 11'd203;
    372: stateMap = 11'd334;
    373: stateMap = 11'd335;
    374: stateMap = 11'd336;
    375: stateMap = 11'd337;
    376: stateMap = 11'd338;
    377: stateMap = 11'd339;
    378: stateMap = 11'd340;
    379: stateMap = 11'd341;
    380: stateMap = 11'd342;
    381: stateMap = 11'd343;
    382: stateMap = 11'd344;
    383: stateMap = 11'd345;
    384: stateMap = 11'd346;
    385: stateMap = 11'd347;
    386: stateMap = 11'd348;
    387: stateMap = 11'd349;
    388: stateMap = 11'd350;
    389: stateMap = 11'd351;
    390: stateMap = 11'd352;
    391: stateMap = 11'd353;
    392: stateMap = 11'd219;
    393: stateMap = 11'd354;
    394: stateMap = 11'd355;
    395: stateMap = 11'd356;
    396: stateMap = 11'd357;
    397: stateMap = 11'd358;
    398: stateMap = 11'd359;
    399: stateMap = 11'd360;
    400: stateMap = 11'd361;
    401: stateMap = 11'd362;
    402: stateMap = 11'd363;
    403: stateMap = 11'd364;
    404: stateMap = 11'd365;
    405: stateMap = 11'd366;
    406: stateMap = 11'd367;
    407: stateMap = 11'd368;
    408: stateMap = 11'd369;
    409: stateMap = 11'd370;
    410: stateMap = 11'd371;
    411: stateMap = 11'd372;
    412: stateMap = 11'd373;
    413: stateMap = 11'd374;
    414: stateMap = 11'd375;
    415: stateMap = 11'd376;
    416: stateMap = 11'd377;
    417: stateMap = 11'd378;
    418: stateMap = 11'd379;
    419: stateMap = 11'd380;
    420: stateMap = 11'd381;
    421: stateMap = 11'd382;
    422: stateMap = 11'd334;
    423: stateMap = 11'd256;
    424: stateMap = 11'd383;
    425: stateMap = 11'd258;
    426: stateMap = 11'd384;
    427: stateMap = 11'd385;
    428: stateMap = 11'd386;
    429: stateMap = 11'd387;
    430: stateMap = 11'd388;
    431: stateMap = 11'd389;
    432: stateMap = 11'd390;
    433: stateMap = 11'd391;
    434: stateMap = 11'd392;
    435: stateMap = 11'd393;
    436: stateMap = 11'd394;
    437: stateMap = 11'd395;
    438: stateMap = 11'd396;
    439: stateMap = 11'd397;
    440: stateMap = 11'd398;
    441: stateMap = 11'd399;
    442: stateMap = 11'd400;
    443: stateMap = 11'd401;
    444: stateMap = 11'd402;
    445: stateMap = 11'd403;
    446: stateMap = 11'd404;
    447: stateMap = 11'd405;
    448: stateMap = 11'd406;
    449: stateMap = 11'd407;
    450: stateMap = 11'd408;
    451: stateMap = 11'd409;
    452: stateMap = 11'd410;
    453: stateMap = 11'd411;
    454: stateMap = 11'd412;
    455: stateMap = 11'd347;
    456: stateMap = 11'd413;
    457: stateMap = 11'd414;
    458: stateMap = 11'd382;
    459: stateMap = 11'd415;
    460: stateMap = 11'd416;
    461: stateMap = 11'd346;
    462: stateMap = 11'd358;
    463: stateMap = 11'd417;
    464: stateMap = 11'd418;
    465: stateMap = 11'd419;
    466: stateMap = 11'd420;
    467: stateMap = 11'd421;
    468: stateMap = 11'd422;
    469: stateMap = 11'd423;
    470: stateMap = 11'd409;
    471: stateMap = 11'd424;
    472: stateMap = 11'd425;
    473: stateMap = 11'd426;
    474: stateMap = 11'd427;
    475: stateMap = 11'd428;
    476: stateMap = 11'd429;
    477: stateMap = 11'd430;
    478: stateMap = 11'd431;
    479: stateMap = 11'd432;
    480: stateMap = 11'd433;
    481: stateMap = 11'd434;
    482: stateMap = 11'd435;
    483: stateMap = 11'd436;
    484: stateMap = 11'd437;
    485: stateMap = 11'd438;
    486: stateMap = 11'd439;
    487: stateMap = 11'd440;
    488: stateMap = 11'd441;
    489: stateMap = 11'd442;
    490: stateMap = 11'd443;
    491: stateMap = 11'd444;
    492: stateMap = 11'd445;
    493: stateMap = 11'd446;
    494: stateMap = 11'd447;
    495: stateMap = 11'd448;
    496: stateMap = 11'd449;
    497: stateMap = 11'd450;
    498: stateMap = 11'd451;
    499: stateMap = 11'd452;
    500: stateMap = 11'd453;
    501: stateMap = 11'd454;
    502: stateMap = 11'd455;
    503: stateMap = 11'd456;
    504: stateMap = 11'd457;
    505: stateMap = 11'd458;
    506: stateMap = 11'd459;
    507: stateMap = 11'd460;
    508: stateMap = 11'd461;
    509: stateMap = 11'd462;
    510: stateMap = 11'd463;
    511: stateMap = 11'd464;
    512: stateMap = 11'd465;
    513: stateMap = 11'd466;
    514: stateMap = 11'd467;
    515: stateMap = 11'd468;
    516: stateMap = 11'd469;
    517: stateMap = 11'd470;
    518: stateMap = 11'd471;
    519: stateMap = 11'd472;
    520: stateMap = 11'd473;
    521: stateMap = 11'd474;
    522: stateMap = 11'd475;
    523: stateMap = 11'd476;
    524: stateMap = 11'd477;
    525: stateMap = 11'd478;
    526: stateMap = 11'd479;
    527: stateMap = 11'd480;
    528: stateMap = 11'd481;
    529: stateMap = 11'd482;
    530: stateMap = 11'd483;
    531: stateMap = 11'd484;
    532: stateMap = 11'd485;
    533: stateMap = 11'd486;
    534: stateMap = 11'd487;
    535: stateMap = 11'd488;
    536: stateMap = 11'd485;
    537: stateMap = 11'd414;
    538: stateMap = 11'd489;
    539: stateMap = 11'd490;
    540: stateMap = 11'd491;
    541: stateMap = 11'd170;
    542: stateMap = 11'd492;
    543: stateMap = 11'd493;
    544: stateMap = 11'd494;
    545: stateMap = 11'd495;
    546: stateMap = 11'd496;
    547: stateMap = 11'd497;
    548: stateMap = 11'd498;
    549: stateMap = 11'd497;
    550: stateMap = 11'd499;
    551: stateMap = 11'd500;
    552: stateMap = 11'd497;
    553: stateMap = 11'd501;
    554: stateMap = 11'd502;
    555: stateMap = 11'd4;
    556: stateMap = 11'd503;
    557: stateMap = 11'd504;
    558: stateMap = 11'd505;
    559: stateMap = 11'd506;
    560: stateMap = 11'd507;
    561: stateMap = 11'd508;
    562: stateMap = 11'd509;
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
    6: acceptStates = 1'b1;
    7: acceptStates = 1'b0;
    8: acceptStates = 1'b1;
    9: acceptStates = 1'b0;
    10: acceptStates = 1'b1;
    11: acceptStates = 1'b0;
    12: acceptStates = 1'b1;
    13: acceptStates = 1'b0;
    14: acceptStates = 1'b1;
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
    63: acceptStates = 1'b1;
    64: acceptStates = 1'b1;
    65: acceptStates = 1'b0;
    66: acceptStates = 1'b1;
    67: acceptStates = 1'b0;
    68: acceptStates = 1'b1;
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
    144: acceptStates = 1'b1;
    145: acceptStates = 1'b1;
    146: acceptStates = 1'b0;
    147: acceptStates = 1'b1;
    148: acceptStates = 1'b1;
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
    161: acceptStates = 1'b1;
    162: acceptStates = 1'b1;
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
    176: acceptStates = 1'b1;
    177: acceptStates = 1'b1;
    178: acceptStates = 1'b0;
    179: acceptStates = 1'b1;
    180: acceptStates = 1'b1;
    181: acceptStates = 1'b0;
    182: acceptStates = 1'b0;
    183: acceptStates = 1'b0;
    184: acceptStates = 1'b0;
    185: acceptStates = 1'b0;
    186: acceptStates = 1'b0;
    187: acceptStates = 1'b0;
    188: acceptStates = 1'b1;
    189: acceptStates = 1'b0;
    190: acceptStates = 1'b1;
    191: acceptStates = 1'b1;
    192: acceptStates = 1'b0;
    193: acceptStates = 1'b0;
    194: acceptStates = 1'b0;
    195: acceptStates = 1'b0;
    196: acceptStates = 1'b1;
    197: acceptStates = 1'b0;
    198: acceptStates = 1'b1;
    199: acceptStates = 1'b1;
    200: acceptStates = 1'b0;
    201: acceptStates = 1'b0;
    202: acceptStates = 1'b0;
    203: acceptStates = 1'b1;
    204: acceptStates = 1'b0;
    205: acceptStates = 1'b1;
    206: acceptStates = 1'b1;
    207: acceptStates = 1'b0;
    208: acceptStates = 1'b0;
    209: acceptStates = 1'b0;
    210: acceptStates = 1'b0;
    211: acceptStates = 1'b1;
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
    314: acceptStates = 1'b1;
    315: acceptStates = 1'b1;
    316: acceptStates = 1'b0;
    317: acceptStates = 1'b0;
    318: acceptStates = 1'b0;
    319: acceptStates = 1'b0;
    320: acceptStates = 1'b0;
    321: acceptStates = 1'b0;
    322: acceptStates = 1'b0;
    323: acceptStates = 1'b0;
    324: acceptStates = 1'b0;
    325: acceptStates = 1'b1;
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
    400: acceptStates = 1'b0;
    401: acceptStates = 1'b0;
    402: acceptStates = 1'b0;
    403: acceptStates = 1'b0;
    404: acceptStates = 1'b0;
    405: acceptStates = 1'b0;
    406: acceptStates = 1'b0;
    407: acceptStates = 1'b0;
    408: acceptStates = 1'b0;
    409: acceptStates = 1'b0;
    410: acceptStates = 1'b0;
    411: acceptStates = 1'b0;
    412: acceptStates = 1'b0;
    413: acceptStates = 1'b0;
    414: acceptStates = 1'b0;
    415: acceptStates = 1'b0;
    416: acceptStates = 1'b0;
    417: acceptStates = 1'b0;
    418: acceptStates = 1'b0;
    419: acceptStates = 1'b0;
    420: acceptStates = 1'b0;
    421: acceptStates = 1'b1;
    422: acceptStates = 1'b0;
    423: acceptStates = 1'b1;
    424: acceptStates = 1'b0;
    425: acceptStates = 1'b1;
    426: acceptStates = 1'b0;
    427: acceptStates = 1'b0;
    428: acceptStates = 1'b0;
    429: acceptStates = 1'b0;
    430: acceptStates = 1'b0;
    431: acceptStates = 1'b0;
    432: acceptStates = 1'b0;
    433: acceptStates = 1'b0;
    434: acceptStates = 1'b0;
    435: acceptStates = 1'b0;
    436: acceptStates = 1'b0;
    437: acceptStates = 1'b0;
    438: acceptStates = 1'b0;
    439: acceptStates = 1'b0;
    440: acceptStates = 1'b0;
    441: acceptStates = 1'b0;
    442: acceptStates = 1'b0;
    443: acceptStates = 1'b0;
    444: acceptStates = 1'b0;
    445: acceptStates = 1'b0;
    446: acceptStates = 1'b0;
    447: acceptStates = 1'b0;
    448: acceptStates = 1'b0;
    449: acceptStates = 1'b0;
    450: acceptStates = 1'b0;
    451: acceptStates = 1'b1;
    452: acceptStates = 1'b0;
    453: acceptStates = 1'b0;
    454: acceptStates = 1'b0;
    455: acceptStates = 1'b1;
    456: acceptStates = 1'b0;
    457: acceptStates = 1'b1;
    458: acceptStates = 1'b0;
    459: acceptStates = 1'b0;
    460: acceptStates = 1'b0;
    461: acceptStates = 1'b0;
    462: acceptStates = 1'b0;
    463: acceptStates = 1'b0;
    464: acceptStates = 1'b0;
    465: acceptStates = 1'b0;
    466: acceptStates = 1'b0;
    467: acceptStates = 1'b0;
    468: acceptStates = 1'b0;
    469: acceptStates = 1'b0;
    470: acceptStates = 1'b0;
    471: acceptStates = 1'b0;
    472: acceptStates = 1'b0;
    473: acceptStates = 1'b0;
    474: acceptStates = 1'b0;
    475: acceptStates = 1'b0;
    476: acceptStates = 1'b0;
    477: acceptStates = 1'b0;
    478: acceptStates = 1'b0;
    479: acceptStates = 1'b0;
    480: acceptStates = 1'b0;
    481: acceptStates = 1'b0;
    482: acceptStates = 1'b0;
    483: acceptStates = 1'b0;
    484: acceptStates = 1'b0;
    485: acceptStates = 1'b0;
    486: acceptStates = 1'b0;
    487: acceptStates = 1'b0;
    488: acceptStates = 1'b0;
    489: acceptStates = 1'b0;
    490: acceptStates = 1'b0;
    491: acceptStates = 1'b0;
    492: acceptStates = 1'b0;
    493: acceptStates = 1'b0;
    494: acceptStates = 1'b0;
    495: acceptStates = 1'b0;
    496: acceptStates = 1'b0;
    497: acceptStates = 1'b0;
    498: acceptStates = 1'b0;
    499: acceptStates = 1'b0;
    500: acceptStates = 1'b0;
    501: acceptStates = 1'b0;
    502: acceptStates = 1'b0;
    503: acceptStates = 1'b0;
    504: acceptStates = 1'b0;
    505: acceptStates = 1'b0;
    506: acceptStates = 1'b0;
    507: acceptStates = 1'b0;
    508: acceptStates = 1'b0;
    509: acceptStates = 1'b0;
    510: acceptStates = 1'b0;
    511: acceptStates = 1'b0;
    512: acceptStates = 1'b0;
    513: acceptStates = 1'b0;
    514: acceptStates = 1'b0;
    515: acceptStates = 1'b0;
    516: acceptStates = 1'b0;
    517: acceptStates = 1'b0;
    518: acceptStates = 1'b0;
    519: acceptStates = 1'b0;
    520: acceptStates = 1'b0;
    521: acceptStates = 1'b0;
    522: acceptStates = 1'b0;
    523: acceptStates = 1'b0;
    524: acceptStates = 1'b0;
    525: acceptStates = 1'b0;
    526: acceptStates = 1'b0;
    527: acceptStates = 1'b0;
    528: acceptStates = 1'b0;
    529: acceptStates = 1'b0;
    530: acceptStates = 1'b0;
    531: acceptStates = 1'b0;
    532: acceptStates = 1'b0;
    533: acceptStates = 1'b0;
    534: acceptStates = 1'b0;
    535: acceptStates = 1'b0;
    536: acceptStates = 1'b0;
    537: acceptStates = 1'b0;
    538: acceptStates = 1'b0;
    539: acceptStates = 1'b0;
    540: acceptStates = 1'b0;
    541: acceptStates = 1'b0;
    542: acceptStates = 1'b0;
    543: acceptStates = 1'b0;
    544: acceptStates = 1'b0;
    545: acceptStates = 1'b0;
    546: acceptStates = 1'b0;
    547: acceptStates = 1'b0;
    548: acceptStates = 1'b0;
    549: acceptStates = 1'b1;
    550: acceptStates = 1'b0;
    551: acceptStates = 1'b0;
    552: acceptStates = 1'b0;
    553: acceptStates = 1'b0;
    554: acceptStates = 1'b0;
    555: acceptStates = 1'b0;
    556: acceptStates = 1'b0;
    557: acceptStates = 1'b0;
    558: acceptStates = 1'b0;
    559: acceptStates = 1'b0;
    560: acceptStates = 1'b0;
    561: acceptStates = 1'b0;
    562: acceptStates = 1'b0;
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
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd1;
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
      default: stateTransition = 11'bX;
    endcase
    2: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    3: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd5;
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
      default: stateTransition = 11'bX;
    endcase
    4: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    5: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd7;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      9: stateTransition = 11'd0;
      10: stateTransition = 11'd0;
      11: stateTransition = 11'd0;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    6: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd555;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd555;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd11;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd424;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd2;
      8: stateTransition = 11'd557;
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd13;
      11: stateTransition = 11'd13;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd18;
      2: stateTransition = 11'd150;
      3: stateTransition = 11'd150;
      4: stateTransition = 11'd150;
      5: stateTransition = 11'd181;
      6: stateTransition = 11'd150;
      7: stateTransition = 11'd6;
      8: stateTransition = 11'd505;
      9: stateTransition = 11'd150;
      10: stateTransition = 11'd150;
      11: stateTransition = 11'd150;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd69;
      2: stateTransition = 11'd192;
      3: stateTransition = 11'd192;
      4: stateTransition = 11'd192;
      5: stateTransition = 11'd200;
      6: stateTransition = 11'd192;
      7: stateTransition = 11'd145;
      8: stateTransition = 11'd510;
      9: stateTransition = 11'd192;
      10: stateTransition = 11'd192;
      11: stateTransition = 11'd192;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    17: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    18: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd378;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    19: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd149;
      2: stateTransition = 11'd321;
      3: stateTransition = 11'd321;
      4: stateTransition = 11'd321;
      5: stateTransition = 11'd316;
      6: stateTransition = 11'd321;
      7: stateTransition = 11'd144;
      8: stateTransition = 11'd561;
      9: stateTransition = 11'd321;
      10: stateTransition = 11'd321;
      11: stateTransition = 11'd321;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    20: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd72;
      2: stateTransition = 11'd207;
      3: stateTransition = 11'd207;
      4: stateTransition = 11'd207;
      5: stateTransition = 11'd327;
      6: stateTransition = 11'd207;
      7: stateTransition = 11'd177;
      8: stateTransition = 11'd512;
      9: stateTransition = 11'd207;
      10: stateTransition = 11'd433;
      11: stateTransition = 11'd207;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    21: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd28;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd426;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd29;
      8: stateTransition = 11'd494;
      9: stateTransition = 11'd29;
      10: stateTransition = 11'd453;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    22: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    23: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    24: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd70;
      2: stateTransition = 11'd70;
      3: stateTransition = 11'd70;
      4: stateTransition = 11'd70;
      5: stateTransition = 11'd499;
      6: stateTransition = 11'd70;
      7: stateTransition = 11'd176;
      8: stateTransition = 11'd558;
      9: stateTransition = 11'd70;
      10: stateTransition = 11'd70;
      11: stateTransition = 11'd70;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    25: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd541;
      2: stateTransition = 11'd541;
      3: stateTransition = 11'd541;
      4: stateTransition = 11'd541;
      5: stateTransition = 11'd546;
      6: stateTransition = 11'd541;
      7: stateTransition = 11'd188;
      8: stateTransition = 11'd548;
      9: stateTransition = 11'd541;
      10: stateTransition = 11'd428;
      11: stateTransition = 11'd541;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    26: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd32;
      2: stateTransition = 11'd33;
      3: stateTransition = 11'd33;
      4: stateTransition = 11'd33;
      5: stateTransition = 11'd212;
      6: stateTransition = 11'd33;
      7: stateTransition = 11'd64;
      8: stateTransition = 11'd33;
      9: stateTransition = 11'd33;
      10: stateTransition = 11'd495;
      11: stateTransition = 11'd33;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    27: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    28: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd75;
      2: stateTransition = 11'd153;
      3: stateTransition = 11'd153;
      4: stateTransition = 11'd153;
      5: stateTransition = 11'd183;
      6: stateTransition = 11'd153;
      7: stateTransition = 11'd153;
      8: stateTransition = 11'd153;
      9: stateTransition = 11'd153;
      10: stateTransition = 11'd310;
      11: stateTransition = 11'd147;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    29: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd155;
      2: stateTransition = 11'd286;
      3: stateTransition = 11'd286;
      4: stateTransition = 11'd286;
      5: stateTransition = 11'd360;
      6: stateTransition = 11'd286;
      7: stateTransition = 11'd63;
      8: stateTransition = 11'd521;
      9: stateTransition = 11'd286;
      10: stateTransition = 11'd438;
      11: stateTransition = 11'd286;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    30: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    31: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    32: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    33: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd39;
      2: stateTransition = 11'd322;
      3: stateTransition = 11'd322;
      4: stateTransition = 11'd322;
      5: stateTransition = 11'd326;
      6: stateTransition = 11'd322;
      7: stateTransition = 11'd322;
      8: stateTransition = 11'd526;
      9: stateTransition = 11'd322;
      10: stateTransition = 11'd444;
      11: stateTransition = 11'd315;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    34: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd41;
      2: stateTransition = 11'd42;
      3: stateTransition = 11'd42;
      4: stateTransition = 11'd42;
      5: stateTransition = 11'd427;
      6: stateTransition = 11'd42;
      7: stateTransition = 11'd10;
      8: stateTransition = 11'd496;
      9: stateTransition = 11'd42;
      10: stateTransition = 11'd454;
      11: stateTransition = 11'd10;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    35: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd74;
      2: stateTransition = 11'd74;
      3: stateTransition = 11'd74;
      4: stateTransition = 11'd74;
      5: stateTransition = 11'd500;
      6: stateTransition = 11'd74;
      7: stateTransition = 11'd74;
      8: stateTransition = 11'd542;
      9: stateTransition = 11'd74;
      10: stateTransition = 11'd429;
      11: stateTransition = 11'd66;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    36: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd45;
      2: stateTransition = 11'd46;
      3: stateTransition = 11'd46;
      4: stateTransition = 11'd46;
      5: stateTransition = 11'd217;
      6: stateTransition = 11'd46;
      7: stateTransition = 11'd46;
      8: stateTransition = 11'd46;
      9: stateTransition = 11'd46;
      10: stateTransition = 11'd497;
      11: stateTransition = 11'd12;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    37: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    38: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd47;
      2: stateTransition = 11'd220;
      3: stateTransition = 11'd220;
      4: stateTransition = 11'd220;
      5: stateTransition = 11'd362;
      6: stateTransition = 11'd220;
      7: stateTransition = 11'd220;
      8: stateTransition = 11'd220;
      9: stateTransition = 11'd220;
      10: stateTransition = 11'd336;
      11: stateTransition = 11'd198;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    39: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    40: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd53;
      2: stateTransition = 11'd194;
      3: stateTransition = 11'd194;
      4: stateTransition = 11'd194;
      5: stateTransition = 11'd202;
      6: stateTransition = 11'd194;
      7: stateTransition = 11'd191;
      8: stateTransition = 11'd194;
      9: stateTransition = 11'd194;
      10: stateTransition = 11'd323;
      11: stateTransition = 11'd191;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    41: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd157;
      2: stateTransition = 11'd209;
      3: stateTransition = 11'd209;
      4: stateTransition = 11'd209;
      5: stateTransition = 11'd214;
      6: stateTransition = 11'd209;
      7: stateTransition = 11'd199;
      8: stateTransition = 11'd209;
      9: stateTransition = 11'd209;
      10: stateTransition = 11'd513;
      11: stateTransition = 11'd199;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    42: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    43: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    44: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    45: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    46: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd58;
      2: stateTransition = 11'd59;
      3: stateTransition = 11'd59;
      4: stateTransition = 11'd59;
      5: stateTransition = 11'd337;
      6: stateTransition = 11'd59;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd59;
      9: stateTransition = 11'd59;
      10: stateTransition = 11'd498;
      11: stateTransition = 11'd14;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    47: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    48: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    49: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    50: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    51: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd61;
      2: stateTransition = 11'd329;
      3: stateTransition = 11'd329;
      4: stateTransition = 11'd329;
      5: stateTransition = 11'd331;
      6: stateTransition = 11'd329;
      7: stateTransition = 11'd325;
      8: stateTransition = 11'd527;
      9: stateTransition = 11'd329;
      10: stateTransition = 11'd445;
      11: stateTransition = 11'd325;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    52: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    53: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    54: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    55: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd79;
      2: stateTransition = 11'd79;
      3: stateTransition = 11'd79;
      4: stateTransition = 11'd79;
      5: stateTransition = 11'd501;
      6: stateTransition = 11'd79;
      7: stateTransition = 11'd68;
      8: stateTransition = 11'd543;
      9: stateTransition = 11'd79;
      10: stateTransition = 11'd430;
      11: stateTransition = 11'd68;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    56: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    57: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    58: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    59: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    60: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    61: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd17;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd424;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd2;
      8: stateTransition = 11'd557;
      9: stateTransition = 11'd13;
      10: stateTransition = 11'd13;
      11: stateTransition = 11'd13;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    62: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    63: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd9;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd451;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    64: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    65: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd89;
      2: stateTransition = 11'd216;
      3: stateTransition = 11'd216;
      4: stateTransition = 11'd216;
      5: stateTransition = 11'd330;
      6: stateTransition = 11'd216;
      7: stateTransition = 11'd203;
      8: stateTransition = 11'd216;
      9: stateTransition = 11'd216;
      10: stateTransition = 11'd333;
      11: stateTransition = 11'd216;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    66: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    67: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd34;
      2: stateTransition = 11'd29;
      3: stateTransition = 11'd29;
      4: stateTransition = 11'd29;
      5: stateTransition = 11'd426;
      6: stateTransition = 11'd29;
      7: stateTransition = 11'd29;
      8: stateTransition = 11'd494;
      9: stateTransition = 11'd29;
      10: stateTransition = 11'd453;
      11: stateTransition = 11'd8;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    68: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    69: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd48;
      2: stateTransition = 11'd158;
      3: stateTransition = 11'd158;
      4: stateTransition = 11'd158;
      5: stateTransition = 11'd311;
      6: stateTransition = 11'd158;
      7: stateTransition = 11'd148;
      8: stateTransition = 11'd506;
      9: stateTransition = 11'd158;
      10: stateTransition = 11'd431;
      11: stateTransition = 11'd148;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    70: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    71: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd56;
      2: stateTransition = 11'd158;
      3: stateTransition = 11'd158;
      4: stateTransition = 11'd158;
      5: stateTransition = 11'd311;
      6: stateTransition = 11'd158;
      7: stateTransition = 11'd148;
      8: stateTransition = 11'd506;
      9: stateTransition = 11'd158;
      10: stateTransition = 11'd431;
      11: stateTransition = 11'd148;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    72: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd62;
      2: stateTransition = 11'd224;
      3: stateTransition = 11'd224;
      4: stateTransition = 11'd224;
      5: stateTransition = 11'd226;
      6: stateTransition = 11'd224;
      7: stateTransition = 11'd211;
      8: stateTransition = 11'd224;
      9: stateTransition = 11'd224;
      10: stateTransition = 11'd339;
      11: stateTransition = 11'd211;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    73: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    74: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    75: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    76: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd49;
      2: stateTransition = 11'd223;
      3: stateTransition = 11'd223;
      4: stateTransition = 11'd223;
      5: stateTransition = 11'd338;
      6: stateTransition = 11'd223;
      7: stateTransition = 11'd223;
      8: stateTransition = 11'd514;
      9: stateTransition = 11'd223;
      10: stateTransition = 11'd434;
      11: stateTransition = 11'd205;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    77: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd51;
      2: stateTransition = 11'd184;
      3: stateTransition = 11'd184;
      4: stateTransition = 11'd184;
      5: stateTransition = 11'd317;
      6: stateTransition = 11'd184;
      7: stateTransition = 11'd180;
      8: stateTransition = 11'd508;
      9: stateTransition = 11'd184;
      10: stateTransition = 11'd432;
      11: stateTransition = 11'd180;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    78: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd57;
      2: stateTransition = 11'd218;
      3: stateTransition = 11'd218;
      4: stateTransition = 11'd218;
      5: stateTransition = 11'd221;
      6: stateTransition = 11'd218;
      7: stateTransition = 11'd206;
      8: stateTransition = 11'd218;
      9: stateTransition = 11'd218;
      10: stateTransition = 11'd335;
      11: stateTransition = 11'd206;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    79: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd389;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    80: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    81: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd52;
      2: stateTransition = 11'd184;
      3: stateTransition = 11'd184;
      4: stateTransition = 11'd184;
      5: stateTransition = 11'd317;
      6: stateTransition = 11'd184;
      7: stateTransition = 11'd180;
      8: stateTransition = 11'd508;
      9: stateTransition = 11'd184;
      10: stateTransition = 11'd432;
      11: stateTransition = 11'd180;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    82: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd234;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    83: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    84: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd93;
      2: stateTransition = 11'd225;
      3: stateTransition = 11'd225;
      4: stateTransition = 11'd225;
      5: stateTransition = 11'd332;
      6: stateTransition = 11'd225;
      7: stateTransition = 11'd225;
      8: stateTransition = 11'd515;
      9: stateTransition = 11'd225;
      10: stateTransition = 11'd225;
      11: stateTransition = 11'd225;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    85: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    86: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    87: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd368;
      2: stateTransition = 11'd20;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    88: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    89: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd109;
      2: stateTransition = 11'd22;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    90: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd23;
      2: stateTransition = 11'd297;
      3: stateTransition = 11'd297;
      4: stateTransition = 11'd297;
      5: stateTransition = 11'd365;
      6: stateTransition = 11'd297;
      7: stateTransition = 11'd297;
      8: stateTransition = 11'd525;
      9: stateTransition = 11'd297;
      10: stateTransition = 11'd442;
      11: stateTransition = 11'd297;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    91: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    92: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    93: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    94: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd25;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    95: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    96: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd26;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    97: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd27;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    98: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd300;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    99: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    100: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd412;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    101: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd117;
      2: stateTransition = 11'd154;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    102: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd182;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    103: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd107;
      2: stateTransition = 11'd245;
      3: stateTransition = 11'd245;
      4: stateTransition = 11'd245;
      5: stateTransition = 11'd344;
      6: stateTransition = 11'd245;
      7: stateTransition = 11'd245;
      8: stateTransition = 11'd245;
      9: stateTransition = 11'd245;
      10: stateTransition = 11'd345;
      11: stateTransition = 11'd245;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    104: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    105: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd31;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    106: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    107: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd35;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    108: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd36;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    109: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd251;
      2: stateTransition = 11'd71;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    110: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    111: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd37;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    112: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd38;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    113: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd288;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    114: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd76;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    115: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    116: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd85;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    117: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd251;
      2: stateTransition = 11'd40;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    118: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd86;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    119: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd304;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    120: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    121: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd412;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    122: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd139;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    123: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    124: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    125: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd87;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    126: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd50;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    127: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    128: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    129: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd55;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    130: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd81;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    131: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd290;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    132: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd92;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    133: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd60;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    134: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    135: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd451;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    136: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd65;
      2: stateTransition = 11'd189;
      3: stateTransition = 11'd189;
      4: stateTransition = 11'd189;
      5: stateTransition = 11'd197;
      6: stateTransition = 11'd189;
      7: stateTransition = 11'd189;
      8: stateTransition = 11'd509;
      9: stateTransition = 11'd189;
      10: stateTransition = 11'd189;
      11: stateTransition = 11'd189;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    137: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    138: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    139: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    140: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd83;
      2: stateTransition = 11'd207;
      3: stateTransition = 11'd207;
      4: stateTransition = 11'd207;
      5: stateTransition = 11'd327;
      6: stateTransition = 11'd207;
      7: stateTransition = 11'd177;
      8: stateTransition = 11'd512;
      9: stateTransition = 11'd207;
      10: stateTransition = 11'd433;
      11: stateTransition = 11'd207;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    141: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    142: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd84;
      2: stateTransition = 11'd193;
      3: stateTransition = 11'd193;
      4: stateTransition = 11'd193;
      5: stateTransition = 11'd201;
      6: stateTransition = 11'd193;
      7: stateTransition = 11'd193;
      8: stateTransition = 11'd193;
      9: stateTransition = 11'd193;
      10: stateTransition = 11'd511;
      11: stateTransition = 11'd179;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    143: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    144: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd78;
      2: stateTransition = 11'd208;
      3: stateTransition = 11'd208;
      4: stateTransition = 11'd208;
      5: stateTransition = 11'd213;
      6: stateTransition = 11'd208;
      7: stateTransition = 11'd208;
      8: stateTransition = 11'd208;
      9: stateTransition = 11'd208;
      10: stateTransition = 11'd328;
      11: stateTransition = 11'd190;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    145: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd77;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    146: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    147: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    148: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    149: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    150: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd146;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    151: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    152: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    153: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    154: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd422;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    155: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    156: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    157: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd154;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    158: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd156;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    159: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd288;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    160: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    161: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd44;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    162: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd251;
      2: stateTransition = 11'd92;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    163: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    164: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd82;
      2: stateTransition = 11'd320;
      3: stateTransition = 11'd320;
      4: stateTransition = 11'd320;
      5: stateTransition = 11'd215;
      6: stateTransition = 11'd320;
      7: stateTransition = 11'd320;
      8: stateTransition = 11'd560;
      9: stateTransition = 11'd320;
      10: stateTransition = 11'd320;
      11: stateTransition = 11'd320;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    165: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    166: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    167: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd312;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    168: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd124;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    169: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    170: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    171: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    172: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    173: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    174: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    175: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd91;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    176: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    177: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    178: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd91;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd451;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    179: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd135;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    180: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd124;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    181: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    182: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    183: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    184: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd166;
      2: stateTransition = 11'd232;
      3: stateTransition = 11'd232;
      4: stateTransition = 11'd232;
      5: stateTransition = 11'd340;
      6: stateTransition = 11'd232;
      7: stateTransition = 11'd232;
      8: stateTransition = 11'd559;
      9: stateTransition = 11'd232;
      10: stateTransition = 11'd232;
      11: stateTransition = 11'd232;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    185: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    186: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    187: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd142;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    188: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd135;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    189: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd167;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    190: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    191: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd234;
      2: stateTransition = 11'd94;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    192: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd302;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    193: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd95;
      2: stateTransition = 11'd96;
      3: stateTransition = 11'd96;
      4: stateTransition = 11'd96;
      5: stateTransition = 11'd361;
      6: stateTransition = 11'd96;
      7: stateTransition = 11'd96;
      8: stateTransition = 11'd502;
      9: stateTransition = 11'd96;
      10: stateTransition = 11'd96;
      11: stateTransition = 11'd96;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    194: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    195: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd142;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    196: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd98;
      2: stateTransition = 11'd236;
      3: stateTransition = 11'd236;
      4: stateTransition = 11'd236;
      5: stateTransition = 11'd341;
      6: stateTransition = 11'd236;
      7: stateTransition = 11'd236;
      8: stateTransition = 11'd516;
      9: stateTransition = 11'd236;
      10: stateTransition = 11'd435;
      11: stateTransition = 11'd236;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    197: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd99;
      2: stateTransition = 11'd239;
      3: stateTransition = 11'd239;
      4: stateTransition = 11'd239;
      5: stateTransition = 11'd240;
      6: stateTransition = 11'd239;
      7: stateTransition = 11'd239;
      8: stateTransition = 11'd239;
      9: stateTransition = 11'd239;
      10: stateTransition = 11'd342;
      11: stateTransition = 11'd239;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    198: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd100;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    199: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd101;
      2: stateTransition = 11'd102;
      3: stateTransition = 11'd102;
      4: stateTransition = 11'd102;
      5: stateTransition = 11'd242;
      6: stateTransition = 11'd102;
      7: stateTransition = 11'd102;
      8: stateTransition = 11'd102;
      9: stateTransition = 11'd102;
      10: stateTransition = 11'd503;
      11: stateTransition = 11'd102;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    200: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd103;
      2: stateTransition = 11'd232;
      3: stateTransition = 11'd232;
      4: stateTransition = 11'd232;
      5: stateTransition = 11'd340;
      6: stateTransition = 11'd232;
      7: stateTransition = 11'd232;
      8: stateTransition = 11'd559;
      9: stateTransition = 11'd232;
      10: stateTransition = 11'd232;
      11: stateTransition = 11'd232;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    201: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    202: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd422;
      2: stateTransition = 11'd94;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    203: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd282;
      2: stateTransition = 11'd222;
      3: stateTransition = 11'd452;
      4: stateTransition = 11'd452;
      5: stateTransition = 11'd456;
      6: stateTransition = 11'd452;
      7: stateTransition = 11'd452;
      8: stateTransition = 11'd533;
      9: stateTransition = 11'd452;
      10: stateTransition = 11'd452;
      11: stateTransition = 11'd452;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    204: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd105;
      2: stateTransition = 11'd236;
      3: stateTransition = 11'd236;
      4: stateTransition = 11'd236;
      5: stateTransition = 11'd341;
      6: stateTransition = 11'd236;
      7: stateTransition = 11'd236;
      8: stateTransition = 11'd516;
      9: stateTransition = 11'd236;
      10: stateTransition = 11'd435;
      11: stateTransition = 11'd236;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    205: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    206: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd108;
      2: stateTransition = 11'd364;
      3: stateTransition = 11'd364;
      4: stateTransition = 11'd364;
      5: stateTransition = 11'd343;
      6: stateTransition = 11'd364;
      7: stateTransition = 11'd364;
      8: stateTransition = 11'd529;
      9: stateTransition = 11'd364;
      10: stateTransition = 11'd447;
      11: stateTransition = 11'd364;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    207: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd109;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    208: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd110;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    209: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd111;
      2: stateTransition = 11'd249;
      3: stateTransition = 11'd249;
      4: stateTransition = 11'd249;
      5: stateTransition = 11'd250;
      6: stateTransition = 11'd249;
      7: stateTransition = 11'd249;
      8: stateTransition = 11'd249;
      9: stateTransition = 11'd249;
      10: stateTransition = 11'd346;
      11: stateTransition = 11'd249;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    210: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    211: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd251;
      2: stateTransition = 11'd113;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    212: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd114;
      2: stateTransition = 11'd168;
      3: stateTransition = 11'd168;
      4: stateTransition = 11'd168;
      5: stateTransition = 11'd253;
      6: stateTransition = 11'd168;
      7: stateTransition = 11'd168;
      8: stateTransition = 11'd313;
      9: stateTransition = 11'd168;
      10: stateTransition = 11'd507;
      11: stateTransition = 11'd168;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    213: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    214: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd169;
      2: stateTransition = 11'd255;
      3: stateTransition = 11'd255;
      4: stateTransition = 11'd255;
      5: stateTransition = 11'd347;
      6: stateTransition = 11'd255;
      7: stateTransition = 11'd255;
      8: stateTransition = 11'd517;
      9: stateTransition = 11'd255;
      10: stateTransition = 11'd436;
      11: stateTransition = 11'd255;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    215: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd170;
      2: stateTransition = 11'd259;
      3: stateTransition = 11'd259;
      4: stateTransition = 11'd259;
      5: stateTransition = 11'd260;
      6: stateTransition = 11'd259;
      7: stateTransition = 11'd259;
      8: stateTransition = 11'd259;
      9: stateTransition = 11'd259;
      10: stateTransition = 11'd348;
      11: stateTransition = 11'd259;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    216: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd116;
      2: stateTransition = 11'd262;
      3: stateTransition = 11'd262;
      4: stateTransition = 11'd262;
      5: stateTransition = 11'd263;
      6: stateTransition = 11'd262;
      7: stateTransition = 11'd262;
      8: stateTransition = 11'd349;
      9: stateTransition = 11'd262;
      10: stateTransition = 11'd518;
      11: stateTransition = 11'd262;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    217: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd117;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    218: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd171;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    219: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd375;
      2: stateTransition = 11'd244;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      9: stateTransition = 11'd376;
      10: stateTransition = 11'd377;
      11: stateTransition = 11'd376;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    220: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd118;
      2: stateTransition = 11'd266;
      3: stateTransition = 11'd266;
      4: stateTransition = 11'd266;
      5: stateTransition = 11'd267;
      6: stateTransition = 11'd266;
      7: stateTransition = 11'd266;
      8: stateTransition = 11'd266;
      9: stateTransition = 11'd266;
      10: stateTransition = 11'd350;
      11: stateTransition = 11'd266;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    221: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd119;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    222: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd120;
      2: stateTransition = 11'd255;
      3: stateTransition = 11'd255;
      4: stateTransition = 11'd255;
      5: stateTransition = 11'd347;
      6: stateTransition = 11'd255;
      7: stateTransition = 11'd255;
      8: stateTransition = 11'd517;
      9: stateTransition = 11'd255;
      10: stateTransition = 11'd436;
      11: stateTransition = 11'd255;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    223: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    224: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd122;
      2: stateTransition = 11'd259;
      3: stateTransition = 11'd259;
      4: stateTransition = 11'd259;
      5: stateTransition = 11'd260;
      6: stateTransition = 11'd259;
      7: stateTransition = 11'd259;
      8: stateTransition = 11'd259;
      9: stateTransition = 11'd259;
      10: stateTransition = 11'd348;
      11: stateTransition = 11'd259;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    225: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd261;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    226: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd172;
      2: stateTransition = 11'd262;
      3: stateTransition = 11'd262;
      4: stateTransition = 11'd262;
      5: stateTransition = 11'd263;
      6: stateTransition = 11'd262;
      7: stateTransition = 11'd262;
      8: stateTransition = 11'd349;
      9: stateTransition = 11'd262;
      10: stateTransition = 11'd518;
      11: stateTransition = 11'd262;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    227: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    228: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd124;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    229: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd125;
      2: stateTransition = 11'd270;
      3: stateTransition = 11'd270;
      4: stateTransition = 11'd270;
      5: stateTransition = 11'd271;
      6: stateTransition = 11'd270;
      7: stateTransition = 11'd270;
      8: stateTransition = 11'd270;
      9: stateTransition = 11'd270;
      10: stateTransition = 11'd519;
      11: stateTransition = 11'd270;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    230: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    231: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd127;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    232: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd128;
      2: stateTransition = 11'd266;
      3: stateTransition = 11'd266;
      4: stateTransition = 11'd266;
      5: stateTransition = 11'd267;
      6: stateTransition = 11'd266;
      7: stateTransition = 11'd266;
      8: stateTransition = 11'd266;
      9: stateTransition = 11'd266;
      10: stateTransition = 11'd350;
      11: stateTransition = 11'd266;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    233: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd129;
      2: stateTransition = 11'd366;
      3: stateTransition = 11'd366;
      4: stateTransition = 11'd366;
      5: stateTransition = 11'd351;
      6: stateTransition = 11'd366;
      7: stateTransition = 11'd366;
      8: stateTransition = 11'd530;
      9: stateTransition = 11'd366;
      10: stateTransition = 11'd448;
      11: stateTransition = 11'd366;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    234: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    235: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd131;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    236: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd132;
      2: stateTransition = 11'd276;
      3: stateTransition = 11'd276;
      4: stateTransition = 11'd276;
      5: stateTransition = 11'd277;
      6: stateTransition = 11'd276;
      7: stateTransition = 11'd276;
      8: stateTransition = 11'd276;
      9: stateTransition = 11'd276;
      10: stateTransition = 11'd354;
      11: stateTransition = 11'd276;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    237: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd133;
      2: stateTransition = 11'd352;
      3: stateTransition = 11'd352;
      4: stateTransition = 11'd352;
      5: stateTransition = 11'd353;
      6: stateTransition = 11'd352;
      7: stateTransition = 11'd352;
      8: stateTransition = 11'd528;
      9: stateTransition = 11'd352;
      10: stateTransition = 11'd446;
      11: stateTransition = 11'd352;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    238: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    239: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd135;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    240: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd136;
      2: stateTransition = 11'd278;
      3: stateTransition = 11'd278;
      4: stateTransition = 11'd278;
      5: stateTransition = 11'd279;
      6: stateTransition = 11'd278;
      7: stateTransition = 11'd278;
      8: stateTransition = 11'd278;
      9: stateTransition = 11'd278;
      10: stateTransition = 11'd355;
      11: stateTransition = 11'd278;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    241: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd173;
      2: stateTransition = 11'd280;
      3: stateTransition = 11'd280;
      4: stateTransition = 11'd280;
      5: stateTransition = 11'd356;
      6: stateTransition = 11'd280;
      7: stateTransition = 11'd280;
      8: stateTransition = 11'd520;
      9: stateTransition = 11'd280;
      10: stateTransition = 11'd437;
      11: stateTransition = 11'd280;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    242: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd174;
      2: stateTransition = 11'd278;
      3: stateTransition = 11'd278;
      4: stateTransition = 11'd278;
      5: stateTransition = 11'd279;
      6: stateTransition = 11'd278;
      7: stateTransition = 11'd278;
      8: stateTransition = 11'd278;
      9: stateTransition = 11'd278;
      10: stateTransition = 11'd355;
      11: stateTransition = 11'd278;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    243: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd137;
      2: stateTransition = 11'd138;
      3: stateTransition = 11'd138;
      4: stateTransition = 11'd138;
      5: stateTransition = 11'd281;
      6: stateTransition = 11'd138;
      7: stateTransition = 11'd138;
      8: stateTransition = 11'd308;
      9: stateTransition = 11'd138;
      10: stateTransition = 11'd504;
      11: stateTransition = 11'd138;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    244: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd139;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    245: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd140;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    246: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    247: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd142;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    248: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    249: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd175;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    250: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd146;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    251: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd21;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    252: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd163;
      2: stateTransition = 11'd293;
      3: stateTransition = 11'd293;
      4: stateTransition = 11'd293;
      5: stateTransition = 11'd441;
      6: stateTransition = 11'd293;
      7: stateTransition = 11'd314;
      8: stateTransition = 11'd524;
      9: stateTransition = 11'd293;
      10: stateTransition = 11'd293;
      11: stateTransition = 11'd293;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    253: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd185;
      2: stateTransition = 11'd195;
      3: stateTransition = 11'd195;
      4: stateTransition = 11'd195;
      5: stateTransition = 11'd358;
      6: stateTransition = 11'd195;
      7: stateTransition = 11'd196;
      8: stateTransition = 11'd195;
      9: stateTransition = 11'd195;
      10: stateTransition = 11'd324;
      11: stateTransition = 11'd195;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    254: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd164;
      2: stateTransition = 11'd186;
      3: stateTransition = 11'd186;
      4: stateTransition = 11'd186;
      5: stateTransition = 11'd294;
      6: stateTransition = 11'd186;
      7: stateTransition = 11'd186;
      8: stateTransition = 11'd186;
      9: stateTransition = 11'd186;
      10: stateTransition = 11'd318;
      11: stateTransition = 11'd161;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    255: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd159;
      2: stateTransition = 11'd289;
      3: stateTransition = 11'd289;
      4: stateTransition = 11'd289;
      5: stateTransition = 11'd334;
      6: stateTransition = 11'd289;
      7: stateTransition = 11'd289;
      8: stateTransition = 11'd522;
      9: stateTransition = 11'd289;
      10: stateTransition = 11'd439;
      11: stateTransition = 11'd423;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    256: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    257: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd160;
      2: stateTransition = 11'd291;
      3: stateTransition = 11'd291;
      4: stateTransition = 11'd291;
      5: stateTransition = 11'd363;
      6: stateTransition = 11'd291;
      7: stateTransition = 11'd425;
      8: stateTransition = 11'd523;
      9: stateTransition = 11'd291;
      10: stateTransition = 11'd440;
      11: stateTransition = 11'd425;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    258: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    259: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd165;
      2: stateTransition = 11'd187;
      3: stateTransition = 11'd187;
      4: stateTransition = 11'd187;
      5: stateTransition = 11'd295;
      6: stateTransition = 11'd187;
      7: stateTransition = 11'd162;
      8: stateTransition = 11'd187;
      9: stateTransition = 11'd187;
      10: stateTransition = 11'd319;
      11: stateTransition = 11'd162;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    260: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    261: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd388;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    262: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd388;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    263: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd67;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    264: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    265: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd422;
      2: stateTransition = 11'd284;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    266: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd285;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    267: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd73;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    268: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd30;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    269: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd182;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    270: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd287;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    271: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd90;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    272: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd43;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    273: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd80;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    274: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd87;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    275: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd532;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    276: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd292;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    277: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    278: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd299;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    279: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd371;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd372;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    280: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd532;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    281: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    282: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd167;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    283: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd303;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    284: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    285: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    286: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    287: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    288: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    289: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    290: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd307;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    291: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd299;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    292: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    293: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd302;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    294: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd307;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    295: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd312;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    296: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    297: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd359;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    298: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    299: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    300: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd112;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    301: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd299;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    302: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    303: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd298;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    304: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd299;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    305: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd109;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    306: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd301;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    307: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd302;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    308: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd115;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    309: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd117;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    310: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd303;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    311: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd123;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    312: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd532;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    313: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd130;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    314: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd305;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    315: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    316: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd307;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    317: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd139;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    318: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd141;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    319: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd309;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    320: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd368;
      2: stateTransition = 11'd178;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    321: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd388;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    322: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd182;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    323: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd359;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    324: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd443;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    325: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd302;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd455;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    326: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd359;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    327: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd300;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    328: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd359;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    329: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd304;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    330: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd371;
      2: stateTransition = 11'd204;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd372;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    331: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd378;
      2: stateTransition = 11'd210;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    332: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd219;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    333: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd371;
      2: stateTransition = 11'd204;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd372;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    334: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd282;
      2: stateTransition = 11'd452;
      3: stateTransition = 11'd452;
      4: stateTransition = 11'd452;
      5: stateTransition = 11'd456;
      6: stateTransition = 11'd452;
      7: stateTransition = 11'd452;
      8: stateTransition = 11'd533;
      9: stateTransition = 11'd452;
      10: stateTransition = 11'd452;
      11: stateTransition = 11'd452;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    335: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd227;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    336: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd382;
      2: stateTransition = 11'd228;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    337: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    338: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    339: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd229;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    340: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd389;
      2: stateTransition = 11'd231;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    341: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd233;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    342: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd235;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    343: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd237;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    344: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd393;
      2: stateTransition = 11'd238;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    345: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd395;
      2: stateTransition = 11'd241;
      3: stateTransition = 11'd481;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd481;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    346: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd374;
      2: stateTransition = 11'd466;
      3: stateTransition = 11'd466;
      4: stateTransition = 11'd466;
      5: stateTransition = 11'd467;
      6: stateTransition = 11'd466;
      7: stateTransition = 11'd466;
      8: stateTransition = 11'd466;
      9: stateTransition = 11'd466;
      10: stateTransition = 11'd468;
      11: stateTransition = 11'd466;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    347: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    348: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd243;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    349: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd532;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    350: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd237;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    351: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd231;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    352: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd235;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    353: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd237;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    354: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd399;
      2: stateTransition = 11'd246;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    355: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd401;
      2: stateTransition = 11'd247;
      3: stateTransition = 11'd402;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd402;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    356: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd403;
      2: stateTransition = 11'd248;
      3: stateTransition = 11'd404;
      4: stateTransition = 11'd404;
      5: stateTransition = 11'd449;
      6: stateTransition = 11'd404;
      7: stateTransition = 11'd404;
      8: stateTransition = 11'd404;
      9: stateTransition = 11'd404;
      10: stateTransition = 11'd405;
      11: stateTransition = 11'd404;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    357: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    358: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd375;
      2: stateTransition = 11'd376;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      9: stateTransition = 11'd376;
      10: stateTransition = 11'd377;
      11: stateTransition = 11'd376;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    359: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd408;
      2: stateTransition = 11'd252;
      3: stateTransition = 11'd491;
      4: stateTransition = 11'd491;
      5: stateTransition = 11'd492;
      6: stateTransition = 11'd491;
      7: stateTransition = 11'd491;
      8: stateTransition = 11'd491;
      9: stateTransition = 11'd491;
      10: stateTransition = 11'd450;
      11: stateTransition = 11'd491;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    360: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd254;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    361: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd412;
      2: stateTransition = 11'd256;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    362: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd257;
      2: stateTransition = 11'd258;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      9: stateTransition = 11'd376;
      10: stateTransition = 11'd377;
      11: stateTransition = 11'd376;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    363: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd257;
      2: stateTransition = 11'd376;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      9: stateTransition = 11'd376;
      10: stateTransition = 11'd377;
      11: stateTransition = 11'd376;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    364: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd413;
      2: stateTransition = 11'd261;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    365: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd413;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    366: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd413;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    367: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd416;
      2: stateTransition = 11'd264;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    368: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd416;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    369: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd418;
      2: stateTransition = 11'd265;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    370: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd420;
      2: stateTransition = 11'd268;
      3: stateTransition = 11'd481;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd481;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    371: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd254;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    372: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd256;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    373: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd375;
      2: stateTransition = 11'd258;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      9: stateTransition = 11'd376;
      10: stateTransition = 11'd377;
      11: stateTransition = 11'd376;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    374: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd269;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    375: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd392;
      2: stateTransition = 11'd272;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    376: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd382;
      2: stateTransition = 11'd264;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    377: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd393;
      2: stateTransition = 11'd265;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    378: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd395;
      2: stateTransition = 11'd268;
      3: stateTransition = 11'd481;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd481;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    379: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd399;
      2: stateTransition = 11'd273;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    380: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd401;
      2: stateTransition = 11'd274;
      3: stateTransition = 11'd402;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd402;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    381: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd403;
      2: stateTransition = 11'd275;
      3: stateTransition = 11'd404;
      4: stateTransition = 11'd404;
      5: stateTransition = 11'd449;
      6: stateTransition = 11'd404;
      7: stateTransition = 11'd404;
      8: stateTransition = 11'd404;
      9: stateTransition = 11'd404;
      10: stateTransition = 11'd405;
      11: stateTransition = 11'd404;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    382: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd368;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    383: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd298;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    384: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd303;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    385: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd309;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    386: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    387: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    388: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    389: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    390: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    391: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    392: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    393: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    394: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    395: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    396: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    397: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    398: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    399: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd367;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    400: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    401: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd371;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd372;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    402: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    403: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    404: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    405: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd300;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    406: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd304;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    407: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd414;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    408: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd418;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    409: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd389;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    410: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    411: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    412: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    413: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd367;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd458;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    414: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    415: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd370;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd463;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    416: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd536;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    417: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd378;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd470;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    418: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd537;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    419: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd381;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    420: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd382;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    421: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd383;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    422: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd382;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    423: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd388;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd387;
      9: stateTransition = 11'd385;
      10: stateTransition = 11'd531;
      11: stateTransition = 11'd385;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    424: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd552;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    425: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd391;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    426: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    427: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd393;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    428: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd394;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    429: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd393;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    430: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd398;
      2: stateTransition = 11'd483;
      3: stateTransition = 11'd483;
      4: stateTransition = 11'd483;
      5: stateTransition = 11'd484;
      6: stateTransition = 11'd483;
      7: stateTransition = 11'd483;
      8: stateTransition = 11'd483;
      9: stateTransition = 11'd483;
      10: stateTransition = 11'd538;
      11: stateTransition = 11'd483;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    431: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd399;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    432: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd400;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    433: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd399;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd539;
      9: stateTransition = 11'd485;
      10: stateTransition = 11'd487;
      11: stateTransition = 11'd485;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    434: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd403;
      2: stateTransition = 11'd404;
      3: stateTransition = 11'd404;
      4: stateTransition = 11'd404;
      5: stateTransition = 11'd449;
      6: stateTransition = 11'd404;
      7: stateTransition = 11'd404;
      8: stateTransition = 11'd404;
      9: stateTransition = 11'd404;
      10: stateTransition = 11'd405;
      11: stateTransition = 11'd404;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    435: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd406;
      2: stateTransition = 11'd489;
      3: stateTransition = 11'd489;
      4: stateTransition = 11'd489;
      5: stateTransition = 11'd490;
      6: stateTransition = 11'd489;
      7: stateTransition = 11'd489;
      8: stateTransition = 11'd489;
      9: stateTransition = 11'd489;
      10: stateTransition = 11'd407;
      11: stateTransition = 11'd489;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    436: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd408;
      2: stateTransition = 11'd491;
      3: stateTransition = 11'd491;
      4: stateTransition = 11'd491;
      5: stateTransition = 11'd492;
      6: stateTransition = 11'd491;
      7: stateTransition = 11'd491;
      8: stateTransition = 11'd491;
      9: stateTransition = 11'd491;
      10: stateTransition = 11'd450;
      11: stateTransition = 11'd491;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    437: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd409;
      2: stateTransition = 11'd491;
      3: stateTransition = 11'd491;
      4: stateTransition = 11'd491;
      5: stateTransition = 11'd492;
      6: stateTransition = 11'd491;
      7: stateTransition = 11'd491;
      8: stateTransition = 11'd491;
      9: stateTransition = 11'd491;
      10: stateTransition = 11'd450;
      11: stateTransition = 11'd491;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    438: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    439: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd411;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    440: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    441: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd415;
      2: stateTransition = 11'd466;
      3: stateTransition = 11'd466;
      4: stateTransition = 11'd466;
      5: stateTransition = 11'd467;
      6: stateTransition = 11'd466;
      7: stateTransition = 11'd466;
      8: stateTransition = 11'd466;
      9: stateTransition = 11'd466;
      10: stateTransition = 11'd468;
      11: stateTransition = 11'd466;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    442: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd416;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    443: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd417;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      9: stateTransition = 11'd474;
      10: stateTransition = 11'd476;
      11: stateTransition = 11'd474;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    444: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd418;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    445: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd419;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      9: stateTransition = 11'd478;
      10: stateTransition = 11'd480;
      11: stateTransition = 11'd478;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    446: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd422;
      2: stateTransition = 11'd422;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    447: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    448: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    449: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    450: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    451: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    452: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd493;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    453: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd545;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    454: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd545;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    455: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd19;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd464;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    456: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd24;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    457: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd54;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd482;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    458: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd460;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    459: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    460: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd152;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd482;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    461: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    462: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd471;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    463: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd88;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd451;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd471;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    464: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    465: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    466: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd457;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    467: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    468: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd97;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd460;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    469: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd106;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    470: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd121;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    471: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd126;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd482;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    472: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd134;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    473: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd143;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    474: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    475: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    476: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    477: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd460;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    478: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd283;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    479: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    480: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    481: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd306;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    482: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd300;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    483: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd304;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    484: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd373;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd482;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      9: stateTransition = 11'd536;
      10: stateTransition = 11'd396;
      11: stateTransition = 11'd536;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    485: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd380;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd544;
      9: stateTransition = 11'd537;
      10: stateTransition = 11'd473;
      11: stateTransition = 11'd537;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    486: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd357;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd534;
      9: stateTransition = 11'd460;
      10: stateTransition = 11'd458;
      11: stateTransition = 11'd458;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    487: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd368;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd535;
      9: stateTransition = 11'd464;
      10: stateTransition = 11'd463;
      11: stateTransition = 11'd463;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    488: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd378;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd562;
      9: stateTransition = 11'd471;
      10: stateTransition = 11'd470;
      11: stateTransition = 11'd470;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    489: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd408;
      2: stateTransition = 11'd491;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd491;
      5: stateTransition = 11'd492;
      6: stateTransition = 11'd491;
      7: stateTransition = 11'd491;
      8: stateTransition = 11'd491;
      9: stateTransition = 11'd491;
      10: stateTransition = 11'd450;
      11: stateTransition = 11'd491;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    490: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd410;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    491: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    492: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    493: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd549;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    494: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd390;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    495: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd462;
      2: stateTransition = 11'd462;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    496: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd545;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    497: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    498: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    499: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd493;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd555;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    500: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    501: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd545;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    502: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd547;
      10: stateTransition = 11'd540;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    503: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd552;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd554;
      9: stateTransition = 11'd552;
      10: stateTransition = 11'd552;
      11: stateTransition = 11'd552;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    504: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    505: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd555;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    506: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd104;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    507: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    508: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd296;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd4;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    509: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd389;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd551;
      9: stateTransition = 11'd556;
      10: stateTransition = 11'd555;
      11: stateTransition = 11'd555;
      12: stateTransition = 11'd0;
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
