`timescale 1ns/1ps

`define ENABLED_REGEX_imap_7 TRUE

module imap_7_verilog(clk,
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


`ifdef ENABLED_REGEX_imap_7

function [7:0] charMap;
  input [7:0] inchar;
  begin
  case( inchar )
    0: charMap = 8'd7;
    1: charMap = 8'd7;
    2: charMap = 8'd7;
    3: charMap = 8'd7;
    4: charMap = 8'd7;
    5: charMap = 8'd7;
    6: charMap = 8'd7;
    7: charMap = 8'd7;
    8: charMap = 8'd7;
    9: charMap = 8'd8;
    10: charMap = 8'd1;
    11: charMap = 8'd8;
    12: charMap = 8'd7;
    13: charMap = 8'd8;
    14: charMap = 8'd7;
    15: charMap = 8'd7;
    16: charMap = 8'd7;
    17: charMap = 8'd7;
    18: charMap = 8'd7;
    19: charMap = 8'd7;
    20: charMap = 8'd7;
    21: charMap = 8'd7;
    22: charMap = 8'd7;
    23: charMap = 8'd7;
    24: charMap = 8'd7;
    25: charMap = 8'd7;
    26: charMap = 8'd7;
    27: charMap = 8'd7;
    28: charMap = 8'd7;
    29: charMap = 8'd7;
    30: charMap = 8'd7;
    31: charMap = 8'd7;
    32: charMap = 8'd8;
    33: charMap = 8'd7;
    34: charMap = 8'd7;
    35: charMap = 8'd7;
    36: charMap = 8'd7;
    37: charMap = 8'd7;
    38: charMap = 8'd7;
    39: charMap = 8'd7;
    40: charMap = 8'd7;
    41: charMap = 8'd7;
    42: charMap = 8'd7;
    43: charMap = 8'd7;
    44: charMap = 8'd7;
    45: charMap = 8'd7;
    46: charMap = 8'd7;
    47: charMap = 8'd7;
    48: charMap = 8'd7;
    49: charMap = 8'd7;
    50: charMap = 8'd7;
    51: charMap = 8'd7;
    52: charMap = 8'd7;
    53: charMap = 8'd7;
    54: charMap = 8'd7;
    55: charMap = 8'd7;
    56: charMap = 8'd7;
    57: charMap = 8'd7;
    58: charMap = 8'd7;
    59: charMap = 8'd7;
    60: charMap = 8'd7;
    61: charMap = 8'd7;
    62: charMap = 8'd7;
    63: charMap = 8'd7;
    64: charMap = 8'd7;
    65: charMap = 8'd5;
    66: charMap = 8'd7;
    67: charMap = 8'd2;
    68: charMap = 8'd7;
    69: charMap = 8'd4;
    70: charMap = 8'd7;
    71: charMap = 8'd7;
    72: charMap = 8'd7;
    73: charMap = 8'd7;
    74: charMap = 8'd7;
    75: charMap = 8'd7;
    76: charMap = 8'd7;
    77: charMap = 8'd7;
    78: charMap = 8'd7;
    79: charMap = 8'd7;
    80: charMap = 8'd7;
    81: charMap = 8'd7;
    82: charMap = 8'd3;
    83: charMap = 8'd7;
    84: charMap = 8'd6;
    85: charMap = 8'd7;
    86: charMap = 8'd7;
    87: charMap = 8'd7;
    88: charMap = 8'd7;
    89: charMap = 8'd7;
    90: charMap = 8'd7;
    91: charMap = 8'd7;
    92: charMap = 8'd7;
    93: charMap = 8'd7;
    94: charMap = 8'd7;
    95: charMap = 8'd7;
    96: charMap = 8'd7;
    97: charMap = 8'd5;
    98: charMap = 8'd7;
    99: charMap = 8'd2;
    100: charMap = 8'd7;
    101: charMap = 8'd4;
    102: charMap = 8'd7;
    103: charMap = 8'd7;
    104: charMap = 8'd7;
    105: charMap = 8'd7;
    106: charMap = 8'd7;
    107: charMap = 8'd7;
    108: charMap = 8'd7;
    109: charMap = 8'd7;
    110: charMap = 8'd7;
    111: charMap = 8'd7;
    112: charMap = 8'd7;
    113: charMap = 8'd7;
    114: charMap = 8'd3;
    115: charMap = 8'd7;
    116: charMap = 8'd6;
    117: charMap = 8'd7;
    118: charMap = 8'd7;
    119: charMap = 8'd7;
    120: charMap = 8'd7;
    121: charMap = 8'd7;
    122: charMap = 8'd7;
    123: charMap = 8'd7;
    124: charMap = 8'd7;
    125: charMap = 8'd7;
    126: charMap = 8'd7;
    127: charMap = 8'd7;
    128: charMap = 8'd7;
    129: charMap = 8'd7;
    130: charMap = 8'd7;
    131: charMap = 8'd7;
    132: charMap = 8'd7;
    133: charMap = 8'd7;
    134: charMap = 8'd7;
    135: charMap = 8'd7;
    136: charMap = 8'd7;
    137: charMap = 8'd7;
    138: charMap = 8'd7;
    139: charMap = 8'd7;
    140: charMap = 8'd7;
    141: charMap = 8'd7;
    142: charMap = 8'd7;
    143: charMap = 8'd7;
    144: charMap = 8'd7;
    145: charMap = 8'd7;
    146: charMap = 8'd7;
    147: charMap = 8'd7;
    148: charMap = 8'd7;
    149: charMap = 8'd7;
    150: charMap = 8'd7;
    151: charMap = 8'd7;
    152: charMap = 8'd7;
    153: charMap = 8'd7;
    154: charMap = 8'd7;
    155: charMap = 8'd7;
    156: charMap = 8'd7;
    157: charMap = 8'd7;
    158: charMap = 8'd7;
    159: charMap = 8'd7;
    160: charMap = 8'd7;
    161: charMap = 8'd7;
    162: charMap = 8'd7;
    163: charMap = 8'd7;
    164: charMap = 8'd7;
    165: charMap = 8'd7;
    166: charMap = 8'd7;
    167: charMap = 8'd7;
    168: charMap = 8'd7;
    169: charMap = 8'd7;
    170: charMap = 8'd7;
    171: charMap = 8'd7;
    172: charMap = 8'd7;
    173: charMap = 8'd7;
    174: charMap = 8'd7;
    175: charMap = 8'd7;
    176: charMap = 8'd7;
    177: charMap = 8'd7;
    178: charMap = 8'd7;
    179: charMap = 8'd7;
    180: charMap = 8'd7;
    181: charMap = 8'd7;
    182: charMap = 8'd7;
    183: charMap = 8'd7;
    184: charMap = 8'd7;
    185: charMap = 8'd7;
    186: charMap = 8'd7;
    187: charMap = 8'd7;
    188: charMap = 8'd7;
    189: charMap = 8'd7;
    190: charMap = 8'd7;
    191: charMap = 8'd7;
    192: charMap = 8'd7;
    193: charMap = 8'd7;
    194: charMap = 8'd7;
    195: charMap = 8'd7;
    196: charMap = 8'd7;
    197: charMap = 8'd7;
    198: charMap = 8'd7;
    199: charMap = 8'd7;
    200: charMap = 8'd7;
    201: charMap = 8'd7;
    202: charMap = 8'd7;
    203: charMap = 8'd7;
    204: charMap = 8'd7;
    205: charMap = 8'd7;
    206: charMap = 8'd7;
    207: charMap = 8'd7;
    208: charMap = 8'd7;
    209: charMap = 8'd7;
    210: charMap = 8'd7;
    211: charMap = 8'd7;
    212: charMap = 8'd7;
    213: charMap = 8'd7;
    214: charMap = 8'd7;
    215: charMap = 8'd7;
    216: charMap = 8'd7;
    217: charMap = 8'd7;
    218: charMap = 8'd7;
    219: charMap = 8'd7;
    220: charMap = 8'd7;
    221: charMap = 8'd7;
    222: charMap = 8'd7;
    223: charMap = 8'd7;
    224: charMap = 8'd7;
    225: charMap = 8'd7;
    226: charMap = 8'd7;
    227: charMap = 8'd7;
    228: charMap = 8'd7;
    229: charMap = 8'd7;
    230: charMap = 8'd7;
    231: charMap = 8'd7;
    232: charMap = 8'd7;
    233: charMap = 8'd7;
    234: charMap = 8'd7;
    235: charMap = 8'd7;
    236: charMap = 8'd7;
    237: charMap = 8'd7;
    238: charMap = 8'd7;
    239: charMap = 8'd7;
    240: charMap = 8'd7;
    241: charMap = 8'd7;
    242: charMap = 8'd7;
    243: charMap = 8'd7;
    244: charMap = 8'd7;
    245: charMap = 8'd7;
    246: charMap = 8'd7;
    247: charMap = 8'd7;
    248: charMap = 8'd7;
    249: charMap = 8'd7;
    250: charMap = 8'd7;
    251: charMap = 8'd7;
    252: charMap = 8'd7;
    253: charMap = 8'd7;
    254: charMap = 8'd7;
    255: charMap = 8'd7;
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
    310: stateMap = 11'd309;
    311: stateMap = 11'd310;
    312: stateMap = 11'd311;
    313: stateMap = 11'd312;
    314: stateMap = 11'd313;
    315: stateMap = 11'd314;
    316: stateMap = 11'd315;
    317: stateMap = 11'd316;
    318: stateMap = 11'd317;
    319: stateMap = 11'd318;
    320: stateMap = 11'd319;
    321: stateMap = 11'd320;
    322: stateMap = 11'd321;
    323: stateMap = 11'd322;
    324: stateMap = 11'd323;
    325: stateMap = 11'd324;
    326: stateMap = 11'd325;
    327: stateMap = 11'd326;
    328: stateMap = 11'd327;
    329: stateMap = 11'd328;
    330: stateMap = 11'd329;
    331: stateMap = 11'd330;
    332: stateMap = 11'd331;
    333: stateMap = 11'd332;
    334: stateMap = 11'd333;
    335: stateMap = 11'd334;
    336: stateMap = 11'd335;
    337: stateMap = 11'd336;
    338: stateMap = 11'd337;
    339: stateMap = 11'd338;
    340: stateMap = 11'd339;
    341: stateMap = 11'd340;
    342: stateMap = 11'd341;
    343: stateMap = 11'd342;
    344: stateMap = 11'd343;
    345: stateMap = 11'd344;
    346: stateMap = 11'd345;
    347: stateMap = 11'd346;
    348: stateMap = 11'd347;
    349: stateMap = 11'd348;
    350: stateMap = 11'd349;
    351: stateMap = 11'd350;
    352: stateMap = 11'd351;
    353: stateMap = 11'd352;
    354: stateMap = 11'd353;
    355: stateMap = 11'd354;
    356: stateMap = 11'd355;
    357: stateMap = 11'd356;
    358: stateMap = 11'd357;
    359: stateMap = 11'd358;
    360: stateMap = 11'd359;
    361: stateMap = 11'd360;
    362: stateMap = 11'd361;
    363: stateMap = 11'd362;
    364: stateMap = 11'd363;
    365: stateMap = 11'd364;
    366: stateMap = 11'd365;
    367: stateMap = 11'd366;
    368: stateMap = 11'd367;
    369: stateMap = 11'd368;
    370: stateMap = 11'd369;
    371: stateMap = 11'd370;
    372: stateMap = 11'd371;
    373: stateMap = 11'd372;
    374: stateMap = 11'd373;
    375: stateMap = 11'd374;
    376: stateMap = 11'd375;
    377: stateMap = 11'd376;
    378: stateMap = 11'd377;
    379: stateMap = 11'd378;
    380: stateMap = 11'd379;
    381: stateMap = 11'd380;
    382: stateMap = 11'd381;
    383: stateMap = 11'd382;
    384: stateMap = 11'd383;
    385: stateMap = 11'd384;
    386: stateMap = 11'd385;
    387: stateMap = 11'd386;
    388: stateMap = 11'd387;
    389: stateMap = 11'd388;
    390: stateMap = 11'd389;
    391: stateMap = 11'd390;
    392: stateMap = 11'd391;
    393: stateMap = 11'd392;
    394: stateMap = 11'd393;
    395: stateMap = 11'd394;
    396: stateMap = 11'd395;
    397: stateMap = 11'd396;
    398: stateMap = 11'd397;
    399: stateMap = 11'd398;
    400: stateMap = 11'd399;
    401: stateMap = 11'd400;
    402: stateMap = 11'd401;
    403: stateMap = 11'd402;
    404: stateMap = 11'd403;
    405: stateMap = 11'd404;
    406: stateMap = 11'd405;
    407: stateMap = 11'd406;
    408: stateMap = 11'd407;
    409: stateMap = 11'd408;
    410: stateMap = 11'd409;
    411: stateMap = 11'd410;
    412: stateMap = 11'd411;
    413: stateMap = 11'd412;
    414: stateMap = 11'd413;
    415: stateMap = 11'd414;
    416: stateMap = 11'd415;
    417: stateMap = 11'd416;
    418: stateMap = 11'd417;
    419: stateMap = 11'd418;
    420: stateMap = 11'd419;
    421: stateMap = 11'd420;
    422: stateMap = 11'd421;
    423: stateMap = 11'd422;
    424: stateMap = 11'd423;
    425: stateMap = 11'd424;
    426: stateMap = 11'd425;
    427: stateMap = 11'd426;
    428: stateMap = 11'd427;
    429: stateMap = 11'd428;
    430: stateMap = 11'd429;
    431: stateMap = 11'd430;
    432: stateMap = 11'd431;
    433: stateMap = 11'd432;
    434: stateMap = 11'd433;
    435: stateMap = 11'd434;
    436: stateMap = 11'd435;
    437: stateMap = 11'd436;
    438: stateMap = 11'd437;
    439: stateMap = 11'd438;
    440: stateMap = 11'd439;
    441: stateMap = 11'd440;
    442: stateMap = 11'd441;
    443: stateMap = 11'd442;
    444: stateMap = 11'd443;
    445: stateMap = 11'd444;
    446: stateMap = 11'd445;
    447: stateMap = 11'd446;
    448: stateMap = 11'd447;
    449: stateMap = 11'd448;
    450: stateMap = 11'd449;
    451: stateMap = 11'd450;
    452: stateMap = 11'd451;
    453: stateMap = 11'd452;
    454: stateMap = 11'd453;
    455: stateMap = 11'd454;
    456: stateMap = 11'd455;
    457: stateMap = 11'd456;
    458: stateMap = 11'd457;
    459: stateMap = 11'd458;
    460: stateMap = 11'd459;
    461: stateMap = 11'd460;
    462: stateMap = 11'd461;
    463: stateMap = 11'd462;
    464: stateMap = 11'd463;
    465: stateMap = 11'd464;
    466: stateMap = 11'd465;
    467: stateMap = 11'd466;
    468: stateMap = 11'd467;
    469: stateMap = 11'd468;
    470: stateMap = 11'd469;
    471: stateMap = 11'd470;
    472: stateMap = 11'd471;
    473: stateMap = 11'd472;
    474: stateMap = 11'd473;
    475: stateMap = 11'd474;
    476: stateMap = 11'd475;
    477: stateMap = 11'd476;
    478: stateMap = 11'd477;
    479: stateMap = 11'd478;
    480: stateMap = 11'd479;
    481: stateMap = 11'd480;
    482: stateMap = 11'd481;
    483: stateMap = 11'd482;
    484: stateMap = 11'd483;
    485: stateMap = 11'd484;
    486: stateMap = 11'd485;
    487: stateMap = 11'd486;
    488: stateMap = 11'd487;
    489: stateMap = 11'd488;
    490: stateMap = 11'd489;
    491: stateMap = 11'd490;
    492: stateMap = 11'd491;
    493: stateMap = 11'd492;
    494: stateMap = 11'd493;
    495: stateMap = 11'd494;
    496: stateMap = 11'd495;
    497: stateMap = 11'd496;
    498: stateMap = 11'd497;
    499: stateMap = 11'd498;
    500: stateMap = 11'd499;
    501: stateMap = 11'd500;
    502: stateMap = 11'd501;
    503: stateMap = 11'd502;
    504: stateMap = 11'd503;
    505: stateMap = 11'd504;
    506: stateMap = 11'd505;
    507: stateMap = 11'd506;
    508: stateMap = 11'd507;
    509: stateMap = 11'd508;
    510: stateMap = 11'd509;
    511: stateMap = 11'd510;
    512: stateMap = 11'd511;
    513: stateMap = 11'd512;
    514: stateMap = 11'd513;
    515: stateMap = 11'd514;
    516: stateMap = 11'd515;
    517: stateMap = 11'd516;
    518: stateMap = 11'd517;
    519: stateMap = 11'd518;
    520: stateMap = 11'd519;
    521: stateMap = 11'd520;
    522: stateMap = 11'd521;
    523: stateMap = 11'd522;
    524: stateMap = 11'd523;
    525: stateMap = 11'd524;
    526: stateMap = 11'd525;
    527: stateMap = 11'd526;
    528: stateMap = 11'd527;
    529: stateMap = 11'd528;
    530: stateMap = 11'd529;
    531: stateMap = 11'd530;
    532: stateMap = 11'd531;
    533: stateMap = 11'd532;
    534: stateMap = 11'd533;
    535: stateMap = 11'd534;
    536: stateMap = 11'd535;
    537: stateMap = 11'd536;
    538: stateMap = 11'd537;
    539: stateMap = 11'd538;
    540: stateMap = 11'd539;
    541: stateMap = 11'd540;
    542: stateMap = 11'd541;
    543: stateMap = 11'd542;
    544: stateMap = 11'd543;
    545: stateMap = 11'd544;
    546: stateMap = 11'd545;
    547: stateMap = 11'd546;
    548: stateMap = 11'd547;
    549: stateMap = 11'd548;
    550: stateMap = 11'd549;
    551: stateMap = 11'd550;
    552: stateMap = 11'd551;
    553: stateMap = 11'd552;
    554: stateMap = 11'd553;
    555: stateMap = 11'd554;
    556: stateMap = 11'd555;
    557: stateMap = 11'd556;
    558: stateMap = 11'd557;
    559: stateMap = 11'd558;
    560: stateMap = 11'd559;
    561: stateMap = 11'd560;
    562: stateMap = 11'd561;
    563: stateMap = 11'd562;
    564: stateMap = 11'd563;
    565: stateMap = 11'd564;
    566: stateMap = 11'd565;
    567: stateMap = 11'd566;
    568: stateMap = 11'd567;
    569: stateMap = 11'd568;
    570: stateMap = 11'd569;
    571: stateMap = 11'd570;
    572: stateMap = 11'd571;
    573: stateMap = 11'd572;
    574: stateMap = 11'd573;
    575: stateMap = 11'd574;
    576: stateMap = 11'd575;
    577: stateMap = 11'd576;
    578: stateMap = 11'd577;
    579: stateMap = 11'd578;
    580: stateMap = 11'd579;
    581: stateMap = 11'd580;
    582: stateMap = 11'd581;
    583: stateMap = 11'd582;
    584: stateMap = 11'd583;
    585: stateMap = 11'd584;
    586: stateMap = 11'd585;
    587: stateMap = 11'd586;
    588: stateMap = 11'd587;
    589: stateMap = 11'd588;
    590: stateMap = 11'd589;
    591: stateMap = 11'd590;
    592: stateMap = 11'd591;
    593: stateMap = 11'd592;
    594: stateMap = 11'd593;
    595: stateMap = 11'd594;
    596: stateMap = 11'd595;
    597: stateMap = 11'd596;
    598: stateMap = 11'd597;
    599: stateMap = 11'd598;
    600: stateMap = 11'd599;
    601: stateMap = 11'd600;
    602: stateMap = 11'd601;
    603: stateMap = 11'd602;
    604: stateMap = 11'd603;
    605: stateMap = 11'd604;
    606: stateMap = 11'd605;
    607: stateMap = 11'd606;
    608: stateMap = 11'd607;
    609: stateMap = 11'd608;
    610: stateMap = 11'd609;
    611: stateMap = 11'd610;
    612: stateMap = 11'd611;
    613: stateMap = 11'd612;
    614: stateMap = 11'd613;
    615: stateMap = 11'd614;
    616: stateMap = 11'd615;
    617: stateMap = 11'd616;
    618: stateMap = 11'd617;
    619: stateMap = 11'd618;
    620: stateMap = 11'd619;
    621: stateMap = 11'd620;
    622: stateMap = 11'd621;
    623: stateMap = 11'd622;
    624: stateMap = 11'd623;
    625: stateMap = 11'd624;
    626: stateMap = 11'd625;
    627: stateMap = 11'd626;
    628: stateMap = 11'd627;
    629: stateMap = 11'd628;
    630: stateMap = 11'd629;
    631: stateMap = 11'd630;
    632: stateMap = 11'd631;
    633: stateMap = 11'd632;
    634: stateMap = 11'd633;
    635: stateMap = 11'd634;
    636: stateMap = 11'd635;
    637: stateMap = 11'd636;
    638: stateMap = 11'd637;
    639: stateMap = 11'd638;
    640: stateMap = 11'd639;
    641: stateMap = 11'd640;
    642: stateMap = 11'd641;
    643: stateMap = 11'd642;
    644: stateMap = 11'd643;
    645: stateMap = 11'd644;
    646: stateMap = 11'd645;
    647: stateMap = 11'd646;
    648: stateMap = 11'd647;
    649: stateMap = 11'd648;
    650: stateMap = 11'd649;
    651: stateMap = 11'd650;
    652: stateMap = 11'd651;
    653: stateMap = 11'd652;
    654: stateMap = 11'd653;
    655: stateMap = 11'd654;
    656: stateMap = 11'd655;
    657: stateMap = 11'd656;
    658: stateMap = 11'd657;
    659: stateMap = 11'd658;
    660: stateMap = 11'd659;
    661: stateMap = 11'd660;
    662: stateMap = 11'd661;
    663: stateMap = 11'd662;
    664: stateMap = 11'd663;
    665: stateMap = 11'd664;
    666: stateMap = 11'd665;
    667: stateMap = 11'd666;
    668: stateMap = 11'd667;
    669: stateMap = 11'd668;
    670: stateMap = 11'd669;
    671: stateMap = 11'd670;
    672: stateMap = 11'd671;
    673: stateMap = 11'd672;
    674: stateMap = 11'd673;
    675: stateMap = 11'd674;
    676: stateMap = 11'd675;
    677: stateMap = 11'd676;
    678: stateMap = 11'd677;
    679: stateMap = 11'd678;
    680: stateMap = 11'd679;
    681: stateMap = 11'd680;
    682: stateMap = 11'd681;
    683: stateMap = 11'd682;
    684: stateMap = 11'd683;
    685: stateMap = 11'd684;
    686: stateMap = 11'd685;
    687: stateMap = 11'd686;
    688: stateMap = 11'd687;
    689: stateMap = 11'd688;
    690: stateMap = 11'd689;
    691: stateMap = 11'd690;
    692: stateMap = 11'd691;
    693: stateMap = 11'd692;
    694: stateMap = 11'd693;
    695: stateMap = 11'd694;
    696: stateMap = 11'd695;
    697: stateMap = 11'd696;
    698: stateMap = 11'd697;
    699: stateMap = 11'd698;
    700: stateMap = 11'd699;
    701: stateMap = 11'd700;
    702: stateMap = 11'd701;
    703: stateMap = 11'd702;
    704: stateMap = 11'd703;
    705: stateMap = 11'd704;
    706: stateMap = 11'd705;
    707: stateMap = 11'd706;
    708: stateMap = 11'd707;
    709: stateMap = 11'd708;
    710: stateMap = 11'd709;
    711: stateMap = 11'd710;
    712: stateMap = 11'd711;
    713: stateMap = 11'd712;
    714: stateMap = 11'd713;
    715: stateMap = 11'd714;
    716: stateMap = 11'd715;
    717: stateMap = 11'd716;
    718: stateMap = 11'd717;
    719: stateMap = 11'd718;
    720: stateMap = 11'd719;
    721: stateMap = 11'd720;
    722: stateMap = 11'd721;
    723: stateMap = 11'd722;
    724: stateMap = 11'd723;
    725: stateMap = 11'd724;
    726: stateMap = 11'd725;
    727: stateMap = 11'd726;
    728: stateMap = 11'd727;
    729: stateMap = 11'd728;
    730: stateMap = 11'd729;
    731: stateMap = 11'd730;
    732: stateMap = 11'd731;
    733: stateMap = 11'd732;
    734: stateMap = 11'd733;
    735: stateMap = 11'd734;
    736: stateMap = 11'd735;
    737: stateMap = 11'd736;
    738: stateMap = 11'd737;
    739: stateMap = 11'd738;
    740: stateMap = 11'd739;
    741: stateMap = 11'd740;
    742: stateMap = 11'd741;
    743: stateMap = 11'd742;
    744: stateMap = 11'd743;
    745: stateMap = 11'd744;
    746: stateMap = 11'd745;
    747: stateMap = 11'd746;
    748: stateMap = 11'd747;
    749: stateMap = 11'd748;
    750: stateMap = 11'd749;
    751: stateMap = 11'd750;
    752: stateMap = 11'd751;
    753: stateMap = 11'd752;
    754: stateMap = 11'd753;
    755: stateMap = 11'd754;
    756: stateMap = 11'd755;
    757: stateMap = 11'd756;
    758: stateMap = 11'd757;
    759: stateMap = 11'd758;
    760: stateMap = 11'd759;
    761: stateMap = 11'd760;
    762: stateMap = 11'd761;
    763: stateMap = 11'd762;
    764: stateMap = 11'd763;
    765: stateMap = 11'd764;
    766: stateMap = 11'd765;
    767: stateMap = 11'd766;
    768: stateMap = 11'd767;
    769: stateMap = 11'd768;
    770: stateMap = 11'd769;
    771: stateMap = 11'd770;
    772: stateMap = 11'd771;
    773: stateMap = 11'd772;
    774: stateMap = 11'd773;
    775: stateMap = 11'd774;
    776: stateMap = 11'd775;
    777: stateMap = 11'd776;
    778: stateMap = 11'd777;
    779: stateMap = 11'd778;
    780: stateMap = 11'd779;
    781: stateMap = 11'd780;
    782: stateMap = 11'd781;
    783: stateMap = 11'd782;
    784: stateMap = 11'd783;
    785: stateMap = 11'd784;
    786: stateMap = 11'd785;
    787: stateMap = 11'd786;
    788: stateMap = 11'd787;
    789: stateMap = 11'd788;
    790: stateMap = 11'd789;
    791: stateMap = 11'd790;
    792: stateMap = 11'd791;
    793: stateMap = 11'd792;
    794: stateMap = 11'd793;
    795: stateMap = 11'd794;
    796: stateMap = 11'd795;
    797: stateMap = 11'd796;
    798: stateMap = 11'd797;
    799: stateMap = 11'd798;
    800: stateMap = 11'd799;
    801: stateMap = 11'd800;
    802: stateMap = 11'd801;
    803: stateMap = 11'd802;
    804: stateMap = 11'd803;
    805: stateMap = 11'd804;
    806: stateMap = 11'd805;
    807: stateMap = 11'd806;
    808: stateMap = 11'd807;
    809: stateMap = 11'd808;
    810: stateMap = 11'd809;
    811: stateMap = 11'd810;
    812: stateMap = 11'd811;
    813: stateMap = 11'd812;
    814: stateMap = 11'd813;
    815: stateMap = 11'd814;
    816: stateMap = 11'd815;
    817: stateMap = 11'd816;
    818: stateMap = 11'd817;
    819: stateMap = 11'd818;
    820: stateMap = 11'd819;
    821: stateMap = 11'd820;
    822: stateMap = 11'd821;
    823: stateMap = 11'd822;
    824: stateMap = 11'd823;
    825: stateMap = 11'd824;
    826: stateMap = 11'd825;
    827: stateMap = 11'd826;
    828: stateMap = 11'd827;
    829: stateMap = 11'd828;
    830: stateMap = 11'd829;
    831: stateMap = 11'd830;
    832: stateMap = 11'd831;
    833: stateMap = 11'd832;
    834: stateMap = 11'd833;
    835: stateMap = 11'd834;
    836: stateMap = 11'd835;
    837: stateMap = 11'd836;
    838: stateMap = 11'd837;
    839: stateMap = 11'd838;
    840: stateMap = 11'd839;
    841: stateMap = 11'd840;
    842: stateMap = 11'd841;
    843: stateMap = 11'd842;
    844: stateMap = 11'd843;
    845: stateMap = 11'd844;
    846: stateMap = 11'd845;
    847: stateMap = 11'd846;
    848: stateMap = 11'd847;
    849: stateMap = 11'd848;
    850: stateMap = 11'd849;
    851: stateMap = 11'd850;
    852: stateMap = 11'd851;
    853: stateMap = 11'd852;
    854: stateMap = 11'd853;
    855: stateMap = 11'd854;
    856: stateMap = 11'd855;
    857: stateMap = 11'd856;
    858: stateMap = 11'd857;
    859: stateMap = 11'd858;
    860: stateMap = 11'd859;
    861: stateMap = 11'd860;
    862: stateMap = 11'd861;
    863: stateMap = 11'd862;
    864: stateMap = 11'd863;
    865: stateMap = 11'd864;
    866: stateMap = 11'd865;
    867: stateMap = 11'd866;
    868: stateMap = 11'd867;
    869: stateMap = 11'd868;
    870: stateMap = 11'd869;
    871: stateMap = 11'd870;
    872: stateMap = 11'd871;
    873: stateMap = 11'd872;
    874: stateMap = 11'd873;
    875: stateMap = 11'd874;
    876: stateMap = 11'd875;
    877: stateMap = 11'd876;
    878: stateMap = 11'd877;
    879: stateMap = 11'd878;
    880: stateMap = 11'd879;
    881: stateMap = 11'd880;
    882: stateMap = 11'd881;
    883: stateMap = 11'd882;
    884: stateMap = 11'd883;
    885: stateMap = 11'd884;
    886: stateMap = 11'd885;
    887: stateMap = 11'd886;
    888: stateMap = 11'd887;
    889: stateMap = 11'd888;
    890: stateMap = 11'd889;
    891: stateMap = 11'd890;
    892: stateMap = 11'd891;
    893: stateMap = 11'd892;
    894: stateMap = 11'd893;
    895: stateMap = 11'd894;
    896: stateMap = 11'd895;
    897: stateMap = 11'd896;
    898: stateMap = 11'd897;
    899: stateMap = 11'd898;
    900: stateMap = 11'd899;
    901: stateMap = 11'd900;
    902: stateMap = 11'd901;
    903: stateMap = 11'd902;
    904: stateMap = 11'd903;
    905: stateMap = 11'd904;
    906: stateMap = 11'd905;
    907: stateMap = 11'd906;
    908: stateMap = 11'd907;
    909: stateMap = 11'd908;
    910: stateMap = 11'd909;
    911: stateMap = 11'd910;
    912: stateMap = 11'd911;
    913: stateMap = 11'd912;
    914: stateMap = 11'd913;
    915: stateMap = 11'd914;
    916: stateMap = 11'd915;
    917: stateMap = 11'd916;
    918: stateMap = 11'd917;
    919: stateMap = 11'd918;
    920: stateMap = 11'd919;
    921: stateMap = 11'd920;
    922: stateMap = 11'd921;
    923: stateMap = 11'd922;
    924: stateMap = 11'd923;
    925: stateMap = 11'd924;
    926: stateMap = 11'd925;
    927: stateMap = 11'd926;
    928: stateMap = 11'd927;
    929: stateMap = 11'd928;
    930: stateMap = 11'd929;
    931: stateMap = 11'd930;
    932: stateMap = 11'd931;
    933: stateMap = 11'd932;
    934: stateMap = 11'd933;
    935: stateMap = 11'd934;
    936: stateMap = 11'd935;
    937: stateMap = 11'd936;
    938: stateMap = 11'd937;
    939: stateMap = 11'd938;
    940: stateMap = 11'd939;
    941: stateMap = 11'd940;
    942: stateMap = 11'd941;
    943: stateMap = 11'd942;
    944: stateMap = 11'd943;
    945: stateMap = 11'd944;
    946: stateMap = 11'd945;
    947: stateMap = 11'd946;
    948: stateMap = 11'd947;
    949: stateMap = 11'd948;
    950: stateMap = 11'd949;
    951: stateMap = 11'd950;
    952: stateMap = 11'd951;
    953: stateMap = 11'd952;
    954: stateMap = 11'd953;
    955: stateMap = 11'd954;
    956: stateMap = 11'd955;
    957: stateMap = 11'd956;
    958: stateMap = 11'd957;
    959: stateMap = 11'd958;
    960: stateMap = 11'd959;
    961: stateMap = 11'd960;
    962: stateMap = 11'd961;
    963: stateMap = 11'd962;
    964: stateMap = 11'd963;
    965: stateMap = 11'd964;
    966: stateMap = 11'd965;
    967: stateMap = 11'd966;
    968: stateMap = 11'd967;
    969: stateMap = 11'd968;
    970: stateMap = 11'd969;
    971: stateMap = 11'd970;
    972: stateMap = 11'd971;
    973: stateMap = 11'd972;
    974: stateMap = 11'd973;
    975: stateMap = 11'd974;
    976: stateMap = 11'd975;
    977: stateMap = 11'd976;
    978: stateMap = 11'd977;
    979: stateMap = 11'd978;
    980: stateMap = 11'd979;
    981: stateMap = 11'd980;
    982: stateMap = 11'd981;
    983: stateMap = 11'd982;
    984: stateMap = 11'd983;
    985: stateMap = 11'd984;
    986: stateMap = 11'd985;
    987: stateMap = 11'd986;
    988: stateMap = 11'd987;
    989: stateMap = 11'd988;
    990: stateMap = 11'd989;
    991: stateMap = 11'd990;
    992: stateMap = 11'd991;
    993: stateMap = 11'd992;
    994: stateMap = 11'd993;
    995: stateMap = 11'd994;
    996: stateMap = 11'd995;
    997: stateMap = 11'd996;
    998: stateMap = 11'd997;
    999: stateMap = 11'd998;
    1000: stateMap = 11'd999;
    1001: stateMap = 11'd1000;
    1002: stateMap = 11'd1001;
    1003: stateMap = 11'd1002;
    1004: stateMap = 11'd1003;
    1005: stateMap = 11'd1004;
    1006: stateMap = 11'd1005;
    1007: stateMap = 11'd1006;
    1008: stateMap = 11'd1007;
    1009: stateMap = 11'd1008;
    1010: stateMap = 11'd1009;
    1011: stateMap = 11'd1010;
    1012: stateMap = 11'd1011;
    1013: stateMap = 11'd1012;
    1014: stateMap = 11'd1013;
    1015: stateMap = 11'd1014;
    1016: stateMap = 11'd1015;
    1017: stateMap = 11'd1016;
    1018: stateMap = 11'd1017;
    1019: stateMap = 11'd1018;
    1020: stateMap = 11'd1019;
    1021: stateMap = 11'd1020;
    1022: stateMap = 11'd1021;
    1023: stateMap = 11'd1022;
    1024: stateMap = 11'd1023;
    1025: stateMap = 11'd1024;
    1026: stateMap = 11'd1025;
    1027: stateMap = 11'd1026;
    1028: stateMap = 11'd1027;
    1029: stateMap = 11'd1028;
    1030: stateMap = 11'd1029;
    1031: stateMap = 11'd1030;
    1032: stateMap = 11'd1031;
    1033: stateMap = 11'd1032;
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
    421: acceptStates = 1'b0;
    422: acceptStates = 1'b0;
    423: acceptStates = 1'b0;
    424: acceptStates = 1'b0;
    425: acceptStates = 1'b0;
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
    451: acceptStates = 1'b0;
    452: acceptStates = 1'b0;
    453: acceptStates = 1'b0;
    454: acceptStates = 1'b0;
    455: acceptStates = 1'b0;
    456: acceptStates = 1'b0;
    457: acceptStates = 1'b0;
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
    549: acceptStates = 1'b0;
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
    563: acceptStates = 1'b0;
    564: acceptStates = 1'b0;
    565: acceptStates = 1'b0;
    566: acceptStates = 1'b0;
    567: acceptStates = 1'b0;
    568: acceptStates = 1'b0;
    569: acceptStates = 1'b0;
    570: acceptStates = 1'b0;
    571: acceptStates = 1'b0;
    572: acceptStates = 1'b0;
    573: acceptStates = 1'b0;
    574: acceptStates = 1'b0;
    575: acceptStates = 1'b0;
    576: acceptStates = 1'b0;
    577: acceptStates = 1'b0;
    578: acceptStates = 1'b0;
    579: acceptStates = 1'b0;
    580: acceptStates = 1'b0;
    581: acceptStates = 1'b0;
    582: acceptStates = 1'b0;
    583: acceptStates = 1'b0;
    584: acceptStates = 1'b0;
    585: acceptStates = 1'b0;
    586: acceptStates = 1'b0;
    587: acceptStates = 1'b0;
    588: acceptStates = 1'b0;
    589: acceptStates = 1'b0;
    590: acceptStates = 1'b0;
    591: acceptStates = 1'b0;
    592: acceptStates = 1'b0;
    593: acceptStates = 1'b0;
    594: acceptStates = 1'b0;
    595: acceptStates = 1'b0;
    596: acceptStates = 1'b0;
    597: acceptStates = 1'b0;
    598: acceptStates = 1'b0;
    599: acceptStates = 1'b0;
    600: acceptStates = 1'b0;
    601: acceptStates = 1'b0;
    602: acceptStates = 1'b0;
    603: acceptStates = 1'b0;
    604: acceptStates = 1'b0;
    605: acceptStates = 1'b0;
    606: acceptStates = 1'b0;
    607: acceptStates = 1'b0;
    608: acceptStates = 1'b0;
    609: acceptStates = 1'b0;
    610: acceptStates = 1'b0;
    611: acceptStates = 1'b0;
    612: acceptStates = 1'b0;
    613: acceptStates = 1'b0;
    614: acceptStates = 1'b0;
    615: acceptStates = 1'b0;
    616: acceptStates = 1'b0;
    617: acceptStates = 1'b0;
    618: acceptStates = 1'b0;
    619: acceptStates = 1'b0;
    620: acceptStates = 1'b0;
    621: acceptStates = 1'b0;
    622: acceptStates = 1'b0;
    623: acceptStates = 1'b0;
    624: acceptStates = 1'b0;
    625: acceptStates = 1'b0;
    626: acceptStates = 1'b0;
    627: acceptStates = 1'b0;
    628: acceptStates = 1'b0;
    629: acceptStates = 1'b0;
    630: acceptStates = 1'b0;
    631: acceptStates = 1'b0;
    632: acceptStates = 1'b0;
    633: acceptStates = 1'b0;
    634: acceptStates = 1'b0;
    635: acceptStates = 1'b0;
    636: acceptStates = 1'b0;
    637: acceptStates = 1'b0;
    638: acceptStates = 1'b0;
    639: acceptStates = 1'b0;
    640: acceptStates = 1'b0;
    641: acceptStates = 1'b0;
    642: acceptStates = 1'b0;
    643: acceptStates = 1'b0;
    644: acceptStates = 1'b0;
    645: acceptStates = 1'b0;
    646: acceptStates = 1'b0;
    647: acceptStates = 1'b0;
    648: acceptStates = 1'b0;
    649: acceptStates = 1'b0;
    650: acceptStates = 1'b0;
    651: acceptStates = 1'b0;
    652: acceptStates = 1'b0;
    653: acceptStates = 1'b0;
    654: acceptStates = 1'b0;
    655: acceptStates = 1'b0;
    656: acceptStates = 1'b0;
    657: acceptStates = 1'b0;
    658: acceptStates = 1'b0;
    659: acceptStates = 1'b0;
    660: acceptStates = 1'b0;
    661: acceptStates = 1'b0;
    662: acceptStates = 1'b0;
    663: acceptStates = 1'b0;
    664: acceptStates = 1'b0;
    665: acceptStates = 1'b0;
    666: acceptStates = 1'b0;
    667: acceptStates = 1'b0;
    668: acceptStates = 1'b0;
    669: acceptStates = 1'b0;
    670: acceptStates = 1'b0;
    671: acceptStates = 1'b0;
    672: acceptStates = 1'b0;
    673: acceptStates = 1'b0;
    674: acceptStates = 1'b0;
    675: acceptStates = 1'b0;
    676: acceptStates = 1'b0;
    677: acceptStates = 1'b0;
    678: acceptStates = 1'b0;
    679: acceptStates = 1'b0;
    680: acceptStates = 1'b0;
    681: acceptStates = 1'b0;
    682: acceptStates = 1'b0;
    683: acceptStates = 1'b0;
    684: acceptStates = 1'b0;
    685: acceptStates = 1'b0;
    686: acceptStates = 1'b0;
    687: acceptStates = 1'b0;
    688: acceptStates = 1'b0;
    689: acceptStates = 1'b0;
    690: acceptStates = 1'b0;
    691: acceptStates = 1'b0;
    692: acceptStates = 1'b0;
    693: acceptStates = 1'b0;
    694: acceptStates = 1'b0;
    695: acceptStates = 1'b0;
    696: acceptStates = 1'b0;
    697: acceptStates = 1'b0;
    698: acceptStates = 1'b0;
    699: acceptStates = 1'b0;
    700: acceptStates = 1'b0;
    701: acceptStates = 1'b0;
    702: acceptStates = 1'b0;
    703: acceptStates = 1'b0;
    704: acceptStates = 1'b0;
    705: acceptStates = 1'b0;
    706: acceptStates = 1'b0;
    707: acceptStates = 1'b0;
    708: acceptStates = 1'b0;
    709: acceptStates = 1'b0;
    710: acceptStates = 1'b0;
    711: acceptStates = 1'b0;
    712: acceptStates = 1'b0;
    713: acceptStates = 1'b0;
    714: acceptStates = 1'b0;
    715: acceptStates = 1'b0;
    716: acceptStates = 1'b0;
    717: acceptStates = 1'b0;
    718: acceptStates = 1'b0;
    719: acceptStates = 1'b0;
    720: acceptStates = 1'b0;
    721: acceptStates = 1'b0;
    722: acceptStates = 1'b0;
    723: acceptStates = 1'b0;
    724: acceptStates = 1'b0;
    725: acceptStates = 1'b0;
    726: acceptStates = 1'b0;
    727: acceptStates = 1'b0;
    728: acceptStates = 1'b0;
    729: acceptStates = 1'b0;
    730: acceptStates = 1'b0;
    731: acceptStates = 1'b0;
    732: acceptStates = 1'b0;
    733: acceptStates = 1'b0;
    734: acceptStates = 1'b0;
    735: acceptStates = 1'b0;
    736: acceptStates = 1'b0;
    737: acceptStates = 1'b0;
    738: acceptStates = 1'b0;
    739: acceptStates = 1'b0;
    740: acceptStates = 1'b0;
    741: acceptStates = 1'b0;
    742: acceptStates = 1'b0;
    743: acceptStates = 1'b0;
    744: acceptStates = 1'b0;
    745: acceptStates = 1'b0;
    746: acceptStates = 1'b0;
    747: acceptStates = 1'b0;
    748: acceptStates = 1'b0;
    749: acceptStates = 1'b0;
    750: acceptStates = 1'b0;
    751: acceptStates = 1'b0;
    752: acceptStates = 1'b0;
    753: acceptStates = 1'b0;
    754: acceptStates = 1'b0;
    755: acceptStates = 1'b0;
    756: acceptStates = 1'b0;
    757: acceptStates = 1'b0;
    758: acceptStates = 1'b0;
    759: acceptStates = 1'b0;
    760: acceptStates = 1'b0;
    761: acceptStates = 1'b0;
    762: acceptStates = 1'b0;
    763: acceptStates = 1'b0;
    764: acceptStates = 1'b0;
    765: acceptStates = 1'b0;
    766: acceptStates = 1'b0;
    767: acceptStates = 1'b0;
    768: acceptStates = 1'b0;
    769: acceptStates = 1'b0;
    770: acceptStates = 1'b0;
    771: acceptStates = 1'b0;
    772: acceptStates = 1'b0;
    773: acceptStates = 1'b0;
    774: acceptStates = 1'b0;
    775: acceptStates = 1'b0;
    776: acceptStates = 1'b0;
    777: acceptStates = 1'b0;
    778: acceptStates = 1'b0;
    779: acceptStates = 1'b0;
    780: acceptStates = 1'b0;
    781: acceptStates = 1'b0;
    782: acceptStates = 1'b0;
    783: acceptStates = 1'b0;
    784: acceptStates = 1'b0;
    785: acceptStates = 1'b0;
    786: acceptStates = 1'b0;
    787: acceptStates = 1'b0;
    788: acceptStates = 1'b0;
    789: acceptStates = 1'b0;
    790: acceptStates = 1'b0;
    791: acceptStates = 1'b0;
    792: acceptStates = 1'b0;
    793: acceptStates = 1'b0;
    794: acceptStates = 1'b0;
    795: acceptStates = 1'b0;
    796: acceptStates = 1'b0;
    797: acceptStates = 1'b0;
    798: acceptStates = 1'b0;
    799: acceptStates = 1'b0;
    800: acceptStates = 1'b0;
    801: acceptStates = 1'b0;
    802: acceptStates = 1'b0;
    803: acceptStates = 1'b0;
    804: acceptStates = 1'b0;
    805: acceptStates = 1'b0;
    806: acceptStates = 1'b0;
    807: acceptStates = 1'b0;
    808: acceptStates = 1'b0;
    809: acceptStates = 1'b0;
    810: acceptStates = 1'b0;
    811: acceptStates = 1'b0;
    812: acceptStates = 1'b0;
    813: acceptStates = 1'b0;
    814: acceptStates = 1'b0;
    815: acceptStates = 1'b0;
    816: acceptStates = 1'b0;
    817: acceptStates = 1'b0;
    818: acceptStates = 1'b0;
    819: acceptStates = 1'b0;
    820: acceptStates = 1'b0;
    821: acceptStates = 1'b0;
    822: acceptStates = 1'b0;
    823: acceptStates = 1'b0;
    824: acceptStates = 1'b0;
    825: acceptStates = 1'b0;
    826: acceptStates = 1'b0;
    827: acceptStates = 1'b0;
    828: acceptStates = 1'b0;
    829: acceptStates = 1'b0;
    830: acceptStates = 1'b0;
    831: acceptStates = 1'b0;
    832: acceptStates = 1'b0;
    833: acceptStates = 1'b0;
    834: acceptStates = 1'b0;
    835: acceptStates = 1'b0;
    836: acceptStates = 1'b0;
    837: acceptStates = 1'b0;
    838: acceptStates = 1'b0;
    839: acceptStates = 1'b0;
    840: acceptStates = 1'b0;
    841: acceptStates = 1'b0;
    842: acceptStates = 1'b0;
    843: acceptStates = 1'b0;
    844: acceptStates = 1'b0;
    845: acceptStates = 1'b0;
    846: acceptStates = 1'b0;
    847: acceptStates = 1'b0;
    848: acceptStates = 1'b0;
    849: acceptStates = 1'b0;
    850: acceptStates = 1'b0;
    851: acceptStates = 1'b0;
    852: acceptStates = 1'b0;
    853: acceptStates = 1'b0;
    854: acceptStates = 1'b0;
    855: acceptStates = 1'b0;
    856: acceptStates = 1'b0;
    857: acceptStates = 1'b0;
    858: acceptStates = 1'b0;
    859: acceptStates = 1'b0;
    860: acceptStates = 1'b0;
    861: acceptStates = 1'b0;
    862: acceptStates = 1'b0;
    863: acceptStates = 1'b0;
    864: acceptStates = 1'b0;
    865: acceptStates = 1'b0;
    866: acceptStates = 1'b0;
    867: acceptStates = 1'b0;
    868: acceptStates = 1'b0;
    869: acceptStates = 1'b0;
    870: acceptStates = 1'b0;
    871: acceptStates = 1'b0;
    872: acceptStates = 1'b0;
    873: acceptStates = 1'b0;
    874: acceptStates = 1'b0;
    875: acceptStates = 1'b0;
    876: acceptStates = 1'b0;
    877: acceptStates = 1'b0;
    878: acceptStates = 1'b0;
    879: acceptStates = 1'b0;
    880: acceptStates = 1'b0;
    881: acceptStates = 1'b0;
    882: acceptStates = 1'b0;
    883: acceptStates = 1'b0;
    884: acceptStates = 1'b0;
    885: acceptStates = 1'b0;
    886: acceptStates = 1'b0;
    887: acceptStates = 1'b0;
    888: acceptStates = 1'b0;
    889: acceptStates = 1'b0;
    890: acceptStates = 1'b0;
    891: acceptStates = 1'b0;
    892: acceptStates = 1'b0;
    893: acceptStates = 1'b0;
    894: acceptStates = 1'b0;
    895: acceptStates = 1'b0;
    896: acceptStates = 1'b0;
    897: acceptStates = 1'b0;
    898: acceptStates = 1'b0;
    899: acceptStates = 1'b0;
    900: acceptStates = 1'b0;
    901: acceptStates = 1'b0;
    902: acceptStates = 1'b0;
    903: acceptStates = 1'b0;
    904: acceptStates = 1'b0;
    905: acceptStates = 1'b0;
    906: acceptStates = 1'b0;
    907: acceptStates = 1'b0;
    908: acceptStates = 1'b0;
    909: acceptStates = 1'b0;
    910: acceptStates = 1'b0;
    911: acceptStates = 1'b0;
    912: acceptStates = 1'b0;
    913: acceptStates = 1'b0;
    914: acceptStates = 1'b0;
    915: acceptStates = 1'b0;
    916: acceptStates = 1'b0;
    917: acceptStates = 1'b0;
    918: acceptStates = 1'b0;
    919: acceptStates = 1'b0;
    920: acceptStates = 1'b0;
    921: acceptStates = 1'b0;
    922: acceptStates = 1'b0;
    923: acceptStates = 1'b0;
    924: acceptStates = 1'b0;
    925: acceptStates = 1'b0;
    926: acceptStates = 1'b0;
    927: acceptStates = 1'b0;
    928: acceptStates = 1'b0;
    929: acceptStates = 1'b0;
    930: acceptStates = 1'b0;
    931: acceptStates = 1'b0;
    932: acceptStates = 1'b0;
    933: acceptStates = 1'b0;
    934: acceptStates = 1'b0;
    935: acceptStates = 1'b0;
    936: acceptStates = 1'b0;
    937: acceptStates = 1'b0;
    938: acceptStates = 1'b0;
    939: acceptStates = 1'b0;
    940: acceptStates = 1'b0;
    941: acceptStates = 1'b0;
    942: acceptStates = 1'b0;
    943: acceptStates = 1'b0;
    944: acceptStates = 1'b0;
    945: acceptStates = 1'b0;
    946: acceptStates = 1'b0;
    947: acceptStates = 1'b0;
    948: acceptStates = 1'b0;
    949: acceptStates = 1'b0;
    950: acceptStates = 1'b0;
    951: acceptStates = 1'b0;
    952: acceptStates = 1'b0;
    953: acceptStates = 1'b0;
    954: acceptStates = 1'b0;
    955: acceptStates = 1'b0;
    956: acceptStates = 1'b0;
    957: acceptStates = 1'b0;
    958: acceptStates = 1'b0;
    959: acceptStates = 1'b0;
    960: acceptStates = 1'b0;
    961: acceptStates = 1'b0;
    962: acceptStates = 1'b0;
    963: acceptStates = 1'b0;
    964: acceptStates = 1'b0;
    965: acceptStates = 1'b0;
    966: acceptStates = 1'b0;
    967: acceptStates = 1'b0;
    968: acceptStates = 1'b0;
    969: acceptStates = 1'b0;
    970: acceptStates = 1'b0;
    971: acceptStates = 1'b0;
    972: acceptStates = 1'b0;
    973: acceptStates = 1'b0;
    974: acceptStates = 1'b0;
    975: acceptStates = 1'b0;
    976: acceptStates = 1'b0;
    977: acceptStates = 1'b0;
    978: acceptStates = 1'b0;
    979: acceptStates = 1'b0;
    980: acceptStates = 1'b0;
    981: acceptStates = 1'b0;
    982: acceptStates = 1'b0;
    983: acceptStates = 1'b0;
    984: acceptStates = 1'b0;
    985: acceptStates = 1'b0;
    986: acceptStates = 1'b0;
    987: acceptStates = 1'b0;
    988: acceptStates = 1'b0;
    989: acceptStates = 1'b0;
    990: acceptStates = 1'b0;
    991: acceptStates = 1'b0;
    992: acceptStates = 1'b0;
    993: acceptStates = 1'b0;
    994: acceptStates = 1'b0;
    995: acceptStates = 1'b0;
    996: acceptStates = 1'b0;
    997: acceptStates = 1'b0;
    998: acceptStates = 1'b0;
    999: acceptStates = 1'b0;
    1000: acceptStates = 1'b0;
    1001: acceptStates = 1'b0;
    1002: acceptStates = 1'b0;
    1003: acceptStates = 1'b0;
    1004: acceptStates = 1'b0;
    1005: acceptStates = 1'b0;
    1006: acceptStates = 1'b0;
    1007: acceptStates = 1'b0;
    1008: acceptStates = 1'b0;
    1009: acceptStates = 1'b0;
    1010: acceptStates = 1'b0;
    1011: acceptStates = 1'b0;
    1012: acceptStates = 1'b0;
    1013: acceptStates = 1'b0;
    1014: acceptStates = 1'b0;
    1015: acceptStates = 1'b0;
    1016: acceptStates = 1'b0;
    1017: acceptStates = 1'b0;
    1018: acceptStates = 1'b0;
    1019: acceptStates = 1'b0;
    1020: acceptStates = 1'b0;
    1021: acceptStates = 1'b0;
    1022: acceptStates = 1'b0;
    1023: acceptStates = 1'b0;
    1024: acceptStates = 1'b0;
    1025: acceptStates = 1'b0;
    1026: acceptStates = 1'b0;
    1027: acceptStates = 1'b0;
    1028: acceptStates = 1'b0;
    1029: acceptStates = 1'b0;
    1030: acceptStates = 1'b0;
    1031: acceptStates = 1'b0;
    1032: acceptStates = 1'b0;
    1033: acceptStates = 1'b0;
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
      8: stateTransition = 11'd3;
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
      default: stateTransition = 11'bX;
    endcase
    7: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd9;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd0;
      default: stateTransition = 11'bX;
    endcase
    8: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd10;
      2: stateTransition = 11'd0;
      3: stateTransition = 11'd0;
      4: stateTransition = 11'd0;
      5: stateTransition = 11'd0;
      6: stateTransition = 11'd0;
      7: stateTransition = 11'd0;
      8: stateTransition = 11'd10;
      default: stateTransition = 11'bX;
    endcase
    9: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1033;
      3: stateTransition = 11'd1033;
      4: stateTransition = 11'd1033;
      5: stateTransition = 11'd1033;
      6: stateTransition = 11'd1033;
      7: stateTransition = 11'd1033;
      8: stateTransition = 11'd1033;
      default: stateTransition = 11'bX;
    endcase
    10: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd2;
      3: stateTransition = 11'd2;
      4: stateTransition = 11'd2;
      5: stateTransition = 11'd2;
      6: stateTransition = 11'd2;
      7: stateTransition = 11'd2;
      8: stateTransition = 11'd2;
      default: stateTransition = 11'bX;
    endcase
    11: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd11;
      3: stateTransition = 11'd11;
      4: stateTransition = 11'd11;
      5: stateTransition = 11'd11;
      6: stateTransition = 11'd11;
      7: stateTransition = 11'd11;
      8: stateTransition = 11'd11;
      default: stateTransition = 11'bX;
    endcase
    12: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd12;
      3: stateTransition = 11'd12;
      4: stateTransition = 11'd12;
      5: stateTransition = 11'd12;
      6: stateTransition = 11'd12;
      7: stateTransition = 11'd12;
      8: stateTransition = 11'd12;
      default: stateTransition = 11'bX;
    endcase
    13: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd13;
      3: stateTransition = 11'd13;
      4: stateTransition = 11'd13;
      5: stateTransition = 11'd13;
      6: stateTransition = 11'd13;
      7: stateTransition = 11'd13;
      8: stateTransition = 11'd13;
      default: stateTransition = 11'bX;
    endcase
    14: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd14;
      3: stateTransition = 11'd14;
      4: stateTransition = 11'd14;
      5: stateTransition = 11'd14;
      6: stateTransition = 11'd14;
      7: stateTransition = 11'd14;
      8: stateTransition = 11'd14;
      default: stateTransition = 11'bX;
    endcase
    15: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd15;
      3: stateTransition = 11'd15;
      4: stateTransition = 11'd15;
      5: stateTransition = 11'd15;
      6: stateTransition = 11'd15;
      7: stateTransition = 11'd15;
      8: stateTransition = 11'd15;
      default: stateTransition = 11'bX;
    endcase
    16: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd16;
      3: stateTransition = 11'd16;
      4: stateTransition = 11'd16;
      5: stateTransition = 11'd16;
      6: stateTransition = 11'd16;
      7: stateTransition = 11'd16;
      8: stateTransition = 11'd16;
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
      default: stateTransition = 11'bX;
    endcase
    115: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd115;
      3: stateTransition = 11'd115;
      4: stateTransition = 11'd115;
      5: stateTransition = 11'd115;
      6: stateTransition = 11'd115;
      7: stateTransition = 11'd115;
      8: stateTransition = 11'd115;
      default: stateTransition = 11'bX;
    endcase
    116: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd116;
      3: stateTransition = 11'd116;
      4: stateTransition = 11'd116;
      5: stateTransition = 11'd116;
      6: stateTransition = 11'd116;
      7: stateTransition = 11'd116;
      8: stateTransition = 11'd116;
      default: stateTransition = 11'bX;
    endcase
    117: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd117;
      3: stateTransition = 11'd117;
      4: stateTransition = 11'd117;
      5: stateTransition = 11'd117;
      6: stateTransition = 11'd117;
      7: stateTransition = 11'd117;
      8: stateTransition = 11'd117;
      default: stateTransition = 11'bX;
    endcase
    118: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd118;
      3: stateTransition = 11'd118;
      4: stateTransition = 11'd118;
      5: stateTransition = 11'd118;
      6: stateTransition = 11'd118;
      7: stateTransition = 11'd118;
      8: stateTransition = 11'd118;
      default: stateTransition = 11'bX;
    endcase
    119: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd119;
      3: stateTransition = 11'd119;
      4: stateTransition = 11'd119;
      5: stateTransition = 11'd119;
      6: stateTransition = 11'd119;
      7: stateTransition = 11'd119;
      8: stateTransition = 11'd119;
      default: stateTransition = 11'bX;
    endcase
    120: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd120;
      3: stateTransition = 11'd120;
      4: stateTransition = 11'd120;
      5: stateTransition = 11'd120;
      6: stateTransition = 11'd120;
      7: stateTransition = 11'd120;
      8: stateTransition = 11'd120;
      default: stateTransition = 11'bX;
    endcase
    121: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd121;
      3: stateTransition = 11'd121;
      4: stateTransition = 11'd121;
      5: stateTransition = 11'd121;
      6: stateTransition = 11'd121;
      7: stateTransition = 11'd121;
      8: stateTransition = 11'd121;
      default: stateTransition = 11'bX;
    endcase
    122: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd122;
      3: stateTransition = 11'd122;
      4: stateTransition = 11'd122;
      5: stateTransition = 11'd122;
      6: stateTransition = 11'd122;
      7: stateTransition = 11'd122;
      8: stateTransition = 11'd122;
      default: stateTransition = 11'bX;
    endcase
    123: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd123;
      3: stateTransition = 11'd123;
      4: stateTransition = 11'd123;
      5: stateTransition = 11'd123;
      6: stateTransition = 11'd123;
      7: stateTransition = 11'd123;
      8: stateTransition = 11'd123;
      default: stateTransition = 11'bX;
    endcase
    124: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd124;
      3: stateTransition = 11'd124;
      4: stateTransition = 11'd124;
      5: stateTransition = 11'd124;
      6: stateTransition = 11'd124;
      7: stateTransition = 11'd124;
      8: stateTransition = 11'd124;
      default: stateTransition = 11'bX;
    endcase
    125: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd125;
      3: stateTransition = 11'd125;
      4: stateTransition = 11'd125;
      5: stateTransition = 11'd125;
      6: stateTransition = 11'd125;
      7: stateTransition = 11'd125;
      8: stateTransition = 11'd125;
      default: stateTransition = 11'bX;
    endcase
    126: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd126;
      3: stateTransition = 11'd126;
      4: stateTransition = 11'd126;
      5: stateTransition = 11'd126;
      6: stateTransition = 11'd126;
      7: stateTransition = 11'd126;
      8: stateTransition = 11'd126;
      default: stateTransition = 11'bX;
    endcase
    127: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd127;
      3: stateTransition = 11'd127;
      4: stateTransition = 11'd127;
      5: stateTransition = 11'd127;
      6: stateTransition = 11'd127;
      7: stateTransition = 11'd127;
      8: stateTransition = 11'd127;
      default: stateTransition = 11'bX;
    endcase
    128: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd128;
      3: stateTransition = 11'd128;
      4: stateTransition = 11'd128;
      5: stateTransition = 11'd128;
      6: stateTransition = 11'd128;
      7: stateTransition = 11'd128;
      8: stateTransition = 11'd128;
      default: stateTransition = 11'bX;
    endcase
    129: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd129;
      3: stateTransition = 11'd129;
      4: stateTransition = 11'd129;
      5: stateTransition = 11'd129;
      6: stateTransition = 11'd129;
      7: stateTransition = 11'd129;
      8: stateTransition = 11'd129;
      default: stateTransition = 11'bX;
    endcase
    130: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd130;
      3: stateTransition = 11'd130;
      4: stateTransition = 11'd130;
      5: stateTransition = 11'd130;
      6: stateTransition = 11'd130;
      7: stateTransition = 11'd130;
      8: stateTransition = 11'd130;
      default: stateTransition = 11'bX;
    endcase
    131: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd131;
      3: stateTransition = 11'd131;
      4: stateTransition = 11'd131;
      5: stateTransition = 11'd131;
      6: stateTransition = 11'd131;
      7: stateTransition = 11'd131;
      8: stateTransition = 11'd131;
      default: stateTransition = 11'bX;
    endcase
    132: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd132;
      3: stateTransition = 11'd132;
      4: stateTransition = 11'd132;
      5: stateTransition = 11'd132;
      6: stateTransition = 11'd132;
      7: stateTransition = 11'd132;
      8: stateTransition = 11'd132;
      default: stateTransition = 11'bX;
    endcase
    133: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd133;
      3: stateTransition = 11'd133;
      4: stateTransition = 11'd133;
      5: stateTransition = 11'd133;
      6: stateTransition = 11'd133;
      7: stateTransition = 11'd133;
      8: stateTransition = 11'd133;
      default: stateTransition = 11'bX;
    endcase
    134: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd134;
      3: stateTransition = 11'd134;
      4: stateTransition = 11'd134;
      5: stateTransition = 11'd134;
      6: stateTransition = 11'd134;
      7: stateTransition = 11'd134;
      8: stateTransition = 11'd134;
      default: stateTransition = 11'bX;
    endcase
    135: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd135;
      3: stateTransition = 11'd135;
      4: stateTransition = 11'd135;
      5: stateTransition = 11'd135;
      6: stateTransition = 11'd135;
      7: stateTransition = 11'd135;
      8: stateTransition = 11'd135;
      default: stateTransition = 11'bX;
    endcase
    136: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd136;
      3: stateTransition = 11'd136;
      4: stateTransition = 11'd136;
      5: stateTransition = 11'd136;
      6: stateTransition = 11'd136;
      7: stateTransition = 11'd136;
      8: stateTransition = 11'd136;
      default: stateTransition = 11'bX;
    endcase
    137: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd137;
      3: stateTransition = 11'd137;
      4: stateTransition = 11'd137;
      5: stateTransition = 11'd137;
      6: stateTransition = 11'd137;
      7: stateTransition = 11'd137;
      8: stateTransition = 11'd137;
      default: stateTransition = 11'bX;
    endcase
    138: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd138;
      3: stateTransition = 11'd138;
      4: stateTransition = 11'd138;
      5: stateTransition = 11'd138;
      6: stateTransition = 11'd138;
      7: stateTransition = 11'd138;
      8: stateTransition = 11'd138;
      default: stateTransition = 11'bX;
    endcase
    139: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd139;
      3: stateTransition = 11'd139;
      4: stateTransition = 11'd139;
      5: stateTransition = 11'd139;
      6: stateTransition = 11'd139;
      7: stateTransition = 11'd139;
      8: stateTransition = 11'd139;
      default: stateTransition = 11'bX;
    endcase
    140: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd140;
      3: stateTransition = 11'd140;
      4: stateTransition = 11'd140;
      5: stateTransition = 11'd140;
      6: stateTransition = 11'd140;
      7: stateTransition = 11'd140;
      8: stateTransition = 11'd140;
      default: stateTransition = 11'bX;
    endcase
    141: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd141;
      3: stateTransition = 11'd141;
      4: stateTransition = 11'd141;
      5: stateTransition = 11'd141;
      6: stateTransition = 11'd141;
      7: stateTransition = 11'd141;
      8: stateTransition = 11'd141;
      default: stateTransition = 11'bX;
    endcase
    142: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd142;
      3: stateTransition = 11'd142;
      4: stateTransition = 11'd142;
      5: stateTransition = 11'd142;
      6: stateTransition = 11'd142;
      7: stateTransition = 11'd142;
      8: stateTransition = 11'd142;
      default: stateTransition = 11'bX;
    endcase
    143: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd143;
      3: stateTransition = 11'd143;
      4: stateTransition = 11'd143;
      5: stateTransition = 11'd143;
      6: stateTransition = 11'd143;
      7: stateTransition = 11'd143;
      8: stateTransition = 11'd143;
      default: stateTransition = 11'bX;
    endcase
    144: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd144;
      3: stateTransition = 11'd144;
      4: stateTransition = 11'd144;
      5: stateTransition = 11'd144;
      6: stateTransition = 11'd144;
      7: stateTransition = 11'd144;
      8: stateTransition = 11'd144;
      default: stateTransition = 11'bX;
    endcase
    145: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd145;
      3: stateTransition = 11'd145;
      4: stateTransition = 11'd145;
      5: stateTransition = 11'd145;
      6: stateTransition = 11'd145;
      7: stateTransition = 11'd145;
      8: stateTransition = 11'd145;
      default: stateTransition = 11'bX;
    endcase
    146: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd146;
      3: stateTransition = 11'd146;
      4: stateTransition = 11'd146;
      5: stateTransition = 11'd146;
      6: stateTransition = 11'd146;
      7: stateTransition = 11'd146;
      8: stateTransition = 11'd146;
      default: stateTransition = 11'bX;
    endcase
    147: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd147;
      3: stateTransition = 11'd147;
      4: stateTransition = 11'd147;
      5: stateTransition = 11'd147;
      6: stateTransition = 11'd147;
      7: stateTransition = 11'd147;
      8: stateTransition = 11'd147;
      default: stateTransition = 11'bX;
    endcase
    148: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd148;
      3: stateTransition = 11'd148;
      4: stateTransition = 11'd148;
      5: stateTransition = 11'd148;
      6: stateTransition = 11'd148;
      7: stateTransition = 11'd148;
      8: stateTransition = 11'd148;
      default: stateTransition = 11'bX;
    endcase
    149: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd149;
      3: stateTransition = 11'd149;
      4: stateTransition = 11'd149;
      5: stateTransition = 11'd149;
      6: stateTransition = 11'd149;
      7: stateTransition = 11'd149;
      8: stateTransition = 11'd149;
      default: stateTransition = 11'bX;
    endcase
    150: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd150;
      3: stateTransition = 11'd150;
      4: stateTransition = 11'd150;
      5: stateTransition = 11'd150;
      6: stateTransition = 11'd150;
      7: stateTransition = 11'd150;
      8: stateTransition = 11'd150;
      default: stateTransition = 11'bX;
    endcase
    151: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd151;
      3: stateTransition = 11'd151;
      4: stateTransition = 11'd151;
      5: stateTransition = 11'd151;
      6: stateTransition = 11'd151;
      7: stateTransition = 11'd151;
      8: stateTransition = 11'd151;
      default: stateTransition = 11'bX;
    endcase
    152: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd152;
      3: stateTransition = 11'd152;
      4: stateTransition = 11'd152;
      5: stateTransition = 11'd152;
      6: stateTransition = 11'd152;
      7: stateTransition = 11'd152;
      8: stateTransition = 11'd152;
      default: stateTransition = 11'bX;
    endcase
    153: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd153;
      3: stateTransition = 11'd153;
      4: stateTransition = 11'd153;
      5: stateTransition = 11'd153;
      6: stateTransition = 11'd153;
      7: stateTransition = 11'd153;
      8: stateTransition = 11'd153;
      default: stateTransition = 11'bX;
    endcase
    154: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd154;
      3: stateTransition = 11'd154;
      4: stateTransition = 11'd154;
      5: stateTransition = 11'd154;
      6: stateTransition = 11'd154;
      7: stateTransition = 11'd154;
      8: stateTransition = 11'd154;
      default: stateTransition = 11'bX;
    endcase
    155: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd155;
      3: stateTransition = 11'd155;
      4: stateTransition = 11'd155;
      5: stateTransition = 11'd155;
      6: stateTransition = 11'd155;
      7: stateTransition = 11'd155;
      8: stateTransition = 11'd155;
      default: stateTransition = 11'bX;
    endcase
    156: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd156;
      3: stateTransition = 11'd156;
      4: stateTransition = 11'd156;
      5: stateTransition = 11'd156;
      6: stateTransition = 11'd156;
      7: stateTransition = 11'd156;
      8: stateTransition = 11'd156;
      default: stateTransition = 11'bX;
    endcase
    157: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd157;
      3: stateTransition = 11'd157;
      4: stateTransition = 11'd157;
      5: stateTransition = 11'd157;
      6: stateTransition = 11'd157;
      7: stateTransition = 11'd157;
      8: stateTransition = 11'd157;
      default: stateTransition = 11'bX;
    endcase
    158: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd158;
      3: stateTransition = 11'd158;
      4: stateTransition = 11'd158;
      5: stateTransition = 11'd158;
      6: stateTransition = 11'd158;
      7: stateTransition = 11'd158;
      8: stateTransition = 11'd158;
      default: stateTransition = 11'bX;
    endcase
    159: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd159;
      3: stateTransition = 11'd159;
      4: stateTransition = 11'd159;
      5: stateTransition = 11'd159;
      6: stateTransition = 11'd159;
      7: stateTransition = 11'd159;
      8: stateTransition = 11'd159;
      default: stateTransition = 11'bX;
    endcase
    160: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd160;
      3: stateTransition = 11'd160;
      4: stateTransition = 11'd160;
      5: stateTransition = 11'd160;
      6: stateTransition = 11'd160;
      7: stateTransition = 11'd160;
      8: stateTransition = 11'd160;
      default: stateTransition = 11'bX;
    endcase
    161: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd161;
      3: stateTransition = 11'd161;
      4: stateTransition = 11'd161;
      5: stateTransition = 11'd161;
      6: stateTransition = 11'd161;
      7: stateTransition = 11'd161;
      8: stateTransition = 11'd161;
      default: stateTransition = 11'bX;
    endcase
    162: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd162;
      3: stateTransition = 11'd162;
      4: stateTransition = 11'd162;
      5: stateTransition = 11'd162;
      6: stateTransition = 11'd162;
      7: stateTransition = 11'd162;
      8: stateTransition = 11'd162;
      default: stateTransition = 11'bX;
    endcase
    163: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd163;
      3: stateTransition = 11'd163;
      4: stateTransition = 11'd163;
      5: stateTransition = 11'd163;
      6: stateTransition = 11'd163;
      7: stateTransition = 11'd163;
      8: stateTransition = 11'd163;
      default: stateTransition = 11'bX;
    endcase
    164: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd164;
      3: stateTransition = 11'd164;
      4: stateTransition = 11'd164;
      5: stateTransition = 11'd164;
      6: stateTransition = 11'd164;
      7: stateTransition = 11'd164;
      8: stateTransition = 11'd164;
      default: stateTransition = 11'bX;
    endcase
    165: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd165;
      3: stateTransition = 11'd165;
      4: stateTransition = 11'd165;
      5: stateTransition = 11'd165;
      6: stateTransition = 11'd165;
      7: stateTransition = 11'd165;
      8: stateTransition = 11'd165;
      default: stateTransition = 11'bX;
    endcase
    166: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd166;
      3: stateTransition = 11'd166;
      4: stateTransition = 11'd166;
      5: stateTransition = 11'd166;
      6: stateTransition = 11'd166;
      7: stateTransition = 11'd166;
      8: stateTransition = 11'd166;
      default: stateTransition = 11'bX;
    endcase
    167: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd167;
      3: stateTransition = 11'd167;
      4: stateTransition = 11'd167;
      5: stateTransition = 11'd167;
      6: stateTransition = 11'd167;
      7: stateTransition = 11'd167;
      8: stateTransition = 11'd167;
      default: stateTransition = 11'bX;
    endcase
    168: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd168;
      3: stateTransition = 11'd168;
      4: stateTransition = 11'd168;
      5: stateTransition = 11'd168;
      6: stateTransition = 11'd168;
      7: stateTransition = 11'd168;
      8: stateTransition = 11'd168;
      default: stateTransition = 11'bX;
    endcase
    169: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd169;
      3: stateTransition = 11'd169;
      4: stateTransition = 11'd169;
      5: stateTransition = 11'd169;
      6: stateTransition = 11'd169;
      7: stateTransition = 11'd169;
      8: stateTransition = 11'd169;
      default: stateTransition = 11'bX;
    endcase
    170: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd170;
      3: stateTransition = 11'd170;
      4: stateTransition = 11'd170;
      5: stateTransition = 11'd170;
      6: stateTransition = 11'd170;
      7: stateTransition = 11'd170;
      8: stateTransition = 11'd170;
      default: stateTransition = 11'bX;
    endcase
    171: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd171;
      3: stateTransition = 11'd171;
      4: stateTransition = 11'd171;
      5: stateTransition = 11'd171;
      6: stateTransition = 11'd171;
      7: stateTransition = 11'd171;
      8: stateTransition = 11'd171;
      default: stateTransition = 11'bX;
    endcase
    172: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd172;
      3: stateTransition = 11'd172;
      4: stateTransition = 11'd172;
      5: stateTransition = 11'd172;
      6: stateTransition = 11'd172;
      7: stateTransition = 11'd172;
      8: stateTransition = 11'd172;
      default: stateTransition = 11'bX;
    endcase
    173: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd173;
      3: stateTransition = 11'd173;
      4: stateTransition = 11'd173;
      5: stateTransition = 11'd173;
      6: stateTransition = 11'd173;
      7: stateTransition = 11'd173;
      8: stateTransition = 11'd173;
      default: stateTransition = 11'bX;
    endcase
    174: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd174;
      3: stateTransition = 11'd174;
      4: stateTransition = 11'd174;
      5: stateTransition = 11'd174;
      6: stateTransition = 11'd174;
      7: stateTransition = 11'd174;
      8: stateTransition = 11'd174;
      default: stateTransition = 11'bX;
    endcase
    175: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd175;
      3: stateTransition = 11'd175;
      4: stateTransition = 11'd175;
      5: stateTransition = 11'd175;
      6: stateTransition = 11'd175;
      7: stateTransition = 11'd175;
      8: stateTransition = 11'd175;
      default: stateTransition = 11'bX;
    endcase
    176: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd176;
      3: stateTransition = 11'd176;
      4: stateTransition = 11'd176;
      5: stateTransition = 11'd176;
      6: stateTransition = 11'd176;
      7: stateTransition = 11'd176;
      8: stateTransition = 11'd176;
      default: stateTransition = 11'bX;
    endcase
    177: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd177;
      3: stateTransition = 11'd177;
      4: stateTransition = 11'd177;
      5: stateTransition = 11'd177;
      6: stateTransition = 11'd177;
      7: stateTransition = 11'd177;
      8: stateTransition = 11'd177;
      default: stateTransition = 11'bX;
    endcase
    178: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd178;
      3: stateTransition = 11'd178;
      4: stateTransition = 11'd178;
      5: stateTransition = 11'd178;
      6: stateTransition = 11'd178;
      7: stateTransition = 11'd178;
      8: stateTransition = 11'd178;
      default: stateTransition = 11'bX;
    endcase
    179: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd179;
      3: stateTransition = 11'd179;
      4: stateTransition = 11'd179;
      5: stateTransition = 11'd179;
      6: stateTransition = 11'd179;
      7: stateTransition = 11'd179;
      8: stateTransition = 11'd179;
      default: stateTransition = 11'bX;
    endcase
    180: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd180;
      3: stateTransition = 11'd180;
      4: stateTransition = 11'd180;
      5: stateTransition = 11'd180;
      6: stateTransition = 11'd180;
      7: stateTransition = 11'd180;
      8: stateTransition = 11'd180;
      default: stateTransition = 11'bX;
    endcase
    181: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd181;
      3: stateTransition = 11'd181;
      4: stateTransition = 11'd181;
      5: stateTransition = 11'd181;
      6: stateTransition = 11'd181;
      7: stateTransition = 11'd181;
      8: stateTransition = 11'd181;
      default: stateTransition = 11'bX;
    endcase
    182: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd182;
      3: stateTransition = 11'd182;
      4: stateTransition = 11'd182;
      5: stateTransition = 11'd182;
      6: stateTransition = 11'd182;
      7: stateTransition = 11'd182;
      8: stateTransition = 11'd182;
      default: stateTransition = 11'bX;
    endcase
    183: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd183;
      3: stateTransition = 11'd183;
      4: stateTransition = 11'd183;
      5: stateTransition = 11'd183;
      6: stateTransition = 11'd183;
      7: stateTransition = 11'd183;
      8: stateTransition = 11'd183;
      default: stateTransition = 11'bX;
    endcase
    184: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd184;
      3: stateTransition = 11'd184;
      4: stateTransition = 11'd184;
      5: stateTransition = 11'd184;
      6: stateTransition = 11'd184;
      7: stateTransition = 11'd184;
      8: stateTransition = 11'd184;
      default: stateTransition = 11'bX;
    endcase
    185: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd185;
      3: stateTransition = 11'd185;
      4: stateTransition = 11'd185;
      5: stateTransition = 11'd185;
      6: stateTransition = 11'd185;
      7: stateTransition = 11'd185;
      8: stateTransition = 11'd185;
      default: stateTransition = 11'bX;
    endcase
    186: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd186;
      3: stateTransition = 11'd186;
      4: stateTransition = 11'd186;
      5: stateTransition = 11'd186;
      6: stateTransition = 11'd186;
      7: stateTransition = 11'd186;
      8: stateTransition = 11'd186;
      default: stateTransition = 11'bX;
    endcase
    187: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd187;
      3: stateTransition = 11'd187;
      4: stateTransition = 11'd187;
      5: stateTransition = 11'd187;
      6: stateTransition = 11'd187;
      7: stateTransition = 11'd187;
      8: stateTransition = 11'd187;
      default: stateTransition = 11'bX;
    endcase
    188: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd188;
      3: stateTransition = 11'd188;
      4: stateTransition = 11'd188;
      5: stateTransition = 11'd188;
      6: stateTransition = 11'd188;
      7: stateTransition = 11'd188;
      8: stateTransition = 11'd188;
      default: stateTransition = 11'bX;
    endcase
    189: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd189;
      3: stateTransition = 11'd189;
      4: stateTransition = 11'd189;
      5: stateTransition = 11'd189;
      6: stateTransition = 11'd189;
      7: stateTransition = 11'd189;
      8: stateTransition = 11'd189;
      default: stateTransition = 11'bX;
    endcase
    190: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd190;
      3: stateTransition = 11'd190;
      4: stateTransition = 11'd190;
      5: stateTransition = 11'd190;
      6: stateTransition = 11'd190;
      7: stateTransition = 11'd190;
      8: stateTransition = 11'd190;
      default: stateTransition = 11'bX;
    endcase
    191: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd191;
      3: stateTransition = 11'd191;
      4: stateTransition = 11'd191;
      5: stateTransition = 11'd191;
      6: stateTransition = 11'd191;
      7: stateTransition = 11'd191;
      8: stateTransition = 11'd191;
      default: stateTransition = 11'bX;
    endcase
    192: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd192;
      3: stateTransition = 11'd192;
      4: stateTransition = 11'd192;
      5: stateTransition = 11'd192;
      6: stateTransition = 11'd192;
      7: stateTransition = 11'd192;
      8: stateTransition = 11'd192;
      default: stateTransition = 11'bX;
    endcase
    193: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd193;
      3: stateTransition = 11'd193;
      4: stateTransition = 11'd193;
      5: stateTransition = 11'd193;
      6: stateTransition = 11'd193;
      7: stateTransition = 11'd193;
      8: stateTransition = 11'd193;
      default: stateTransition = 11'bX;
    endcase
    194: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd194;
      3: stateTransition = 11'd194;
      4: stateTransition = 11'd194;
      5: stateTransition = 11'd194;
      6: stateTransition = 11'd194;
      7: stateTransition = 11'd194;
      8: stateTransition = 11'd194;
      default: stateTransition = 11'bX;
    endcase
    195: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd195;
      3: stateTransition = 11'd195;
      4: stateTransition = 11'd195;
      5: stateTransition = 11'd195;
      6: stateTransition = 11'd195;
      7: stateTransition = 11'd195;
      8: stateTransition = 11'd195;
      default: stateTransition = 11'bX;
    endcase
    196: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd196;
      3: stateTransition = 11'd196;
      4: stateTransition = 11'd196;
      5: stateTransition = 11'd196;
      6: stateTransition = 11'd196;
      7: stateTransition = 11'd196;
      8: stateTransition = 11'd196;
      default: stateTransition = 11'bX;
    endcase
    197: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd197;
      3: stateTransition = 11'd197;
      4: stateTransition = 11'd197;
      5: stateTransition = 11'd197;
      6: stateTransition = 11'd197;
      7: stateTransition = 11'd197;
      8: stateTransition = 11'd197;
      default: stateTransition = 11'bX;
    endcase
    198: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd198;
      3: stateTransition = 11'd198;
      4: stateTransition = 11'd198;
      5: stateTransition = 11'd198;
      6: stateTransition = 11'd198;
      7: stateTransition = 11'd198;
      8: stateTransition = 11'd198;
      default: stateTransition = 11'bX;
    endcase
    199: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd199;
      3: stateTransition = 11'd199;
      4: stateTransition = 11'd199;
      5: stateTransition = 11'd199;
      6: stateTransition = 11'd199;
      7: stateTransition = 11'd199;
      8: stateTransition = 11'd199;
      default: stateTransition = 11'bX;
    endcase
    200: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd200;
      3: stateTransition = 11'd200;
      4: stateTransition = 11'd200;
      5: stateTransition = 11'd200;
      6: stateTransition = 11'd200;
      7: stateTransition = 11'd200;
      8: stateTransition = 11'd200;
      default: stateTransition = 11'bX;
    endcase
    201: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd201;
      3: stateTransition = 11'd201;
      4: stateTransition = 11'd201;
      5: stateTransition = 11'd201;
      6: stateTransition = 11'd201;
      7: stateTransition = 11'd201;
      8: stateTransition = 11'd201;
      default: stateTransition = 11'bX;
    endcase
    202: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd202;
      3: stateTransition = 11'd202;
      4: stateTransition = 11'd202;
      5: stateTransition = 11'd202;
      6: stateTransition = 11'd202;
      7: stateTransition = 11'd202;
      8: stateTransition = 11'd202;
      default: stateTransition = 11'bX;
    endcase
    203: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd203;
      3: stateTransition = 11'd203;
      4: stateTransition = 11'd203;
      5: stateTransition = 11'd203;
      6: stateTransition = 11'd203;
      7: stateTransition = 11'd203;
      8: stateTransition = 11'd203;
      default: stateTransition = 11'bX;
    endcase
    204: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd204;
      3: stateTransition = 11'd204;
      4: stateTransition = 11'd204;
      5: stateTransition = 11'd204;
      6: stateTransition = 11'd204;
      7: stateTransition = 11'd204;
      8: stateTransition = 11'd204;
      default: stateTransition = 11'bX;
    endcase
    205: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd205;
      3: stateTransition = 11'd205;
      4: stateTransition = 11'd205;
      5: stateTransition = 11'd205;
      6: stateTransition = 11'd205;
      7: stateTransition = 11'd205;
      8: stateTransition = 11'd205;
      default: stateTransition = 11'bX;
    endcase
    206: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd206;
      3: stateTransition = 11'd206;
      4: stateTransition = 11'd206;
      5: stateTransition = 11'd206;
      6: stateTransition = 11'd206;
      7: stateTransition = 11'd206;
      8: stateTransition = 11'd206;
      default: stateTransition = 11'bX;
    endcase
    207: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd207;
      3: stateTransition = 11'd207;
      4: stateTransition = 11'd207;
      5: stateTransition = 11'd207;
      6: stateTransition = 11'd207;
      7: stateTransition = 11'd207;
      8: stateTransition = 11'd207;
      default: stateTransition = 11'bX;
    endcase
    208: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd208;
      3: stateTransition = 11'd208;
      4: stateTransition = 11'd208;
      5: stateTransition = 11'd208;
      6: stateTransition = 11'd208;
      7: stateTransition = 11'd208;
      8: stateTransition = 11'd208;
      default: stateTransition = 11'bX;
    endcase
    209: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd209;
      3: stateTransition = 11'd209;
      4: stateTransition = 11'd209;
      5: stateTransition = 11'd209;
      6: stateTransition = 11'd209;
      7: stateTransition = 11'd209;
      8: stateTransition = 11'd209;
      default: stateTransition = 11'bX;
    endcase
    210: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd210;
      3: stateTransition = 11'd210;
      4: stateTransition = 11'd210;
      5: stateTransition = 11'd210;
      6: stateTransition = 11'd210;
      7: stateTransition = 11'd210;
      8: stateTransition = 11'd210;
      default: stateTransition = 11'bX;
    endcase
    211: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd211;
      3: stateTransition = 11'd211;
      4: stateTransition = 11'd211;
      5: stateTransition = 11'd211;
      6: stateTransition = 11'd211;
      7: stateTransition = 11'd211;
      8: stateTransition = 11'd211;
      default: stateTransition = 11'bX;
    endcase
    212: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd212;
      3: stateTransition = 11'd212;
      4: stateTransition = 11'd212;
      5: stateTransition = 11'd212;
      6: stateTransition = 11'd212;
      7: stateTransition = 11'd212;
      8: stateTransition = 11'd212;
      default: stateTransition = 11'bX;
    endcase
    213: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd213;
      3: stateTransition = 11'd213;
      4: stateTransition = 11'd213;
      5: stateTransition = 11'd213;
      6: stateTransition = 11'd213;
      7: stateTransition = 11'd213;
      8: stateTransition = 11'd213;
      default: stateTransition = 11'bX;
    endcase
    214: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd214;
      3: stateTransition = 11'd214;
      4: stateTransition = 11'd214;
      5: stateTransition = 11'd214;
      6: stateTransition = 11'd214;
      7: stateTransition = 11'd214;
      8: stateTransition = 11'd214;
      default: stateTransition = 11'bX;
    endcase
    215: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd215;
      3: stateTransition = 11'd215;
      4: stateTransition = 11'd215;
      5: stateTransition = 11'd215;
      6: stateTransition = 11'd215;
      7: stateTransition = 11'd215;
      8: stateTransition = 11'd215;
      default: stateTransition = 11'bX;
    endcase
    216: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd216;
      3: stateTransition = 11'd216;
      4: stateTransition = 11'd216;
      5: stateTransition = 11'd216;
      6: stateTransition = 11'd216;
      7: stateTransition = 11'd216;
      8: stateTransition = 11'd216;
      default: stateTransition = 11'bX;
    endcase
    217: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd217;
      3: stateTransition = 11'd217;
      4: stateTransition = 11'd217;
      5: stateTransition = 11'd217;
      6: stateTransition = 11'd217;
      7: stateTransition = 11'd217;
      8: stateTransition = 11'd217;
      default: stateTransition = 11'bX;
    endcase
    218: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd218;
      3: stateTransition = 11'd218;
      4: stateTransition = 11'd218;
      5: stateTransition = 11'd218;
      6: stateTransition = 11'd218;
      7: stateTransition = 11'd218;
      8: stateTransition = 11'd218;
      default: stateTransition = 11'bX;
    endcase
    219: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd219;
      3: stateTransition = 11'd219;
      4: stateTransition = 11'd219;
      5: stateTransition = 11'd219;
      6: stateTransition = 11'd219;
      7: stateTransition = 11'd219;
      8: stateTransition = 11'd219;
      default: stateTransition = 11'bX;
    endcase
    220: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd220;
      3: stateTransition = 11'd220;
      4: stateTransition = 11'd220;
      5: stateTransition = 11'd220;
      6: stateTransition = 11'd220;
      7: stateTransition = 11'd220;
      8: stateTransition = 11'd220;
      default: stateTransition = 11'bX;
    endcase
    221: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd221;
      3: stateTransition = 11'd221;
      4: stateTransition = 11'd221;
      5: stateTransition = 11'd221;
      6: stateTransition = 11'd221;
      7: stateTransition = 11'd221;
      8: stateTransition = 11'd221;
      default: stateTransition = 11'bX;
    endcase
    222: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd222;
      3: stateTransition = 11'd222;
      4: stateTransition = 11'd222;
      5: stateTransition = 11'd222;
      6: stateTransition = 11'd222;
      7: stateTransition = 11'd222;
      8: stateTransition = 11'd222;
      default: stateTransition = 11'bX;
    endcase
    223: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd223;
      3: stateTransition = 11'd223;
      4: stateTransition = 11'd223;
      5: stateTransition = 11'd223;
      6: stateTransition = 11'd223;
      7: stateTransition = 11'd223;
      8: stateTransition = 11'd223;
      default: stateTransition = 11'bX;
    endcase
    224: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd224;
      3: stateTransition = 11'd224;
      4: stateTransition = 11'd224;
      5: stateTransition = 11'd224;
      6: stateTransition = 11'd224;
      7: stateTransition = 11'd224;
      8: stateTransition = 11'd224;
      default: stateTransition = 11'bX;
    endcase
    225: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd225;
      3: stateTransition = 11'd225;
      4: stateTransition = 11'd225;
      5: stateTransition = 11'd225;
      6: stateTransition = 11'd225;
      7: stateTransition = 11'd225;
      8: stateTransition = 11'd225;
      default: stateTransition = 11'bX;
    endcase
    226: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd226;
      3: stateTransition = 11'd226;
      4: stateTransition = 11'd226;
      5: stateTransition = 11'd226;
      6: stateTransition = 11'd226;
      7: stateTransition = 11'd226;
      8: stateTransition = 11'd226;
      default: stateTransition = 11'bX;
    endcase
    227: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd227;
      3: stateTransition = 11'd227;
      4: stateTransition = 11'd227;
      5: stateTransition = 11'd227;
      6: stateTransition = 11'd227;
      7: stateTransition = 11'd227;
      8: stateTransition = 11'd227;
      default: stateTransition = 11'bX;
    endcase
    228: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd228;
      3: stateTransition = 11'd228;
      4: stateTransition = 11'd228;
      5: stateTransition = 11'd228;
      6: stateTransition = 11'd228;
      7: stateTransition = 11'd228;
      8: stateTransition = 11'd228;
      default: stateTransition = 11'bX;
    endcase
    229: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd229;
      3: stateTransition = 11'd229;
      4: stateTransition = 11'd229;
      5: stateTransition = 11'd229;
      6: stateTransition = 11'd229;
      7: stateTransition = 11'd229;
      8: stateTransition = 11'd229;
      default: stateTransition = 11'bX;
    endcase
    230: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd230;
      3: stateTransition = 11'd230;
      4: stateTransition = 11'd230;
      5: stateTransition = 11'd230;
      6: stateTransition = 11'd230;
      7: stateTransition = 11'd230;
      8: stateTransition = 11'd230;
      default: stateTransition = 11'bX;
    endcase
    231: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd231;
      3: stateTransition = 11'd231;
      4: stateTransition = 11'd231;
      5: stateTransition = 11'd231;
      6: stateTransition = 11'd231;
      7: stateTransition = 11'd231;
      8: stateTransition = 11'd231;
      default: stateTransition = 11'bX;
    endcase
    232: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd232;
      3: stateTransition = 11'd232;
      4: stateTransition = 11'd232;
      5: stateTransition = 11'd232;
      6: stateTransition = 11'd232;
      7: stateTransition = 11'd232;
      8: stateTransition = 11'd232;
      default: stateTransition = 11'bX;
    endcase
    233: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd233;
      3: stateTransition = 11'd233;
      4: stateTransition = 11'd233;
      5: stateTransition = 11'd233;
      6: stateTransition = 11'd233;
      7: stateTransition = 11'd233;
      8: stateTransition = 11'd233;
      default: stateTransition = 11'bX;
    endcase
    234: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd234;
      3: stateTransition = 11'd234;
      4: stateTransition = 11'd234;
      5: stateTransition = 11'd234;
      6: stateTransition = 11'd234;
      7: stateTransition = 11'd234;
      8: stateTransition = 11'd234;
      default: stateTransition = 11'bX;
    endcase
    235: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd235;
      3: stateTransition = 11'd235;
      4: stateTransition = 11'd235;
      5: stateTransition = 11'd235;
      6: stateTransition = 11'd235;
      7: stateTransition = 11'd235;
      8: stateTransition = 11'd235;
      default: stateTransition = 11'bX;
    endcase
    236: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd236;
      3: stateTransition = 11'd236;
      4: stateTransition = 11'd236;
      5: stateTransition = 11'd236;
      6: stateTransition = 11'd236;
      7: stateTransition = 11'd236;
      8: stateTransition = 11'd236;
      default: stateTransition = 11'bX;
    endcase
    237: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd237;
      3: stateTransition = 11'd237;
      4: stateTransition = 11'd237;
      5: stateTransition = 11'd237;
      6: stateTransition = 11'd237;
      7: stateTransition = 11'd237;
      8: stateTransition = 11'd237;
      default: stateTransition = 11'bX;
    endcase
    238: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd238;
      3: stateTransition = 11'd238;
      4: stateTransition = 11'd238;
      5: stateTransition = 11'd238;
      6: stateTransition = 11'd238;
      7: stateTransition = 11'd238;
      8: stateTransition = 11'd238;
      default: stateTransition = 11'bX;
    endcase
    239: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd239;
      3: stateTransition = 11'd239;
      4: stateTransition = 11'd239;
      5: stateTransition = 11'd239;
      6: stateTransition = 11'd239;
      7: stateTransition = 11'd239;
      8: stateTransition = 11'd239;
      default: stateTransition = 11'bX;
    endcase
    240: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd240;
      3: stateTransition = 11'd240;
      4: stateTransition = 11'd240;
      5: stateTransition = 11'd240;
      6: stateTransition = 11'd240;
      7: stateTransition = 11'd240;
      8: stateTransition = 11'd240;
      default: stateTransition = 11'bX;
    endcase
    241: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd241;
      3: stateTransition = 11'd241;
      4: stateTransition = 11'd241;
      5: stateTransition = 11'd241;
      6: stateTransition = 11'd241;
      7: stateTransition = 11'd241;
      8: stateTransition = 11'd241;
      default: stateTransition = 11'bX;
    endcase
    242: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd242;
      3: stateTransition = 11'd242;
      4: stateTransition = 11'd242;
      5: stateTransition = 11'd242;
      6: stateTransition = 11'd242;
      7: stateTransition = 11'd242;
      8: stateTransition = 11'd242;
      default: stateTransition = 11'bX;
    endcase
    243: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd243;
      3: stateTransition = 11'd243;
      4: stateTransition = 11'd243;
      5: stateTransition = 11'd243;
      6: stateTransition = 11'd243;
      7: stateTransition = 11'd243;
      8: stateTransition = 11'd243;
      default: stateTransition = 11'bX;
    endcase
    244: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd244;
      3: stateTransition = 11'd244;
      4: stateTransition = 11'd244;
      5: stateTransition = 11'd244;
      6: stateTransition = 11'd244;
      7: stateTransition = 11'd244;
      8: stateTransition = 11'd244;
      default: stateTransition = 11'bX;
    endcase
    245: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd245;
      3: stateTransition = 11'd245;
      4: stateTransition = 11'd245;
      5: stateTransition = 11'd245;
      6: stateTransition = 11'd245;
      7: stateTransition = 11'd245;
      8: stateTransition = 11'd245;
      default: stateTransition = 11'bX;
    endcase
    246: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd246;
      3: stateTransition = 11'd246;
      4: stateTransition = 11'd246;
      5: stateTransition = 11'd246;
      6: stateTransition = 11'd246;
      7: stateTransition = 11'd246;
      8: stateTransition = 11'd246;
      default: stateTransition = 11'bX;
    endcase
    247: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd247;
      3: stateTransition = 11'd247;
      4: stateTransition = 11'd247;
      5: stateTransition = 11'd247;
      6: stateTransition = 11'd247;
      7: stateTransition = 11'd247;
      8: stateTransition = 11'd247;
      default: stateTransition = 11'bX;
    endcase
    248: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd248;
      3: stateTransition = 11'd248;
      4: stateTransition = 11'd248;
      5: stateTransition = 11'd248;
      6: stateTransition = 11'd248;
      7: stateTransition = 11'd248;
      8: stateTransition = 11'd248;
      default: stateTransition = 11'bX;
    endcase
    249: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd249;
      3: stateTransition = 11'd249;
      4: stateTransition = 11'd249;
      5: stateTransition = 11'd249;
      6: stateTransition = 11'd249;
      7: stateTransition = 11'd249;
      8: stateTransition = 11'd249;
      default: stateTransition = 11'bX;
    endcase
    250: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd250;
      3: stateTransition = 11'd250;
      4: stateTransition = 11'd250;
      5: stateTransition = 11'd250;
      6: stateTransition = 11'd250;
      7: stateTransition = 11'd250;
      8: stateTransition = 11'd250;
      default: stateTransition = 11'bX;
    endcase
    251: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd251;
      3: stateTransition = 11'd251;
      4: stateTransition = 11'd251;
      5: stateTransition = 11'd251;
      6: stateTransition = 11'd251;
      7: stateTransition = 11'd251;
      8: stateTransition = 11'd251;
      default: stateTransition = 11'bX;
    endcase
    252: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd252;
      3: stateTransition = 11'd252;
      4: stateTransition = 11'd252;
      5: stateTransition = 11'd252;
      6: stateTransition = 11'd252;
      7: stateTransition = 11'd252;
      8: stateTransition = 11'd252;
      default: stateTransition = 11'bX;
    endcase
    253: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd253;
      3: stateTransition = 11'd253;
      4: stateTransition = 11'd253;
      5: stateTransition = 11'd253;
      6: stateTransition = 11'd253;
      7: stateTransition = 11'd253;
      8: stateTransition = 11'd253;
      default: stateTransition = 11'bX;
    endcase
    254: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd254;
      3: stateTransition = 11'd254;
      4: stateTransition = 11'd254;
      5: stateTransition = 11'd254;
      6: stateTransition = 11'd254;
      7: stateTransition = 11'd254;
      8: stateTransition = 11'd254;
      default: stateTransition = 11'bX;
    endcase
    255: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd255;
      3: stateTransition = 11'd255;
      4: stateTransition = 11'd255;
      5: stateTransition = 11'd255;
      6: stateTransition = 11'd255;
      7: stateTransition = 11'd255;
      8: stateTransition = 11'd255;
      default: stateTransition = 11'bX;
    endcase
    256: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd256;
      3: stateTransition = 11'd256;
      4: stateTransition = 11'd256;
      5: stateTransition = 11'd256;
      6: stateTransition = 11'd256;
      7: stateTransition = 11'd256;
      8: stateTransition = 11'd256;
      default: stateTransition = 11'bX;
    endcase
    257: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd257;
      3: stateTransition = 11'd257;
      4: stateTransition = 11'd257;
      5: stateTransition = 11'd257;
      6: stateTransition = 11'd257;
      7: stateTransition = 11'd257;
      8: stateTransition = 11'd257;
      default: stateTransition = 11'bX;
    endcase
    258: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd258;
      3: stateTransition = 11'd258;
      4: stateTransition = 11'd258;
      5: stateTransition = 11'd258;
      6: stateTransition = 11'd258;
      7: stateTransition = 11'd258;
      8: stateTransition = 11'd258;
      default: stateTransition = 11'bX;
    endcase
    259: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd259;
      3: stateTransition = 11'd259;
      4: stateTransition = 11'd259;
      5: stateTransition = 11'd259;
      6: stateTransition = 11'd259;
      7: stateTransition = 11'd259;
      8: stateTransition = 11'd259;
      default: stateTransition = 11'bX;
    endcase
    260: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd260;
      3: stateTransition = 11'd260;
      4: stateTransition = 11'd260;
      5: stateTransition = 11'd260;
      6: stateTransition = 11'd260;
      7: stateTransition = 11'd260;
      8: stateTransition = 11'd260;
      default: stateTransition = 11'bX;
    endcase
    261: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd261;
      3: stateTransition = 11'd261;
      4: stateTransition = 11'd261;
      5: stateTransition = 11'd261;
      6: stateTransition = 11'd261;
      7: stateTransition = 11'd261;
      8: stateTransition = 11'd261;
      default: stateTransition = 11'bX;
    endcase
    262: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd262;
      3: stateTransition = 11'd262;
      4: stateTransition = 11'd262;
      5: stateTransition = 11'd262;
      6: stateTransition = 11'd262;
      7: stateTransition = 11'd262;
      8: stateTransition = 11'd262;
      default: stateTransition = 11'bX;
    endcase
    263: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd263;
      3: stateTransition = 11'd263;
      4: stateTransition = 11'd263;
      5: stateTransition = 11'd263;
      6: stateTransition = 11'd263;
      7: stateTransition = 11'd263;
      8: stateTransition = 11'd263;
      default: stateTransition = 11'bX;
    endcase
    264: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd264;
      3: stateTransition = 11'd264;
      4: stateTransition = 11'd264;
      5: stateTransition = 11'd264;
      6: stateTransition = 11'd264;
      7: stateTransition = 11'd264;
      8: stateTransition = 11'd264;
      default: stateTransition = 11'bX;
    endcase
    265: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd265;
      3: stateTransition = 11'd265;
      4: stateTransition = 11'd265;
      5: stateTransition = 11'd265;
      6: stateTransition = 11'd265;
      7: stateTransition = 11'd265;
      8: stateTransition = 11'd265;
      default: stateTransition = 11'bX;
    endcase
    266: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd266;
      3: stateTransition = 11'd266;
      4: stateTransition = 11'd266;
      5: stateTransition = 11'd266;
      6: stateTransition = 11'd266;
      7: stateTransition = 11'd266;
      8: stateTransition = 11'd266;
      default: stateTransition = 11'bX;
    endcase
    267: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd267;
      3: stateTransition = 11'd267;
      4: stateTransition = 11'd267;
      5: stateTransition = 11'd267;
      6: stateTransition = 11'd267;
      7: stateTransition = 11'd267;
      8: stateTransition = 11'd267;
      default: stateTransition = 11'bX;
    endcase
    268: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd268;
      3: stateTransition = 11'd268;
      4: stateTransition = 11'd268;
      5: stateTransition = 11'd268;
      6: stateTransition = 11'd268;
      7: stateTransition = 11'd268;
      8: stateTransition = 11'd268;
      default: stateTransition = 11'bX;
    endcase
    269: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd269;
      3: stateTransition = 11'd269;
      4: stateTransition = 11'd269;
      5: stateTransition = 11'd269;
      6: stateTransition = 11'd269;
      7: stateTransition = 11'd269;
      8: stateTransition = 11'd269;
      default: stateTransition = 11'bX;
    endcase
    270: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd270;
      3: stateTransition = 11'd270;
      4: stateTransition = 11'd270;
      5: stateTransition = 11'd270;
      6: stateTransition = 11'd270;
      7: stateTransition = 11'd270;
      8: stateTransition = 11'd270;
      default: stateTransition = 11'bX;
    endcase
    271: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd271;
      3: stateTransition = 11'd271;
      4: stateTransition = 11'd271;
      5: stateTransition = 11'd271;
      6: stateTransition = 11'd271;
      7: stateTransition = 11'd271;
      8: stateTransition = 11'd271;
      default: stateTransition = 11'bX;
    endcase
    272: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd272;
      3: stateTransition = 11'd272;
      4: stateTransition = 11'd272;
      5: stateTransition = 11'd272;
      6: stateTransition = 11'd272;
      7: stateTransition = 11'd272;
      8: stateTransition = 11'd272;
      default: stateTransition = 11'bX;
    endcase
    273: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd273;
      3: stateTransition = 11'd273;
      4: stateTransition = 11'd273;
      5: stateTransition = 11'd273;
      6: stateTransition = 11'd273;
      7: stateTransition = 11'd273;
      8: stateTransition = 11'd273;
      default: stateTransition = 11'bX;
    endcase
    274: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd274;
      3: stateTransition = 11'd274;
      4: stateTransition = 11'd274;
      5: stateTransition = 11'd274;
      6: stateTransition = 11'd274;
      7: stateTransition = 11'd274;
      8: stateTransition = 11'd274;
      default: stateTransition = 11'bX;
    endcase
    275: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd275;
      3: stateTransition = 11'd275;
      4: stateTransition = 11'd275;
      5: stateTransition = 11'd275;
      6: stateTransition = 11'd275;
      7: stateTransition = 11'd275;
      8: stateTransition = 11'd275;
      default: stateTransition = 11'bX;
    endcase
    276: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd276;
      3: stateTransition = 11'd276;
      4: stateTransition = 11'd276;
      5: stateTransition = 11'd276;
      6: stateTransition = 11'd276;
      7: stateTransition = 11'd276;
      8: stateTransition = 11'd276;
      default: stateTransition = 11'bX;
    endcase
    277: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd277;
      3: stateTransition = 11'd277;
      4: stateTransition = 11'd277;
      5: stateTransition = 11'd277;
      6: stateTransition = 11'd277;
      7: stateTransition = 11'd277;
      8: stateTransition = 11'd277;
      default: stateTransition = 11'bX;
    endcase
    278: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd278;
      3: stateTransition = 11'd278;
      4: stateTransition = 11'd278;
      5: stateTransition = 11'd278;
      6: stateTransition = 11'd278;
      7: stateTransition = 11'd278;
      8: stateTransition = 11'd278;
      default: stateTransition = 11'bX;
    endcase
    279: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd279;
      3: stateTransition = 11'd279;
      4: stateTransition = 11'd279;
      5: stateTransition = 11'd279;
      6: stateTransition = 11'd279;
      7: stateTransition = 11'd279;
      8: stateTransition = 11'd279;
      default: stateTransition = 11'bX;
    endcase
    280: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd280;
      3: stateTransition = 11'd280;
      4: stateTransition = 11'd280;
      5: stateTransition = 11'd280;
      6: stateTransition = 11'd280;
      7: stateTransition = 11'd280;
      8: stateTransition = 11'd280;
      default: stateTransition = 11'bX;
    endcase
    281: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd281;
      3: stateTransition = 11'd281;
      4: stateTransition = 11'd281;
      5: stateTransition = 11'd281;
      6: stateTransition = 11'd281;
      7: stateTransition = 11'd281;
      8: stateTransition = 11'd281;
      default: stateTransition = 11'bX;
    endcase
    282: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd282;
      3: stateTransition = 11'd282;
      4: stateTransition = 11'd282;
      5: stateTransition = 11'd282;
      6: stateTransition = 11'd282;
      7: stateTransition = 11'd282;
      8: stateTransition = 11'd282;
      default: stateTransition = 11'bX;
    endcase
    283: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd283;
      3: stateTransition = 11'd283;
      4: stateTransition = 11'd283;
      5: stateTransition = 11'd283;
      6: stateTransition = 11'd283;
      7: stateTransition = 11'd283;
      8: stateTransition = 11'd283;
      default: stateTransition = 11'bX;
    endcase
    284: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd284;
      3: stateTransition = 11'd284;
      4: stateTransition = 11'd284;
      5: stateTransition = 11'd284;
      6: stateTransition = 11'd284;
      7: stateTransition = 11'd284;
      8: stateTransition = 11'd284;
      default: stateTransition = 11'bX;
    endcase
    285: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd285;
      3: stateTransition = 11'd285;
      4: stateTransition = 11'd285;
      5: stateTransition = 11'd285;
      6: stateTransition = 11'd285;
      7: stateTransition = 11'd285;
      8: stateTransition = 11'd285;
      default: stateTransition = 11'bX;
    endcase
    286: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd286;
      3: stateTransition = 11'd286;
      4: stateTransition = 11'd286;
      5: stateTransition = 11'd286;
      6: stateTransition = 11'd286;
      7: stateTransition = 11'd286;
      8: stateTransition = 11'd286;
      default: stateTransition = 11'bX;
    endcase
    287: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd287;
      3: stateTransition = 11'd287;
      4: stateTransition = 11'd287;
      5: stateTransition = 11'd287;
      6: stateTransition = 11'd287;
      7: stateTransition = 11'd287;
      8: stateTransition = 11'd287;
      default: stateTransition = 11'bX;
    endcase
    288: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd288;
      3: stateTransition = 11'd288;
      4: stateTransition = 11'd288;
      5: stateTransition = 11'd288;
      6: stateTransition = 11'd288;
      7: stateTransition = 11'd288;
      8: stateTransition = 11'd288;
      default: stateTransition = 11'bX;
    endcase
    289: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd289;
      3: stateTransition = 11'd289;
      4: stateTransition = 11'd289;
      5: stateTransition = 11'd289;
      6: stateTransition = 11'd289;
      7: stateTransition = 11'd289;
      8: stateTransition = 11'd289;
      default: stateTransition = 11'bX;
    endcase
    290: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd290;
      3: stateTransition = 11'd290;
      4: stateTransition = 11'd290;
      5: stateTransition = 11'd290;
      6: stateTransition = 11'd290;
      7: stateTransition = 11'd290;
      8: stateTransition = 11'd290;
      default: stateTransition = 11'bX;
    endcase
    291: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd291;
      3: stateTransition = 11'd291;
      4: stateTransition = 11'd291;
      5: stateTransition = 11'd291;
      6: stateTransition = 11'd291;
      7: stateTransition = 11'd291;
      8: stateTransition = 11'd291;
      default: stateTransition = 11'bX;
    endcase
    292: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd292;
      3: stateTransition = 11'd292;
      4: stateTransition = 11'd292;
      5: stateTransition = 11'd292;
      6: stateTransition = 11'd292;
      7: stateTransition = 11'd292;
      8: stateTransition = 11'd292;
      default: stateTransition = 11'bX;
    endcase
    293: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd293;
      3: stateTransition = 11'd293;
      4: stateTransition = 11'd293;
      5: stateTransition = 11'd293;
      6: stateTransition = 11'd293;
      7: stateTransition = 11'd293;
      8: stateTransition = 11'd293;
      default: stateTransition = 11'bX;
    endcase
    294: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd294;
      3: stateTransition = 11'd294;
      4: stateTransition = 11'd294;
      5: stateTransition = 11'd294;
      6: stateTransition = 11'd294;
      7: stateTransition = 11'd294;
      8: stateTransition = 11'd294;
      default: stateTransition = 11'bX;
    endcase
    295: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd295;
      3: stateTransition = 11'd295;
      4: stateTransition = 11'd295;
      5: stateTransition = 11'd295;
      6: stateTransition = 11'd295;
      7: stateTransition = 11'd295;
      8: stateTransition = 11'd295;
      default: stateTransition = 11'bX;
    endcase
    296: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd296;
      3: stateTransition = 11'd296;
      4: stateTransition = 11'd296;
      5: stateTransition = 11'd296;
      6: stateTransition = 11'd296;
      7: stateTransition = 11'd296;
      8: stateTransition = 11'd296;
      default: stateTransition = 11'bX;
    endcase
    297: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd297;
      3: stateTransition = 11'd297;
      4: stateTransition = 11'd297;
      5: stateTransition = 11'd297;
      6: stateTransition = 11'd297;
      7: stateTransition = 11'd297;
      8: stateTransition = 11'd297;
      default: stateTransition = 11'bX;
    endcase
    298: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd298;
      3: stateTransition = 11'd298;
      4: stateTransition = 11'd298;
      5: stateTransition = 11'd298;
      6: stateTransition = 11'd298;
      7: stateTransition = 11'd298;
      8: stateTransition = 11'd298;
      default: stateTransition = 11'bX;
    endcase
    299: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd299;
      3: stateTransition = 11'd299;
      4: stateTransition = 11'd299;
      5: stateTransition = 11'd299;
      6: stateTransition = 11'd299;
      7: stateTransition = 11'd299;
      8: stateTransition = 11'd299;
      default: stateTransition = 11'bX;
    endcase
    300: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd300;
      3: stateTransition = 11'd300;
      4: stateTransition = 11'd300;
      5: stateTransition = 11'd300;
      6: stateTransition = 11'd300;
      7: stateTransition = 11'd300;
      8: stateTransition = 11'd300;
      default: stateTransition = 11'bX;
    endcase
    301: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd301;
      3: stateTransition = 11'd301;
      4: stateTransition = 11'd301;
      5: stateTransition = 11'd301;
      6: stateTransition = 11'd301;
      7: stateTransition = 11'd301;
      8: stateTransition = 11'd301;
      default: stateTransition = 11'bX;
    endcase
    302: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd302;
      3: stateTransition = 11'd302;
      4: stateTransition = 11'd302;
      5: stateTransition = 11'd302;
      6: stateTransition = 11'd302;
      7: stateTransition = 11'd302;
      8: stateTransition = 11'd302;
      default: stateTransition = 11'bX;
    endcase
    303: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd303;
      3: stateTransition = 11'd303;
      4: stateTransition = 11'd303;
      5: stateTransition = 11'd303;
      6: stateTransition = 11'd303;
      7: stateTransition = 11'd303;
      8: stateTransition = 11'd303;
      default: stateTransition = 11'bX;
    endcase
    304: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd304;
      3: stateTransition = 11'd304;
      4: stateTransition = 11'd304;
      5: stateTransition = 11'd304;
      6: stateTransition = 11'd304;
      7: stateTransition = 11'd304;
      8: stateTransition = 11'd304;
      default: stateTransition = 11'bX;
    endcase
    305: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd305;
      3: stateTransition = 11'd305;
      4: stateTransition = 11'd305;
      5: stateTransition = 11'd305;
      6: stateTransition = 11'd305;
      7: stateTransition = 11'd305;
      8: stateTransition = 11'd305;
      default: stateTransition = 11'bX;
    endcase
    306: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd306;
      3: stateTransition = 11'd306;
      4: stateTransition = 11'd306;
      5: stateTransition = 11'd306;
      6: stateTransition = 11'd306;
      7: stateTransition = 11'd306;
      8: stateTransition = 11'd306;
      default: stateTransition = 11'bX;
    endcase
    307: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd307;
      3: stateTransition = 11'd307;
      4: stateTransition = 11'd307;
      5: stateTransition = 11'd307;
      6: stateTransition = 11'd307;
      7: stateTransition = 11'd307;
      8: stateTransition = 11'd307;
      default: stateTransition = 11'bX;
    endcase
    308: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd308;
      3: stateTransition = 11'd308;
      4: stateTransition = 11'd308;
      5: stateTransition = 11'd308;
      6: stateTransition = 11'd308;
      7: stateTransition = 11'd308;
      8: stateTransition = 11'd308;
      default: stateTransition = 11'bX;
    endcase
    309: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd309;
      3: stateTransition = 11'd309;
      4: stateTransition = 11'd309;
      5: stateTransition = 11'd309;
      6: stateTransition = 11'd309;
      7: stateTransition = 11'd309;
      8: stateTransition = 11'd309;
      default: stateTransition = 11'bX;
    endcase
    310: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd310;
      3: stateTransition = 11'd310;
      4: stateTransition = 11'd310;
      5: stateTransition = 11'd310;
      6: stateTransition = 11'd310;
      7: stateTransition = 11'd310;
      8: stateTransition = 11'd310;
      default: stateTransition = 11'bX;
    endcase
    311: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd311;
      3: stateTransition = 11'd311;
      4: stateTransition = 11'd311;
      5: stateTransition = 11'd311;
      6: stateTransition = 11'd311;
      7: stateTransition = 11'd311;
      8: stateTransition = 11'd311;
      default: stateTransition = 11'bX;
    endcase
    312: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd312;
      3: stateTransition = 11'd312;
      4: stateTransition = 11'd312;
      5: stateTransition = 11'd312;
      6: stateTransition = 11'd312;
      7: stateTransition = 11'd312;
      8: stateTransition = 11'd312;
      default: stateTransition = 11'bX;
    endcase
    313: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd313;
      3: stateTransition = 11'd313;
      4: stateTransition = 11'd313;
      5: stateTransition = 11'd313;
      6: stateTransition = 11'd313;
      7: stateTransition = 11'd313;
      8: stateTransition = 11'd313;
      default: stateTransition = 11'bX;
    endcase
    314: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd314;
      3: stateTransition = 11'd314;
      4: stateTransition = 11'd314;
      5: stateTransition = 11'd314;
      6: stateTransition = 11'd314;
      7: stateTransition = 11'd314;
      8: stateTransition = 11'd314;
      default: stateTransition = 11'bX;
    endcase
    315: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd315;
      3: stateTransition = 11'd315;
      4: stateTransition = 11'd315;
      5: stateTransition = 11'd315;
      6: stateTransition = 11'd315;
      7: stateTransition = 11'd315;
      8: stateTransition = 11'd315;
      default: stateTransition = 11'bX;
    endcase
    316: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd316;
      3: stateTransition = 11'd316;
      4: stateTransition = 11'd316;
      5: stateTransition = 11'd316;
      6: stateTransition = 11'd316;
      7: stateTransition = 11'd316;
      8: stateTransition = 11'd316;
      default: stateTransition = 11'bX;
    endcase
    317: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd317;
      3: stateTransition = 11'd317;
      4: stateTransition = 11'd317;
      5: stateTransition = 11'd317;
      6: stateTransition = 11'd317;
      7: stateTransition = 11'd317;
      8: stateTransition = 11'd317;
      default: stateTransition = 11'bX;
    endcase
    318: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd318;
      3: stateTransition = 11'd318;
      4: stateTransition = 11'd318;
      5: stateTransition = 11'd318;
      6: stateTransition = 11'd318;
      7: stateTransition = 11'd318;
      8: stateTransition = 11'd318;
      default: stateTransition = 11'bX;
    endcase
    319: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd319;
      3: stateTransition = 11'd319;
      4: stateTransition = 11'd319;
      5: stateTransition = 11'd319;
      6: stateTransition = 11'd319;
      7: stateTransition = 11'd319;
      8: stateTransition = 11'd319;
      default: stateTransition = 11'bX;
    endcase
    320: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd320;
      3: stateTransition = 11'd320;
      4: stateTransition = 11'd320;
      5: stateTransition = 11'd320;
      6: stateTransition = 11'd320;
      7: stateTransition = 11'd320;
      8: stateTransition = 11'd320;
      default: stateTransition = 11'bX;
    endcase
    321: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd321;
      3: stateTransition = 11'd321;
      4: stateTransition = 11'd321;
      5: stateTransition = 11'd321;
      6: stateTransition = 11'd321;
      7: stateTransition = 11'd321;
      8: stateTransition = 11'd321;
      default: stateTransition = 11'bX;
    endcase
    322: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd322;
      3: stateTransition = 11'd322;
      4: stateTransition = 11'd322;
      5: stateTransition = 11'd322;
      6: stateTransition = 11'd322;
      7: stateTransition = 11'd322;
      8: stateTransition = 11'd322;
      default: stateTransition = 11'bX;
    endcase
    323: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd323;
      3: stateTransition = 11'd323;
      4: stateTransition = 11'd323;
      5: stateTransition = 11'd323;
      6: stateTransition = 11'd323;
      7: stateTransition = 11'd323;
      8: stateTransition = 11'd323;
      default: stateTransition = 11'bX;
    endcase
    324: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd324;
      3: stateTransition = 11'd324;
      4: stateTransition = 11'd324;
      5: stateTransition = 11'd324;
      6: stateTransition = 11'd324;
      7: stateTransition = 11'd324;
      8: stateTransition = 11'd324;
      default: stateTransition = 11'bX;
    endcase
    325: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd325;
      3: stateTransition = 11'd325;
      4: stateTransition = 11'd325;
      5: stateTransition = 11'd325;
      6: stateTransition = 11'd325;
      7: stateTransition = 11'd325;
      8: stateTransition = 11'd325;
      default: stateTransition = 11'bX;
    endcase
    326: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd326;
      3: stateTransition = 11'd326;
      4: stateTransition = 11'd326;
      5: stateTransition = 11'd326;
      6: stateTransition = 11'd326;
      7: stateTransition = 11'd326;
      8: stateTransition = 11'd326;
      default: stateTransition = 11'bX;
    endcase
    327: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd327;
      3: stateTransition = 11'd327;
      4: stateTransition = 11'd327;
      5: stateTransition = 11'd327;
      6: stateTransition = 11'd327;
      7: stateTransition = 11'd327;
      8: stateTransition = 11'd327;
      default: stateTransition = 11'bX;
    endcase
    328: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd328;
      3: stateTransition = 11'd328;
      4: stateTransition = 11'd328;
      5: stateTransition = 11'd328;
      6: stateTransition = 11'd328;
      7: stateTransition = 11'd328;
      8: stateTransition = 11'd328;
      default: stateTransition = 11'bX;
    endcase
    329: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd329;
      3: stateTransition = 11'd329;
      4: stateTransition = 11'd329;
      5: stateTransition = 11'd329;
      6: stateTransition = 11'd329;
      7: stateTransition = 11'd329;
      8: stateTransition = 11'd329;
      default: stateTransition = 11'bX;
    endcase
    330: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd330;
      3: stateTransition = 11'd330;
      4: stateTransition = 11'd330;
      5: stateTransition = 11'd330;
      6: stateTransition = 11'd330;
      7: stateTransition = 11'd330;
      8: stateTransition = 11'd330;
      default: stateTransition = 11'bX;
    endcase
    331: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd331;
      3: stateTransition = 11'd331;
      4: stateTransition = 11'd331;
      5: stateTransition = 11'd331;
      6: stateTransition = 11'd331;
      7: stateTransition = 11'd331;
      8: stateTransition = 11'd331;
      default: stateTransition = 11'bX;
    endcase
    332: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd332;
      3: stateTransition = 11'd332;
      4: stateTransition = 11'd332;
      5: stateTransition = 11'd332;
      6: stateTransition = 11'd332;
      7: stateTransition = 11'd332;
      8: stateTransition = 11'd332;
      default: stateTransition = 11'bX;
    endcase
    333: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd333;
      3: stateTransition = 11'd333;
      4: stateTransition = 11'd333;
      5: stateTransition = 11'd333;
      6: stateTransition = 11'd333;
      7: stateTransition = 11'd333;
      8: stateTransition = 11'd333;
      default: stateTransition = 11'bX;
    endcase
    334: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd334;
      3: stateTransition = 11'd334;
      4: stateTransition = 11'd334;
      5: stateTransition = 11'd334;
      6: stateTransition = 11'd334;
      7: stateTransition = 11'd334;
      8: stateTransition = 11'd334;
      default: stateTransition = 11'bX;
    endcase
    335: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd335;
      3: stateTransition = 11'd335;
      4: stateTransition = 11'd335;
      5: stateTransition = 11'd335;
      6: stateTransition = 11'd335;
      7: stateTransition = 11'd335;
      8: stateTransition = 11'd335;
      default: stateTransition = 11'bX;
    endcase
    336: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd336;
      3: stateTransition = 11'd336;
      4: stateTransition = 11'd336;
      5: stateTransition = 11'd336;
      6: stateTransition = 11'd336;
      7: stateTransition = 11'd336;
      8: stateTransition = 11'd336;
      default: stateTransition = 11'bX;
    endcase
    337: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd337;
      3: stateTransition = 11'd337;
      4: stateTransition = 11'd337;
      5: stateTransition = 11'd337;
      6: stateTransition = 11'd337;
      7: stateTransition = 11'd337;
      8: stateTransition = 11'd337;
      default: stateTransition = 11'bX;
    endcase
    338: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd338;
      3: stateTransition = 11'd338;
      4: stateTransition = 11'd338;
      5: stateTransition = 11'd338;
      6: stateTransition = 11'd338;
      7: stateTransition = 11'd338;
      8: stateTransition = 11'd338;
      default: stateTransition = 11'bX;
    endcase
    339: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd339;
      3: stateTransition = 11'd339;
      4: stateTransition = 11'd339;
      5: stateTransition = 11'd339;
      6: stateTransition = 11'd339;
      7: stateTransition = 11'd339;
      8: stateTransition = 11'd339;
      default: stateTransition = 11'bX;
    endcase
    340: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd340;
      3: stateTransition = 11'd340;
      4: stateTransition = 11'd340;
      5: stateTransition = 11'd340;
      6: stateTransition = 11'd340;
      7: stateTransition = 11'd340;
      8: stateTransition = 11'd340;
      default: stateTransition = 11'bX;
    endcase
    341: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd341;
      3: stateTransition = 11'd341;
      4: stateTransition = 11'd341;
      5: stateTransition = 11'd341;
      6: stateTransition = 11'd341;
      7: stateTransition = 11'd341;
      8: stateTransition = 11'd341;
      default: stateTransition = 11'bX;
    endcase
    342: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd342;
      3: stateTransition = 11'd342;
      4: stateTransition = 11'd342;
      5: stateTransition = 11'd342;
      6: stateTransition = 11'd342;
      7: stateTransition = 11'd342;
      8: stateTransition = 11'd342;
      default: stateTransition = 11'bX;
    endcase
    343: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd343;
      3: stateTransition = 11'd343;
      4: stateTransition = 11'd343;
      5: stateTransition = 11'd343;
      6: stateTransition = 11'd343;
      7: stateTransition = 11'd343;
      8: stateTransition = 11'd343;
      default: stateTransition = 11'bX;
    endcase
    344: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd344;
      3: stateTransition = 11'd344;
      4: stateTransition = 11'd344;
      5: stateTransition = 11'd344;
      6: stateTransition = 11'd344;
      7: stateTransition = 11'd344;
      8: stateTransition = 11'd344;
      default: stateTransition = 11'bX;
    endcase
    345: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd345;
      3: stateTransition = 11'd345;
      4: stateTransition = 11'd345;
      5: stateTransition = 11'd345;
      6: stateTransition = 11'd345;
      7: stateTransition = 11'd345;
      8: stateTransition = 11'd345;
      default: stateTransition = 11'bX;
    endcase
    346: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd346;
      3: stateTransition = 11'd346;
      4: stateTransition = 11'd346;
      5: stateTransition = 11'd346;
      6: stateTransition = 11'd346;
      7: stateTransition = 11'd346;
      8: stateTransition = 11'd346;
      default: stateTransition = 11'bX;
    endcase
    347: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd347;
      3: stateTransition = 11'd347;
      4: stateTransition = 11'd347;
      5: stateTransition = 11'd347;
      6: stateTransition = 11'd347;
      7: stateTransition = 11'd347;
      8: stateTransition = 11'd347;
      default: stateTransition = 11'bX;
    endcase
    348: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd348;
      3: stateTransition = 11'd348;
      4: stateTransition = 11'd348;
      5: stateTransition = 11'd348;
      6: stateTransition = 11'd348;
      7: stateTransition = 11'd348;
      8: stateTransition = 11'd348;
      default: stateTransition = 11'bX;
    endcase
    349: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd349;
      3: stateTransition = 11'd349;
      4: stateTransition = 11'd349;
      5: stateTransition = 11'd349;
      6: stateTransition = 11'd349;
      7: stateTransition = 11'd349;
      8: stateTransition = 11'd349;
      default: stateTransition = 11'bX;
    endcase
    350: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd350;
      3: stateTransition = 11'd350;
      4: stateTransition = 11'd350;
      5: stateTransition = 11'd350;
      6: stateTransition = 11'd350;
      7: stateTransition = 11'd350;
      8: stateTransition = 11'd350;
      default: stateTransition = 11'bX;
    endcase
    351: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd351;
      3: stateTransition = 11'd351;
      4: stateTransition = 11'd351;
      5: stateTransition = 11'd351;
      6: stateTransition = 11'd351;
      7: stateTransition = 11'd351;
      8: stateTransition = 11'd351;
      default: stateTransition = 11'bX;
    endcase
    352: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd352;
      3: stateTransition = 11'd352;
      4: stateTransition = 11'd352;
      5: stateTransition = 11'd352;
      6: stateTransition = 11'd352;
      7: stateTransition = 11'd352;
      8: stateTransition = 11'd352;
      default: stateTransition = 11'bX;
    endcase
    353: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd353;
      3: stateTransition = 11'd353;
      4: stateTransition = 11'd353;
      5: stateTransition = 11'd353;
      6: stateTransition = 11'd353;
      7: stateTransition = 11'd353;
      8: stateTransition = 11'd353;
      default: stateTransition = 11'bX;
    endcase
    354: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd354;
      3: stateTransition = 11'd354;
      4: stateTransition = 11'd354;
      5: stateTransition = 11'd354;
      6: stateTransition = 11'd354;
      7: stateTransition = 11'd354;
      8: stateTransition = 11'd354;
      default: stateTransition = 11'bX;
    endcase
    355: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd355;
      3: stateTransition = 11'd355;
      4: stateTransition = 11'd355;
      5: stateTransition = 11'd355;
      6: stateTransition = 11'd355;
      7: stateTransition = 11'd355;
      8: stateTransition = 11'd355;
      default: stateTransition = 11'bX;
    endcase
    356: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd356;
      3: stateTransition = 11'd356;
      4: stateTransition = 11'd356;
      5: stateTransition = 11'd356;
      6: stateTransition = 11'd356;
      7: stateTransition = 11'd356;
      8: stateTransition = 11'd356;
      default: stateTransition = 11'bX;
    endcase
    357: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd357;
      3: stateTransition = 11'd357;
      4: stateTransition = 11'd357;
      5: stateTransition = 11'd357;
      6: stateTransition = 11'd357;
      7: stateTransition = 11'd357;
      8: stateTransition = 11'd357;
      default: stateTransition = 11'bX;
    endcase
    358: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd358;
      3: stateTransition = 11'd358;
      4: stateTransition = 11'd358;
      5: stateTransition = 11'd358;
      6: stateTransition = 11'd358;
      7: stateTransition = 11'd358;
      8: stateTransition = 11'd358;
      default: stateTransition = 11'bX;
    endcase
    359: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd359;
      3: stateTransition = 11'd359;
      4: stateTransition = 11'd359;
      5: stateTransition = 11'd359;
      6: stateTransition = 11'd359;
      7: stateTransition = 11'd359;
      8: stateTransition = 11'd359;
      default: stateTransition = 11'bX;
    endcase
    360: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd360;
      3: stateTransition = 11'd360;
      4: stateTransition = 11'd360;
      5: stateTransition = 11'd360;
      6: stateTransition = 11'd360;
      7: stateTransition = 11'd360;
      8: stateTransition = 11'd360;
      default: stateTransition = 11'bX;
    endcase
    361: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd361;
      3: stateTransition = 11'd361;
      4: stateTransition = 11'd361;
      5: stateTransition = 11'd361;
      6: stateTransition = 11'd361;
      7: stateTransition = 11'd361;
      8: stateTransition = 11'd361;
      default: stateTransition = 11'bX;
    endcase
    362: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd362;
      3: stateTransition = 11'd362;
      4: stateTransition = 11'd362;
      5: stateTransition = 11'd362;
      6: stateTransition = 11'd362;
      7: stateTransition = 11'd362;
      8: stateTransition = 11'd362;
      default: stateTransition = 11'bX;
    endcase
    363: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd363;
      3: stateTransition = 11'd363;
      4: stateTransition = 11'd363;
      5: stateTransition = 11'd363;
      6: stateTransition = 11'd363;
      7: stateTransition = 11'd363;
      8: stateTransition = 11'd363;
      default: stateTransition = 11'bX;
    endcase
    364: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd364;
      3: stateTransition = 11'd364;
      4: stateTransition = 11'd364;
      5: stateTransition = 11'd364;
      6: stateTransition = 11'd364;
      7: stateTransition = 11'd364;
      8: stateTransition = 11'd364;
      default: stateTransition = 11'bX;
    endcase
    365: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd365;
      3: stateTransition = 11'd365;
      4: stateTransition = 11'd365;
      5: stateTransition = 11'd365;
      6: stateTransition = 11'd365;
      7: stateTransition = 11'd365;
      8: stateTransition = 11'd365;
      default: stateTransition = 11'bX;
    endcase
    366: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd366;
      3: stateTransition = 11'd366;
      4: stateTransition = 11'd366;
      5: stateTransition = 11'd366;
      6: stateTransition = 11'd366;
      7: stateTransition = 11'd366;
      8: stateTransition = 11'd366;
      default: stateTransition = 11'bX;
    endcase
    367: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd367;
      3: stateTransition = 11'd367;
      4: stateTransition = 11'd367;
      5: stateTransition = 11'd367;
      6: stateTransition = 11'd367;
      7: stateTransition = 11'd367;
      8: stateTransition = 11'd367;
      default: stateTransition = 11'bX;
    endcase
    368: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd368;
      3: stateTransition = 11'd368;
      4: stateTransition = 11'd368;
      5: stateTransition = 11'd368;
      6: stateTransition = 11'd368;
      7: stateTransition = 11'd368;
      8: stateTransition = 11'd368;
      default: stateTransition = 11'bX;
    endcase
    369: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd369;
      3: stateTransition = 11'd369;
      4: stateTransition = 11'd369;
      5: stateTransition = 11'd369;
      6: stateTransition = 11'd369;
      7: stateTransition = 11'd369;
      8: stateTransition = 11'd369;
      default: stateTransition = 11'bX;
    endcase
    370: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd370;
      3: stateTransition = 11'd370;
      4: stateTransition = 11'd370;
      5: stateTransition = 11'd370;
      6: stateTransition = 11'd370;
      7: stateTransition = 11'd370;
      8: stateTransition = 11'd370;
      default: stateTransition = 11'bX;
    endcase
    371: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd371;
      3: stateTransition = 11'd371;
      4: stateTransition = 11'd371;
      5: stateTransition = 11'd371;
      6: stateTransition = 11'd371;
      7: stateTransition = 11'd371;
      8: stateTransition = 11'd371;
      default: stateTransition = 11'bX;
    endcase
    372: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd372;
      3: stateTransition = 11'd372;
      4: stateTransition = 11'd372;
      5: stateTransition = 11'd372;
      6: stateTransition = 11'd372;
      7: stateTransition = 11'd372;
      8: stateTransition = 11'd372;
      default: stateTransition = 11'bX;
    endcase
    373: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd373;
      3: stateTransition = 11'd373;
      4: stateTransition = 11'd373;
      5: stateTransition = 11'd373;
      6: stateTransition = 11'd373;
      7: stateTransition = 11'd373;
      8: stateTransition = 11'd373;
      default: stateTransition = 11'bX;
    endcase
    374: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd374;
      3: stateTransition = 11'd374;
      4: stateTransition = 11'd374;
      5: stateTransition = 11'd374;
      6: stateTransition = 11'd374;
      7: stateTransition = 11'd374;
      8: stateTransition = 11'd374;
      default: stateTransition = 11'bX;
    endcase
    375: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd375;
      3: stateTransition = 11'd375;
      4: stateTransition = 11'd375;
      5: stateTransition = 11'd375;
      6: stateTransition = 11'd375;
      7: stateTransition = 11'd375;
      8: stateTransition = 11'd375;
      default: stateTransition = 11'bX;
    endcase
    376: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd376;
      3: stateTransition = 11'd376;
      4: stateTransition = 11'd376;
      5: stateTransition = 11'd376;
      6: stateTransition = 11'd376;
      7: stateTransition = 11'd376;
      8: stateTransition = 11'd376;
      default: stateTransition = 11'bX;
    endcase
    377: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd377;
      3: stateTransition = 11'd377;
      4: stateTransition = 11'd377;
      5: stateTransition = 11'd377;
      6: stateTransition = 11'd377;
      7: stateTransition = 11'd377;
      8: stateTransition = 11'd377;
      default: stateTransition = 11'bX;
    endcase
    378: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd378;
      3: stateTransition = 11'd378;
      4: stateTransition = 11'd378;
      5: stateTransition = 11'd378;
      6: stateTransition = 11'd378;
      7: stateTransition = 11'd378;
      8: stateTransition = 11'd378;
      default: stateTransition = 11'bX;
    endcase
    379: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd379;
      3: stateTransition = 11'd379;
      4: stateTransition = 11'd379;
      5: stateTransition = 11'd379;
      6: stateTransition = 11'd379;
      7: stateTransition = 11'd379;
      8: stateTransition = 11'd379;
      default: stateTransition = 11'bX;
    endcase
    380: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd380;
      3: stateTransition = 11'd380;
      4: stateTransition = 11'd380;
      5: stateTransition = 11'd380;
      6: stateTransition = 11'd380;
      7: stateTransition = 11'd380;
      8: stateTransition = 11'd380;
      default: stateTransition = 11'bX;
    endcase
    381: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd381;
      3: stateTransition = 11'd381;
      4: stateTransition = 11'd381;
      5: stateTransition = 11'd381;
      6: stateTransition = 11'd381;
      7: stateTransition = 11'd381;
      8: stateTransition = 11'd381;
      default: stateTransition = 11'bX;
    endcase
    382: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd382;
      3: stateTransition = 11'd382;
      4: stateTransition = 11'd382;
      5: stateTransition = 11'd382;
      6: stateTransition = 11'd382;
      7: stateTransition = 11'd382;
      8: stateTransition = 11'd382;
      default: stateTransition = 11'bX;
    endcase
    383: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd383;
      3: stateTransition = 11'd383;
      4: stateTransition = 11'd383;
      5: stateTransition = 11'd383;
      6: stateTransition = 11'd383;
      7: stateTransition = 11'd383;
      8: stateTransition = 11'd383;
      default: stateTransition = 11'bX;
    endcase
    384: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd384;
      3: stateTransition = 11'd384;
      4: stateTransition = 11'd384;
      5: stateTransition = 11'd384;
      6: stateTransition = 11'd384;
      7: stateTransition = 11'd384;
      8: stateTransition = 11'd384;
      default: stateTransition = 11'bX;
    endcase
    385: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd385;
      3: stateTransition = 11'd385;
      4: stateTransition = 11'd385;
      5: stateTransition = 11'd385;
      6: stateTransition = 11'd385;
      7: stateTransition = 11'd385;
      8: stateTransition = 11'd385;
      default: stateTransition = 11'bX;
    endcase
    386: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd386;
      3: stateTransition = 11'd386;
      4: stateTransition = 11'd386;
      5: stateTransition = 11'd386;
      6: stateTransition = 11'd386;
      7: stateTransition = 11'd386;
      8: stateTransition = 11'd386;
      default: stateTransition = 11'bX;
    endcase
    387: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd387;
      3: stateTransition = 11'd387;
      4: stateTransition = 11'd387;
      5: stateTransition = 11'd387;
      6: stateTransition = 11'd387;
      7: stateTransition = 11'd387;
      8: stateTransition = 11'd387;
      default: stateTransition = 11'bX;
    endcase
    388: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd388;
      3: stateTransition = 11'd388;
      4: stateTransition = 11'd388;
      5: stateTransition = 11'd388;
      6: stateTransition = 11'd388;
      7: stateTransition = 11'd388;
      8: stateTransition = 11'd388;
      default: stateTransition = 11'bX;
    endcase
    389: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd389;
      3: stateTransition = 11'd389;
      4: stateTransition = 11'd389;
      5: stateTransition = 11'd389;
      6: stateTransition = 11'd389;
      7: stateTransition = 11'd389;
      8: stateTransition = 11'd389;
      default: stateTransition = 11'bX;
    endcase
    390: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd390;
      3: stateTransition = 11'd390;
      4: stateTransition = 11'd390;
      5: stateTransition = 11'd390;
      6: stateTransition = 11'd390;
      7: stateTransition = 11'd390;
      8: stateTransition = 11'd390;
      default: stateTransition = 11'bX;
    endcase
    391: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd391;
      3: stateTransition = 11'd391;
      4: stateTransition = 11'd391;
      5: stateTransition = 11'd391;
      6: stateTransition = 11'd391;
      7: stateTransition = 11'd391;
      8: stateTransition = 11'd391;
      default: stateTransition = 11'bX;
    endcase
    392: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd392;
      3: stateTransition = 11'd392;
      4: stateTransition = 11'd392;
      5: stateTransition = 11'd392;
      6: stateTransition = 11'd392;
      7: stateTransition = 11'd392;
      8: stateTransition = 11'd392;
      default: stateTransition = 11'bX;
    endcase
    393: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd393;
      3: stateTransition = 11'd393;
      4: stateTransition = 11'd393;
      5: stateTransition = 11'd393;
      6: stateTransition = 11'd393;
      7: stateTransition = 11'd393;
      8: stateTransition = 11'd393;
      default: stateTransition = 11'bX;
    endcase
    394: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd394;
      3: stateTransition = 11'd394;
      4: stateTransition = 11'd394;
      5: stateTransition = 11'd394;
      6: stateTransition = 11'd394;
      7: stateTransition = 11'd394;
      8: stateTransition = 11'd394;
      default: stateTransition = 11'bX;
    endcase
    395: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd395;
      3: stateTransition = 11'd395;
      4: stateTransition = 11'd395;
      5: stateTransition = 11'd395;
      6: stateTransition = 11'd395;
      7: stateTransition = 11'd395;
      8: stateTransition = 11'd395;
      default: stateTransition = 11'bX;
    endcase
    396: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd396;
      3: stateTransition = 11'd396;
      4: stateTransition = 11'd396;
      5: stateTransition = 11'd396;
      6: stateTransition = 11'd396;
      7: stateTransition = 11'd396;
      8: stateTransition = 11'd396;
      default: stateTransition = 11'bX;
    endcase
    397: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd397;
      3: stateTransition = 11'd397;
      4: stateTransition = 11'd397;
      5: stateTransition = 11'd397;
      6: stateTransition = 11'd397;
      7: stateTransition = 11'd397;
      8: stateTransition = 11'd397;
      default: stateTransition = 11'bX;
    endcase
    398: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd398;
      3: stateTransition = 11'd398;
      4: stateTransition = 11'd398;
      5: stateTransition = 11'd398;
      6: stateTransition = 11'd398;
      7: stateTransition = 11'd398;
      8: stateTransition = 11'd398;
      default: stateTransition = 11'bX;
    endcase
    399: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd399;
      3: stateTransition = 11'd399;
      4: stateTransition = 11'd399;
      5: stateTransition = 11'd399;
      6: stateTransition = 11'd399;
      7: stateTransition = 11'd399;
      8: stateTransition = 11'd399;
      default: stateTransition = 11'bX;
    endcase
    400: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd400;
      3: stateTransition = 11'd400;
      4: stateTransition = 11'd400;
      5: stateTransition = 11'd400;
      6: stateTransition = 11'd400;
      7: stateTransition = 11'd400;
      8: stateTransition = 11'd400;
      default: stateTransition = 11'bX;
    endcase
    401: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd401;
      3: stateTransition = 11'd401;
      4: stateTransition = 11'd401;
      5: stateTransition = 11'd401;
      6: stateTransition = 11'd401;
      7: stateTransition = 11'd401;
      8: stateTransition = 11'd401;
      default: stateTransition = 11'bX;
    endcase
    402: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd402;
      3: stateTransition = 11'd402;
      4: stateTransition = 11'd402;
      5: stateTransition = 11'd402;
      6: stateTransition = 11'd402;
      7: stateTransition = 11'd402;
      8: stateTransition = 11'd402;
      default: stateTransition = 11'bX;
    endcase
    403: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd403;
      3: stateTransition = 11'd403;
      4: stateTransition = 11'd403;
      5: stateTransition = 11'd403;
      6: stateTransition = 11'd403;
      7: stateTransition = 11'd403;
      8: stateTransition = 11'd403;
      default: stateTransition = 11'bX;
    endcase
    404: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd404;
      3: stateTransition = 11'd404;
      4: stateTransition = 11'd404;
      5: stateTransition = 11'd404;
      6: stateTransition = 11'd404;
      7: stateTransition = 11'd404;
      8: stateTransition = 11'd404;
      default: stateTransition = 11'bX;
    endcase
    405: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd405;
      3: stateTransition = 11'd405;
      4: stateTransition = 11'd405;
      5: stateTransition = 11'd405;
      6: stateTransition = 11'd405;
      7: stateTransition = 11'd405;
      8: stateTransition = 11'd405;
      default: stateTransition = 11'bX;
    endcase
    406: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd406;
      3: stateTransition = 11'd406;
      4: stateTransition = 11'd406;
      5: stateTransition = 11'd406;
      6: stateTransition = 11'd406;
      7: stateTransition = 11'd406;
      8: stateTransition = 11'd406;
      default: stateTransition = 11'bX;
    endcase
    407: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd407;
      3: stateTransition = 11'd407;
      4: stateTransition = 11'd407;
      5: stateTransition = 11'd407;
      6: stateTransition = 11'd407;
      7: stateTransition = 11'd407;
      8: stateTransition = 11'd407;
      default: stateTransition = 11'bX;
    endcase
    408: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd408;
      3: stateTransition = 11'd408;
      4: stateTransition = 11'd408;
      5: stateTransition = 11'd408;
      6: stateTransition = 11'd408;
      7: stateTransition = 11'd408;
      8: stateTransition = 11'd408;
      default: stateTransition = 11'bX;
    endcase
    409: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd409;
      3: stateTransition = 11'd409;
      4: stateTransition = 11'd409;
      5: stateTransition = 11'd409;
      6: stateTransition = 11'd409;
      7: stateTransition = 11'd409;
      8: stateTransition = 11'd409;
      default: stateTransition = 11'bX;
    endcase
    410: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd410;
      3: stateTransition = 11'd410;
      4: stateTransition = 11'd410;
      5: stateTransition = 11'd410;
      6: stateTransition = 11'd410;
      7: stateTransition = 11'd410;
      8: stateTransition = 11'd410;
      default: stateTransition = 11'bX;
    endcase
    411: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd411;
      3: stateTransition = 11'd411;
      4: stateTransition = 11'd411;
      5: stateTransition = 11'd411;
      6: stateTransition = 11'd411;
      7: stateTransition = 11'd411;
      8: stateTransition = 11'd411;
      default: stateTransition = 11'bX;
    endcase
    412: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd412;
      3: stateTransition = 11'd412;
      4: stateTransition = 11'd412;
      5: stateTransition = 11'd412;
      6: stateTransition = 11'd412;
      7: stateTransition = 11'd412;
      8: stateTransition = 11'd412;
      default: stateTransition = 11'bX;
    endcase
    413: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd413;
      3: stateTransition = 11'd413;
      4: stateTransition = 11'd413;
      5: stateTransition = 11'd413;
      6: stateTransition = 11'd413;
      7: stateTransition = 11'd413;
      8: stateTransition = 11'd413;
      default: stateTransition = 11'bX;
    endcase
    414: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd414;
      3: stateTransition = 11'd414;
      4: stateTransition = 11'd414;
      5: stateTransition = 11'd414;
      6: stateTransition = 11'd414;
      7: stateTransition = 11'd414;
      8: stateTransition = 11'd414;
      default: stateTransition = 11'bX;
    endcase
    415: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd415;
      3: stateTransition = 11'd415;
      4: stateTransition = 11'd415;
      5: stateTransition = 11'd415;
      6: stateTransition = 11'd415;
      7: stateTransition = 11'd415;
      8: stateTransition = 11'd415;
      default: stateTransition = 11'bX;
    endcase
    416: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd416;
      3: stateTransition = 11'd416;
      4: stateTransition = 11'd416;
      5: stateTransition = 11'd416;
      6: stateTransition = 11'd416;
      7: stateTransition = 11'd416;
      8: stateTransition = 11'd416;
      default: stateTransition = 11'bX;
    endcase
    417: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd417;
      3: stateTransition = 11'd417;
      4: stateTransition = 11'd417;
      5: stateTransition = 11'd417;
      6: stateTransition = 11'd417;
      7: stateTransition = 11'd417;
      8: stateTransition = 11'd417;
      default: stateTransition = 11'bX;
    endcase
    418: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd418;
      3: stateTransition = 11'd418;
      4: stateTransition = 11'd418;
      5: stateTransition = 11'd418;
      6: stateTransition = 11'd418;
      7: stateTransition = 11'd418;
      8: stateTransition = 11'd418;
      default: stateTransition = 11'bX;
    endcase
    419: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd419;
      3: stateTransition = 11'd419;
      4: stateTransition = 11'd419;
      5: stateTransition = 11'd419;
      6: stateTransition = 11'd419;
      7: stateTransition = 11'd419;
      8: stateTransition = 11'd419;
      default: stateTransition = 11'bX;
    endcase
    420: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd420;
      3: stateTransition = 11'd420;
      4: stateTransition = 11'd420;
      5: stateTransition = 11'd420;
      6: stateTransition = 11'd420;
      7: stateTransition = 11'd420;
      8: stateTransition = 11'd420;
      default: stateTransition = 11'bX;
    endcase
    421: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd421;
      3: stateTransition = 11'd421;
      4: stateTransition = 11'd421;
      5: stateTransition = 11'd421;
      6: stateTransition = 11'd421;
      7: stateTransition = 11'd421;
      8: stateTransition = 11'd421;
      default: stateTransition = 11'bX;
    endcase
    422: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd422;
      3: stateTransition = 11'd422;
      4: stateTransition = 11'd422;
      5: stateTransition = 11'd422;
      6: stateTransition = 11'd422;
      7: stateTransition = 11'd422;
      8: stateTransition = 11'd422;
      default: stateTransition = 11'bX;
    endcase
    423: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd423;
      3: stateTransition = 11'd423;
      4: stateTransition = 11'd423;
      5: stateTransition = 11'd423;
      6: stateTransition = 11'd423;
      7: stateTransition = 11'd423;
      8: stateTransition = 11'd423;
      default: stateTransition = 11'bX;
    endcase
    424: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd424;
      3: stateTransition = 11'd424;
      4: stateTransition = 11'd424;
      5: stateTransition = 11'd424;
      6: stateTransition = 11'd424;
      7: stateTransition = 11'd424;
      8: stateTransition = 11'd424;
      default: stateTransition = 11'bX;
    endcase
    425: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd425;
      3: stateTransition = 11'd425;
      4: stateTransition = 11'd425;
      5: stateTransition = 11'd425;
      6: stateTransition = 11'd425;
      7: stateTransition = 11'd425;
      8: stateTransition = 11'd425;
      default: stateTransition = 11'bX;
    endcase
    426: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd426;
      3: stateTransition = 11'd426;
      4: stateTransition = 11'd426;
      5: stateTransition = 11'd426;
      6: stateTransition = 11'd426;
      7: stateTransition = 11'd426;
      8: stateTransition = 11'd426;
      default: stateTransition = 11'bX;
    endcase
    427: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd427;
      3: stateTransition = 11'd427;
      4: stateTransition = 11'd427;
      5: stateTransition = 11'd427;
      6: stateTransition = 11'd427;
      7: stateTransition = 11'd427;
      8: stateTransition = 11'd427;
      default: stateTransition = 11'bX;
    endcase
    428: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd428;
      3: stateTransition = 11'd428;
      4: stateTransition = 11'd428;
      5: stateTransition = 11'd428;
      6: stateTransition = 11'd428;
      7: stateTransition = 11'd428;
      8: stateTransition = 11'd428;
      default: stateTransition = 11'bX;
    endcase
    429: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd429;
      3: stateTransition = 11'd429;
      4: stateTransition = 11'd429;
      5: stateTransition = 11'd429;
      6: stateTransition = 11'd429;
      7: stateTransition = 11'd429;
      8: stateTransition = 11'd429;
      default: stateTransition = 11'bX;
    endcase
    430: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd430;
      3: stateTransition = 11'd430;
      4: stateTransition = 11'd430;
      5: stateTransition = 11'd430;
      6: stateTransition = 11'd430;
      7: stateTransition = 11'd430;
      8: stateTransition = 11'd430;
      default: stateTransition = 11'bX;
    endcase
    431: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd431;
      3: stateTransition = 11'd431;
      4: stateTransition = 11'd431;
      5: stateTransition = 11'd431;
      6: stateTransition = 11'd431;
      7: stateTransition = 11'd431;
      8: stateTransition = 11'd431;
      default: stateTransition = 11'bX;
    endcase
    432: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd432;
      3: stateTransition = 11'd432;
      4: stateTransition = 11'd432;
      5: stateTransition = 11'd432;
      6: stateTransition = 11'd432;
      7: stateTransition = 11'd432;
      8: stateTransition = 11'd432;
      default: stateTransition = 11'bX;
    endcase
    433: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd433;
      3: stateTransition = 11'd433;
      4: stateTransition = 11'd433;
      5: stateTransition = 11'd433;
      6: stateTransition = 11'd433;
      7: stateTransition = 11'd433;
      8: stateTransition = 11'd433;
      default: stateTransition = 11'bX;
    endcase
    434: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd434;
      3: stateTransition = 11'd434;
      4: stateTransition = 11'd434;
      5: stateTransition = 11'd434;
      6: stateTransition = 11'd434;
      7: stateTransition = 11'd434;
      8: stateTransition = 11'd434;
      default: stateTransition = 11'bX;
    endcase
    435: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd435;
      3: stateTransition = 11'd435;
      4: stateTransition = 11'd435;
      5: stateTransition = 11'd435;
      6: stateTransition = 11'd435;
      7: stateTransition = 11'd435;
      8: stateTransition = 11'd435;
      default: stateTransition = 11'bX;
    endcase
    436: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd436;
      3: stateTransition = 11'd436;
      4: stateTransition = 11'd436;
      5: stateTransition = 11'd436;
      6: stateTransition = 11'd436;
      7: stateTransition = 11'd436;
      8: stateTransition = 11'd436;
      default: stateTransition = 11'bX;
    endcase
    437: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd437;
      3: stateTransition = 11'd437;
      4: stateTransition = 11'd437;
      5: stateTransition = 11'd437;
      6: stateTransition = 11'd437;
      7: stateTransition = 11'd437;
      8: stateTransition = 11'd437;
      default: stateTransition = 11'bX;
    endcase
    438: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd438;
      3: stateTransition = 11'd438;
      4: stateTransition = 11'd438;
      5: stateTransition = 11'd438;
      6: stateTransition = 11'd438;
      7: stateTransition = 11'd438;
      8: stateTransition = 11'd438;
      default: stateTransition = 11'bX;
    endcase
    439: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd439;
      3: stateTransition = 11'd439;
      4: stateTransition = 11'd439;
      5: stateTransition = 11'd439;
      6: stateTransition = 11'd439;
      7: stateTransition = 11'd439;
      8: stateTransition = 11'd439;
      default: stateTransition = 11'bX;
    endcase
    440: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd440;
      3: stateTransition = 11'd440;
      4: stateTransition = 11'd440;
      5: stateTransition = 11'd440;
      6: stateTransition = 11'd440;
      7: stateTransition = 11'd440;
      8: stateTransition = 11'd440;
      default: stateTransition = 11'bX;
    endcase
    441: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd441;
      3: stateTransition = 11'd441;
      4: stateTransition = 11'd441;
      5: stateTransition = 11'd441;
      6: stateTransition = 11'd441;
      7: stateTransition = 11'd441;
      8: stateTransition = 11'd441;
      default: stateTransition = 11'bX;
    endcase
    442: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd442;
      3: stateTransition = 11'd442;
      4: stateTransition = 11'd442;
      5: stateTransition = 11'd442;
      6: stateTransition = 11'd442;
      7: stateTransition = 11'd442;
      8: stateTransition = 11'd442;
      default: stateTransition = 11'bX;
    endcase
    443: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd443;
      3: stateTransition = 11'd443;
      4: stateTransition = 11'd443;
      5: stateTransition = 11'd443;
      6: stateTransition = 11'd443;
      7: stateTransition = 11'd443;
      8: stateTransition = 11'd443;
      default: stateTransition = 11'bX;
    endcase
    444: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd444;
      3: stateTransition = 11'd444;
      4: stateTransition = 11'd444;
      5: stateTransition = 11'd444;
      6: stateTransition = 11'd444;
      7: stateTransition = 11'd444;
      8: stateTransition = 11'd444;
      default: stateTransition = 11'bX;
    endcase
    445: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd445;
      3: stateTransition = 11'd445;
      4: stateTransition = 11'd445;
      5: stateTransition = 11'd445;
      6: stateTransition = 11'd445;
      7: stateTransition = 11'd445;
      8: stateTransition = 11'd445;
      default: stateTransition = 11'bX;
    endcase
    446: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd446;
      3: stateTransition = 11'd446;
      4: stateTransition = 11'd446;
      5: stateTransition = 11'd446;
      6: stateTransition = 11'd446;
      7: stateTransition = 11'd446;
      8: stateTransition = 11'd446;
      default: stateTransition = 11'bX;
    endcase
    447: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd447;
      3: stateTransition = 11'd447;
      4: stateTransition = 11'd447;
      5: stateTransition = 11'd447;
      6: stateTransition = 11'd447;
      7: stateTransition = 11'd447;
      8: stateTransition = 11'd447;
      default: stateTransition = 11'bX;
    endcase
    448: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd448;
      3: stateTransition = 11'd448;
      4: stateTransition = 11'd448;
      5: stateTransition = 11'd448;
      6: stateTransition = 11'd448;
      7: stateTransition = 11'd448;
      8: stateTransition = 11'd448;
      default: stateTransition = 11'bX;
    endcase
    449: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd449;
      3: stateTransition = 11'd449;
      4: stateTransition = 11'd449;
      5: stateTransition = 11'd449;
      6: stateTransition = 11'd449;
      7: stateTransition = 11'd449;
      8: stateTransition = 11'd449;
      default: stateTransition = 11'bX;
    endcase
    450: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd450;
      3: stateTransition = 11'd450;
      4: stateTransition = 11'd450;
      5: stateTransition = 11'd450;
      6: stateTransition = 11'd450;
      7: stateTransition = 11'd450;
      8: stateTransition = 11'd450;
      default: stateTransition = 11'bX;
    endcase
    451: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd451;
      3: stateTransition = 11'd451;
      4: stateTransition = 11'd451;
      5: stateTransition = 11'd451;
      6: stateTransition = 11'd451;
      7: stateTransition = 11'd451;
      8: stateTransition = 11'd451;
      default: stateTransition = 11'bX;
    endcase
    452: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd452;
      3: stateTransition = 11'd452;
      4: stateTransition = 11'd452;
      5: stateTransition = 11'd452;
      6: stateTransition = 11'd452;
      7: stateTransition = 11'd452;
      8: stateTransition = 11'd452;
      default: stateTransition = 11'bX;
    endcase
    453: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd453;
      3: stateTransition = 11'd453;
      4: stateTransition = 11'd453;
      5: stateTransition = 11'd453;
      6: stateTransition = 11'd453;
      7: stateTransition = 11'd453;
      8: stateTransition = 11'd453;
      default: stateTransition = 11'bX;
    endcase
    454: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd454;
      3: stateTransition = 11'd454;
      4: stateTransition = 11'd454;
      5: stateTransition = 11'd454;
      6: stateTransition = 11'd454;
      7: stateTransition = 11'd454;
      8: stateTransition = 11'd454;
      default: stateTransition = 11'bX;
    endcase
    455: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd455;
      3: stateTransition = 11'd455;
      4: stateTransition = 11'd455;
      5: stateTransition = 11'd455;
      6: stateTransition = 11'd455;
      7: stateTransition = 11'd455;
      8: stateTransition = 11'd455;
      default: stateTransition = 11'bX;
    endcase
    456: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd456;
      3: stateTransition = 11'd456;
      4: stateTransition = 11'd456;
      5: stateTransition = 11'd456;
      6: stateTransition = 11'd456;
      7: stateTransition = 11'd456;
      8: stateTransition = 11'd456;
      default: stateTransition = 11'bX;
    endcase
    457: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd457;
      3: stateTransition = 11'd457;
      4: stateTransition = 11'd457;
      5: stateTransition = 11'd457;
      6: stateTransition = 11'd457;
      7: stateTransition = 11'd457;
      8: stateTransition = 11'd457;
      default: stateTransition = 11'bX;
    endcase
    458: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd458;
      3: stateTransition = 11'd458;
      4: stateTransition = 11'd458;
      5: stateTransition = 11'd458;
      6: stateTransition = 11'd458;
      7: stateTransition = 11'd458;
      8: stateTransition = 11'd458;
      default: stateTransition = 11'bX;
    endcase
    459: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd459;
      3: stateTransition = 11'd459;
      4: stateTransition = 11'd459;
      5: stateTransition = 11'd459;
      6: stateTransition = 11'd459;
      7: stateTransition = 11'd459;
      8: stateTransition = 11'd459;
      default: stateTransition = 11'bX;
    endcase
    460: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd460;
      3: stateTransition = 11'd460;
      4: stateTransition = 11'd460;
      5: stateTransition = 11'd460;
      6: stateTransition = 11'd460;
      7: stateTransition = 11'd460;
      8: stateTransition = 11'd460;
      default: stateTransition = 11'bX;
    endcase
    461: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd461;
      3: stateTransition = 11'd461;
      4: stateTransition = 11'd461;
      5: stateTransition = 11'd461;
      6: stateTransition = 11'd461;
      7: stateTransition = 11'd461;
      8: stateTransition = 11'd461;
      default: stateTransition = 11'bX;
    endcase
    462: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd462;
      3: stateTransition = 11'd462;
      4: stateTransition = 11'd462;
      5: stateTransition = 11'd462;
      6: stateTransition = 11'd462;
      7: stateTransition = 11'd462;
      8: stateTransition = 11'd462;
      default: stateTransition = 11'bX;
    endcase
    463: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd463;
      3: stateTransition = 11'd463;
      4: stateTransition = 11'd463;
      5: stateTransition = 11'd463;
      6: stateTransition = 11'd463;
      7: stateTransition = 11'd463;
      8: stateTransition = 11'd463;
      default: stateTransition = 11'bX;
    endcase
    464: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd464;
      3: stateTransition = 11'd464;
      4: stateTransition = 11'd464;
      5: stateTransition = 11'd464;
      6: stateTransition = 11'd464;
      7: stateTransition = 11'd464;
      8: stateTransition = 11'd464;
      default: stateTransition = 11'bX;
    endcase
    465: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd465;
      3: stateTransition = 11'd465;
      4: stateTransition = 11'd465;
      5: stateTransition = 11'd465;
      6: stateTransition = 11'd465;
      7: stateTransition = 11'd465;
      8: stateTransition = 11'd465;
      default: stateTransition = 11'bX;
    endcase
    466: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd466;
      3: stateTransition = 11'd466;
      4: stateTransition = 11'd466;
      5: stateTransition = 11'd466;
      6: stateTransition = 11'd466;
      7: stateTransition = 11'd466;
      8: stateTransition = 11'd466;
      default: stateTransition = 11'bX;
    endcase
    467: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd467;
      3: stateTransition = 11'd467;
      4: stateTransition = 11'd467;
      5: stateTransition = 11'd467;
      6: stateTransition = 11'd467;
      7: stateTransition = 11'd467;
      8: stateTransition = 11'd467;
      default: stateTransition = 11'bX;
    endcase
    468: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd468;
      3: stateTransition = 11'd468;
      4: stateTransition = 11'd468;
      5: stateTransition = 11'd468;
      6: stateTransition = 11'd468;
      7: stateTransition = 11'd468;
      8: stateTransition = 11'd468;
      default: stateTransition = 11'bX;
    endcase
    469: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd469;
      3: stateTransition = 11'd469;
      4: stateTransition = 11'd469;
      5: stateTransition = 11'd469;
      6: stateTransition = 11'd469;
      7: stateTransition = 11'd469;
      8: stateTransition = 11'd469;
      default: stateTransition = 11'bX;
    endcase
    470: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd470;
      3: stateTransition = 11'd470;
      4: stateTransition = 11'd470;
      5: stateTransition = 11'd470;
      6: stateTransition = 11'd470;
      7: stateTransition = 11'd470;
      8: stateTransition = 11'd470;
      default: stateTransition = 11'bX;
    endcase
    471: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd471;
      3: stateTransition = 11'd471;
      4: stateTransition = 11'd471;
      5: stateTransition = 11'd471;
      6: stateTransition = 11'd471;
      7: stateTransition = 11'd471;
      8: stateTransition = 11'd471;
      default: stateTransition = 11'bX;
    endcase
    472: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd472;
      3: stateTransition = 11'd472;
      4: stateTransition = 11'd472;
      5: stateTransition = 11'd472;
      6: stateTransition = 11'd472;
      7: stateTransition = 11'd472;
      8: stateTransition = 11'd472;
      default: stateTransition = 11'bX;
    endcase
    473: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd473;
      3: stateTransition = 11'd473;
      4: stateTransition = 11'd473;
      5: stateTransition = 11'd473;
      6: stateTransition = 11'd473;
      7: stateTransition = 11'd473;
      8: stateTransition = 11'd473;
      default: stateTransition = 11'bX;
    endcase
    474: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd474;
      3: stateTransition = 11'd474;
      4: stateTransition = 11'd474;
      5: stateTransition = 11'd474;
      6: stateTransition = 11'd474;
      7: stateTransition = 11'd474;
      8: stateTransition = 11'd474;
      default: stateTransition = 11'bX;
    endcase
    475: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd475;
      3: stateTransition = 11'd475;
      4: stateTransition = 11'd475;
      5: stateTransition = 11'd475;
      6: stateTransition = 11'd475;
      7: stateTransition = 11'd475;
      8: stateTransition = 11'd475;
      default: stateTransition = 11'bX;
    endcase
    476: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd476;
      3: stateTransition = 11'd476;
      4: stateTransition = 11'd476;
      5: stateTransition = 11'd476;
      6: stateTransition = 11'd476;
      7: stateTransition = 11'd476;
      8: stateTransition = 11'd476;
      default: stateTransition = 11'bX;
    endcase
    477: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd477;
      3: stateTransition = 11'd477;
      4: stateTransition = 11'd477;
      5: stateTransition = 11'd477;
      6: stateTransition = 11'd477;
      7: stateTransition = 11'd477;
      8: stateTransition = 11'd477;
      default: stateTransition = 11'bX;
    endcase
    478: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd478;
      3: stateTransition = 11'd478;
      4: stateTransition = 11'd478;
      5: stateTransition = 11'd478;
      6: stateTransition = 11'd478;
      7: stateTransition = 11'd478;
      8: stateTransition = 11'd478;
      default: stateTransition = 11'bX;
    endcase
    479: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd479;
      3: stateTransition = 11'd479;
      4: stateTransition = 11'd479;
      5: stateTransition = 11'd479;
      6: stateTransition = 11'd479;
      7: stateTransition = 11'd479;
      8: stateTransition = 11'd479;
      default: stateTransition = 11'bX;
    endcase
    480: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd480;
      3: stateTransition = 11'd480;
      4: stateTransition = 11'd480;
      5: stateTransition = 11'd480;
      6: stateTransition = 11'd480;
      7: stateTransition = 11'd480;
      8: stateTransition = 11'd480;
      default: stateTransition = 11'bX;
    endcase
    481: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd481;
      3: stateTransition = 11'd481;
      4: stateTransition = 11'd481;
      5: stateTransition = 11'd481;
      6: stateTransition = 11'd481;
      7: stateTransition = 11'd481;
      8: stateTransition = 11'd481;
      default: stateTransition = 11'bX;
    endcase
    482: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd482;
      3: stateTransition = 11'd482;
      4: stateTransition = 11'd482;
      5: stateTransition = 11'd482;
      6: stateTransition = 11'd482;
      7: stateTransition = 11'd482;
      8: stateTransition = 11'd482;
      default: stateTransition = 11'bX;
    endcase
    483: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd483;
      3: stateTransition = 11'd483;
      4: stateTransition = 11'd483;
      5: stateTransition = 11'd483;
      6: stateTransition = 11'd483;
      7: stateTransition = 11'd483;
      8: stateTransition = 11'd483;
      default: stateTransition = 11'bX;
    endcase
    484: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd484;
      3: stateTransition = 11'd484;
      4: stateTransition = 11'd484;
      5: stateTransition = 11'd484;
      6: stateTransition = 11'd484;
      7: stateTransition = 11'd484;
      8: stateTransition = 11'd484;
      default: stateTransition = 11'bX;
    endcase
    485: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd485;
      3: stateTransition = 11'd485;
      4: stateTransition = 11'd485;
      5: stateTransition = 11'd485;
      6: stateTransition = 11'd485;
      7: stateTransition = 11'd485;
      8: stateTransition = 11'd485;
      default: stateTransition = 11'bX;
    endcase
    486: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd486;
      3: stateTransition = 11'd486;
      4: stateTransition = 11'd486;
      5: stateTransition = 11'd486;
      6: stateTransition = 11'd486;
      7: stateTransition = 11'd486;
      8: stateTransition = 11'd486;
      default: stateTransition = 11'bX;
    endcase
    487: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd487;
      3: stateTransition = 11'd487;
      4: stateTransition = 11'd487;
      5: stateTransition = 11'd487;
      6: stateTransition = 11'd487;
      7: stateTransition = 11'd487;
      8: stateTransition = 11'd487;
      default: stateTransition = 11'bX;
    endcase
    488: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd488;
      3: stateTransition = 11'd488;
      4: stateTransition = 11'd488;
      5: stateTransition = 11'd488;
      6: stateTransition = 11'd488;
      7: stateTransition = 11'd488;
      8: stateTransition = 11'd488;
      default: stateTransition = 11'bX;
    endcase
    489: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd489;
      3: stateTransition = 11'd489;
      4: stateTransition = 11'd489;
      5: stateTransition = 11'd489;
      6: stateTransition = 11'd489;
      7: stateTransition = 11'd489;
      8: stateTransition = 11'd489;
      default: stateTransition = 11'bX;
    endcase
    490: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd490;
      3: stateTransition = 11'd490;
      4: stateTransition = 11'd490;
      5: stateTransition = 11'd490;
      6: stateTransition = 11'd490;
      7: stateTransition = 11'd490;
      8: stateTransition = 11'd490;
      default: stateTransition = 11'bX;
    endcase
    491: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd491;
      3: stateTransition = 11'd491;
      4: stateTransition = 11'd491;
      5: stateTransition = 11'd491;
      6: stateTransition = 11'd491;
      7: stateTransition = 11'd491;
      8: stateTransition = 11'd491;
      default: stateTransition = 11'bX;
    endcase
    492: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd492;
      3: stateTransition = 11'd492;
      4: stateTransition = 11'd492;
      5: stateTransition = 11'd492;
      6: stateTransition = 11'd492;
      7: stateTransition = 11'd492;
      8: stateTransition = 11'd492;
      default: stateTransition = 11'bX;
    endcase
    493: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd493;
      3: stateTransition = 11'd493;
      4: stateTransition = 11'd493;
      5: stateTransition = 11'd493;
      6: stateTransition = 11'd493;
      7: stateTransition = 11'd493;
      8: stateTransition = 11'd493;
      default: stateTransition = 11'bX;
    endcase
    494: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd494;
      3: stateTransition = 11'd494;
      4: stateTransition = 11'd494;
      5: stateTransition = 11'd494;
      6: stateTransition = 11'd494;
      7: stateTransition = 11'd494;
      8: stateTransition = 11'd494;
      default: stateTransition = 11'bX;
    endcase
    495: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd495;
      3: stateTransition = 11'd495;
      4: stateTransition = 11'd495;
      5: stateTransition = 11'd495;
      6: stateTransition = 11'd495;
      7: stateTransition = 11'd495;
      8: stateTransition = 11'd495;
      default: stateTransition = 11'bX;
    endcase
    496: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd496;
      3: stateTransition = 11'd496;
      4: stateTransition = 11'd496;
      5: stateTransition = 11'd496;
      6: stateTransition = 11'd496;
      7: stateTransition = 11'd496;
      8: stateTransition = 11'd496;
      default: stateTransition = 11'bX;
    endcase
    497: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd497;
      3: stateTransition = 11'd497;
      4: stateTransition = 11'd497;
      5: stateTransition = 11'd497;
      6: stateTransition = 11'd497;
      7: stateTransition = 11'd497;
      8: stateTransition = 11'd497;
      default: stateTransition = 11'bX;
    endcase
    498: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd498;
      3: stateTransition = 11'd498;
      4: stateTransition = 11'd498;
      5: stateTransition = 11'd498;
      6: stateTransition = 11'd498;
      7: stateTransition = 11'd498;
      8: stateTransition = 11'd498;
      default: stateTransition = 11'bX;
    endcase
    499: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd499;
      3: stateTransition = 11'd499;
      4: stateTransition = 11'd499;
      5: stateTransition = 11'd499;
      6: stateTransition = 11'd499;
      7: stateTransition = 11'd499;
      8: stateTransition = 11'd499;
      default: stateTransition = 11'bX;
    endcase
    500: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd500;
      3: stateTransition = 11'd500;
      4: stateTransition = 11'd500;
      5: stateTransition = 11'd500;
      6: stateTransition = 11'd500;
      7: stateTransition = 11'd500;
      8: stateTransition = 11'd500;
      default: stateTransition = 11'bX;
    endcase
    501: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd501;
      3: stateTransition = 11'd501;
      4: stateTransition = 11'd501;
      5: stateTransition = 11'd501;
      6: stateTransition = 11'd501;
      7: stateTransition = 11'd501;
      8: stateTransition = 11'd501;
      default: stateTransition = 11'bX;
    endcase
    502: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd502;
      3: stateTransition = 11'd502;
      4: stateTransition = 11'd502;
      5: stateTransition = 11'd502;
      6: stateTransition = 11'd502;
      7: stateTransition = 11'd502;
      8: stateTransition = 11'd502;
      default: stateTransition = 11'bX;
    endcase
    503: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd503;
      3: stateTransition = 11'd503;
      4: stateTransition = 11'd503;
      5: stateTransition = 11'd503;
      6: stateTransition = 11'd503;
      7: stateTransition = 11'd503;
      8: stateTransition = 11'd503;
      default: stateTransition = 11'bX;
    endcase
    504: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd504;
      3: stateTransition = 11'd504;
      4: stateTransition = 11'd504;
      5: stateTransition = 11'd504;
      6: stateTransition = 11'd504;
      7: stateTransition = 11'd504;
      8: stateTransition = 11'd504;
      default: stateTransition = 11'bX;
    endcase
    505: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd505;
      3: stateTransition = 11'd505;
      4: stateTransition = 11'd505;
      5: stateTransition = 11'd505;
      6: stateTransition = 11'd505;
      7: stateTransition = 11'd505;
      8: stateTransition = 11'd505;
      default: stateTransition = 11'bX;
    endcase
    506: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd506;
      3: stateTransition = 11'd506;
      4: stateTransition = 11'd506;
      5: stateTransition = 11'd506;
      6: stateTransition = 11'd506;
      7: stateTransition = 11'd506;
      8: stateTransition = 11'd506;
      default: stateTransition = 11'bX;
    endcase
    507: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd507;
      3: stateTransition = 11'd507;
      4: stateTransition = 11'd507;
      5: stateTransition = 11'd507;
      6: stateTransition = 11'd507;
      7: stateTransition = 11'd507;
      8: stateTransition = 11'd507;
      default: stateTransition = 11'bX;
    endcase
    508: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd508;
      3: stateTransition = 11'd508;
      4: stateTransition = 11'd508;
      5: stateTransition = 11'd508;
      6: stateTransition = 11'd508;
      7: stateTransition = 11'd508;
      8: stateTransition = 11'd508;
      default: stateTransition = 11'bX;
    endcase
    509: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd509;
      3: stateTransition = 11'd509;
      4: stateTransition = 11'd509;
      5: stateTransition = 11'd509;
      6: stateTransition = 11'd509;
      7: stateTransition = 11'd509;
      8: stateTransition = 11'd509;
      default: stateTransition = 11'bX;
    endcase
    510: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd510;
      3: stateTransition = 11'd510;
      4: stateTransition = 11'd510;
      5: stateTransition = 11'd510;
      6: stateTransition = 11'd510;
      7: stateTransition = 11'd510;
      8: stateTransition = 11'd510;
      default: stateTransition = 11'bX;
    endcase
    511: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd511;
      3: stateTransition = 11'd511;
      4: stateTransition = 11'd511;
      5: stateTransition = 11'd511;
      6: stateTransition = 11'd511;
      7: stateTransition = 11'd511;
      8: stateTransition = 11'd511;
      default: stateTransition = 11'bX;
    endcase
    512: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd512;
      3: stateTransition = 11'd512;
      4: stateTransition = 11'd512;
      5: stateTransition = 11'd512;
      6: stateTransition = 11'd512;
      7: stateTransition = 11'd512;
      8: stateTransition = 11'd512;
      default: stateTransition = 11'bX;
    endcase
    513: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd513;
      3: stateTransition = 11'd513;
      4: stateTransition = 11'd513;
      5: stateTransition = 11'd513;
      6: stateTransition = 11'd513;
      7: stateTransition = 11'd513;
      8: stateTransition = 11'd513;
      default: stateTransition = 11'bX;
    endcase
    514: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd514;
      3: stateTransition = 11'd514;
      4: stateTransition = 11'd514;
      5: stateTransition = 11'd514;
      6: stateTransition = 11'd514;
      7: stateTransition = 11'd514;
      8: stateTransition = 11'd514;
      default: stateTransition = 11'bX;
    endcase
    515: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd515;
      3: stateTransition = 11'd515;
      4: stateTransition = 11'd515;
      5: stateTransition = 11'd515;
      6: stateTransition = 11'd515;
      7: stateTransition = 11'd515;
      8: stateTransition = 11'd515;
      default: stateTransition = 11'bX;
    endcase
    516: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd516;
      3: stateTransition = 11'd516;
      4: stateTransition = 11'd516;
      5: stateTransition = 11'd516;
      6: stateTransition = 11'd516;
      7: stateTransition = 11'd516;
      8: stateTransition = 11'd516;
      default: stateTransition = 11'bX;
    endcase
    517: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd517;
      3: stateTransition = 11'd517;
      4: stateTransition = 11'd517;
      5: stateTransition = 11'd517;
      6: stateTransition = 11'd517;
      7: stateTransition = 11'd517;
      8: stateTransition = 11'd517;
      default: stateTransition = 11'bX;
    endcase
    518: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd518;
      3: stateTransition = 11'd518;
      4: stateTransition = 11'd518;
      5: stateTransition = 11'd518;
      6: stateTransition = 11'd518;
      7: stateTransition = 11'd518;
      8: stateTransition = 11'd518;
      default: stateTransition = 11'bX;
    endcase
    519: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd519;
      3: stateTransition = 11'd519;
      4: stateTransition = 11'd519;
      5: stateTransition = 11'd519;
      6: stateTransition = 11'd519;
      7: stateTransition = 11'd519;
      8: stateTransition = 11'd519;
      default: stateTransition = 11'bX;
    endcase
    520: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd520;
      3: stateTransition = 11'd520;
      4: stateTransition = 11'd520;
      5: stateTransition = 11'd520;
      6: stateTransition = 11'd520;
      7: stateTransition = 11'd520;
      8: stateTransition = 11'd520;
      default: stateTransition = 11'bX;
    endcase
    521: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd521;
      3: stateTransition = 11'd521;
      4: stateTransition = 11'd521;
      5: stateTransition = 11'd521;
      6: stateTransition = 11'd521;
      7: stateTransition = 11'd521;
      8: stateTransition = 11'd521;
      default: stateTransition = 11'bX;
    endcase
    522: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd522;
      3: stateTransition = 11'd522;
      4: stateTransition = 11'd522;
      5: stateTransition = 11'd522;
      6: stateTransition = 11'd522;
      7: stateTransition = 11'd522;
      8: stateTransition = 11'd522;
      default: stateTransition = 11'bX;
    endcase
    523: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd523;
      3: stateTransition = 11'd523;
      4: stateTransition = 11'd523;
      5: stateTransition = 11'd523;
      6: stateTransition = 11'd523;
      7: stateTransition = 11'd523;
      8: stateTransition = 11'd523;
      default: stateTransition = 11'bX;
    endcase
    524: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd524;
      3: stateTransition = 11'd524;
      4: stateTransition = 11'd524;
      5: stateTransition = 11'd524;
      6: stateTransition = 11'd524;
      7: stateTransition = 11'd524;
      8: stateTransition = 11'd524;
      default: stateTransition = 11'bX;
    endcase
    525: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd525;
      3: stateTransition = 11'd525;
      4: stateTransition = 11'd525;
      5: stateTransition = 11'd525;
      6: stateTransition = 11'd525;
      7: stateTransition = 11'd525;
      8: stateTransition = 11'd525;
      default: stateTransition = 11'bX;
    endcase
    526: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd526;
      3: stateTransition = 11'd526;
      4: stateTransition = 11'd526;
      5: stateTransition = 11'd526;
      6: stateTransition = 11'd526;
      7: stateTransition = 11'd526;
      8: stateTransition = 11'd526;
      default: stateTransition = 11'bX;
    endcase
    527: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd527;
      3: stateTransition = 11'd527;
      4: stateTransition = 11'd527;
      5: stateTransition = 11'd527;
      6: stateTransition = 11'd527;
      7: stateTransition = 11'd527;
      8: stateTransition = 11'd527;
      default: stateTransition = 11'bX;
    endcase
    528: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd528;
      3: stateTransition = 11'd528;
      4: stateTransition = 11'd528;
      5: stateTransition = 11'd528;
      6: stateTransition = 11'd528;
      7: stateTransition = 11'd528;
      8: stateTransition = 11'd528;
      default: stateTransition = 11'bX;
    endcase
    529: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd529;
      3: stateTransition = 11'd529;
      4: stateTransition = 11'd529;
      5: stateTransition = 11'd529;
      6: stateTransition = 11'd529;
      7: stateTransition = 11'd529;
      8: stateTransition = 11'd529;
      default: stateTransition = 11'bX;
    endcase
    530: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd530;
      3: stateTransition = 11'd530;
      4: stateTransition = 11'd530;
      5: stateTransition = 11'd530;
      6: stateTransition = 11'd530;
      7: stateTransition = 11'd530;
      8: stateTransition = 11'd530;
      default: stateTransition = 11'bX;
    endcase
    531: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd531;
      3: stateTransition = 11'd531;
      4: stateTransition = 11'd531;
      5: stateTransition = 11'd531;
      6: stateTransition = 11'd531;
      7: stateTransition = 11'd531;
      8: stateTransition = 11'd531;
      default: stateTransition = 11'bX;
    endcase
    532: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd532;
      3: stateTransition = 11'd532;
      4: stateTransition = 11'd532;
      5: stateTransition = 11'd532;
      6: stateTransition = 11'd532;
      7: stateTransition = 11'd532;
      8: stateTransition = 11'd532;
      default: stateTransition = 11'bX;
    endcase
    533: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd533;
      3: stateTransition = 11'd533;
      4: stateTransition = 11'd533;
      5: stateTransition = 11'd533;
      6: stateTransition = 11'd533;
      7: stateTransition = 11'd533;
      8: stateTransition = 11'd533;
      default: stateTransition = 11'bX;
    endcase
    534: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd534;
      3: stateTransition = 11'd534;
      4: stateTransition = 11'd534;
      5: stateTransition = 11'd534;
      6: stateTransition = 11'd534;
      7: stateTransition = 11'd534;
      8: stateTransition = 11'd534;
      default: stateTransition = 11'bX;
    endcase
    535: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd535;
      3: stateTransition = 11'd535;
      4: stateTransition = 11'd535;
      5: stateTransition = 11'd535;
      6: stateTransition = 11'd535;
      7: stateTransition = 11'd535;
      8: stateTransition = 11'd535;
      default: stateTransition = 11'bX;
    endcase
    536: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd536;
      3: stateTransition = 11'd536;
      4: stateTransition = 11'd536;
      5: stateTransition = 11'd536;
      6: stateTransition = 11'd536;
      7: stateTransition = 11'd536;
      8: stateTransition = 11'd536;
      default: stateTransition = 11'bX;
    endcase
    537: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd537;
      3: stateTransition = 11'd537;
      4: stateTransition = 11'd537;
      5: stateTransition = 11'd537;
      6: stateTransition = 11'd537;
      7: stateTransition = 11'd537;
      8: stateTransition = 11'd537;
      default: stateTransition = 11'bX;
    endcase
    538: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd538;
      3: stateTransition = 11'd538;
      4: stateTransition = 11'd538;
      5: stateTransition = 11'd538;
      6: stateTransition = 11'd538;
      7: stateTransition = 11'd538;
      8: stateTransition = 11'd538;
      default: stateTransition = 11'bX;
    endcase
    539: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd539;
      3: stateTransition = 11'd539;
      4: stateTransition = 11'd539;
      5: stateTransition = 11'd539;
      6: stateTransition = 11'd539;
      7: stateTransition = 11'd539;
      8: stateTransition = 11'd539;
      default: stateTransition = 11'bX;
    endcase
    540: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd540;
      3: stateTransition = 11'd540;
      4: stateTransition = 11'd540;
      5: stateTransition = 11'd540;
      6: stateTransition = 11'd540;
      7: stateTransition = 11'd540;
      8: stateTransition = 11'd540;
      default: stateTransition = 11'bX;
    endcase
    541: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd541;
      3: stateTransition = 11'd541;
      4: stateTransition = 11'd541;
      5: stateTransition = 11'd541;
      6: stateTransition = 11'd541;
      7: stateTransition = 11'd541;
      8: stateTransition = 11'd541;
      default: stateTransition = 11'bX;
    endcase
    542: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd542;
      3: stateTransition = 11'd542;
      4: stateTransition = 11'd542;
      5: stateTransition = 11'd542;
      6: stateTransition = 11'd542;
      7: stateTransition = 11'd542;
      8: stateTransition = 11'd542;
      default: stateTransition = 11'bX;
    endcase
    543: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd543;
      3: stateTransition = 11'd543;
      4: stateTransition = 11'd543;
      5: stateTransition = 11'd543;
      6: stateTransition = 11'd543;
      7: stateTransition = 11'd543;
      8: stateTransition = 11'd543;
      default: stateTransition = 11'bX;
    endcase
    544: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd544;
      3: stateTransition = 11'd544;
      4: stateTransition = 11'd544;
      5: stateTransition = 11'd544;
      6: stateTransition = 11'd544;
      7: stateTransition = 11'd544;
      8: stateTransition = 11'd544;
      default: stateTransition = 11'bX;
    endcase
    545: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd545;
      3: stateTransition = 11'd545;
      4: stateTransition = 11'd545;
      5: stateTransition = 11'd545;
      6: stateTransition = 11'd545;
      7: stateTransition = 11'd545;
      8: stateTransition = 11'd545;
      default: stateTransition = 11'bX;
    endcase
    546: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd546;
      3: stateTransition = 11'd546;
      4: stateTransition = 11'd546;
      5: stateTransition = 11'd546;
      6: stateTransition = 11'd546;
      7: stateTransition = 11'd546;
      8: stateTransition = 11'd546;
      default: stateTransition = 11'bX;
    endcase
    547: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd547;
      3: stateTransition = 11'd547;
      4: stateTransition = 11'd547;
      5: stateTransition = 11'd547;
      6: stateTransition = 11'd547;
      7: stateTransition = 11'd547;
      8: stateTransition = 11'd547;
      default: stateTransition = 11'bX;
    endcase
    548: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd548;
      3: stateTransition = 11'd548;
      4: stateTransition = 11'd548;
      5: stateTransition = 11'd548;
      6: stateTransition = 11'd548;
      7: stateTransition = 11'd548;
      8: stateTransition = 11'd548;
      default: stateTransition = 11'bX;
    endcase
    549: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd549;
      3: stateTransition = 11'd549;
      4: stateTransition = 11'd549;
      5: stateTransition = 11'd549;
      6: stateTransition = 11'd549;
      7: stateTransition = 11'd549;
      8: stateTransition = 11'd549;
      default: stateTransition = 11'bX;
    endcase
    550: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd550;
      3: stateTransition = 11'd550;
      4: stateTransition = 11'd550;
      5: stateTransition = 11'd550;
      6: stateTransition = 11'd550;
      7: stateTransition = 11'd550;
      8: stateTransition = 11'd550;
      default: stateTransition = 11'bX;
    endcase
    551: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd551;
      3: stateTransition = 11'd551;
      4: stateTransition = 11'd551;
      5: stateTransition = 11'd551;
      6: stateTransition = 11'd551;
      7: stateTransition = 11'd551;
      8: stateTransition = 11'd551;
      default: stateTransition = 11'bX;
    endcase
    552: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd552;
      3: stateTransition = 11'd552;
      4: stateTransition = 11'd552;
      5: stateTransition = 11'd552;
      6: stateTransition = 11'd552;
      7: stateTransition = 11'd552;
      8: stateTransition = 11'd552;
      default: stateTransition = 11'bX;
    endcase
    553: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd553;
      3: stateTransition = 11'd553;
      4: stateTransition = 11'd553;
      5: stateTransition = 11'd553;
      6: stateTransition = 11'd553;
      7: stateTransition = 11'd553;
      8: stateTransition = 11'd553;
      default: stateTransition = 11'bX;
    endcase
    554: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd554;
      3: stateTransition = 11'd554;
      4: stateTransition = 11'd554;
      5: stateTransition = 11'd554;
      6: stateTransition = 11'd554;
      7: stateTransition = 11'd554;
      8: stateTransition = 11'd554;
      default: stateTransition = 11'bX;
    endcase
    555: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd555;
      3: stateTransition = 11'd555;
      4: stateTransition = 11'd555;
      5: stateTransition = 11'd555;
      6: stateTransition = 11'd555;
      7: stateTransition = 11'd555;
      8: stateTransition = 11'd555;
      default: stateTransition = 11'bX;
    endcase
    556: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd556;
      3: stateTransition = 11'd556;
      4: stateTransition = 11'd556;
      5: stateTransition = 11'd556;
      6: stateTransition = 11'd556;
      7: stateTransition = 11'd556;
      8: stateTransition = 11'd556;
      default: stateTransition = 11'bX;
    endcase
    557: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd557;
      3: stateTransition = 11'd557;
      4: stateTransition = 11'd557;
      5: stateTransition = 11'd557;
      6: stateTransition = 11'd557;
      7: stateTransition = 11'd557;
      8: stateTransition = 11'd557;
      default: stateTransition = 11'bX;
    endcase
    558: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd558;
      3: stateTransition = 11'd558;
      4: stateTransition = 11'd558;
      5: stateTransition = 11'd558;
      6: stateTransition = 11'd558;
      7: stateTransition = 11'd558;
      8: stateTransition = 11'd558;
      default: stateTransition = 11'bX;
    endcase
    559: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd559;
      3: stateTransition = 11'd559;
      4: stateTransition = 11'd559;
      5: stateTransition = 11'd559;
      6: stateTransition = 11'd559;
      7: stateTransition = 11'd559;
      8: stateTransition = 11'd559;
      default: stateTransition = 11'bX;
    endcase
    560: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd560;
      3: stateTransition = 11'd560;
      4: stateTransition = 11'd560;
      5: stateTransition = 11'd560;
      6: stateTransition = 11'd560;
      7: stateTransition = 11'd560;
      8: stateTransition = 11'd560;
      default: stateTransition = 11'bX;
    endcase
    561: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd561;
      3: stateTransition = 11'd561;
      4: stateTransition = 11'd561;
      5: stateTransition = 11'd561;
      6: stateTransition = 11'd561;
      7: stateTransition = 11'd561;
      8: stateTransition = 11'd561;
      default: stateTransition = 11'bX;
    endcase
    562: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd562;
      3: stateTransition = 11'd562;
      4: stateTransition = 11'd562;
      5: stateTransition = 11'd562;
      6: stateTransition = 11'd562;
      7: stateTransition = 11'd562;
      8: stateTransition = 11'd562;
      default: stateTransition = 11'bX;
    endcase
    563: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd563;
      3: stateTransition = 11'd563;
      4: stateTransition = 11'd563;
      5: stateTransition = 11'd563;
      6: stateTransition = 11'd563;
      7: stateTransition = 11'd563;
      8: stateTransition = 11'd563;
      default: stateTransition = 11'bX;
    endcase
    564: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd564;
      3: stateTransition = 11'd564;
      4: stateTransition = 11'd564;
      5: stateTransition = 11'd564;
      6: stateTransition = 11'd564;
      7: stateTransition = 11'd564;
      8: stateTransition = 11'd564;
      default: stateTransition = 11'bX;
    endcase
    565: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd565;
      3: stateTransition = 11'd565;
      4: stateTransition = 11'd565;
      5: stateTransition = 11'd565;
      6: stateTransition = 11'd565;
      7: stateTransition = 11'd565;
      8: stateTransition = 11'd565;
      default: stateTransition = 11'bX;
    endcase
    566: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd566;
      3: stateTransition = 11'd566;
      4: stateTransition = 11'd566;
      5: stateTransition = 11'd566;
      6: stateTransition = 11'd566;
      7: stateTransition = 11'd566;
      8: stateTransition = 11'd566;
      default: stateTransition = 11'bX;
    endcase
    567: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd567;
      3: stateTransition = 11'd567;
      4: stateTransition = 11'd567;
      5: stateTransition = 11'd567;
      6: stateTransition = 11'd567;
      7: stateTransition = 11'd567;
      8: stateTransition = 11'd567;
      default: stateTransition = 11'bX;
    endcase
    568: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd568;
      3: stateTransition = 11'd568;
      4: stateTransition = 11'd568;
      5: stateTransition = 11'd568;
      6: stateTransition = 11'd568;
      7: stateTransition = 11'd568;
      8: stateTransition = 11'd568;
      default: stateTransition = 11'bX;
    endcase
    569: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd569;
      3: stateTransition = 11'd569;
      4: stateTransition = 11'd569;
      5: stateTransition = 11'd569;
      6: stateTransition = 11'd569;
      7: stateTransition = 11'd569;
      8: stateTransition = 11'd569;
      default: stateTransition = 11'bX;
    endcase
    570: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd570;
      3: stateTransition = 11'd570;
      4: stateTransition = 11'd570;
      5: stateTransition = 11'd570;
      6: stateTransition = 11'd570;
      7: stateTransition = 11'd570;
      8: stateTransition = 11'd570;
      default: stateTransition = 11'bX;
    endcase
    571: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd571;
      3: stateTransition = 11'd571;
      4: stateTransition = 11'd571;
      5: stateTransition = 11'd571;
      6: stateTransition = 11'd571;
      7: stateTransition = 11'd571;
      8: stateTransition = 11'd571;
      default: stateTransition = 11'bX;
    endcase
    572: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd572;
      3: stateTransition = 11'd572;
      4: stateTransition = 11'd572;
      5: stateTransition = 11'd572;
      6: stateTransition = 11'd572;
      7: stateTransition = 11'd572;
      8: stateTransition = 11'd572;
      default: stateTransition = 11'bX;
    endcase
    573: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd573;
      3: stateTransition = 11'd573;
      4: stateTransition = 11'd573;
      5: stateTransition = 11'd573;
      6: stateTransition = 11'd573;
      7: stateTransition = 11'd573;
      8: stateTransition = 11'd573;
      default: stateTransition = 11'bX;
    endcase
    574: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd574;
      3: stateTransition = 11'd574;
      4: stateTransition = 11'd574;
      5: stateTransition = 11'd574;
      6: stateTransition = 11'd574;
      7: stateTransition = 11'd574;
      8: stateTransition = 11'd574;
      default: stateTransition = 11'bX;
    endcase
    575: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd575;
      3: stateTransition = 11'd575;
      4: stateTransition = 11'd575;
      5: stateTransition = 11'd575;
      6: stateTransition = 11'd575;
      7: stateTransition = 11'd575;
      8: stateTransition = 11'd575;
      default: stateTransition = 11'bX;
    endcase
    576: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd576;
      3: stateTransition = 11'd576;
      4: stateTransition = 11'd576;
      5: stateTransition = 11'd576;
      6: stateTransition = 11'd576;
      7: stateTransition = 11'd576;
      8: stateTransition = 11'd576;
      default: stateTransition = 11'bX;
    endcase
    577: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd577;
      3: stateTransition = 11'd577;
      4: stateTransition = 11'd577;
      5: stateTransition = 11'd577;
      6: stateTransition = 11'd577;
      7: stateTransition = 11'd577;
      8: stateTransition = 11'd577;
      default: stateTransition = 11'bX;
    endcase
    578: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd578;
      3: stateTransition = 11'd578;
      4: stateTransition = 11'd578;
      5: stateTransition = 11'd578;
      6: stateTransition = 11'd578;
      7: stateTransition = 11'd578;
      8: stateTransition = 11'd578;
      default: stateTransition = 11'bX;
    endcase
    579: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd579;
      3: stateTransition = 11'd579;
      4: stateTransition = 11'd579;
      5: stateTransition = 11'd579;
      6: stateTransition = 11'd579;
      7: stateTransition = 11'd579;
      8: stateTransition = 11'd579;
      default: stateTransition = 11'bX;
    endcase
    580: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd580;
      3: stateTransition = 11'd580;
      4: stateTransition = 11'd580;
      5: stateTransition = 11'd580;
      6: stateTransition = 11'd580;
      7: stateTransition = 11'd580;
      8: stateTransition = 11'd580;
      default: stateTransition = 11'bX;
    endcase
    581: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd581;
      3: stateTransition = 11'd581;
      4: stateTransition = 11'd581;
      5: stateTransition = 11'd581;
      6: stateTransition = 11'd581;
      7: stateTransition = 11'd581;
      8: stateTransition = 11'd581;
      default: stateTransition = 11'bX;
    endcase
    582: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd582;
      3: stateTransition = 11'd582;
      4: stateTransition = 11'd582;
      5: stateTransition = 11'd582;
      6: stateTransition = 11'd582;
      7: stateTransition = 11'd582;
      8: stateTransition = 11'd582;
      default: stateTransition = 11'bX;
    endcase
    583: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd583;
      3: stateTransition = 11'd583;
      4: stateTransition = 11'd583;
      5: stateTransition = 11'd583;
      6: stateTransition = 11'd583;
      7: stateTransition = 11'd583;
      8: stateTransition = 11'd583;
      default: stateTransition = 11'bX;
    endcase
    584: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd584;
      3: stateTransition = 11'd584;
      4: stateTransition = 11'd584;
      5: stateTransition = 11'd584;
      6: stateTransition = 11'd584;
      7: stateTransition = 11'd584;
      8: stateTransition = 11'd584;
      default: stateTransition = 11'bX;
    endcase
    585: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd585;
      3: stateTransition = 11'd585;
      4: stateTransition = 11'd585;
      5: stateTransition = 11'd585;
      6: stateTransition = 11'd585;
      7: stateTransition = 11'd585;
      8: stateTransition = 11'd585;
      default: stateTransition = 11'bX;
    endcase
    586: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd586;
      3: stateTransition = 11'd586;
      4: stateTransition = 11'd586;
      5: stateTransition = 11'd586;
      6: stateTransition = 11'd586;
      7: stateTransition = 11'd586;
      8: stateTransition = 11'd586;
      default: stateTransition = 11'bX;
    endcase
    587: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd587;
      3: stateTransition = 11'd587;
      4: stateTransition = 11'd587;
      5: stateTransition = 11'd587;
      6: stateTransition = 11'd587;
      7: stateTransition = 11'd587;
      8: stateTransition = 11'd587;
      default: stateTransition = 11'bX;
    endcase
    588: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd588;
      3: stateTransition = 11'd588;
      4: stateTransition = 11'd588;
      5: stateTransition = 11'd588;
      6: stateTransition = 11'd588;
      7: stateTransition = 11'd588;
      8: stateTransition = 11'd588;
      default: stateTransition = 11'bX;
    endcase
    589: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd589;
      3: stateTransition = 11'd589;
      4: stateTransition = 11'd589;
      5: stateTransition = 11'd589;
      6: stateTransition = 11'd589;
      7: stateTransition = 11'd589;
      8: stateTransition = 11'd589;
      default: stateTransition = 11'bX;
    endcase
    590: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd590;
      3: stateTransition = 11'd590;
      4: stateTransition = 11'd590;
      5: stateTransition = 11'd590;
      6: stateTransition = 11'd590;
      7: stateTransition = 11'd590;
      8: stateTransition = 11'd590;
      default: stateTransition = 11'bX;
    endcase
    591: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd591;
      3: stateTransition = 11'd591;
      4: stateTransition = 11'd591;
      5: stateTransition = 11'd591;
      6: stateTransition = 11'd591;
      7: stateTransition = 11'd591;
      8: stateTransition = 11'd591;
      default: stateTransition = 11'bX;
    endcase
    592: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd592;
      3: stateTransition = 11'd592;
      4: stateTransition = 11'd592;
      5: stateTransition = 11'd592;
      6: stateTransition = 11'd592;
      7: stateTransition = 11'd592;
      8: stateTransition = 11'd592;
      default: stateTransition = 11'bX;
    endcase
    593: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd593;
      3: stateTransition = 11'd593;
      4: stateTransition = 11'd593;
      5: stateTransition = 11'd593;
      6: stateTransition = 11'd593;
      7: stateTransition = 11'd593;
      8: stateTransition = 11'd593;
      default: stateTransition = 11'bX;
    endcase
    594: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd594;
      3: stateTransition = 11'd594;
      4: stateTransition = 11'd594;
      5: stateTransition = 11'd594;
      6: stateTransition = 11'd594;
      7: stateTransition = 11'd594;
      8: stateTransition = 11'd594;
      default: stateTransition = 11'bX;
    endcase
    595: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd595;
      3: stateTransition = 11'd595;
      4: stateTransition = 11'd595;
      5: stateTransition = 11'd595;
      6: stateTransition = 11'd595;
      7: stateTransition = 11'd595;
      8: stateTransition = 11'd595;
      default: stateTransition = 11'bX;
    endcase
    596: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd596;
      3: stateTransition = 11'd596;
      4: stateTransition = 11'd596;
      5: stateTransition = 11'd596;
      6: stateTransition = 11'd596;
      7: stateTransition = 11'd596;
      8: stateTransition = 11'd596;
      default: stateTransition = 11'bX;
    endcase
    597: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd597;
      3: stateTransition = 11'd597;
      4: stateTransition = 11'd597;
      5: stateTransition = 11'd597;
      6: stateTransition = 11'd597;
      7: stateTransition = 11'd597;
      8: stateTransition = 11'd597;
      default: stateTransition = 11'bX;
    endcase
    598: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd598;
      3: stateTransition = 11'd598;
      4: stateTransition = 11'd598;
      5: stateTransition = 11'd598;
      6: stateTransition = 11'd598;
      7: stateTransition = 11'd598;
      8: stateTransition = 11'd598;
      default: stateTransition = 11'bX;
    endcase
    599: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd599;
      3: stateTransition = 11'd599;
      4: stateTransition = 11'd599;
      5: stateTransition = 11'd599;
      6: stateTransition = 11'd599;
      7: stateTransition = 11'd599;
      8: stateTransition = 11'd599;
      default: stateTransition = 11'bX;
    endcase
    600: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd600;
      3: stateTransition = 11'd600;
      4: stateTransition = 11'd600;
      5: stateTransition = 11'd600;
      6: stateTransition = 11'd600;
      7: stateTransition = 11'd600;
      8: stateTransition = 11'd600;
      default: stateTransition = 11'bX;
    endcase
    601: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd601;
      3: stateTransition = 11'd601;
      4: stateTransition = 11'd601;
      5: stateTransition = 11'd601;
      6: stateTransition = 11'd601;
      7: stateTransition = 11'd601;
      8: stateTransition = 11'd601;
      default: stateTransition = 11'bX;
    endcase
    602: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd602;
      3: stateTransition = 11'd602;
      4: stateTransition = 11'd602;
      5: stateTransition = 11'd602;
      6: stateTransition = 11'd602;
      7: stateTransition = 11'd602;
      8: stateTransition = 11'd602;
      default: stateTransition = 11'bX;
    endcase
    603: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd603;
      3: stateTransition = 11'd603;
      4: stateTransition = 11'd603;
      5: stateTransition = 11'd603;
      6: stateTransition = 11'd603;
      7: stateTransition = 11'd603;
      8: stateTransition = 11'd603;
      default: stateTransition = 11'bX;
    endcase
    604: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd604;
      3: stateTransition = 11'd604;
      4: stateTransition = 11'd604;
      5: stateTransition = 11'd604;
      6: stateTransition = 11'd604;
      7: stateTransition = 11'd604;
      8: stateTransition = 11'd604;
      default: stateTransition = 11'bX;
    endcase
    605: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd605;
      3: stateTransition = 11'd605;
      4: stateTransition = 11'd605;
      5: stateTransition = 11'd605;
      6: stateTransition = 11'd605;
      7: stateTransition = 11'd605;
      8: stateTransition = 11'd605;
      default: stateTransition = 11'bX;
    endcase
    606: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd606;
      3: stateTransition = 11'd606;
      4: stateTransition = 11'd606;
      5: stateTransition = 11'd606;
      6: stateTransition = 11'd606;
      7: stateTransition = 11'd606;
      8: stateTransition = 11'd606;
      default: stateTransition = 11'bX;
    endcase
    607: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd607;
      3: stateTransition = 11'd607;
      4: stateTransition = 11'd607;
      5: stateTransition = 11'd607;
      6: stateTransition = 11'd607;
      7: stateTransition = 11'd607;
      8: stateTransition = 11'd607;
      default: stateTransition = 11'bX;
    endcase
    608: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd608;
      3: stateTransition = 11'd608;
      4: stateTransition = 11'd608;
      5: stateTransition = 11'd608;
      6: stateTransition = 11'd608;
      7: stateTransition = 11'd608;
      8: stateTransition = 11'd608;
      default: stateTransition = 11'bX;
    endcase
    609: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd609;
      3: stateTransition = 11'd609;
      4: stateTransition = 11'd609;
      5: stateTransition = 11'd609;
      6: stateTransition = 11'd609;
      7: stateTransition = 11'd609;
      8: stateTransition = 11'd609;
      default: stateTransition = 11'bX;
    endcase
    610: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd610;
      3: stateTransition = 11'd610;
      4: stateTransition = 11'd610;
      5: stateTransition = 11'd610;
      6: stateTransition = 11'd610;
      7: stateTransition = 11'd610;
      8: stateTransition = 11'd610;
      default: stateTransition = 11'bX;
    endcase
    611: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd611;
      3: stateTransition = 11'd611;
      4: stateTransition = 11'd611;
      5: stateTransition = 11'd611;
      6: stateTransition = 11'd611;
      7: stateTransition = 11'd611;
      8: stateTransition = 11'd611;
      default: stateTransition = 11'bX;
    endcase
    612: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd612;
      3: stateTransition = 11'd612;
      4: stateTransition = 11'd612;
      5: stateTransition = 11'd612;
      6: stateTransition = 11'd612;
      7: stateTransition = 11'd612;
      8: stateTransition = 11'd612;
      default: stateTransition = 11'bX;
    endcase
    613: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd613;
      3: stateTransition = 11'd613;
      4: stateTransition = 11'd613;
      5: stateTransition = 11'd613;
      6: stateTransition = 11'd613;
      7: stateTransition = 11'd613;
      8: stateTransition = 11'd613;
      default: stateTransition = 11'bX;
    endcase
    614: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd614;
      3: stateTransition = 11'd614;
      4: stateTransition = 11'd614;
      5: stateTransition = 11'd614;
      6: stateTransition = 11'd614;
      7: stateTransition = 11'd614;
      8: stateTransition = 11'd614;
      default: stateTransition = 11'bX;
    endcase
    615: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd615;
      3: stateTransition = 11'd615;
      4: stateTransition = 11'd615;
      5: stateTransition = 11'd615;
      6: stateTransition = 11'd615;
      7: stateTransition = 11'd615;
      8: stateTransition = 11'd615;
      default: stateTransition = 11'bX;
    endcase
    616: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd616;
      3: stateTransition = 11'd616;
      4: stateTransition = 11'd616;
      5: stateTransition = 11'd616;
      6: stateTransition = 11'd616;
      7: stateTransition = 11'd616;
      8: stateTransition = 11'd616;
      default: stateTransition = 11'bX;
    endcase
    617: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd617;
      3: stateTransition = 11'd617;
      4: stateTransition = 11'd617;
      5: stateTransition = 11'd617;
      6: stateTransition = 11'd617;
      7: stateTransition = 11'd617;
      8: stateTransition = 11'd617;
      default: stateTransition = 11'bX;
    endcase
    618: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd618;
      3: stateTransition = 11'd618;
      4: stateTransition = 11'd618;
      5: stateTransition = 11'd618;
      6: stateTransition = 11'd618;
      7: stateTransition = 11'd618;
      8: stateTransition = 11'd618;
      default: stateTransition = 11'bX;
    endcase
    619: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd619;
      3: stateTransition = 11'd619;
      4: stateTransition = 11'd619;
      5: stateTransition = 11'd619;
      6: stateTransition = 11'd619;
      7: stateTransition = 11'd619;
      8: stateTransition = 11'd619;
      default: stateTransition = 11'bX;
    endcase
    620: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd620;
      3: stateTransition = 11'd620;
      4: stateTransition = 11'd620;
      5: stateTransition = 11'd620;
      6: stateTransition = 11'd620;
      7: stateTransition = 11'd620;
      8: stateTransition = 11'd620;
      default: stateTransition = 11'bX;
    endcase
    621: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd621;
      3: stateTransition = 11'd621;
      4: stateTransition = 11'd621;
      5: stateTransition = 11'd621;
      6: stateTransition = 11'd621;
      7: stateTransition = 11'd621;
      8: stateTransition = 11'd621;
      default: stateTransition = 11'bX;
    endcase
    622: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd622;
      3: stateTransition = 11'd622;
      4: stateTransition = 11'd622;
      5: stateTransition = 11'd622;
      6: stateTransition = 11'd622;
      7: stateTransition = 11'd622;
      8: stateTransition = 11'd622;
      default: stateTransition = 11'bX;
    endcase
    623: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd623;
      3: stateTransition = 11'd623;
      4: stateTransition = 11'd623;
      5: stateTransition = 11'd623;
      6: stateTransition = 11'd623;
      7: stateTransition = 11'd623;
      8: stateTransition = 11'd623;
      default: stateTransition = 11'bX;
    endcase
    624: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd624;
      3: stateTransition = 11'd624;
      4: stateTransition = 11'd624;
      5: stateTransition = 11'd624;
      6: stateTransition = 11'd624;
      7: stateTransition = 11'd624;
      8: stateTransition = 11'd624;
      default: stateTransition = 11'bX;
    endcase
    625: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd625;
      3: stateTransition = 11'd625;
      4: stateTransition = 11'd625;
      5: stateTransition = 11'd625;
      6: stateTransition = 11'd625;
      7: stateTransition = 11'd625;
      8: stateTransition = 11'd625;
      default: stateTransition = 11'bX;
    endcase
    626: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd626;
      3: stateTransition = 11'd626;
      4: stateTransition = 11'd626;
      5: stateTransition = 11'd626;
      6: stateTransition = 11'd626;
      7: stateTransition = 11'd626;
      8: stateTransition = 11'd626;
      default: stateTransition = 11'bX;
    endcase
    627: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd627;
      3: stateTransition = 11'd627;
      4: stateTransition = 11'd627;
      5: stateTransition = 11'd627;
      6: stateTransition = 11'd627;
      7: stateTransition = 11'd627;
      8: stateTransition = 11'd627;
      default: stateTransition = 11'bX;
    endcase
    628: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd628;
      3: stateTransition = 11'd628;
      4: stateTransition = 11'd628;
      5: stateTransition = 11'd628;
      6: stateTransition = 11'd628;
      7: stateTransition = 11'd628;
      8: stateTransition = 11'd628;
      default: stateTransition = 11'bX;
    endcase
    629: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd629;
      3: stateTransition = 11'd629;
      4: stateTransition = 11'd629;
      5: stateTransition = 11'd629;
      6: stateTransition = 11'd629;
      7: stateTransition = 11'd629;
      8: stateTransition = 11'd629;
      default: stateTransition = 11'bX;
    endcase
    630: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd630;
      3: stateTransition = 11'd630;
      4: stateTransition = 11'd630;
      5: stateTransition = 11'd630;
      6: stateTransition = 11'd630;
      7: stateTransition = 11'd630;
      8: stateTransition = 11'd630;
      default: stateTransition = 11'bX;
    endcase
    631: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd631;
      3: stateTransition = 11'd631;
      4: stateTransition = 11'd631;
      5: stateTransition = 11'd631;
      6: stateTransition = 11'd631;
      7: stateTransition = 11'd631;
      8: stateTransition = 11'd631;
      default: stateTransition = 11'bX;
    endcase
    632: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd632;
      3: stateTransition = 11'd632;
      4: stateTransition = 11'd632;
      5: stateTransition = 11'd632;
      6: stateTransition = 11'd632;
      7: stateTransition = 11'd632;
      8: stateTransition = 11'd632;
      default: stateTransition = 11'bX;
    endcase
    633: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd633;
      3: stateTransition = 11'd633;
      4: stateTransition = 11'd633;
      5: stateTransition = 11'd633;
      6: stateTransition = 11'd633;
      7: stateTransition = 11'd633;
      8: stateTransition = 11'd633;
      default: stateTransition = 11'bX;
    endcase
    634: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd634;
      3: stateTransition = 11'd634;
      4: stateTransition = 11'd634;
      5: stateTransition = 11'd634;
      6: stateTransition = 11'd634;
      7: stateTransition = 11'd634;
      8: stateTransition = 11'd634;
      default: stateTransition = 11'bX;
    endcase
    635: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd635;
      3: stateTransition = 11'd635;
      4: stateTransition = 11'd635;
      5: stateTransition = 11'd635;
      6: stateTransition = 11'd635;
      7: stateTransition = 11'd635;
      8: stateTransition = 11'd635;
      default: stateTransition = 11'bX;
    endcase
    636: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd636;
      3: stateTransition = 11'd636;
      4: stateTransition = 11'd636;
      5: stateTransition = 11'd636;
      6: stateTransition = 11'd636;
      7: stateTransition = 11'd636;
      8: stateTransition = 11'd636;
      default: stateTransition = 11'bX;
    endcase
    637: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd637;
      3: stateTransition = 11'd637;
      4: stateTransition = 11'd637;
      5: stateTransition = 11'd637;
      6: stateTransition = 11'd637;
      7: stateTransition = 11'd637;
      8: stateTransition = 11'd637;
      default: stateTransition = 11'bX;
    endcase
    638: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd638;
      3: stateTransition = 11'd638;
      4: stateTransition = 11'd638;
      5: stateTransition = 11'd638;
      6: stateTransition = 11'd638;
      7: stateTransition = 11'd638;
      8: stateTransition = 11'd638;
      default: stateTransition = 11'bX;
    endcase
    639: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd639;
      3: stateTransition = 11'd639;
      4: stateTransition = 11'd639;
      5: stateTransition = 11'd639;
      6: stateTransition = 11'd639;
      7: stateTransition = 11'd639;
      8: stateTransition = 11'd639;
      default: stateTransition = 11'bX;
    endcase
    640: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd640;
      3: stateTransition = 11'd640;
      4: stateTransition = 11'd640;
      5: stateTransition = 11'd640;
      6: stateTransition = 11'd640;
      7: stateTransition = 11'd640;
      8: stateTransition = 11'd640;
      default: stateTransition = 11'bX;
    endcase
    641: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd641;
      3: stateTransition = 11'd641;
      4: stateTransition = 11'd641;
      5: stateTransition = 11'd641;
      6: stateTransition = 11'd641;
      7: stateTransition = 11'd641;
      8: stateTransition = 11'd641;
      default: stateTransition = 11'bX;
    endcase
    642: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd642;
      3: stateTransition = 11'd642;
      4: stateTransition = 11'd642;
      5: stateTransition = 11'd642;
      6: stateTransition = 11'd642;
      7: stateTransition = 11'd642;
      8: stateTransition = 11'd642;
      default: stateTransition = 11'bX;
    endcase
    643: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd643;
      3: stateTransition = 11'd643;
      4: stateTransition = 11'd643;
      5: stateTransition = 11'd643;
      6: stateTransition = 11'd643;
      7: stateTransition = 11'd643;
      8: stateTransition = 11'd643;
      default: stateTransition = 11'bX;
    endcase
    644: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd644;
      3: stateTransition = 11'd644;
      4: stateTransition = 11'd644;
      5: stateTransition = 11'd644;
      6: stateTransition = 11'd644;
      7: stateTransition = 11'd644;
      8: stateTransition = 11'd644;
      default: stateTransition = 11'bX;
    endcase
    645: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd645;
      3: stateTransition = 11'd645;
      4: stateTransition = 11'd645;
      5: stateTransition = 11'd645;
      6: stateTransition = 11'd645;
      7: stateTransition = 11'd645;
      8: stateTransition = 11'd645;
      default: stateTransition = 11'bX;
    endcase
    646: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd646;
      3: stateTransition = 11'd646;
      4: stateTransition = 11'd646;
      5: stateTransition = 11'd646;
      6: stateTransition = 11'd646;
      7: stateTransition = 11'd646;
      8: stateTransition = 11'd646;
      default: stateTransition = 11'bX;
    endcase
    647: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd647;
      3: stateTransition = 11'd647;
      4: stateTransition = 11'd647;
      5: stateTransition = 11'd647;
      6: stateTransition = 11'd647;
      7: stateTransition = 11'd647;
      8: stateTransition = 11'd647;
      default: stateTransition = 11'bX;
    endcase
    648: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd648;
      3: stateTransition = 11'd648;
      4: stateTransition = 11'd648;
      5: stateTransition = 11'd648;
      6: stateTransition = 11'd648;
      7: stateTransition = 11'd648;
      8: stateTransition = 11'd648;
      default: stateTransition = 11'bX;
    endcase
    649: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd649;
      3: stateTransition = 11'd649;
      4: stateTransition = 11'd649;
      5: stateTransition = 11'd649;
      6: stateTransition = 11'd649;
      7: stateTransition = 11'd649;
      8: stateTransition = 11'd649;
      default: stateTransition = 11'bX;
    endcase
    650: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd650;
      3: stateTransition = 11'd650;
      4: stateTransition = 11'd650;
      5: stateTransition = 11'd650;
      6: stateTransition = 11'd650;
      7: stateTransition = 11'd650;
      8: stateTransition = 11'd650;
      default: stateTransition = 11'bX;
    endcase
    651: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd651;
      3: stateTransition = 11'd651;
      4: stateTransition = 11'd651;
      5: stateTransition = 11'd651;
      6: stateTransition = 11'd651;
      7: stateTransition = 11'd651;
      8: stateTransition = 11'd651;
      default: stateTransition = 11'bX;
    endcase
    652: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd652;
      3: stateTransition = 11'd652;
      4: stateTransition = 11'd652;
      5: stateTransition = 11'd652;
      6: stateTransition = 11'd652;
      7: stateTransition = 11'd652;
      8: stateTransition = 11'd652;
      default: stateTransition = 11'bX;
    endcase
    653: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd653;
      3: stateTransition = 11'd653;
      4: stateTransition = 11'd653;
      5: stateTransition = 11'd653;
      6: stateTransition = 11'd653;
      7: stateTransition = 11'd653;
      8: stateTransition = 11'd653;
      default: stateTransition = 11'bX;
    endcase
    654: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd654;
      3: stateTransition = 11'd654;
      4: stateTransition = 11'd654;
      5: stateTransition = 11'd654;
      6: stateTransition = 11'd654;
      7: stateTransition = 11'd654;
      8: stateTransition = 11'd654;
      default: stateTransition = 11'bX;
    endcase
    655: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd655;
      3: stateTransition = 11'd655;
      4: stateTransition = 11'd655;
      5: stateTransition = 11'd655;
      6: stateTransition = 11'd655;
      7: stateTransition = 11'd655;
      8: stateTransition = 11'd655;
      default: stateTransition = 11'bX;
    endcase
    656: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd656;
      3: stateTransition = 11'd656;
      4: stateTransition = 11'd656;
      5: stateTransition = 11'd656;
      6: stateTransition = 11'd656;
      7: stateTransition = 11'd656;
      8: stateTransition = 11'd656;
      default: stateTransition = 11'bX;
    endcase
    657: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd657;
      3: stateTransition = 11'd657;
      4: stateTransition = 11'd657;
      5: stateTransition = 11'd657;
      6: stateTransition = 11'd657;
      7: stateTransition = 11'd657;
      8: stateTransition = 11'd657;
      default: stateTransition = 11'bX;
    endcase
    658: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd658;
      3: stateTransition = 11'd658;
      4: stateTransition = 11'd658;
      5: stateTransition = 11'd658;
      6: stateTransition = 11'd658;
      7: stateTransition = 11'd658;
      8: stateTransition = 11'd658;
      default: stateTransition = 11'bX;
    endcase
    659: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd659;
      3: stateTransition = 11'd659;
      4: stateTransition = 11'd659;
      5: stateTransition = 11'd659;
      6: stateTransition = 11'd659;
      7: stateTransition = 11'd659;
      8: stateTransition = 11'd659;
      default: stateTransition = 11'bX;
    endcase
    660: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd660;
      3: stateTransition = 11'd660;
      4: stateTransition = 11'd660;
      5: stateTransition = 11'd660;
      6: stateTransition = 11'd660;
      7: stateTransition = 11'd660;
      8: stateTransition = 11'd660;
      default: stateTransition = 11'bX;
    endcase
    661: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd661;
      3: stateTransition = 11'd661;
      4: stateTransition = 11'd661;
      5: stateTransition = 11'd661;
      6: stateTransition = 11'd661;
      7: stateTransition = 11'd661;
      8: stateTransition = 11'd661;
      default: stateTransition = 11'bX;
    endcase
    662: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd662;
      3: stateTransition = 11'd662;
      4: stateTransition = 11'd662;
      5: stateTransition = 11'd662;
      6: stateTransition = 11'd662;
      7: stateTransition = 11'd662;
      8: stateTransition = 11'd662;
      default: stateTransition = 11'bX;
    endcase
    663: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd663;
      3: stateTransition = 11'd663;
      4: stateTransition = 11'd663;
      5: stateTransition = 11'd663;
      6: stateTransition = 11'd663;
      7: stateTransition = 11'd663;
      8: stateTransition = 11'd663;
      default: stateTransition = 11'bX;
    endcase
    664: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd664;
      3: stateTransition = 11'd664;
      4: stateTransition = 11'd664;
      5: stateTransition = 11'd664;
      6: stateTransition = 11'd664;
      7: stateTransition = 11'd664;
      8: stateTransition = 11'd664;
      default: stateTransition = 11'bX;
    endcase
    665: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd665;
      3: stateTransition = 11'd665;
      4: stateTransition = 11'd665;
      5: stateTransition = 11'd665;
      6: stateTransition = 11'd665;
      7: stateTransition = 11'd665;
      8: stateTransition = 11'd665;
      default: stateTransition = 11'bX;
    endcase
    666: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd666;
      3: stateTransition = 11'd666;
      4: stateTransition = 11'd666;
      5: stateTransition = 11'd666;
      6: stateTransition = 11'd666;
      7: stateTransition = 11'd666;
      8: stateTransition = 11'd666;
      default: stateTransition = 11'bX;
    endcase
    667: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd667;
      3: stateTransition = 11'd667;
      4: stateTransition = 11'd667;
      5: stateTransition = 11'd667;
      6: stateTransition = 11'd667;
      7: stateTransition = 11'd667;
      8: stateTransition = 11'd667;
      default: stateTransition = 11'bX;
    endcase
    668: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd668;
      3: stateTransition = 11'd668;
      4: stateTransition = 11'd668;
      5: stateTransition = 11'd668;
      6: stateTransition = 11'd668;
      7: stateTransition = 11'd668;
      8: stateTransition = 11'd668;
      default: stateTransition = 11'bX;
    endcase
    669: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd669;
      3: stateTransition = 11'd669;
      4: stateTransition = 11'd669;
      5: stateTransition = 11'd669;
      6: stateTransition = 11'd669;
      7: stateTransition = 11'd669;
      8: stateTransition = 11'd669;
      default: stateTransition = 11'bX;
    endcase
    670: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd670;
      3: stateTransition = 11'd670;
      4: stateTransition = 11'd670;
      5: stateTransition = 11'd670;
      6: stateTransition = 11'd670;
      7: stateTransition = 11'd670;
      8: stateTransition = 11'd670;
      default: stateTransition = 11'bX;
    endcase
    671: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd671;
      3: stateTransition = 11'd671;
      4: stateTransition = 11'd671;
      5: stateTransition = 11'd671;
      6: stateTransition = 11'd671;
      7: stateTransition = 11'd671;
      8: stateTransition = 11'd671;
      default: stateTransition = 11'bX;
    endcase
    672: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd672;
      3: stateTransition = 11'd672;
      4: stateTransition = 11'd672;
      5: stateTransition = 11'd672;
      6: stateTransition = 11'd672;
      7: stateTransition = 11'd672;
      8: stateTransition = 11'd672;
      default: stateTransition = 11'bX;
    endcase
    673: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd673;
      3: stateTransition = 11'd673;
      4: stateTransition = 11'd673;
      5: stateTransition = 11'd673;
      6: stateTransition = 11'd673;
      7: stateTransition = 11'd673;
      8: stateTransition = 11'd673;
      default: stateTransition = 11'bX;
    endcase
    674: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd674;
      3: stateTransition = 11'd674;
      4: stateTransition = 11'd674;
      5: stateTransition = 11'd674;
      6: stateTransition = 11'd674;
      7: stateTransition = 11'd674;
      8: stateTransition = 11'd674;
      default: stateTransition = 11'bX;
    endcase
    675: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd675;
      3: stateTransition = 11'd675;
      4: stateTransition = 11'd675;
      5: stateTransition = 11'd675;
      6: stateTransition = 11'd675;
      7: stateTransition = 11'd675;
      8: stateTransition = 11'd675;
      default: stateTransition = 11'bX;
    endcase
    676: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd676;
      3: stateTransition = 11'd676;
      4: stateTransition = 11'd676;
      5: stateTransition = 11'd676;
      6: stateTransition = 11'd676;
      7: stateTransition = 11'd676;
      8: stateTransition = 11'd676;
      default: stateTransition = 11'bX;
    endcase
    677: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd677;
      3: stateTransition = 11'd677;
      4: stateTransition = 11'd677;
      5: stateTransition = 11'd677;
      6: stateTransition = 11'd677;
      7: stateTransition = 11'd677;
      8: stateTransition = 11'd677;
      default: stateTransition = 11'bX;
    endcase
    678: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd678;
      3: stateTransition = 11'd678;
      4: stateTransition = 11'd678;
      5: stateTransition = 11'd678;
      6: stateTransition = 11'd678;
      7: stateTransition = 11'd678;
      8: stateTransition = 11'd678;
      default: stateTransition = 11'bX;
    endcase
    679: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd679;
      3: stateTransition = 11'd679;
      4: stateTransition = 11'd679;
      5: stateTransition = 11'd679;
      6: stateTransition = 11'd679;
      7: stateTransition = 11'd679;
      8: stateTransition = 11'd679;
      default: stateTransition = 11'bX;
    endcase
    680: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd680;
      3: stateTransition = 11'd680;
      4: stateTransition = 11'd680;
      5: stateTransition = 11'd680;
      6: stateTransition = 11'd680;
      7: stateTransition = 11'd680;
      8: stateTransition = 11'd680;
      default: stateTransition = 11'bX;
    endcase
    681: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd681;
      3: stateTransition = 11'd681;
      4: stateTransition = 11'd681;
      5: stateTransition = 11'd681;
      6: stateTransition = 11'd681;
      7: stateTransition = 11'd681;
      8: stateTransition = 11'd681;
      default: stateTransition = 11'bX;
    endcase
    682: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd682;
      3: stateTransition = 11'd682;
      4: stateTransition = 11'd682;
      5: stateTransition = 11'd682;
      6: stateTransition = 11'd682;
      7: stateTransition = 11'd682;
      8: stateTransition = 11'd682;
      default: stateTransition = 11'bX;
    endcase
    683: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd683;
      3: stateTransition = 11'd683;
      4: stateTransition = 11'd683;
      5: stateTransition = 11'd683;
      6: stateTransition = 11'd683;
      7: stateTransition = 11'd683;
      8: stateTransition = 11'd683;
      default: stateTransition = 11'bX;
    endcase
    684: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd684;
      3: stateTransition = 11'd684;
      4: stateTransition = 11'd684;
      5: stateTransition = 11'd684;
      6: stateTransition = 11'd684;
      7: stateTransition = 11'd684;
      8: stateTransition = 11'd684;
      default: stateTransition = 11'bX;
    endcase
    685: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd685;
      3: stateTransition = 11'd685;
      4: stateTransition = 11'd685;
      5: stateTransition = 11'd685;
      6: stateTransition = 11'd685;
      7: stateTransition = 11'd685;
      8: stateTransition = 11'd685;
      default: stateTransition = 11'bX;
    endcase
    686: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd686;
      3: stateTransition = 11'd686;
      4: stateTransition = 11'd686;
      5: stateTransition = 11'd686;
      6: stateTransition = 11'd686;
      7: stateTransition = 11'd686;
      8: stateTransition = 11'd686;
      default: stateTransition = 11'bX;
    endcase
    687: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd687;
      3: stateTransition = 11'd687;
      4: stateTransition = 11'd687;
      5: stateTransition = 11'd687;
      6: stateTransition = 11'd687;
      7: stateTransition = 11'd687;
      8: stateTransition = 11'd687;
      default: stateTransition = 11'bX;
    endcase
    688: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd688;
      3: stateTransition = 11'd688;
      4: stateTransition = 11'd688;
      5: stateTransition = 11'd688;
      6: stateTransition = 11'd688;
      7: stateTransition = 11'd688;
      8: stateTransition = 11'd688;
      default: stateTransition = 11'bX;
    endcase
    689: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd689;
      3: stateTransition = 11'd689;
      4: stateTransition = 11'd689;
      5: stateTransition = 11'd689;
      6: stateTransition = 11'd689;
      7: stateTransition = 11'd689;
      8: stateTransition = 11'd689;
      default: stateTransition = 11'bX;
    endcase
    690: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd690;
      3: stateTransition = 11'd690;
      4: stateTransition = 11'd690;
      5: stateTransition = 11'd690;
      6: stateTransition = 11'd690;
      7: stateTransition = 11'd690;
      8: stateTransition = 11'd690;
      default: stateTransition = 11'bX;
    endcase
    691: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd691;
      3: stateTransition = 11'd691;
      4: stateTransition = 11'd691;
      5: stateTransition = 11'd691;
      6: stateTransition = 11'd691;
      7: stateTransition = 11'd691;
      8: stateTransition = 11'd691;
      default: stateTransition = 11'bX;
    endcase
    692: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd692;
      3: stateTransition = 11'd692;
      4: stateTransition = 11'd692;
      5: stateTransition = 11'd692;
      6: stateTransition = 11'd692;
      7: stateTransition = 11'd692;
      8: stateTransition = 11'd692;
      default: stateTransition = 11'bX;
    endcase
    693: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd693;
      3: stateTransition = 11'd693;
      4: stateTransition = 11'd693;
      5: stateTransition = 11'd693;
      6: stateTransition = 11'd693;
      7: stateTransition = 11'd693;
      8: stateTransition = 11'd693;
      default: stateTransition = 11'bX;
    endcase
    694: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd694;
      3: stateTransition = 11'd694;
      4: stateTransition = 11'd694;
      5: stateTransition = 11'd694;
      6: stateTransition = 11'd694;
      7: stateTransition = 11'd694;
      8: stateTransition = 11'd694;
      default: stateTransition = 11'bX;
    endcase
    695: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd695;
      3: stateTransition = 11'd695;
      4: stateTransition = 11'd695;
      5: stateTransition = 11'd695;
      6: stateTransition = 11'd695;
      7: stateTransition = 11'd695;
      8: stateTransition = 11'd695;
      default: stateTransition = 11'bX;
    endcase
    696: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd696;
      3: stateTransition = 11'd696;
      4: stateTransition = 11'd696;
      5: stateTransition = 11'd696;
      6: stateTransition = 11'd696;
      7: stateTransition = 11'd696;
      8: stateTransition = 11'd696;
      default: stateTransition = 11'bX;
    endcase
    697: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd697;
      3: stateTransition = 11'd697;
      4: stateTransition = 11'd697;
      5: stateTransition = 11'd697;
      6: stateTransition = 11'd697;
      7: stateTransition = 11'd697;
      8: stateTransition = 11'd697;
      default: stateTransition = 11'bX;
    endcase
    698: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd698;
      3: stateTransition = 11'd698;
      4: stateTransition = 11'd698;
      5: stateTransition = 11'd698;
      6: stateTransition = 11'd698;
      7: stateTransition = 11'd698;
      8: stateTransition = 11'd698;
      default: stateTransition = 11'bX;
    endcase
    699: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd699;
      3: stateTransition = 11'd699;
      4: stateTransition = 11'd699;
      5: stateTransition = 11'd699;
      6: stateTransition = 11'd699;
      7: stateTransition = 11'd699;
      8: stateTransition = 11'd699;
      default: stateTransition = 11'bX;
    endcase
    700: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd700;
      3: stateTransition = 11'd700;
      4: stateTransition = 11'd700;
      5: stateTransition = 11'd700;
      6: stateTransition = 11'd700;
      7: stateTransition = 11'd700;
      8: stateTransition = 11'd700;
      default: stateTransition = 11'bX;
    endcase
    701: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd701;
      3: stateTransition = 11'd701;
      4: stateTransition = 11'd701;
      5: stateTransition = 11'd701;
      6: stateTransition = 11'd701;
      7: stateTransition = 11'd701;
      8: stateTransition = 11'd701;
      default: stateTransition = 11'bX;
    endcase
    702: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd702;
      3: stateTransition = 11'd702;
      4: stateTransition = 11'd702;
      5: stateTransition = 11'd702;
      6: stateTransition = 11'd702;
      7: stateTransition = 11'd702;
      8: stateTransition = 11'd702;
      default: stateTransition = 11'bX;
    endcase
    703: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd703;
      3: stateTransition = 11'd703;
      4: stateTransition = 11'd703;
      5: stateTransition = 11'd703;
      6: stateTransition = 11'd703;
      7: stateTransition = 11'd703;
      8: stateTransition = 11'd703;
      default: stateTransition = 11'bX;
    endcase
    704: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd704;
      3: stateTransition = 11'd704;
      4: stateTransition = 11'd704;
      5: stateTransition = 11'd704;
      6: stateTransition = 11'd704;
      7: stateTransition = 11'd704;
      8: stateTransition = 11'd704;
      default: stateTransition = 11'bX;
    endcase
    705: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd705;
      3: stateTransition = 11'd705;
      4: stateTransition = 11'd705;
      5: stateTransition = 11'd705;
      6: stateTransition = 11'd705;
      7: stateTransition = 11'd705;
      8: stateTransition = 11'd705;
      default: stateTransition = 11'bX;
    endcase
    706: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd706;
      3: stateTransition = 11'd706;
      4: stateTransition = 11'd706;
      5: stateTransition = 11'd706;
      6: stateTransition = 11'd706;
      7: stateTransition = 11'd706;
      8: stateTransition = 11'd706;
      default: stateTransition = 11'bX;
    endcase
    707: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd707;
      3: stateTransition = 11'd707;
      4: stateTransition = 11'd707;
      5: stateTransition = 11'd707;
      6: stateTransition = 11'd707;
      7: stateTransition = 11'd707;
      8: stateTransition = 11'd707;
      default: stateTransition = 11'bX;
    endcase
    708: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd708;
      3: stateTransition = 11'd708;
      4: stateTransition = 11'd708;
      5: stateTransition = 11'd708;
      6: stateTransition = 11'd708;
      7: stateTransition = 11'd708;
      8: stateTransition = 11'd708;
      default: stateTransition = 11'bX;
    endcase
    709: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd709;
      3: stateTransition = 11'd709;
      4: stateTransition = 11'd709;
      5: stateTransition = 11'd709;
      6: stateTransition = 11'd709;
      7: stateTransition = 11'd709;
      8: stateTransition = 11'd709;
      default: stateTransition = 11'bX;
    endcase
    710: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd710;
      3: stateTransition = 11'd710;
      4: stateTransition = 11'd710;
      5: stateTransition = 11'd710;
      6: stateTransition = 11'd710;
      7: stateTransition = 11'd710;
      8: stateTransition = 11'd710;
      default: stateTransition = 11'bX;
    endcase
    711: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd711;
      3: stateTransition = 11'd711;
      4: stateTransition = 11'd711;
      5: stateTransition = 11'd711;
      6: stateTransition = 11'd711;
      7: stateTransition = 11'd711;
      8: stateTransition = 11'd711;
      default: stateTransition = 11'bX;
    endcase
    712: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd712;
      3: stateTransition = 11'd712;
      4: stateTransition = 11'd712;
      5: stateTransition = 11'd712;
      6: stateTransition = 11'd712;
      7: stateTransition = 11'd712;
      8: stateTransition = 11'd712;
      default: stateTransition = 11'bX;
    endcase
    713: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd713;
      3: stateTransition = 11'd713;
      4: stateTransition = 11'd713;
      5: stateTransition = 11'd713;
      6: stateTransition = 11'd713;
      7: stateTransition = 11'd713;
      8: stateTransition = 11'd713;
      default: stateTransition = 11'bX;
    endcase
    714: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd714;
      3: stateTransition = 11'd714;
      4: stateTransition = 11'd714;
      5: stateTransition = 11'd714;
      6: stateTransition = 11'd714;
      7: stateTransition = 11'd714;
      8: stateTransition = 11'd714;
      default: stateTransition = 11'bX;
    endcase
    715: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd715;
      3: stateTransition = 11'd715;
      4: stateTransition = 11'd715;
      5: stateTransition = 11'd715;
      6: stateTransition = 11'd715;
      7: stateTransition = 11'd715;
      8: stateTransition = 11'd715;
      default: stateTransition = 11'bX;
    endcase
    716: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd716;
      3: stateTransition = 11'd716;
      4: stateTransition = 11'd716;
      5: stateTransition = 11'd716;
      6: stateTransition = 11'd716;
      7: stateTransition = 11'd716;
      8: stateTransition = 11'd716;
      default: stateTransition = 11'bX;
    endcase
    717: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd717;
      3: stateTransition = 11'd717;
      4: stateTransition = 11'd717;
      5: stateTransition = 11'd717;
      6: stateTransition = 11'd717;
      7: stateTransition = 11'd717;
      8: stateTransition = 11'd717;
      default: stateTransition = 11'bX;
    endcase
    718: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd718;
      3: stateTransition = 11'd718;
      4: stateTransition = 11'd718;
      5: stateTransition = 11'd718;
      6: stateTransition = 11'd718;
      7: stateTransition = 11'd718;
      8: stateTransition = 11'd718;
      default: stateTransition = 11'bX;
    endcase
    719: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd719;
      3: stateTransition = 11'd719;
      4: stateTransition = 11'd719;
      5: stateTransition = 11'd719;
      6: stateTransition = 11'd719;
      7: stateTransition = 11'd719;
      8: stateTransition = 11'd719;
      default: stateTransition = 11'bX;
    endcase
    720: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd720;
      3: stateTransition = 11'd720;
      4: stateTransition = 11'd720;
      5: stateTransition = 11'd720;
      6: stateTransition = 11'd720;
      7: stateTransition = 11'd720;
      8: stateTransition = 11'd720;
      default: stateTransition = 11'bX;
    endcase
    721: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd721;
      3: stateTransition = 11'd721;
      4: stateTransition = 11'd721;
      5: stateTransition = 11'd721;
      6: stateTransition = 11'd721;
      7: stateTransition = 11'd721;
      8: stateTransition = 11'd721;
      default: stateTransition = 11'bX;
    endcase
    722: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd722;
      3: stateTransition = 11'd722;
      4: stateTransition = 11'd722;
      5: stateTransition = 11'd722;
      6: stateTransition = 11'd722;
      7: stateTransition = 11'd722;
      8: stateTransition = 11'd722;
      default: stateTransition = 11'bX;
    endcase
    723: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd723;
      3: stateTransition = 11'd723;
      4: stateTransition = 11'd723;
      5: stateTransition = 11'd723;
      6: stateTransition = 11'd723;
      7: stateTransition = 11'd723;
      8: stateTransition = 11'd723;
      default: stateTransition = 11'bX;
    endcase
    724: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd724;
      3: stateTransition = 11'd724;
      4: stateTransition = 11'd724;
      5: stateTransition = 11'd724;
      6: stateTransition = 11'd724;
      7: stateTransition = 11'd724;
      8: stateTransition = 11'd724;
      default: stateTransition = 11'bX;
    endcase
    725: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd725;
      3: stateTransition = 11'd725;
      4: stateTransition = 11'd725;
      5: stateTransition = 11'd725;
      6: stateTransition = 11'd725;
      7: stateTransition = 11'd725;
      8: stateTransition = 11'd725;
      default: stateTransition = 11'bX;
    endcase
    726: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd726;
      3: stateTransition = 11'd726;
      4: stateTransition = 11'd726;
      5: stateTransition = 11'd726;
      6: stateTransition = 11'd726;
      7: stateTransition = 11'd726;
      8: stateTransition = 11'd726;
      default: stateTransition = 11'bX;
    endcase
    727: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd727;
      3: stateTransition = 11'd727;
      4: stateTransition = 11'd727;
      5: stateTransition = 11'd727;
      6: stateTransition = 11'd727;
      7: stateTransition = 11'd727;
      8: stateTransition = 11'd727;
      default: stateTransition = 11'bX;
    endcase
    728: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd728;
      3: stateTransition = 11'd728;
      4: stateTransition = 11'd728;
      5: stateTransition = 11'd728;
      6: stateTransition = 11'd728;
      7: stateTransition = 11'd728;
      8: stateTransition = 11'd728;
      default: stateTransition = 11'bX;
    endcase
    729: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd729;
      3: stateTransition = 11'd729;
      4: stateTransition = 11'd729;
      5: stateTransition = 11'd729;
      6: stateTransition = 11'd729;
      7: stateTransition = 11'd729;
      8: stateTransition = 11'd729;
      default: stateTransition = 11'bX;
    endcase
    730: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd730;
      3: stateTransition = 11'd730;
      4: stateTransition = 11'd730;
      5: stateTransition = 11'd730;
      6: stateTransition = 11'd730;
      7: stateTransition = 11'd730;
      8: stateTransition = 11'd730;
      default: stateTransition = 11'bX;
    endcase
    731: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd731;
      3: stateTransition = 11'd731;
      4: stateTransition = 11'd731;
      5: stateTransition = 11'd731;
      6: stateTransition = 11'd731;
      7: stateTransition = 11'd731;
      8: stateTransition = 11'd731;
      default: stateTransition = 11'bX;
    endcase
    732: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd732;
      3: stateTransition = 11'd732;
      4: stateTransition = 11'd732;
      5: stateTransition = 11'd732;
      6: stateTransition = 11'd732;
      7: stateTransition = 11'd732;
      8: stateTransition = 11'd732;
      default: stateTransition = 11'bX;
    endcase
    733: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd733;
      3: stateTransition = 11'd733;
      4: stateTransition = 11'd733;
      5: stateTransition = 11'd733;
      6: stateTransition = 11'd733;
      7: stateTransition = 11'd733;
      8: stateTransition = 11'd733;
      default: stateTransition = 11'bX;
    endcase
    734: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd734;
      3: stateTransition = 11'd734;
      4: stateTransition = 11'd734;
      5: stateTransition = 11'd734;
      6: stateTransition = 11'd734;
      7: stateTransition = 11'd734;
      8: stateTransition = 11'd734;
      default: stateTransition = 11'bX;
    endcase
    735: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd735;
      3: stateTransition = 11'd735;
      4: stateTransition = 11'd735;
      5: stateTransition = 11'd735;
      6: stateTransition = 11'd735;
      7: stateTransition = 11'd735;
      8: stateTransition = 11'd735;
      default: stateTransition = 11'bX;
    endcase
    736: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd736;
      3: stateTransition = 11'd736;
      4: stateTransition = 11'd736;
      5: stateTransition = 11'd736;
      6: stateTransition = 11'd736;
      7: stateTransition = 11'd736;
      8: stateTransition = 11'd736;
      default: stateTransition = 11'bX;
    endcase
    737: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd737;
      3: stateTransition = 11'd737;
      4: stateTransition = 11'd737;
      5: stateTransition = 11'd737;
      6: stateTransition = 11'd737;
      7: stateTransition = 11'd737;
      8: stateTransition = 11'd737;
      default: stateTransition = 11'bX;
    endcase
    738: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd738;
      3: stateTransition = 11'd738;
      4: stateTransition = 11'd738;
      5: stateTransition = 11'd738;
      6: stateTransition = 11'd738;
      7: stateTransition = 11'd738;
      8: stateTransition = 11'd738;
      default: stateTransition = 11'bX;
    endcase
    739: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd739;
      3: stateTransition = 11'd739;
      4: stateTransition = 11'd739;
      5: stateTransition = 11'd739;
      6: stateTransition = 11'd739;
      7: stateTransition = 11'd739;
      8: stateTransition = 11'd739;
      default: stateTransition = 11'bX;
    endcase
    740: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd740;
      3: stateTransition = 11'd740;
      4: stateTransition = 11'd740;
      5: stateTransition = 11'd740;
      6: stateTransition = 11'd740;
      7: stateTransition = 11'd740;
      8: stateTransition = 11'd740;
      default: stateTransition = 11'bX;
    endcase
    741: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd741;
      3: stateTransition = 11'd741;
      4: stateTransition = 11'd741;
      5: stateTransition = 11'd741;
      6: stateTransition = 11'd741;
      7: stateTransition = 11'd741;
      8: stateTransition = 11'd741;
      default: stateTransition = 11'bX;
    endcase
    742: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd742;
      3: stateTransition = 11'd742;
      4: stateTransition = 11'd742;
      5: stateTransition = 11'd742;
      6: stateTransition = 11'd742;
      7: stateTransition = 11'd742;
      8: stateTransition = 11'd742;
      default: stateTransition = 11'bX;
    endcase
    743: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd743;
      3: stateTransition = 11'd743;
      4: stateTransition = 11'd743;
      5: stateTransition = 11'd743;
      6: stateTransition = 11'd743;
      7: stateTransition = 11'd743;
      8: stateTransition = 11'd743;
      default: stateTransition = 11'bX;
    endcase
    744: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd744;
      3: stateTransition = 11'd744;
      4: stateTransition = 11'd744;
      5: stateTransition = 11'd744;
      6: stateTransition = 11'd744;
      7: stateTransition = 11'd744;
      8: stateTransition = 11'd744;
      default: stateTransition = 11'bX;
    endcase
    745: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd745;
      3: stateTransition = 11'd745;
      4: stateTransition = 11'd745;
      5: stateTransition = 11'd745;
      6: stateTransition = 11'd745;
      7: stateTransition = 11'd745;
      8: stateTransition = 11'd745;
      default: stateTransition = 11'bX;
    endcase
    746: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd746;
      3: stateTransition = 11'd746;
      4: stateTransition = 11'd746;
      5: stateTransition = 11'd746;
      6: stateTransition = 11'd746;
      7: stateTransition = 11'd746;
      8: stateTransition = 11'd746;
      default: stateTransition = 11'bX;
    endcase
    747: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd747;
      3: stateTransition = 11'd747;
      4: stateTransition = 11'd747;
      5: stateTransition = 11'd747;
      6: stateTransition = 11'd747;
      7: stateTransition = 11'd747;
      8: stateTransition = 11'd747;
      default: stateTransition = 11'bX;
    endcase
    748: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd748;
      3: stateTransition = 11'd748;
      4: stateTransition = 11'd748;
      5: stateTransition = 11'd748;
      6: stateTransition = 11'd748;
      7: stateTransition = 11'd748;
      8: stateTransition = 11'd748;
      default: stateTransition = 11'bX;
    endcase
    749: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd749;
      3: stateTransition = 11'd749;
      4: stateTransition = 11'd749;
      5: stateTransition = 11'd749;
      6: stateTransition = 11'd749;
      7: stateTransition = 11'd749;
      8: stateTransition = 11'd749;
      default: stateTransition = 11'bX;
    endcase
    750: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd750;
      3: stateTransition = 11'd750;
      4: stateTransition = 11'd750;
      5: stateTransition = 11'd750;
      6: stateTransition = 11'd750;
      7: stateTransition = 11'd750;
      8: stateTransition = 11'd750;
      default: stateTransition = 11'bX;
    endcase
    751: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd751;
      3: stateTransition = 11'd751;
      4: stateTransition = 11'd751;
      5: stateTransition = 11'd751;
      6: stateTransition = 11'd751;
      7: stateTransition = 11'd751;
      8: stateTransition = 11'd751;
      default: stateTransition = 11'bX;
    endcase
    752: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd752;
      3: stateTransition = 11'd752;
      4: stateTransition = 11'd752;
      5: stateTransition = 11'd752;
      6: stateTransition = 11'd752;
      7: stateTransition = 11'd752;
      8: stateTransition = 11'd752;
      default: stateTransition = 11'bX;
    endcase
    753: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd753;
      3: stateTransition = 11'd753;
      4: stateTransition = 11'd753;
      5: stateTransition = 11'd753;
      6: stateTransition = 11'd753;
      7: stateTransition = 11'd753;
      8: stateTransition = 11'd753;
      default: stateTransition = 11'bX;
    endcase
    754: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd754;
      3: stateTransition = 11'd754;
      4: stateTransition = 11'd754;
      5: stateTransition = 11'd754;
      6: stateTransition = 11'd754;
      7: stateTransition = 11'd754;
      8: stateTransition = 11'd754;
      default: stateTransition = 11'bX;
    endcase
    755: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd755;
      3: stateTransition = 11'd755;
      4: stateTransition = 11'd755;
      5: stateTransition = 11'd755;
      6: stateTransition = 11'd755;
      7: stateTransition = 11'd755;
      8: stateTransition = 11'd755;
      default: stateTransition = 11'bX;
    endcase
    756: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd756;
      3: stateTransition = 11'd756;
      4: stateTransition = 11'd756;
      5: stateTransition = 11'd756;
      6: stateTransition = 11'd756;
      7: stateTransition = 11'd756;
      8: stateTransition = 11'd756;
      default: stateTransition = 11'bX;
    endcase
    757: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd757;
      3: stateTransition = 11'd757;
      4: stateTransition = 11'd757;
      5: stateTransition = 11'd757;
      6: stateTransition = 11'd757;
      7: stateTransition = 11'd757;
      8: stateTransition = 11'd757;
      default: stateTransition = 11'bX;
    endcase
    758: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd758;
      3: stateTransition = 11'd758;
      4: stateTransition = 11'd758;
      5: stateTransition = 11'd758;
      6: stateTransition = 11'd758;
      7: stateTransition = 11'd758;
      8: stateTransition = 11'd758;
      default: stateTransition = 11'bX;
    endcase
    759: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd759;
      3: stateTransition = 11'd759;
      4: stateTransition = 11'd759;
      5: stateTransition = 11'd759;
      6: stateTransition = 11'd759;
      7: stateTransition = 11'd759;
      8: stateTransition = 11'd759;
      default: stateTransition = 11'bX;
    endcase
    760: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd760;
      3: stateTransition = 11'd760;
      4: stateTransition = 11'd760;
      5: stateTransition = 11'd760;
      6: stateTransition = 11'd760;
      7: stateTransition = 11'd760;
      8: stateTransition = 11'd760;
      default: stateTransition = 11'bX;
    endcase
    761: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd761;
      3: stateTransition = 11'd761;
      4: stateTransition = 11'd761;
      5: stateTransition = 11'd761;
      6: stateTransition = 11'd761;
      7: stateTransition = 11'd761;
      8: stateTransition = 11'd761;
      default: stateTransition = 11'bX;
    endcase
    762: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd762;
      3: stateTransition = 11'd762;
      4: stateTransition = 11'd762;
      5: stateTransition = 11'd762;
      6: stateTransition = 11'd762;
      7: stateTransition = 11'd762;
      8: stateTransition = 11'd762;
      default: stateTransition = 11'bX;
    endcase
    763: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd763;
      3: stateTransition = 11'd763;
      4: stateTransition = 11'd763;
      5: stateTransition = 11'd763;
      6: stateTransition = 11'd763;
      7: stateTransition = 11'd763;
      8: stateTransition = 11'd763;
      default: stateTransition = 11'bX;
    endcase
    764: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd764;
      3: stateTransition = 11'd764;
      4: stateTransition = 11'd764;
      5: stateTransition = 11'd764;
      6: stateTransition = 11'd764;
      7: stateTransition = 11'd764;
      8: stateTransition = 11'd764;
      default: stateTransition = 11'bX;
    endcase
    765: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd765;
      3: stateTransition = 11'd765;
      4: stateTransition = 11'd765;
      5: stateTransition = 11'd765;
      6: stateTransition = 11'd765;
      7: stateTransition = 11'd765;
      8: stateTransition = 11'd765;
      default: stateTransition = 11'bX;
    endcase
    766: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd766;
      3: stateTransition = 11'd766;
      4: stateTransition = 11'd766;
      5: stateTransition = 11'd766;
      6: stateTransition = 11'd766;
      7: stateTransition = 11'd766;
      8: stateTransition = 11'd766;
      default: stateTransition = 11'bX;
    endcase
    767: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd767;
      3: stateTransition = 11'd767;
      4: stateTransition = 11'd767;
      5: stateTransition = 11'd767;
      6: stateTransition = 11'd767;
      7: stateTransition = 11'd767;
      8: stateTransition = 11'd767;
      default: stateTransition = 11'bX;
    endcase
    768: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd768;
      3: stateTransition = 11'd768;
      4: stateTransition = 11'd768;
      5: stateTransition = 11'd768;
      6: stateTransition = 11'd768;
      7: stateTransition = 11'd768;
      8: stateTransition = 11'd768;
      default: stateTransition = 11'bX;
    endcase
    769: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd769;
      3: stateTransition = 11'd769;
      4: stateTransition = 11'd769;
      5: stateTransition = 11'd769;
      6: stateTransition = 11'd769;
      7: stateTransition = 11'd769;
      8: stateTransition = 11'd769;
      default: stateTransition = 11'bX;
    endcase
    770: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd770;
      3: stateTransition = 11'd770;
      4: stateTransition = 11'd770;
      5: stateTransition = 11'd770;
      6: stateTransition = 11'd770;
      7: stateTransition = 11'd770;
      8: stateTransition = 11'd770;
      default: stateTransition = 11'bX;
    endcase
    771: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd771;
      3: stateTransition = 11'd771;
      4: stateTransition = 11'd771;
      5: stateTransition = 11'd771;
      6: stateTransition = 11'd771;
      7: stateTransition = 11'd771;
      8: stateTransition = 11'd771;
      default: stateTransition = 11'bX;
    endcase
    772: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd772;
      3: stateTransition = 11'd772;
      4: stateTransition = 11'd772;
      5: stateTransition = 11'd772;
      6: stateTransition = 11'd772;
      7: stateTransition = 11'd772;
      8: stateTransition = 11'd772;
      default: stateTransition = 11'bX;
    endcase
    773: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd773;
      3: stateTransition = 11'd773;
      4: stateTransition = 11'd773;
      5: stateTransition = 11'd773;
      6: stateTransition = 11'd773;
      7: stateTransition = 11'd773;
      8: stateTransition = 11'd773;
      default: stateTransition = 11'bX;
    endcase
    774: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd774;
      3: stateTransition = 11'd774;
      4: stateTransition = 11'd774;
      5: stateTransition = 11'd774;
      6: stateTransition = 11'd774;
      7: stateTransition = 11'd774;
      8: stateTransition = 11'd774;
      default: stateTransition = 11'bX;
    endcase
    775: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd775;
      3: stateTransition = 11'd775;
      4: stateTransition = 11'd775;
      5: stateTransition = 11'd775;
      6: stateTransition = 11'd775;
      7: stateTransition = 11'd775;
      8: stateTransition = 11'd775;
      default: stateTransition = 11'bX;
    endcase
    776: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd776;
      3: stateTransition = 11'd776;
      4: stateTransition = 11'd776;
      5: stateTransition = 11'd776;
      6: stateTransition = 11'd776;
      7: stateTransition = 11'd776;
      8: stateTransition = 11'd776;
      default: stateTransition = 11'bX;
    endcase
    777: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd777;
      3: stateTransition = 11'd777;
      4: stateTransition = 11'd777;
      5: stateTransition = 11'd777;
      6: stateTransition = 11'd777;
      7: stateTransition = 11'd777;
      8: stateTransition = 11'd777;
      default: stateTransition = 11'bX;
    endcase
    778: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd778;
      3: stateTransition = 11'd778;
      4: stateTransition = 11'd778;
      5: stateTransition = 11'd778;
      6: stateTransition = 11'd778;
      7: stateTransition = 11'd778;
      8: stateTransition = 11'd778;
      default: stateTransition = 11'bX;
    endcase
    779: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd779;
      3: stateTransition = 11'd779;
      4: stateTransition = 11'd779;
      5: stateTransition = 11'd779;
      6: stateTransition = 11'd779;
      7: stateTransition = 11'd779;
      8: stateTransition = 11'd779;
      default: stateTransition = 11'bX;
    endcase
    780: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd780;
      3: stateTransition = 11'd780;
      4: stateTransition = 11'd780;
      5: stateTransition = 11'd780;
      6: stateTransition = 11'd780;
      7: stateTransition = 11'd780;
      8: stateTransition = 11'd780;
      default: stateTransition = 11'bX;
    endcase
    781: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd781;
      3: stateTransition = 11'd781;
      4: stateTransition = 11'd781;
      5: stateTransition = 11'd781;
      6: stateTransition = 11'd781;
      7: stateTransition = 11'd781;
      8: stateTransition = 11'd781;
      default: stateTransition = 11'bX;
    endcase
    782: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd782;
      3: stateTransition = 11'd782;
      4: stateTransition = 11'd782;
      5: stateTransition = 11'd782;
      6: stateTransition = 11'd782;
      7: stateTransition = 11'd782;
      8: stateTransition = 11'd782;
      default: stateTransition = 11'bX;
    endcase
    783: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd783;
      3: stateTransition = 11'd783;
      4: stateTransition = 11'd783;
      5: stateTransition = 11'd783;
      6: stateTransition = 11'd783;
      7: stateTransition = 11'd783;
      8: stateTransition = 11'd783;
      default: stateTransition = 11'bX;
    endcase
    784: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd784;
      3: stateTransition = 11'd784;
      4: stateTransition = 11'd784;
      5: stateTransition = 11'd784;
      6: stateTransition = 11'd784;
      7: stateTransition = 11'd784;
      8: stateTransition = 11'd784;
      default: stateTransition = 11'bX;
    endcase
    785: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd785;
      3: stateTransition = 11'd785;
      4: stateTransition = 11'd785;
      5: stateTransition = 11'd785;
      6: stateTransition = 11'd785;
      7: stateTransition = 11'd785;
      8: stateTransition = 11'd785;
      default: stateTransition = 11'bX;
    endcase
    786: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd786;
      3: stateTransition = 11'd786;
      4: stateTransition = 11'd786;
      5: stateTransition = 11'd786;
      6: stateTransition = 11'd786;
      7: stateTransition = 11'd786;
      8: stateTransition = 11'd786;
      default: stateTransition = 11'bX;
    endcase
    787: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd787;
      3: stateTransition = 11'd787;
      4: stateTransition = 11'd787;
      5: stateTransition = 11'd787;
      6: stateTransition = 11'd787;
      7: stateTransition = 11'd787;
      8: stateTransition = 11'd787;
      default: stateTransition = 11'bX;
    endcase
    788: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd788;
      3: stateTransition = 11'd788;
      4: stateTransition = 11'd788;
      5: stateTransition = 11'd788;
      6: stateTransition = 11'd788;
      7: stateTransition = 11'd788;
      8: stateTransition = 11'd788;
      default: stateTransition = 11'bX;
    endcase
    789: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd789;
      3: stateTransition = 11'd789;
      4: stateTransition = 11'd789;
      5: stateTransition = 11'd789;
      6: stateTransition = 11'd789;
      7: stateTransition = 11'd789;
      8: stateTransition = 11'd789;
      default: stateTransition = 11'bX;
    endcase
    790: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd790;
      3: stateTransition = 11'd790;
      4: stateTransition = 11'd790;
      5: stateTransition = 11'd790;
      6: stateTransition = 11'd790;
      7: stateTransition = 11'd790;
      8: stateTransition = 11'd790;
      default: stateTransition = 11'bX;
    endcase
    791: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd791;
      3: stateTransition = 11'd791;
      4: stateTransition = 11'd791;
      5: stateTransition = 11'd791;
      6: stateTransition = 11'd791;
      7: stateTransition = 11'd791;
      8: stateTransition = 11'd791;
      default: stateTransition = 11'bX;
    endcase
    792: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd792;
      3: stateTransition = 11'd792;
      4: stateTransition = 11'd792;
      5: stateTransition = 11'd792;
      6: stateTransition = 11'd792;
      7: stateTransition = 11'd792;
      8: stateTransition = 11'd792;
      default: stateTransition = 11'bX;
    endcase
    793: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd793;
      3: stateTransition = 11'd793;
      4: stateTransition = 11'd793;
      5: stateTransition = 11'd793;
      6: stateTransition = 11'd793;
      7: stateTransition = 11'd793;
      8: stateTransition = 11'd793;
      default: stateTransition = 11'bX;
    endcase
    794: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd794;
      3: stateTransition = 11'd794;
      4: stateTransition = 11'd794;
      5: stateTransition = 11'd794;
      6: stateTransition = 11'd794;
      7: stateTransition = 11'd794;
      8: stateTransition = 11'd794;
      default: stateTransition = 11'bX;
    endcase
    795: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd795;
      3: stateTransition = 11'd795;
      4: stateTransition = 11'd795;
      5: stateTransition = 11'd795;
      6: stateTransition = 11'd795;
      7: stateTransition = 11'd795;
      8: stateTransition = 11'd795;
      default: stateTransition = 11'bX;
    endcase
    796: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd796;
      3: stateTransition = 11'd796;
      4: stateTransition = 11'd796;
      5: stateTransition = 11'd796;
      6: stateTransition = 11'd796;
      7: stateTransition = 11'd796;
      8: stateTransition = 11'd796;
      default: stateTransition = 11'bX;
    endcase
    797: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd797;
      3: stateTransition = 11'd797;
      4: stateTransition = 11'd797;
      5: stateTransition = 11'd797;
      6: stateTransition = 11'd797;
      7: stateTransition = 11'd797;
      8: stateTransition = 11'd797;
      default: stateTransition = 11'bX;
    endcase
    798: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd798;
      3: stateTransition = 11'd798;
      4: stateTransition = 11'd798;
      5: stateTransition = 11'd798;
      6: stateTransition = 11'd798;
      7: stateTransition = 11'd798;
      8: stateTransition = 11'd798;
      default: stateTransition = 11'bX;
    endcase
    799: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd799;
      3: stateTransition = 11'd799;
      4: stateTransition = 11'd799;
      5: stateTransition = 11'd799;
      6: stateTransition = 11'd799;
      7: stateTransition = 11'd799;
      8: stateTransition = 11'd799;
      default: stateTransition = 11'bX;
    endcase
    800: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd800;
      3: stateTransition = 11'd800;
      4: stateTransition = 11'd800;
      5: stateTransition = 11'd800;
      6: stateTransition = 11'd800;
      7: stateTransition = 11'd800;
      8: stateTransition = 11'd800;
      default: stateTransition = 11'bX;
    endcase
    801: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd801;
      3: stateTransition = 11'd801;
      4: stateTransition = 11'd801;
      5: stateTransition = 11'd801;
      6: stateTransition = 11'd801;
      7: stateTransition = 11'd801;
      8: stateTransition = 11'd801;
      default: stateTransition = 11'bX;
    endcase
    802: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd802;
      3: stateTransition = 11'd802;
      4: stateTransition = 11'd802;
      5: stateTransition = 11'd802;
      6: stateTransition = 11'd802;
      7: stateTransition = 11'd802;
      8: stateTransition = 11'd802;
      default: stateTransition = 11'bX;
    endcase
    803: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd803;
      3: stateTransition = 11'd803;
      4: stateTransition = 11'd803;
      5: stateTransition = 11'd803;
      6: stateTransition = 11'd803;
      7: stateTransition = 11'd803;
      8: stateTransition = 11'd803;
      default: stateTransition = 11'bX;
    endcase
    804: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd804;
      3: stateTransition = 11'd804;
      4: stateTransition = 11'd804;
      5: stateTransition = 11'd804;
      6: stateTransition = 11'd804;
      7: stateTransition = 11'd804;
      8: stateTransition = 11'd804;
      default: stateTransition = 11'bX;
    endcase
    805: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd805;
      3: stateTransition = 11'd805;
      4: stateTransition = 11'd805;
      5: stateTransition = 11'd805;
      6: stateTransition = 11'd805;
      7: stateTransition = 11'd805;
      8: stateTransition = 11'd805;
      default: stateTransition = 11'bX;
    endcase
    806: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd806;
      3: stateTransition = 11'd806;
      4: stateTransition = 11'd806;
      5: stateTransition = 11'd806;
      6: stateTransition = 11'd806;
      7: stateTransition = 11'd806;
      8: stateTransition = 11'd806;
      default: stateTransition = 11'bX;
    endcase
    807: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd807;
      3: stateTransition = 11'd807;
      4: stateTransition = 11'd807;
      5: stateTransition = 11'd807;
      6: stateTransition = 11'd807;
      7: stateTransition = 11'd807;
      8: stateTransition = 11'd807;
      default: stateTransition = 11'bX;
    endcase
    808: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd808;
      3: stateTransition = 11'd808;
      4: stateTransition = 11'd808;
      5: stateTransition = 11'd808;
      6: stateTransition = 11'd808;
      7: stateTransition = 11'd808;
      8: stateTransition = 11'd808;
      default: stateTransition = 11'bX;
    endcase
    809: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd809;
      3: stateTransition = 11'd809;
      4: stateTransition = 11'd809;
      5: stateTransition = 11'd809;
      6: stateTransition = 11'd809;
      7: stateTransition = 11'd809;
      8: stateTransition = 11'd809;
      default: stateTransition = 11'bX;
    endcase
    810: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd810;
      3: stateTransition = 11'd810;
      4: stateTransition = 11'd810;
      5: stateTransition = 11'd810;
      6: stateTransition = 11'd810;
      7: stateTransition = 11'd810;
      8: stateTransition = 11'd810;
      default: stateTransition = 11'bX;
    endcase
    811: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd811;
      3: stateTransition = 11'd811;
      4: stateTransition = 11'd811;
      5: stateTransition = 11'd811;
      6: stateTransition = 11'd811;
      7: stateTransition = 11'd811;
      8: stateTransition = 11'd811;
      default: stateTransition = 11'bX;
    endcase
    812: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd812;
      3: stateTransition = 11'd812;
      4: stateTransition = 11'd812;
      5: stateTransition = 11'd812;
      6: stateTransition = 11'd812;
      7: stateTransition = 11'd812;
      8: stateTransition = 11'd812;
      default: stateTransition = 11'bX;
    endcase
    813: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd813;
      3: stateTransition = 11'd813;
      4: stateTransition = 11'd813;
      5: stateTransition = 11'd813;
      6: stateTransition = 11'd813;
      7: stateTransition = 11'd813;
      8: stateTransition = 11'd813;
      default: stateTransition = 11'bX;
    endcase
    814: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd814;
      3: stateTransition = 11'd814;
      4: stateTransition = 11'd814;
      5: stateTransition = 11'd814;
      6: stateTransition = 11'd814;
      7: stateTransition = 11'd814;
      8: stateTransition = 11'd814;
      default: stateTransition = 11'bX;
    endcase
    815: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd815;
      3: stateTransition = 11'd815;
      4: stateTransition = 11'd815;
      5: stateTransition = 11'd815;
      6: stateTransition = 11'd815;
      7: stateTransition = 11'd815;
      8: stateTransition = 11'd815;
      default: stateTransition = 11'bX;
    endcase
    816: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd816;
      3: stateTransition = 11'd816;
      4: stateTransition = 11'd816;
      5: stateTransition = 11'd816;
      6: stateTransition = 11'd816;
      7: stateTransition = 11'd816;
      8: stateTransition = 11'd816;
      default: stateTransition = 11'bX;
    endcase
    817: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd817;
      3: stateTransition = 11'd817;
      4: stateTransition = 11'd817;
      5: stateTransition = 11'd817;
      6: stateTransition = 11'd817;
      7: stateTransition = 11'd817;
      8: stateTransition = 11'd817;
      default: stateTransition = 11'bX;
    endcase
    818: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd818;
      3: stateTransition = 11'd818;
      4: stateTransition = 11'd818;
      5: stateTransition = 11'd818;
      6: stateTransition = 11'd818;
      7: stateTransition = 11'd818;
      8: stateTransition = 11'd818;
      default: stateTransition = 11'bX;
    endcase
    819: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd819;
      3: stateTransition = 11'd819;
      4: stateTransition = 11'd819;
      5: stateTransition = 11'd819;
      6: stateTransition = 11'd819;
      7: stateTransition = 11'd819;
      8: stateTransition = 11'd819;
      default: stateTransition = 11'bX;
    endcase
    820: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd820;
      3: stateTransition = 11'd820;
      4: stateTransition = 11'd820;
      5: stateTransition = 11'd820;
      6: stateTransition = 11'd820;
      7: stateTransition = 11'd820;
      8: stateTransition = 11'd820;
      default: stateTransition = 11'bX;
    endcase
    821: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd821;
      3: stateTransition = 11'd821;
      4: stateTransition = 11'd821;
      5: stateTransition = 11'd821;
      6: stateTransition = 11'd821;
      7: stateTransition = 11'd821;
      8: stateTransition = 11'd821;
      default: stateTransition = 11'bX;
    endcase
    822: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd822;
      3: stateTransition = 11'd822;
      4: stateTransition = 11'd822;
      5: stateTransition = 11'd822;
      6: stateTransition = 11'd822;
      7: stateTransition = 11'd822;
      8: stateTransition = 11'd822;
      default: stateTransition = 11'bX;
    endcase
    823: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd823;
      3: stateTransition = 11'd823;
      4: stateTransition = 11'd823;
      5: stateTransition = 11'd823;
      6: stateTransition = 11'd823;
      7: stateTransition = 11'd823;
      8: stateTransition = 11'd823;
      default: stateTransition = 11'bX;
    endcase
    824: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd824;
      3: stateTransition = 11'd824;
      4: stateTransition = 11'd824;
      5: stateTransition = 11'd824;
      6: stateTransition = 11'd824;
      7: stateTransition = 11'd824;
      8: stateTransition = 11'd824;
      default: stateTransition = 11'bX;
    endcase
    825: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd825;
      3: stateTransition = 11'd825;
      4: stateTransition = 11'd825;
      5: stateTransition = 11'd825;
      6: stateTransition = 11'd825;
      7: stateTransition = 11'd825;
      8: stateTransition = 11'd825;
      default: stateTransition = 11'bX;
    endcase
    826: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd826;
      3: stateTransition = 11'd826;
      4: stateTransition = 11'd826;
      5: stateTransition = 11'd826;
      6: stateTransition = 11'd826;
      7: stateTransition = 11'd826;
      8: stateTransition = 11'd826;
      default: stateTransition = 11'bX;
    endcase
    827: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd827;
      3: stateTransition = 11'd827;
      4: stateTransition = 11'd827;
      5: stateTransition = 11'd827;
      6: stateTransition = 11'd827;
      7: stateTransition = 11'd827;
      8: stateTransition = 11'd827;
      default: stateTransition = 11'bX;
    endcase
    828: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd828;
      3: stateTransition = 11'd828;
      4: stateTransition = 11'd828;
      5: stateTransition = 11'd828;
      6: stateTransition = 11'd828;
      7: stateTransition = 11'd828;
      8: stateTransition = 11'd828;
      default: stateTransition = 11'bX;
    endcase
    829: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd829;
      3: stateTransition = 11'd829;
      4: stateTransition = 11'd829;
      5: stateTransition = 11'd829;
      6: stateTransition = 11'd829;
      7: stateTransition = 11'd829;
      8: stateTransition = 11'd829;
      default: stateTransition = 11'bX;
    endcase
    830: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd830;
      3: stateTransition = 11'd830;
      4: stateTransition = 11'd830;
      5: stateTransition = 11'd830;
      6: stateTransition = 11'd830;
      7: stateTransition = 11'd830;
      8: stateTransition = 11'd830;
      default: stateTransition = 11'bX;
    endcase
    831: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd831;
      3: stateTransition = 11'd831;
      4: stateTransition = 11'd831;
      5: stateTransition = 11'd831;
      6: stateTransition = 11'd831;
      7: stateTransition = 11'd831;
      8: stateTransition = 11'd831;
      default: stateTransition = 11'bX;
    endcase
    832: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd832;
      3: stateTransition = 11'd832;
      4: stateTransition = 11'd832;
      5: stateTransition = 11'd832;
      6: stateTransition = 11'd832;
      7: stateTransition = 11'd832;
      8: stateTransition = 11'd832;
      default: stateTransition = 11'bX;
    endcase
    833: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd833;
      3: stateTransition = 11'd833;
      4: stateTransition = 11'd833;
      5: stateTransition = 11'd833;
      6: stateTransition = 11'd833;
      7: stateTransition = 11'd833;
      8: stateTransition = 11'd833;
      default: stateTransition = 11'bX;
    endcase
    834: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd834;
      3: stateTransition = 11'd834;
      4: stateTransition = 11'd834;
      5: stateTransition = 11'd834;
      6: stateTransition = 11'd834;
      7: stateTransition = 11'd834;
      8: stateTransition = 11'd834;
      default: stateTransition = 11'bX;
    endcase
    835: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd835;
      3: stateTransition = 11'd835;
      4: stateTransition = 11'd835;
      5: stateTransition = 11'd835;
      6: stateTransition = 11'd835;
      7: stateTransition = 11'd835;
      8: stateTransition = 11'd835;
      default: stateTransition = 11'bX;
    endcase
    836: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd836;
      3: stateTransition = 11'd836;
      4: stateTransition = 11'd836;
      5: stateTransition = 11'd836;
      6: stateTransition = 11'd836;
      7: stateTransition = 11'd836;
      8: stateTransition = 11'd836;
      default: stateTransition = 11'bX;
    endcase
    837: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd837;
      3: stateTransition = 11'd837;
      4: stateTransition = 11'd837;
      5: stateTransition = 11'd837;
      6: stateTransition = 11'd837;
      7: stateTransition = 11'd837;
      8: stateTransition = 11'd837;
      default: stateTransition = 11'bX;
    endcase
    838: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd838;
      3: stateTransition = 11'd838;
      4: stateTransition = 11'd838;
      5: stateTransition = 11'd838;
      6: stateTransition = 11'd838;
      7: stateTransition = 11'd838;
      8: stateTransition = 11'd838;
      default: stateTransition = 11'bX;
    endcase
    839: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd839;
      3: stateTransition = 11'd839;
      4: stateTransition = 11'd839;
      5: stateTransition = 11'd839;
      6: stateTransition = 11'd839;
      7: stateTransition = 11'd839;
      8: stateTransition = 11'd839;
      default: stateTransition = 11'bX;
    endcase
    840: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd840;
      3: stateTransition = 11'd840;
      4: stateTransition = 11'd840;
      5: stateTransition = 11'd840;
      6: stateTransition = 11'd840;
      7: stateTransition = 11'd840;
      8: stateTransition = 11'd840;
      default: stateTransition = 11'bX;
    endcase
    841: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd841;
      3: stateTransition = 11'd841;
      4: stateTransition = 11'd841;
      5: stateTransition = 11'd841;
      6: stateTransition = 11'd841;
      7: stateTransition = 11'd841;
      8: stateTransition = 11'd841;
      default: stateTransition = 11'bX;
    endcase
    842: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd842;
      3: stateTransition = 11'd842;
      4: stateTransition = 11'd842;
      5: stateTransition = 11'd842;
      6: stateTransition = 11'd842;
      7: stateTransition = 11'd842;
      8: stateTransition = 11'd842;
      default: stateTransition = 11'bX;
    endcase
    843: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd843;
      3: stateTransition = 11'd843;
      4: stateTransition = 11'd843;
      5: stateTransition = 11'd843;
      6: stateTransition = 11'd843;
      7: stateTransition = 11'd843;
      8: stateTransition = 11'd843;
      default: stateTransition = 11'bX;
    endcase
    844: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd844;
      3: stateTransition = 11'd844;
      4: stateTransition = 11'd844;
      5: stateTransition = 11'd844;
      6: stateTransition = 11'd844;
      7: stateTransition = 11'd844;
      8: stateTransition = 11'd844;
      default: stateTransition = 11'bX;
    endcase
    845: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd845;
      3: stateTransition = 11'd845;
      4: stateTransition = 11'd845;
      5: stateTransition = 11'd845;
      6: stateTransition = 11'd845;
      7: stateTransition = 11'd845;
      8: stateTransition = 11'd845;
      default: stateTransition = 11'bX;
    endcase
    846: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd846;
      3: stateTransition = 11'd846;
      4: stateTransition = 11'd846;
      5: stateTransition = 11'd846;
      6: stateTransition = 11'd846;
      7: stateTransition = 11'd846;
      8: stateTransition = 11'd846;
      default: stateTransition = 11'bX;
    endcase
    847: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd847;
      3: stateTransition = 11'd847;
      4: stateTransition = 11'd847;
      5: stateTransition = 11'd847;
      6: stateTransition = 11'd847;
      7: stateTransition = 11'd847;
      8: stateTransition = 11'd847;
      default: stateTransition = 11'bX;
    endcase
    848: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd848;
      3: stateTransition = 11'd848;
      4: stateTransition = 11'd848;
      5: stateTransition = 11'd848;
      6: stateTransition = 11'd848;
      7: stateTransition = 11'd848;
      8: stateTransition = 11'd848;
      default: stateTransition = 11'bX;
    endcase
    849: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd849;
      3: stateTransition = 11'd849;
      4: stateTransition = 11'd849;
      5: stateTransition = 11'd849;
      6: stateTransition = 11'd849;
      7: stateTransition = 11'd849;
      8: stateTransition = 11'd849;
      default: stateTransition = 11'bX;
    endcase
    850: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd850;
      3: stateTransition = 11'd850;
      4: stateTransition = 11'd850;
      5: stateTransition = 11'd850;
      6: stateTransition = 11'd850;
      7: stateTransition = 11'd850;
      8: stateTransition = 11'd850;
      default: stateTransition = 11'bX;
    endcase
    851: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd851;
      3: stateTransition = 11'd851;
      4: stateTransition = 11'd851;
      5: stateTransition = 11'd851;
      6: stateTransition = 11'd851;
      7: stateTransition = 11'd851;
      8: stateTransition = 11'd851;
      default: stateTransition = 11'bX;
    endcase
    852: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd852;
      3: stateTransition = 11'd852;
      4: stateTransition = 11'd852;
      5: stateTransition = 11'd852;
      6: stateTransition = 11'd852;
      7: stateTransition = 11'd852;
      8: stateTransition = 11'd852;
      default: stateTransition = 11'bX;
    endcase
    853: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd853;
      3: stateTransition = 11'd853;
      4: stateTransition = 11'd853;
      5: stateTransition = 11'd853;
      6: stateTransition = 11'd853;
      7: stateTransition = 11'd853;
      8: stateTransition = 11'd853;
      default: stateTransition = 11'bX;
    endcase
    854: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd854;
      3: stateTransition = 11'd854;
      4: stateTransition = 11'd854;
      5: stateTransition = 11'd854;
      6: stateTransition = 11'd854;
      7: stateTransition = 11'd854;
      8: stateTransition = 11'd854;
      default: stateTransition = 11'bX;
    endcase
    855: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd855;
      3: stateTransition = 11'd855;
      4: stateTransition = 11'd855;
      5: stateTransition = 11'd855;
      6: stateTransition = 11'd855;
      7: stateTransition = 11'd855;
      8: stateTransition = 11'd855;
      default: stateTransition = 11'bX;
    endcase
    856: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd856;
      3: stateTransition = 11'd856;
      4: stateTransition = 11'd856;
      5: stateTransition = 11'd856;
      6: stateTransition = 11'd856;
      7: stateTransition = 11'd856;
      8: stateTransition = 11'd856;
      default: stateTransition = 11'bX;
    endcase
    857: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd857;
      3: stateTransition = 11'd857;
      4: stateTransition = 11'd857;
      5: stateTransition = 11'd857;
      6: stateTransition = 11'd857;
      7: stateTransition = 11'd857;
      8: stateTransition = 11'd857;
      default: stateTransition = 11'bX;
    endcase
    858: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd858;
      3: stateTransition = 11'd858;
      4: stateTransition = 11'd858;
      5: stateTransition = 11'd858;
      6: stateTransition = 11'd858;
      7: stateTransition = 11'd858;
      8: stateTransition = 11'd858;
      default: stateTransition = 11'bX;
    endcase
    859: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd859;
      3: stateTransition = 11'd859;
      4: stateTransition = 11'd859;
      5: stateTransition = 11'd859;
      6: stateTransition = 11'd859;
      7: stateTransition = 11'd859;
      8: stateTransition = 11'd859;
      default: stateTransition = 11'bX;
    endcase
    860: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd860;
      3: stateTransition = 11'd860;
      4: stateTransition = 11'd860;
      5: stateTransition = 11'd860;
      6: stateTransition = 11'd860;
      7: stateTransition = 11'd860;
      8: stateTransition = 11'd860;
      default: stateTransition = 11'bX;
    endcase
    861: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd861;
      3: stateTransition = 11'd861;
      4: stateTransition = 11'd861;
      5: stateTransition = 11'd861;
      6: stateTransition = 11'd861;
      7: stateTransition = 11'd861;
      8: stateTransition = 11'd861;
      default: stateTransition = 11'bX;
    endcase
    862: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd862;
      3: stateTransition = 11'd862;
      4: stateTransition = 11'd862;
      5: stateTransition = 11'd862;
      6: stateTransition = 11'd862;
      7: stateTransition = 11'd862;
      8: stateTransition = 11'd862;
      default: stateTransition = 11'bX;
    endcase
    863: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd863;
      3: stateTransition = 11'd863;
      4: stateTransition = 11'd863;
      5: stateTransition = 11'd863;
      6: stateTransition = 11'd863;
      7: stateTransition = 11'd863;
      8: stateTransition = 11'd863;
      default: stateTransition = 11'bX;
    endcase
    864: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd864;
      3: stateTransition = 11'd864;
      4: stateTransition = 11'd864;
      5: stateTransition = 11'd864;
      6: stateTransition = 11'd864;
      7: stateTransition = 11'd864;
      8: stateTransition = 11'd864;
      default: stateTransition = 11'bX;
    endcase
    865: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd865;
      3: stateTransition = 11'd865;
      4: stateTransition = 11'd865;
      5: stateTransition = 11'd865;
      6: stateTransition = 11'd865;
      7: stateTransition = 11'd865;
      8: stateTransition = 11'd865;
      default: stateTransition = 11'bX;
    endcase
    866: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd866;
      3: stateTransition = 11'd866;
      4: stateTransition = 11'd866;
      5: stateTransition = 11'd866;
      6: stateTransition = 11'd866;
      7: stateTransition = 11'd866;
      8: stateTransition = 11'd866;
      default: stateTransition = 11'bX;
    endcase
    867: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd867;
      3: stateTransition = 11'd867;
      4: stateTransition = 11'd867;
      5: stateTransition = 11'd867;
      6: stateTransition = 11'd867;
      7: stateTransition = 11'd867;
      8: stateTransition = 11'd867;
      default: stateTransition = 11'bX;
    endcase
    868: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd868;
      3: stateTransition = 11'd868;
      4: stateTransition = 11'd868;
      5: stateTransition = 11'd868;
      6: stateTransition = 11'd868;
      7: stateTransition = 11'd868;
      8: stateTransition = 11'd868;
      default: stateTransition = 11'bX;
    endcase
    869: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd869;
      3: stateTransition = 11'd869;
      4: stateTransition = 11'd869;
      5: stateTransition = 11'd869;
      6: stateTransition = 11'd869;
      7: stateTransition = 11'd869;
      8: stateTransition = 11'd869;
      default: stateTransition = 11'bX;
    endcase
    870: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd870;
      3: stateTransition = 11'd870;
      4: stateTransition = 11'd870;
      5: stateTransition = 11'd870;
      6: stateTransition = 11'd870;
      7: stateTransition = 11'd870;
      8: stateTransition = 11'd870;
      default: stateTransition = 11'bX;
    endcase
    871: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd871;
      3: stateTransition = 11'd871;
      4: stateTransition = 11'd871;
      5: stateTransition = 11'd871;
      6: stateTransition = 11'd871;
      7: stateTransition = 11'd871;
      8: stateTransition = 11'd871;
      default: stateTransition = 11'bX;
    endcase
    872: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd872;
      3: stateTransition = 11'd872;
      4: stateTransition = 11'd872;
      5: stateTransition = 11'd872;
      6: stateTransition = 11'd872;
      7: stateTransition = 11'd872;
      8: stateTransition = 11'd872;
      default: stateTransition = 11'bX;
    endcase
    873: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd873;
      3: stateTransition = 11'd873;
      4: stateTransition = 11'd873;
      5: stateTransition = 11'd873;
      6: stateTransition = 11'd873;
      7: stateTransition = 11'd873;
      8: stateTransition = 11'd873;
      default: stateTransition = 11'bX;
    endcase
    874: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd874;
      3: stateTransition = 11'd874;
      4: stateTransition = 11'd874;
      5: stateTransition = 11'd874;
      6: stateTransition = 11'd874;
      7: stateTransition = 11'd874;
      8: stateTransition = 11'd874;
      default: stateTransition = 11'bX;
    endcase
    875: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd875;
      3: stateTransition = 11'd875;
      4: stateTransition = 11'd875;
      5: stateTransition = 11'd875;
      6: stateTransition = 11'd875;
      7: stateTransition = 11'd875;
      8: stateTransition = 11'd875;
      default: stateTransition = 11'bX;
    endcase
    876: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd876;
      3: stateTransition = 11'd876;
      4: stateTransition = 11'd876;
      5: stateTransition = 11'd876;
      6: stateTransition = 11'd876;
      7: stateTransition = 11'd876;
      8: stateTransition = 11'd876;
      default: stateTransition = 11'bX;
    endcase
    877: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd877;
      3: stateTransition = 11'd877;
      4: stateTransition = 11'd877;
      5: stateTransition = 11'd877;
      6: stateTransition = 11'd877;
      7: stateTransition = 11'd877;
      8: stateTransition = 11'd877;
      default: stateTransition = 11'bX;
    endcase
    878: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd878;
      3: stateTransition = 11'd878;
      4: stateTransition = 11'd878;
      5: stateTransition = 11'd878;
      6: stateTransition = 11'd878;
      7: stateTransition = 11'd878;
      8: stateTransition = 11'd878;
      default: stateTransition = 11'bX;
    endcase
    879: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd879;
      3: stateTransition = 11'd879;
      4: stateTransition = 11'd879;
      5: stateTransition = 11'd879;
      6: stateTransition = 11'd879;
      7: stateTransition = 11'd879;
      8: stateTransition = 11'd879;
      default: stateTransition = 11'bX;
    endcase
    880: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd880;
      3: stateTransition = 11'd880;
      4: stateTransition = 11'd880;
      5: stateTransition = 11'd880;
      6: stateTransition = 11'd880;
      7: stateTransition = 11'd880;
      8: stateTransition = 11'd880;
      default: stateTransition = 11'bX;
    endcase
    881: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd881;
      3: stateTransition = 11'd881;
      4: stateTransition = 11'd881;
      5: stateTransition = 11'd881;
      6: stateTransition = 11'd881;
      7: stateTransition = 11'd881;
      8: stateTransition = 11'd881;
      default: stateTransition = 11'bX;
    endcase
    882: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd882;
      3: stateTransition = 11'd882;
      4: stateTransition = 11'd882;
      5: stateTransition = 11'd882;
      6: stateTransition = 11'd882;
      7: stateTransition = 11'd882;
      8: stateTransition = 11'd882;
      default: stateTransition = 11'bX;
    endcase
    883: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd883;
      3: stateTransition = 11'd883;
      4: stateTransition = 11'd883;
      5: stateTransition = 11'd883;
      6: stateTransition = 11'd883;
      7: stateTransition = 11'd883;
      8: stateTransition = 11'd883;
      default: stateTransition = 11'bX;
    endcase
    884: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd884;
      3: stateTransition = 11'd884;
      4: stateTransition = 11'd884;
      5: stateTransition = 11'd884;
      6: stateTransition = 11'd884;
      7: stateTransition = 11'd884;
      8: stateTransition = 11'd884;
      default: stateTransition = 11'bX;
    endcase
    885: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd885;
      3: stateTransition = 11'd885;
      4: stateTransition = 11'd885;
      5: stateTransition = 11'd885;
      6: stateTransition = 11'd885;
      7: stateTransition = 11'd885;
      8: stateTransition = 11'd885;
      default: stateTransition = 11'bX;
    endcase
    886: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd886;
      3: stateTransition = 11'd886;
      4: stateTransition = 11'd886;
      5: stateTransition = 11'd886;
      6: stateTransition = 11'd886;
      7: stateTransition = 11'd886;
      8: stateTransition = 11'd886;
      default: stateTransition = 11'bX;
    endcase
    887: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd887;
      3: stateTransition = 11'd887;
      4: stateTransition = 11'd887;
      5: stateTransition = 11'd887;
      6: stateTransition = 11'd887;
      7: stateTransition = 11'd887;
      8: stateTransition = 11'd887;
      default: stateTransition = 11'bX;
    endcase
    888: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd888;
      3: stateTransition = 11'd888;
      4: stateTransition = 11'd888;
      5: stateTransition = 11'd888;
      6: stateTransition = 11'd888;
      7: stateTransition = 11'd888;
      8: stateTransition = 11'd888;
      default: stateTransition = 11'bX;
    endcase
    889: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd889;
      3: stateTransition = 11'd889;
      4: stateTransition = 11'd889;
      5: stateTransition = 11'd889;
      6: stateTransition = 11'd889;
      7: stateTransition = 11'd889;
      8: stateTransition = 11'd889;
      default: stateTransition = 11'bX;
    endcase
    890: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd890;
      3: stateTransition = 11'd890;
      4: stateTransition = 11'd890;
      5: stateTransition = 11'd890;
      6: stateTransition = 11'd890;
      7: stateTransition = 11'd890;
      8: stateTransition = 11'd890;
      default: stateTransition = 11'bX;
    endcase
    891: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd891;
      3: stateTransition = 11'd891;
      4: stateTransition = 11'd891;
      5: stateTransition = 11'd891;
      6: stateTransition = 11'd891;
      7: stateTransition = 11'd891;
      8: stateTransition = 11'd891;
      default: stateTransition = 11'bX;
    endcase
    892: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd892;
      3: stateTransition = 11'd892;
      4: stateTransition = 11'd892;
      5: stateTransition = 11'd892;
      6: stateTransition = 11'd892;
      7: stateTransition = 11'd892;
      8: stateTransition = 11'd892;
      default: stateTransition = 11'bX;
    endcase
    893: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd893;
      3: stateTransition = 11'd893;
      4: stateTransition = 11'd893;
      5: stateTransition = 11'd893;
      6: stateTransition = 11'd893;
      7: stateTransition = 11'd893;
      8: stateTransition = 11'd893;
      default: stateTransition = 11'bX;
    endcase
    894: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd894;
      3: stateTransition = 11'd894;
      4: stateTransition = 11'd894;
      5: stateTransition = 11'd894;
      6: stateTransition = 11'd894;
      7: stateTransition = 11'd894;
      8: stateTransition = 11'd894;
      default: stateTransition = 11'bX;
    endcase
    895: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd895;
      3: stateTransition = 11'd895;
      4: stateTransition = 11'd895;
      5: stateTransition = 11'd895;
      6: stateTransition = 11'd895;
      7: stateTransition = 11'd895;
      8: stateTransition = 11'd895;
      default: stateTransition = 11'bX;
    endcase
    896: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd896;
      3: stateTransition = 11'd896;
      4: stateTransition = 11'd896;
      5: stateTransition = 11'd896;
      6: stateTransition = 11'd896;
      7: stateTransition = 11'd896;
      8: stateTransition = 11'd896;
      default: stateTransition = 11'bX;
    endcase
    897: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd897;
      3: stateTransition = 11'd897;
      4: stateTransition = 11'd897;
      5: stateTransition = 11'd897;
      6: stateTransition = 11'd897;
      7: stateTransition = 11'd897;
      8: stateTransition = 11'd897;
      default: stateTransition = 11'bX;
    endcase
    898: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd898;
      3: stateTransition = 11'd898;
      4: stateTransition = 11'd898;
      5: stateTransition = 11'd898;
      6: stateTransition = 11'd898;
      7: stateTransition = 11'd898;
      8: stateTransition = 11'd898;
      default: stateTransition = 11'bX;
    endcase
    899: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd899;
      3: stateTransition = 11'd899;
      4: stateTransition = 11'd899;
      5: stateTransition = 11'd899;
      6: stateTransition = 11'd899;
      7: stateTransition = 11'd899;
      8: stateTransition = 11'd899;
      default: stateTransition = 11'bX;
    endcase
    900: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd900;
      3: stateTransition = 11'd900;
      4: stateTransition = 11'd900;
      5: stateTransition = 11'd900;
      6: stateTransition = 11'd900;
      7: stateTransition = 11'd900;
      8: stateTransition = 11'd900;
      default: stateTransition = 11'bX;
    endcase
    901: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd901;
      3: stateTransition = 11'd901;
      4: stateTransition = 11'd901;
      5: stateTransition = 11'd901;
      6: stateTransition = 11'd901;
      7: stateTransition = 11'd901;
      8: stateTransition = 11'd901;
      default: stateTransition = 11'bX;
    endcase
    902: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd902;
      3: stateTransition = 11'd902;
      4: stateTransition = 11'd902;
      5: stateTransition = 11'd902;
      6: stateTransition = 11'd902;
      7: stateTransition = 11'd902;
      8: stateTransition = 11'd902;
      default: stateTransition = 11'bX;
    endcase
    903: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd903;
      3: stateTransition = 11'd903;
      4: stateTransition = 11'd903;
      5: stateTransition = 11'd903;
      6: stateTransition = 11'd903;
      7: stateTransition = 11'd903;
      8: stateTransition = 11'd903;
      default: stateTransition = 11'bX;
    endcase
    904: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd904;
      3: stateTransition = 11'd904;
      4: stateTransition = 11'd904;
      5: stateTransition = 11'd904;
      6: stateTransition = 11'd904;
      7: stateTransition = 11'd904;
      8: stateTransition = 11'd904;
      default: stateTransition = 11'bX;
    endcase
    905: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd905;
      3: stateTransition = 11'd905;
      4: stateTransition = 11'd905;
      5: stateTransition = 11'd905;
      6: stateTransition = 11'd905;
      7: stateTransition = 11'd905;
      8: stateTransition = 11'd905;
      default: stateTransition = 11'bX;
    endcase
    906: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd906;
      3: stateTransition = 11'd906;
      4: stateTransition = 11'd906;
      5: stateTransition = 11'd906;
      6: stateTransition = 11'd906;
      7: stateTransition = 11'd906;
      8: stateTransition = 11'd906;
      default: stateTransition = 11'bX;
    endcase
    907: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd907;
      3: stateTransition = 11'd907;
      4: stateTransition = 11'd907;
      5: stateTransition = 11'd907;
      6: stateTransition = 11'd907;
      7: stateTransition = 11'd907;
      8: stateTransition = 11'd907;
      default: stateTransition = 11'bX;
    endcase
    908: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd908;
      3: stateTransition = 11'd908;
      4: stateTransition = 11'd908;
      5: stateTransition = 11'd908;
      6: stateTransition = 11'd908;
      7: stateTransition = 11'd908;
      8: stateTransition = 11'd908;
      default: stateTransition = 11'bX;
    endcase
    909: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd909;
      3: stateTransition = 11'd909;
      4: stateTransition = 11'd909;
      5: stateTransition = 11'd909;
      6: stateTransition = 11'd909;
      7: stateTransition = 11'd909;
      8: stateTransition = 11'd909;
      default: stateTransition = 11'bX;
    endcase
    910: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd910;
      3: stateTransition = 11'd910;
      4: stateTransition = 11'd910;
      5: stateTransition = 11'd910;
      6: stateTransition = 11'd910;
      7: stateTransition = 11'd910;
      8: stateTransition = 11'd910;
      default: stateTransition = 11'bX;
    endcase
    911: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd911;
      3: stateTransition = 11'd911;
      4: stateTransition = 11'd911;
      5: stateTransition = 11'd911;
      6: stateTransition = 11'd911;
      7: stateTransition = 11'd911;
      8: stateTransition = 11'd911;
      default: stateTransition = 11'bX;
    endcase
    912: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd912;
      3: stateTransition = 11'd912;
      4: stateTransition = 11'd912;
      5: stateTransition = 11'd912;
      6: stateTransition = 11'd912;
      7: stateTransition = 11'd912;
      8: stateTransition = 11'd912;
      default: stateTransition = 11'bX;
    endcase
    913: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd913;
      3: stateTransition = 11'd913;
      4: stateTransition = 11'd913;
      5: stateTransition = 11'd913;
      6: stateTransition = 11'd913;
      7: stateTransition = 11'd913;
      8: stateTransition = 11'd913;
      default: stateTransition = 11'bX;
    endcase
    914: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd914;
      3: stateTransition = 11'd914;
      4: stateTransition = 11'd914;
      5: stateTransition = 11'd914;
      6: stateTransition = 11'd914;
      7: stateTransition = 11'd914;
      8: stateTransition = 11'd914;
      default: stateTransition = 11'bX;
    endcase
    915: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd915;
      3: stateTransition = 11'd915;
      4: stateTransition = 11'd915;
      5: stateTransition = 11'd915;
      6: stateTransition = 11'd915;
      7: stateTransition = 11'd915;
      8: stateTransition = 11'd915;
      default: stateTransition = 11'bX;
    endcase
    916: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd916;
      3: stateTransition = 11'd916;
      4: stateTransition = 11'd916;
      5: stateTransition = 11'd916;
      6: stateTransition = 11'd916;
      7: stateTransition = 11'd916;
      8: stateTransition = 11'd916;
      default: stateTransition = 11'bX;
    endcase
    917: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd917;
      3: stateTransition = 11'd917;
      4: stateTransition = 11'd917;
      5: stateTransition = 11'd917;
      6: stateTransition = 11'd917;
      7: stateTransition = 11'd917;
      8: stateTransition = 11'd917;
      default: stateTransition = 11'bX;
    endcase
    918: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd918;
      3: stateTransition = 11'd918;
      4: stateTransition = 11'd918;
      5: stateTransition = 11'd918;
      6: stateTransition = 11'd918;
      7: stateTransition = 11'd918;
      8: stateTransition = 11'd918;
      default: stateTransition = 11'bX;
    endcase
    919: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd919;
      3: stateTransition = 11'd919;
      4: stateTransition = 11'd919;
      5: stateTransition = 11'd919;
      6: stateTransition = 11'd919;
      7: stateTransition = 11'd919;
      8: stateTransition = 11'd919;
      default: stateTransition = 11'bX;
    endcase
    920: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd920;
      3: stateTransition = 11'd920;
      4: stateTransition = 11'd920;
      5: stateTransition = 11'd920;
      6: stateTransition = 11'd920;
      7: stateTransition = 11'd920;
      8: stateTransition = 11'd920;
      default: stateTransition = 11'bX;
    endcase
    921: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd921;
      3: stateTransition = 11'd921;
      4: stateTransition = 11'd921;
      5: stateTransition = 11'd921;
      6: stateTransition = 11'd921;
      7: stateTransition = 11'd921;
      8: stateTransition = 11'd921;
      default: stateTransition = 11'bX;
    endcase
    922: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd922;
      3: stateTransition = 11'd922;
      4: stateTransition = 11'd922;
      5: stateTransition = 11'd922;
      6: stateTransition = 11'd922;
      7: stateTransition = 11'd922;
      8: stateTransition = 11'd922;
      default: stateTransition = 11'bX;
    endcase
    923: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd923;
      3: stateTransition = 11'd923;
      4: stateTransition = 11'd923;
      5: stateTransition = 11'd923;
      6: stateTransition = 11'd923;
      7: stateTransition = 11'd923;
      8: stateTransition = 11'd923;
      default: stateTransition = 11'bX;
    endcase
    924: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd924;
      3: stateTransition = 11'd924;
      4: stateTransition = 11'd924;
      5: stateTransition = 11'd924;
      6: stateTransition = 11'd924;
      7: stateTransition = 11'd924;
      8: stateTransition = 11'd924;
      default: stateTransition = 11'bX;
    endcase
    925: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd925;
      3: stateTransition = 11'd925;
      4: stateTransition = 11'd925;
      5: stateTransition = 11'd925;
      6: stateTransition = 11'd925;
      7: stateTransition = 11'd925;
      8: stateTransition = 11'd925;
      default: stateTransition = 11'bX;
    endcase
    926: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd926;
      3: stateTransition = 11'd926;
      4: stateTransition = 11'd926;
      5: stateTransition = 11'd926;
      6: stateTransition = 11'd926;
      7: stateTransition = 11'd926;
      8: stateTransition = 11'd926;
      default: stateTransition = 11'bX;
    endcase
    927: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd927;
      3: stateTransition = 11'd927;
      4: stateTransition = 11'd927;
      5: stateTransition = 11'd927;
      6: stateTransition = 11'd927;
      7: stateTransition = 11'd927;
      8: stateTransition = 11'd927;
      default: stateTransition = 11'bX;
    endcase
    928: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd928;
      3: stateTransition = 11'd928;
      4: stateTransition = 11'd928;
      5: stateTransition = 11'd928;
      6: stateTransition = 11'd928;
      7: stateTransition = 11'd928;
      8: stateTransition = 11'd928;
      default: stateTransition = 11'bX;
    endcase
    929: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd929;
      3: stateTransition = 11'd929;
      4: stateTransition = 11'd929;
      5: stateTransition = 11'd929;
      6: stateTransition = 11'd929;
      7: stateTransition = 11'd929;
      8: stateTransition = 11'd929;
      default: stateTransition = 11'bX;
    endcase
    930: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd930;
      3: stateTransition = 11'd930;
      4: stateTransition = 11'd930;
      5: stateTransition = 11'd930;
      6: stateTransition = 11'd930;
      7: stateTransition = 11'd930;
      8: stateTransition = 11'd930;
      default: stateTransition = 11'bX;
    endcase
    931: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd931;
      3: stateTransition = 11'd931;
      4: stateTransition = 11'd931;
      5: stateTransition = 11'd931;
      6: stateTransition = 11'd931;
      7: stateTransition = 11'd931;
      8: stateTransition = 11'd931;
      default: stateTransition = 11'bX;
    endcase
    932: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd932;
      3: stateTransition = 11'd932;
      4: stateTransition = 11'd932;
      5: stateTransition = 11'd932;
      6: stateTransition = 11'd932;
      7: stateTransition = 11'd932;
      8: stateTransition = 11'd932;
      default: stateTransition = 11'bX;
    endcase
    933: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd933;
      3: stateTransition = 11'd933;
      4: stateTransition = 11'd933;
      5: stateTransition = 11'd933;
      6: stateTransition = 11'd933;
      7: stateTransition = 11'd933;
      8: stateTransition = 11'd933;
      default: stateTransition = 11'bX;
    endcase
    934: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd934;
      3: stateTransition = 11'd934;
      4: stateTransition = 11'd934;
      5: stateTransition = 11'd934;
      6: stateTransition = 11'd934;
      7: stateTransition = 11'd934;
      8: stateTransition = 11'd934;
      default: stateTransition = 11'bX;
    endcase
    935: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd935;
      3: stateTransition = 11'd935;
      4: stateTransition = 11'd935;
      5: stateTransition = 11'd935;
      6: stateTransition = 11'd935;
      7: stateTransition = 11'd935;
      8: stateTransition = 11'd935;
      default: stateTransition = 11'bX;
    endcase
    936: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd936;
      3: stateTransition = 11'd936;
      4: stateTransition = 11'd936;
      5: stateTransition = 11'd936;
      6: stateTransition = 11'd936;
      7: stateTransition = 11'd936;
      8: stateTransition = 11'd936;
      default: stateTransition = 11'bX;
    endcase
    937: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd937;
      3: stateTransition = 11'd937;
      4: stateTransition = 11'd937;
      5: stateTransition = 11'd937;
      6: stateTransition = 11'd937;
      7: stateTransition = 11'd937;
      8: stateTransition = 11'd937;
      default: stateTransition = 11'bX;
    endcase
    938: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd938;
      3: stateTransition = 11'd938;
      4: stateTransition = 11'd938;
      5: stateTransition = 11'd938;
      6: stateTransition = 11'd938;
      7: stateTransition = 11'd938;
      8: stateTransition = 11'd938;
      default: stateTransition = 11'bX;
    endcase
    939: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd939;
      3: stateTransition = 11'd939;
      4: stateTransition = 11'd939;
      5: stateTransition = 11'd939;
      6: stateTransition = 11'd939;
      7: stateTransition = 11'd939;
      8: stateTransition = 11'd939;
      default: stateTransition = 11'bX;
    endcase
    940: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd940;
      3: stateTransition = 11'd940;
      4: stateTransition = 11'd940;
      5: stateTransition = 11'd940;
      6: stateTransition = 11'd940;
      7: stateTransition = 11'd940;
      8: stateTransition = 11'd940;
      default: stateTransition = 11'bX;
    endcase
    941: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd941;
      3: stateTransition = 11'd941;
      4: stateTransition = 11'd941;
      5: stateTransition = 11'd941;
      6: stateTransition = 11'd941;
      7: stateTransition = 11'd941;
      8: stateTransition = 11'd941;
      default: stateTransition = 11'bX;
    endcase
    942: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd942;
      3: stateTransition = 11'd942;
      4: stateTransition = 11'd942;
      5: stateTransition = 11'd942;
      6: stateTransition = 11'd942;
      7: stateTransition = 11'd942;
      8: stateTransition = 11'd942;
      default: stateTransition = 11'bX;
    endcase
    943: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd943;
      3: stateTransition = 11'd943;
      4: stateTransition = 11'd943;
      5: stateTransition = 11'd943;
      6: stateTransition = 11'd943;
      7: stateTransition = 11'd943;
      8: stateTransition = 11'd943;
      default: stateTransition = 11'bX;
    endcase
    944: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd944;
      3: stateTransition = 11'd944;
      4: stateTransition = 11'd944;
      5: stateTransition = 11'd944;
      6: stateTransition = 11'd944;
      7: stateTransition = 11'd944;
      8: stateTransition = 11'd944;
      default: stateTransition = 11'bX;
    endcase
    945: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd945;
      3: stateTransition = 11'd945;
      4: stateTransition = 11'd945;
      5: stateTransition = 11'd945;
      6: stateTransition = 11'd945;
      7: stateTransition = 11'd945;
      8: stateTransition = 11'd945;
      default: stateTransition = 11'bX;
    endcase
    946: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd946;
      3: stateTransition = 11'd946;
      4: stateTransition = 11'd946;
      5: stateTransition = 11'd946;
      6: stateTransition = 11'd946;
      7: stateTransition = 11'd946;
      8: stateTransition = 11'd946;
      default: stateTransition = 11'bX;
    endcase
    947: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd947;
      3: stateTransition = 11'd947;
      4: stateTransition = 11'd947;
      5: stateTransition = 11'd947;
      6: stateTransition = 11'd947;
      7: stateTransition = 11'd947;
      8: stateTransition = 11'd947;
      default: stateTransition = 11'bX;
    endcase
    948: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd948;
      3: stateTransition = 11'd948;
      4: stateTransition = 11'd948;
      5: stateTransition = 11'd948;
      6: stateTransition = 11'd948;
      7: stateTransition = 11'd948;
      8: stateTransition = 11'd948;
      default: stateTransition = 11'bX;
    endcase
    949: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd949;
      3: stateTransition = 11'd949;
      4: stateTransition = 11'd949;
      5: stateTransition = 11'd949;
      6: stateTransition = 11'd949;
      7: stateTransition = 11'd949;
      8: stateTransition = 11'd949;
      default: stateTransition = 11'bX;
    endcase
    950: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd950;
      3: stateTransition = 11'd950;
      4: stateTransition = 11'd950;
      5: stateTransition = 11'd950;
      6: stateTransition = 11'd950;
      7: stateTransition = 11'd950;
      8: stateTransition = 11'd950;
      default: stateTransition = 11'bX;
    endcase
    951: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd951;
      3: stateTransition = 11'd951;
      4: stateTransition = 11'd951;
      5: stateTransition = 11'd951;
      6: stateTransition = 11'd951;
      7: stateTransition = 11'd951;
      8: stateTransition = 11'd951;
      default: stateTransition = 11'bX;
    endcase
    952: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd952;
      3: stateTransition = 11'd952;
      4: stateTransition = 11'd952;
      5: stateTransition = 11'd952;
      6: stateTransition = 11'd952;
      7: stateTransition = 11'd952;
      8: stateTransition = 11'd952;
      default: stateTransition = 11'bX;
    endcase
    953: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd953;
      3: stateTransition = 11'd953;
      4: stateTransition = 11'd953;
      5: stateTransition = 11'd953;
      6: stateTransition = 11'd953;
      7: stateTransition = 11'd953;
      8: stateTransition = 11'd953;
      default: stateTransition = 11'bX;
    endcase
    954: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd954;
      3: stateTransition = 11'd954;
      4: stateTransition = 11'd954;
      5: stateTransition = 11'd954;
      6: stateTransition = 11'd954;
      7: stateTransition = 11'd954;
      8: stateTransition = 11'd954;
      default: stateTransition = 11'bX;
    endcase
    955: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd955;
      3: stateTransition = 11'd955;
      4: stateTransition = 11'd955;
      5: stateTransition = 11'd955;
      6: stateTransition = 11'd955;
      7: stateTransition = 11'd955;
      8: stateTransition = 11'd955;
      default: stateTransition = 11'bX;
    endcase
    956: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd956;
      3: stateTransition = 11'd956;
      4: stateTransition = 11'd956;
      5: stateTransition = 11'd956;
      6: stateTransition = 11'd956;
      7: stateTransition = 11'd956;
      8: stateTransition = 11'd956;
      default: stateTransition = 11'bX;
    endcase
    957: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd957;
      3: stateTransition = 11'd957;
      4: stateTransition = 11'd957;
      5: stateTransition = 11'd957;
      6: stateTransition = 11'd957;
      7: stateTransition = 11'd957;
      8: stateTransition = 11'd957;
      default: stateTransition = 11'bX;
    endcase
    958: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd958;
      3: stateTransition = 11'd958;
      4: stateTransition = 11'd958;
      5: stateTransition = 11'd958;
      6: stateTransition = 11'd958;
      7: stateTransition = 11'd958;
      8: stateTransition = 11'd958;
      default: stateTransition = 11'bX;
    endcase
    959: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd959;
      3: stateTransition = 11'd959;
      4: stateTransition = 11'd959;
      5: stateTransition = 11'd959;
      6: stateTransition = 11'd959;
      7: stateTransition = 11'd959;
      8: stateTransition = 11'd959;
      default: stateTransition = 11'bX;
    endcase
    960: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd960;
      3: stateTransition = 11'd960;
      4: stateTransition = 11'd960;
      5: stateTransition = 11'd960;
      6: stateTransition = 11'd960;
      7: stateTransition = 11'd960;
      8: stateTransition = 11'd960;
      default: stateTransition = 11'bX;
    endcase
    961: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd961;
      3: stateTransition = 11'd961;
      4: stateTransition = 11'd961;
      5: stateTransition = 11'd961;
      6: stateTransition = 11'd961;
      7: stateTransition = 11'd961;
      8: stateTransition = 11'd961;
      default: stateTransition = 11'bX;
    endcase
    962: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd962;
      3: stateTransition = 11'd962;
      4: stateTransition = 11'd962;
      5: stateTransition = 11'd962;
      6: stateTransition = 11'd962;
      7: stateTransition = 11'd962;
      8: stateTransition = 11'd962;
      default: stateTransition = 11'bX;
    endcase
    963: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd963;
      3: stateTransition = 11'd963;
      4: stateTransition = 11'd963;
      5: stateTransition = 11'd963;
      6: stateTransition = 11'd963;
      7: stateTransition = 11'd963;
      8: stateTransition = 11'd963;
      default: stateTransition = 11'bX;
    endcase
    964: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd964;
      3: stateTransition = 11'd964;
      4: stateTransition = 11'd964;
      5: stateTransition = 11'd964;
      6: stateTransition = 11'd964;
      7: stateTransition = 11'd964;
      8: stateTransition = 11'd964;
      default: stateTransition = 11'bX;
    endcase
    965: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd965;
      3: stateTransition = 11'd965;
      4: stateTransition = 11'd965;
      5: stateTransition = 11'd965;
      6: stateTransition = 11'd965;
      7: stateTransition = 11'd965;
      8: stateTransition = 11'd965;
      default: stateTransition = 11'bX;
    endcase
    966: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd966;
      3: stateTransition = 11'd966;
      4: stateTransition = 11'd966;
      5: stateTransition = 11'd966;
      6: stateTransition = 11'd966;
      7: stateTransition = 11'd966;
      8: stateTransition = 11'd966;
      default: stateTransition = 11'bX;
    endcase
    967: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd967;
      3: stateTransition = 11'd967;
      4: stateTransition = 11'd967;
      5: stateTransition = 11'd967;
      6: stateTransition = 11'd967;
      7: stateTransition = 11'd967;
      8: stateTransition = 11'd967;
      default: stateTransition = 11'bX;
    endcase
    968: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd968;
      3: stateTransition = 11'd968;
      4: stateTransition = 11'd968;
      5: stateTransition = 11'd968;
      6: stateTransition = 11'd968;
      7: stateTransition = 11'd968;
      8: stateTransition = 11'd968;
      default: stateTransition = 11'bX;
    endcase
    969: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd969;
      3: stateTransition = 11'd969;
      4: stateTransition = 11'd969;
      5: stateTransition = 11'd969;
      6: stateTransition = 11'd969;
      7: stateTransition = 11'd969;
      8: stateTransition = 11'd969;
      default: stateTransition = 11'bX;
    endcase
    970: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd970;
      3: stateTransition = 11'd970;
      4: stateTransition = 11'd970;
      5: stateTransition = 11'd970;
      6: stateTransition = 11'd970;
      7: stateTransition = 11'd970;
      8: stateTransition = 11'd970;
      default: stateTransition = 11'bX;
    endcase
    971: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd971;
      3: stateTransition = 11'd971;
      4: stateTransition = 11'd971;
      5: stateTransition = 11'd971;
      6: stateTransition = 11'd971;
      7: stateTransition = 11'd971;
      8: stateTransition = 11'd971;
      default: stateTransition = 11'bX;
    endcase
    972: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd972;
      3: stateTransition = 11'd972;
      4: stateTransition = 11'd972;
      5: stateTransition = 11'd972;
      6: stateTransition = 11'd972;
      7: stateTransition = 11'd972;
      8: stateTransition = 11'd972;
      default: stateTransition = 11'bX;
    endcase
    973: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd973;
      3: stateTransition = 11'd973;
      4: stateTransition = 11'd973;
      5: stateTransition = 11'd973;
      6: stateTransition = 11'd973;
      7: stateTransition = 11'd973;
      8: stateTransition = 11'd973;
      default: stateTransition = 11'bX;
    endcase
    974: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd974;
      3: stateTransition = 11'd974;
      4: stateTransition = 11'd974;
      5: stateTransition = 11'd974;
      6: stateTransition = 11'd974;
      7: stateTransition = 11'd974;
      8: stateTransition = 11'd974;
      default: stateTransition = 11'bX;
    endcase
    975: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd975;
      3: stateTransition = 11'd975;
      4: stateTransition = 11'd975;
      5: stateTransition = 11'd975;
      6: stateTransition = 11'd975;
      7: stateTransition = 11'd975;
      8: stateTransition = 11'd975;
      default: stateTransition = 11'bX;
    endcase
    976: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd976;
      3: stateTransition = 11'd976;
      4: stateTransition = 11'd976;
      5: stateTransition = 11'd976;
      6: stateTransition = 11'd976;
      7: stateTransition = 11'd976;
      8: stateTransition = 11'd976;
      default: stateTransition = 11'bX;
    endcase
    977: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd977;
      3: stateTransition = 11'd977;
      4: stateTransition = 11'd977;
      5: stateTransition = 11'd977;
      6: stateTransition = 11'd977;
      7: stateTransition = 11'd977;
      8: stateTransition = 11'd977;
      default: stateTransition = 11'bX;
    endcase
    978: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd978;
      3: stateTransition = 11'd978;
      4: stateTransition = 11'd978;
      5: stateTransition = 11'd978;
      6: stateTransition = 11'd978;
      7: stateTransition = 11'd978;
      8: stateTransition = 11'd978;
      default: stateTransition = 11'bX;
    endcase
    979: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd979;
      3: stateTransition = 11'd979;
      4: stateTransition = 11'd979;
      5: stateTransition = 11'd979;
      6: stateTransition = 11'd979;
      7: stateTransition = 11'd979;
      8: stateTransition = 11'd979;
      default: stateTransition = 11'bX;
    endcase
    980: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd980;
      3: stateTransition = 11'd980;
      4: stateTransition = 11'd980;
      5: stateTransition = 11'd980;
      6: stateTransition = 11'd980;
      7: stateTransition = 11'd980;
      8: stateTransition = 11'd980;
      default: stateTransition = 11'bX;
    endcase
    981: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd981;
      3: stateTransition = 11'd981;
      4: stateTransition = 11'd981;
      5: stateTransition = 11'd981;
      6: stateTransition = 11'd981;
      7: stateTransition = 11'd981;
      8: stateTransition = 11'd981;
      default: stateTransition = 11'bX;
    endcase
    982: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd982;
      3: stateTransition = 11'd982;
      4: stateTransition = 11'd982;
      5: stateTransition = 11'd982;
      6: stateTransition = 11'd982;
      7: stateTransition = 11'd982;
      8: stateTransition = 11'd982;
      default: stateTransition = 11'bX;
    endcase
    983: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd983;
      3: stateTransition = 11'd983;
      4: stateTransition = 11'd983;
      5: stateTransition = 11'd983;
      6: stateTransition = 11'd983;
      7: stateTransition = 11'd983;
      8: stateTransition = 11'd983;
      default: stateTransition = 11'bX;
    endcase
    984: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd984;
      3: stateTransition = 11'd984;
      4: stateTransition = 11'd984;
      5: stateTransition = 11'd984;
      6: stateTransition = 11'd984;
      7: stateTransition = 11'd984;
      8: stateTransition = 11'd984;
      default: stateTransition = 11'bX;
    endcase
    985: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd985;
      3: stateTransition = 11'd985;
      4: stateTransition = 11'd985;
      5: stateTransition = 11'd985;
      6: stateTransition = 11'd985;
      7: stateTransition = 11'd985;
      8: stateTransition = 11'd985;
      default: stateTransition = 11'bX;
    endcase
    986: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd986;
      3: stateTransition = 11'd986;
      4: stateTransition = 11'd986;
      5: stateTransition = 11'd986;
      6: stateTransition = 11'd986;
      7: stateTransition = 11'd986;
      8: stateTransition = 11'd986;
      default: stateTransition = 11'bX;
    endcase
    987: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd987;
      3: stateTransition = 11'd987;
      4: stateTransition = 11'd987;
      5: stateTransition = 11'd987;
      6: stateTransition = 11'd987;
      7: stateTransition = 11'd987;
      8: stateTransition = 11'd987;
      default: stateTransition = 11'bX;
    endcase
    988: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd988;
      3: stateTransition = 11'd988;
      4: stateTransition = 11'd988;
      5: stateTransition = 11'd988;
      6: stateTransition = 11'd988;
      7: stateTransition = 11'd988;
      8: stateTransition = 11'd988;
      default: stateTransition = 11'bX;
    endcase
    989: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd989;
      3: stateTransition = 11'd989;
      4: stateTransition = 11'd989;
      5: stateTransition = 11'd989;
      6: stateTransition = 11'd989;
      7: stateTransition = 11'd989;
      8: stateTransition = 11'd989;
      default: stateTransition = 11'bX;
    endcase
    990: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd990;
      3: stateTransition = 11'd990;
      4: stateTransition = 11'd990;
      5: stateTransition = 11'd990;
      6: stateTransition = 11'd990;
      7: stateTransition = 11'd990;
      8: stateTransition = 11'd990;
      default: stateTransition = 11'bX;
    endcase
    991: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd991;
      3: stateTransition = 11'd991;
      4: stateTransition = 11'd991;
      5: stateTransition = 11'd991;
      6: stateTransition = 11'd991;
      7: stateTransition = 11'd991;
      8: stateTransition = 11'd991;
      default: stateTransition = 11'bX;
    endcase
    992: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd992;
      3: stateTransition = 11'd992;
      4: stateTransition = 11'd992;
      5: stateTransition = 11'd992;
      6: stateTransition = 11'd992;
      7: stateTransition = 11'd992;
      8: stateTransition = 11'd992;
      default: stateTransition = 11'bX;
    endcase
    993: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd993;
      3: stateTransition = 11'd993;
      4: stateTransition = 11'd993;
      5: stateTransition = 11'd993;
      6: stateTransition = 11'd993;
      7: stateTransition = 11'd993;
      8: stateTransition = 11'd993;
      default: stateTransition = 11'bX;
    endcase
    994: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd994;
      3: stateTransition = 11'd994;
      4: stateTransition = 11'd994;
      5: stateTransition = 11'd994;
      6: stateTransition = 11'd994;
      7: stateTransition = 11'd994;
      8: stateTransition = 11'd994;
      default: stateTransition = 11'bX;
    endcase
    995: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd995;
      3: stateTransition = 11'd995;
      4: stateTransition = 11'd995;
      5: stateTransition = 11'd995;
      6: stateTransition = 11'd995;
      7: stateTransition = 11'd995;
      8: stateTransition = 11'd995;
      default: stateTransition = 11'bX;
    endcase
    996: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd996;
      3: stateTransition = 11'd996;
      4: stateTransition = 11'd996;
      5: stateTransition = 11'd996;
      6: stateTransition = 11'd996;
      7: stateTransition = 11'd996;
      8: stateTransition = 11'd996;
      default: stateTransition = 11'bX;
    endcase
    997: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd997;
      3: stateTransition = 11'd997;
      4: stateTransition = 11'd997;
      5: stateTransition = 11'd997;
      6: stateTransition = 11'd997;
      7: stateTransition = 11'd997;
      8: stateTransition = 11'd997;
      default: stateTransition = 11'bX;
    endcase
    998: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd998;
      3: stateTransition = 11'd998;
      4: stateTransition = 11'd998;
      5: stateTransition = 11'd998;
      6: stateTransition = 11'd998;
      7: stateTransition = 11'd998;
      8: stateTransition = 11'd998;
      default: stateTransition = 11'bX;
    endcase
    999: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd999;
      3: stateTransition = 11'd999;
      4: stateTransition = 11'd999;
      5: stateTransition = 11'd999;
      6: stateTransition = 11'd999;
      7: stateTransition = 11'd999;
      8: stateTransition = 11'd999;
      default: stateTransition = 11'bX;
    endcase
    1000: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1000;
      3: stateTransition = 11'd1000;
      4: stateTransition = 11'd1000;
      5: stateTransition = 11'd1000;
      6: stateTransition = 11'd1000;
      7: stateTransition = 11'd1000;
      8: stateTransition = 11'd1000;
      default: stateTransition = 11'bX;
    endcase
    1001: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1001;
      3: stateTransition = 11'd1001;
      4: stateTransition = 11'd1001;
      5: stateTransition = 11'd1001;
      6: stateTransition = 11'd1001;
      7: stateTransition = 11'd1001;
      8: stateTransition = 11'd1001;
      default: stateTransition = 11'bX;
    endcase
    1002: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1002;
      3: stateTransition = 11'd1002;
      4: stateTransition = 11'd1002;
      5: stateTransition = 11'd1002;
      6: stateTransition = 11'd1002;
      7: stateTransition = 11'd1002;
      8: stateTransition = 11'd1002;
      default: stateTransition = 11'bX;
    endcase
    1003: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1003;
      3: stateTransition = 11'd1003;
      4: stateTransition = 11'd1003;
      5: stateTransition = 11'd1003;
      6: stateTransition = 11'd1003;
      7: stateTransition = 11'd1003;
      8: stateTransition = 11'd1003;
      default: stateTransition = 11'bX;
    endcase
    1004: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1004;
      3: stateTransition = 11'd1004;
      4: stateTransition = 11'd1004;
      5: stateTransition = 11'd1004;
      6: stateTransition = 11'd1004;
      7: stateTransition = 11'd1004;
      8: stateTransition = 11'd1004;
      default: stateTransition = 11'bX;
    endcase
    1005: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1005;
      3: stateTransition = 11'd1005;
      4: stateTransition = 11'd1005;
      5: stateTransition = 11'd1005;
      6: stateTransition = 11'd1005;
      7: stateTransition = 11'd1005;
      8: stateTransition = 11'd1005;
      default: stateTransition = 11'bX;
    endcase
    1006: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1006;
      3: stateTransition = 11'd1006;
      4: stateTransition = 11'd1006;
      5: stateTransition = 11'd1006;
      6: stateTransition = 11'd1006;
      7: stateTransition = 11'd1006;
      8: stateTransition = 11'd1006;
      default: stateTransition = 11'bX;
    endcase
    1007: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1007;
      3: stateTransition = 11'd1007;
      4: stateTransition = 11'd1007;
      5: stateTransition = 11'd1007;
      6: stateTransition = 11'd1007;
      7: stateTransition = 11'd1007;
      8: stateTransition = 11'd1007;
      default: stateTransition = 11'bX;
    endcase
    1008: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1008;
      3: stateTransition = 11'd1008;
      4: stateTransition = 11'd1008;
      5: stateTransition = 11'd1008;
      6: stateTransition = 11'd1008;
      7: stateTransition = 11'd1008;
      8: stateTransition = 11'd1008;
      default: stateTransition = 11'bX;
    endcase
    1009: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1009;
      3: stateTransition = 11'd1009;
      4: stateTransition = 11'd1009;
      5: stateTransition = 11'd1009;
      6: stateTransition = 11'd1009;
      7: stateTransition = 11'd1009;
      8: stateTransition = 11'd1009;
      default: stateTransition = 11'bX;
    endcase
    1010: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1010;
      3: stateTransition = 11'd1010;
      4: stateTransition = 11'd1010;
      5: stateTransition = 11'd1010;
      6: stateTransition = 11'd1010;
      7: stateTransition = 11'd1010;
      8: stateTransition = 11'd1010;
      default: stateTransition = 11'bX;
    endcase
    1011: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1011;
      3: stateTransition = 11'd1011;
      4: stateTransition = 11'd1011;
      5: stateTransition = 11'd1011;
      6: stateTransition = 11'd1011;
      7: stateTransition = 11'd1011;
      8: stateTransition = 11'd1011;
      default: stateTransition = 11'bX;
    endcase
    1012: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1012;
      3: stateTransition = 11'd1012;
      4: stateTransition = 11'd1012;
      5: stateTransition = 11'd1012;
      6: stateTransition = 11'd1012;
      7: stateTransition = 11'd1012;
      8: stateTransition = 11'd1012;
      default: stateTransition = 11'bX;
    endcase
    1013: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1013;
      3: stateTransition = 11'd1013;
      4: stateTransition = 11'd1013;
      5: stateTransition = 11'd1013;
      6: stateTransition = 11'd1013;
      7: stateTransition = 11'd1013;
      8: stateTransition = 11'd1013;
      default: stateTransition = 11'bX;
    endcase
    1014: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1014;
      3: stateTransition = 11'd1014;
      4: stateTransition = 11'd1014;
      5: stateTransition = 11'd1014;
      6: stateTransition = 11'd1014;
      7: stateTransition = 11'd1014;
      8: stateTransition = 11'd1014;
      default: stateTransition = 11'bX;
    endcase
    1015: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1015;
      3: stateTransition = 11'd1015;
      4: stateTransition = 11'd1015;
      5: stateTransition = 11'd1015;
      6: stateTransition = 11'd1015;
      7: stateTransition = 11'd1015;
      8: stateTransition = 11'd1015;
      default: stateTransition = 11'bX;
    endcase
    1016: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1016;
      3: stateTransition = 11'd1016;
      4: stateTransition = 11'd1016;
      5: stateTransition = 11'd1016;
      6: stateTransition = 11'd1016;
      7: stateTransition = 11'd1016;
      8: stateTransition = 11'd1016;
      default: stateTransition = 11'bX;
    endcase
    1017: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1017;
      3: stateTransition = 11'd1017;
      4: stateTransition = 11'd1017;
      5: stateTransition = 11'd1017;
      6: stateTransition = 11'd1017;
      7: stateTransition = 11'd1017;
      8: stateTransition = 11'd1017;
      default: stateTransition = 11'bX;
    endcase
    1018: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1018;
      3: stateTransition = 11'd1018;
      4: stateTransition = 11'd1018;
      5: stateTransition = 11'd1018;
      6: stateTransition = 11'd1018;
      7: stateTransition = 11'd1018;
      8: stateTransition = 11'd1018;
      default: stateTransition = 11'bX;
    endcase
    1019: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1019;
      3: stateTransition = 11'd1019;
      4: stateTransition = 11'd1019;
      5: stateTransition = 11'd1019;
      6: stateTransition = 11'd1019;
      7: stateTransition = 11'd1019;
      8: stateTransition = 11'd1019;
      default: stateTransition = 11'bX;
    endcase
    1020: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1020;
      3: stateTransition = 11'd1020;
      4: stateTransition = 11'd1020;
      5: stateTransition = 11'd1020;
      6: stateTransition = 11'd1020;
      7: stateTransition = 11'd1020;
      8: stateTransition = 11'd1020;
      default: stateTransition = 11'bX;
    endcase
    1021: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1021;
      3: stateTransition = 11'd1021;
      4: stateTransition = 11'd1021;
      5: stateTransition = 11'd1021;
      6: stateTransition = 11'd1021;
      7: stateTransition = 11'd1021;
      8: stateTransition = 11'd1021;
      default: stateTransition = 11'bX;
    endcase
    1022: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1022;
      3: stateTransition = 11'd1022;
      4: stateTransition = 11'd1022;
      5: stateTransition = 11'd1022;
      6: stateTransition = 11'd1022;
      7: stateTransition = 11'd1022;
      8: stateTransition = 11'd1022;
      default: stateTransition = 11'bX;
    endcase
    1023: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1023;
      3: stateTransition = 11'd1023;
      4: stateTransition = 11'd1023;
      5: stateTransition = 11'd1023;
      6: stateTransition = 11'd1023;
      7: stateTransition = 11'd1023;
      8: stateTransition = 11'd1023;
      default: stateTransition = 11'bX;
    endcase
    1024: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1024;
      3: stateTransition = 11'd1024;
      4: stateTransition = 11'd1024;
      5: stateTransition = 11'd1024;
      6: stateTransition = 11'd1024;
      7: stateTransition = 11'd1024;
      8: stateTransition = 11'd1024;
      default: stateTransition = 11'bX;
    endcase
    1025: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1025;
      3: stateTransition = 11'd1025;
      4: stateTransition = 11'd1025;
      5: stateTransition = 11'd1025;
      6: stateTransition = 11'd1025;
      7: stateTransition = 11'd1025;
      8: stateTransition = 11'd1025;
      default: stateTransition = 11'bX;
    endcase
    1026: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1026;
      3: stateTransition = 11'd1026;
      4: stateTransition = 11'd1026;
      5: stateTransition = 11'd1026;
      6: stateTransition = 11'd1026;
      7: stateTransition = 11'd1026;
      8: stateTransition = 11'd1026;
      default: stateTransition = 11'bX;
    endcase
    1027: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1027;
      3: stateTransition = 11'd1027;
      4: stateTransition = 11'd1027;
      5: stateTransition = 11'd1027;
      6: stateTransition = 11'd1027;
      7: stateTransition = 11'd1027;
      8: stateTransition = 11'd1027;
      default: stateTransition = 11'bX;
    endcase
    1028: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1028;
      3: stateTransition = 11'd1028;
      4: stateTransition = 11'd1028;
      5: stateTransition = 11'd1028;
      6: stateTransition = 11'd1028;
      7: stateTransition = 11'd1028;
      8: stateTransition = 11'd1028;
      default: stateTransition = 11'bX;
    endcase
    1029: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1029;
      3: stateTransition = 11'd1029;
      4: stateTransition = 11'd1029;
      5: stateTransition = 11'd1029;
      6: stateTransition = 11'd1029;
      7: stateTransition = 11'd1029;
      8: stateTransition = 11'd1029;
      default: stateTransition = 11'bX;
    endcase
    1030: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1030;
      3: stateTransition = 11'd1030;
      4: stateTransition = 11'd1030;
      5: stateTransition = 11'd1030;
      6: stateTransition = 11'd1030;
      7: stateTransition = 11'd1030;
      8: stateTransition = 11'd1030;
      default: stateTransition = 11'bX;
    endcase
    1031: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1031;
      3: stateTransition = 11'd1031;
      4: stateTransition = 11'd1031;
      5: stateTransition = 11'd1031;
      6: stateTransition = 11'd1031;
      7: stateTransition = 11'd1031;
      8: stateTransition = 11'd1031;
      default: stateTransition = 11'bX;
    endcase
    1032: case ( mapped_char ) 
      0: stateTransition = 11'd0;
      1: stateTransition = 11'd0;
      2: stateTransition = 11'd1032;
      3: stateTransition = 11'd1032;
      4: stateTransition = 11'd1032;
      5: stateTransition = 11'd1032;
      6: stateTransition = 11'd1032;
      7: stateTransition = 11'd1032;
      8: stateTransition = 11'd1032;
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
