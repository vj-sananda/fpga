//---------------------------------------------------
//			cancid_ALL.lst
//---------------------------------------------------
wire enable_all  =  1;

wire [15:0] count_ALL_0 ;
cancid_ALL_0_verilog   cancid_ALL_0_verilog_i  (
			     // Outputs
			     .count		(count_ALL_0),
			     .fired             (fired_ALL_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

wire [15:0] count_ALL_1 ;
cancid_ALL_1_verilog   cancid_ALL_1_verilog_i  (
			     // Outputs
			     .count		(count_ALL_1),
			     .fired             (fired_ALL_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_2 ;
cancid_ALL_2_verilog   cancid_ALL_2_verilog_i  (
			     // Outputs
			     .count		(count_ALL_2),
			     .fired             (fired_ALL_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_3 ;
cancid_ALL_3_verilog   cancid_ALL_3_verilog_i  (
			     // Outputs
			     .count		(count_ALL_3),
			     .fired             (fired_ALL_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_4 ;
cancid_ALL_4_verilog   cancid_ALL_4_verilog_i  (
			     // Outputs
			     .count		(count_ALL_4),
			     .fired             (fired_ALL_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

//These are the optional patterns,
//All regex matchers run in parallel in this architecture
//Added to make FPGA build easier, with just mandatory patterns

`ifdef REGEX_OPTIONAL

wire [15:0] count_ALL_5 ;
cancid_ALL_5_verilog   cancid_ALL_5_verilog_i  (
			     // Outputs
			     .count		(count_ALL_5),
			     .fired             (fired_ALL_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_6 ;
cancid_ALL_6_verilog   cancid_ALL_6_verilog_i  (
			     // Outputs
			     .count		(count_ALL_6),
			     .fired             (fired_ALL_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_7 ;
cancid_ALL_7_verilog   cancid_ALL_7_verilog_i  (
			     // Outputs
			     .count		(count_ALL_7),
			     .fired             (fired_ALL_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_8 ;
cancid_ALL_8_verilog   cancid_ALL_8_verilog_i  (
			     // Outputs
			     .count		(count_ALL_8),
			     .fired             (fired_ALL_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_9 ;
cancid_ALL_9_verilog   cancid_ALL_9_verilog_i  (
			     // Outputs
			     .count		(count_ALL_9),
			     .fired             (fired_ALL_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_10 ;
cancid_ALL_10_verilog   cancid_ALL_10_verilog_i  (
			     // Outputs
			     .count		(count_ALL_10),
			     .fired             (fired_ALL_10),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_11 ;
cancid_ALL_11_verilog   cancid_ALL_11_verilog_i  (
			     // Outputs
			     .count		(count_ALL_11),
			     .fired             (fired_ALL_11),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_12 ;
cancid_ALL_12_verilog   cancid_ALL_12_verilog_i  (
			     // Outputs
			     .count		(count_ALL_12),
			     .fired             (fired_ALL_12),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_13 ;
cancid_ALL_13_verilog   cancid_ALL_13_verilog_i  (
			     // Outputs
			     .count		(count_ALL_13),
			     .fired             (fired_ALL_13),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ALL_14 ;
cancid_ALL_14_verilog   cancid_ALL_14_verilog_i  (
			     // Outputs
			     .count		(count_ALL_14),
			     .fired             (fired_ALL_14),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_all),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));
`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_finger.lst
//---------------------------------------------------
wire enable_finger ;
wire [15:0] count_finger_0 ;
cancid_finger_0_verilog   cancid_finger_0_verilog_i  (
			     // Outputs
			     .count		(count_finger_0),
			     .fired             (fired_finger_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


`ifdef REGEX_OPTIONAL
wire [15:0] count_finger_1 ;
cancid_finger_1_verilog   cancid_finger_1_verilog_i  (
			     // Outputs
			     .count		(count_finger_1),
			     .fired             (fired_finger_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_2 ;
cancid_finger_2_verilog   cancid_finger_2_verilog_i  (
			     // Outputs
			     .count		(count_finger_2),
			     .fired             (fired_finger_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_3 ;
cancid_finger_3_verilog   cancid_finger_3_verilog_i  (
			     // Outputs
			     .count		(count_finger_3),
			     .fired             (fired_finger_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_4 ;
cancid_finger_4_verilog   cancid_finger_4_verilog_i  (
			     // Outputs
			     .count		(count_finger_4),
			     .fired             (fired_finger_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_finger_5 ;
cancid_finger_5_verilog   cancid_finger_5_verilog_i  (
			     // Outputs
			     .count		(count_finger_5),
			     .fired             (fired_finger_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_finger),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_ftp.lst
//---------------------------------------------------
wire enable_ftp ;
wire [15:0] count_ftp_0 ;
cancid_ftp_0_verilog   cancid_ftp_0_verilog_i  (
			     // Outputs
			     .count		(count_ftp_0),
			     .fired             (fired_ftp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL
wire [15:0] count_ftp_1 ;
cancid_ftp_1_verilog   cancid_ftp_1_verilog_i  (
			     // Outputs
			     .count		(count_ftp_1),
			     .fired             (fired_ftp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_2 ;
cancid_ftp_2_verilog   cancid_ftp_2_verilog_i  (
			     // Outputs
			     .count		(count_ftp_2),
			     .fired             (fired_ftp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_3 ;
cancid_ftp_3_verilog   cancid_ftp_3_verilog_i  (
			     // Outputs
			     .count		(count_ftp_3),
			     .fired             (fired_ftp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_4 ;
cancid_ftp_4_verilog   cancid_ftp_4_verilog_i  (
			     // Outputs
			     .count		(count_ftp_4),
			     .fired             (fired_ftp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_5 ;
cancid_ftp_5_verilog   cancid_ftp_5_verilog_i  (
			     // Outputs
			     .count		(count_ftp_5),
			     .fired             (fired_ftp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_6 ;
cancid_ftp_6_verilog   cancid_ftp_6_verilog_i  (
			     // Outputs
			     .count		(count_ftp_6),
			     .fired             (fired_ftp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_7 ;
cancid_ftp_7_verilog   cancid_ftp_7_verilog_i  (
			     // Outputs
			     .count		(count_ftp_7),
			     .fired             (fired_ftp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_8 ;
cancid_ftp_8_verilog   cancid_ftp_8_verilog_i  (
			     // Outputs
			     .count		(count_ftp_8),
			     .fired             (fired_ftp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_ftp_9 ;
cancid_ftp_9_verilog   cancid_ftp_9_verilog_i  (
			     // Outputs
			     .count		(count_ftp_9),
			     .fired             (fired_ftp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_ftp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_http.lst
//---------------------------------------------------
wire enable_http ;
wire [15:0] count_http_0 ;
cancid_http_0_verilog   cancid_http_0_verilog_i  (
			     // Outputs
			     .count		(count_http_0),
			     .fired             (fired_http_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL
wire [15:0] count_http_1 ;
cancid_http_1_verilog   cancid_http_1_verilog_i  (
			     // Outputs
			     .count		(count_http_1),
			     .fired             (fired_http_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_2 ;
cancid_http_2_verilog   cancid_http_2_verilog_i  (
			     // Outputs
			     .count		(count_http_2),
			     .fired             (fired_http_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_3 ;
cancid_http_3_verilog   cancid_http_3_verilog_i  (
			     // Outputs
			     .count		(count_http_3),
			     .fired             (fired_http_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_4 ;
cancid_http_4_verilog   cancid_http_4_verilog_i  (
			     // Outputs
			     .count		(count_http_4),
			     .fired             (fired_http_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_5 ;
cancid_http_5_verilog   cancid_http_5_verilog_i  (
			     // Outputs
			     .count		(count_http_5),
			     .fired             (fired_http_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_6 ;
cancid_http_6_verilog   cancid_http_6_verilog_i  (
			     // Outputs
			     .count		(count_http_6),
			     .fired             (fired_http_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_7 ;
cancid_http_7_verilog   cancid_http_7_verilog_i  (
			     // Outputs
			     .count		(count_http_7),
			     .fired             (fired_http_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_8 ;
cancid_http_8_verilog   cancid_http_8_verilog_i  (
			     // Outputs
			     .count		(count_http_8),
			     .fired             (fired_http_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_http_9 ;
cancid_http_9_verilog   cancid_http_9_verilog_i  (
			     // Outputs
			     .count		(count_http_9),
			     .fired             (fired_http_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_http),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_imap.lst
//---------------------------------------------------
wire enable_imap ;
wire [15:0] count_imap_0 ;
cancid_imap_0_verilog   cancid_imap_0_verilog_i  (
			     // Outputs
			     .count		(count_imap_0),
			     .fired             (fired_imap_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL
wire [15:0] count_imap_1 ;
cancid_imap_1_verilog   cancid_imap_1_verilog_i  (
			     // Outputs
			     .count		(count_imap_1),
			     .fired             (fired_imap_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_2 ;
cancid_imap_2_verilog   cancid_imap_2_verilog_i  (
			     // Outputs
			     .count		(count_imap_2),
			     .fired             (fired_imap_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_3 ;
cancid_imap_3_verilog   cancid_imap_3_verilog_i  (
			     // Outputs
			     .count		(count_imap_3),
			     .fired             (fired_imap_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_4 ;
cancid_imap_4_verilog   cancid_imap_4_verilog_i  (
			     // Outputs
			     .count		(count_imap_4),
			     .fired             (fired_imap_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_5 ;
cancid_imap_5_verilog   cancid_imap_5_verilog_i  (
			     // Outputs
			     .count		(count_imap_5),
			     .fired             (fired_imap_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_6 ;
cancid_imap_6_verilog   cancid_imap_6_verilog_i  (
			     // Outputs
			     .count		(count_imap_6),
			     .fired             (fired_imap_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_7 ;
cancid_imap_7_verilog   cancid_imap_7_verilog_i  (
			     // Outputs
			     .count		(count_imap_7),
			     .fired             (fired_imap_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_8 ;
cancid_imap_8_verilog   cancid_imap_8_verilog_i  (
			     // Outputs
			     .count		(count_imap_8),
			     .fired             (fired_imap_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_imap_9 ;
cancid_imap_9_verilog   cancid_imap_9_verilog_i  (
			     // Outputs
			     .count		(count_imap_9),
			     .fired             (fired_imap_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_imap),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_netbios.lst
//---------------------------------------------------
wire enable_netbios ;
wire [15:0] count_netbios_0 ;
cancid_netbios_0_verilog   cancid_netbios_0_verilog_i  (
			     // Outputs
			     .count		(count_netbios_0),
			     .fired             (fired_netbios_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL
wire [15:0] count_netbios_1 ;
cancid_netbios_1_verilog   cancid_netbios_1_verilog_i  (
			     // Outputs
			     .count		(count_netbios_1),
			     .fired             (fired_netbios_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_2 ;
cancid_netbios_2_verilog   cancid_netbios_2_verilog_i  (
			     // Outputs
			     .count		(count_netbios_2),
			     .fired             (fired_netbios_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_3 ;
cancid_netbios_3_verilog   cancid_netbios_3_verilog_i  (
			     // Outputs
			     .count		(count_netbios_3),
			     .fired             (fired_netbios_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_4 ;
cancid_netbios_4_verilog   cancid_netbios_4_verilog_i  (
			     // Outputs
			     .count		(count_netbios_4),
			     .fired             (fired_netbios_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_5 ;
cancid_netbios_5_verilog   cancid_netbios_5_verilog_i  (
			     // Outputs
			     .count		(count_netbios_5),
			     .fired             (fired_netbios_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_6 ;
cancid_netbios_6_verilog   cancid_netbios_6_verilog_i  (
			     // Outputs
			     .count		(count_netbios_6),
			     .fired             (fired_netbios_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_7 ;
cancid_netbios_7_verilog   cancid_netbios_7_verilog_i  (
			     // Outputs
			     .count		(count_netbios_7),
			     .fired             (fired_netbios_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_8 ;
cancid_netbios_8_verilog   cancid_netbios_8_verilog_i  (
			     // Outputs
			     .count		(count_netbios_8),
			     .fired             (fired_netbios_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_netbios_9 ;
cancid_netbios_9_verilog   cancid_netbios_9_verilog_i  (
			     // Outputs
			     .count		(count_netbios_9),
			     .fired             (fired_netbios_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_netbios),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_nntp.lst
//---------------------------------------------------
wire enable_nntp ;
wire [15:0] count_nntp_0 ;
cancid_nntp_0_verilog   cancid_nntp_0_verilog_i  (
			     // Outputs
			     .count		(count_nntp_0),
			     .fired             (fired_nntp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL

wire [15:0] count_nntp_1 ;
cancid_nntp_1_verilog   cancid_nntp_1_verilog_i  (
			     // Outputs
			     .count		(count_nntp_1),
			     .fired             (fired_nntp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_2 ;
cancid_nntp_2_verilog   cancid_nntp_2_verilog_i  (
			     // Outputs
			     .count		(count_nntp_2),
			     .fired             (fired_nntp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_3 ;
cancid_nntp_3_verilog   cancid_nntp_3_verilog_i  (
			     // Outputs
			     .count		(count_nntp_3),
			     .fired             (fired_nntp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_4 ;
cancid_nntp_4_verilog   cancid_nntp_4_verilog_i  (
			     // Outputs
			     .count		(count_nntp_4),
			     .fired             (fired_nntp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_5 ;
cancid_nntp_5_verilog   cancid_nntp_5_verilog_i  (
			     // Outputs
			     .count		(count_nntp_5),
			     .fired             (fired_nntp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_6 ;
cancid_nntp_6_verilog   cancid_nntp_6_verilog_i  (
			     // Outputs
			     .count		(count_nntp_6),
			     .fired             (fired_nntp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_7 ;
cancid_nntp_7_verilog   cancid_nntp_7_verilog_i  (
			     // Outputs
			     .count		(count_nntp_7),
			     .fired             (fired_nntp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_8 ;
cancid_nntp_8_verilog   cancid_nntp_8_verilog_i  (
			     // Outputs
			     .count		(count_nntp_8),
			     .fired             (fired_nntp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_nntp_9 ;
cancid_nntp_9_verilog   cancid_nntp_9_verilog_i  (
			     // Outputs
			     .count		(count_nntp_9),
			     .fired             (fired_nntp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_nntp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_pop3.lst
//---------------------------------------------------
wire enable_pop3 ;
wire [15:0] count_pop3_0 ;
cancid_pop3_0_verilog   cancid_pop3_0_verilog_i  (
			     // Outputs
			     .count		(count_pop3_0),
			     .fired             (fired_pop3_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL

wire [15:0] count_pop3_1 ;
cancid_pop3_1_verilog   cancid_pop3_1_verilog_i  (
			     // Outputs
			     .count		(count_pop3_1),
			     .fired             (fired_pop3_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_2 ;
cancid_pop3_2_verilog   cancid_pop3_2_verilog_i  (
			     // Outputs
			     .count		(count_pop3_2),
			     .fired             (fired_pop3_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_3 ;
cancid_pop3_3_verilog   cancid_pop3_3_verilog_i  (
			     // Outputs
			     .count		(count_pop3_3),
			     .fired             (fired_pop3_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_4 ;
cancid_pop3_4_verilog   cancid_pop3_4_verilog_i  (
			     // Outputs
			     .count		(count_pop3_4),
			     .fired             (fired_pop3_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_5 ;
cancid_pop3_5_verilog   cancid_pop3_5_verilog_i  (
			     // Outputs
			     .count		(count_pop3_5),
			     .fired             (fired_pop3_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_6 ;
cancid_pop3_6_verilog   cancid_pop3_6_verilog_i  (
			     // Outputs
			     .count		(count_pop3_6),
			     .fired             (fired_pop3_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_7 ;
cancid_pop3_7_verilog   cancid_pop3_7_verilog_i  (
			     // Outputs
			     .count		(count_pop3_7),
			     .fired             (fired_pop3_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_8 ;
cancid_pop3_8_verilog   cancid_pop3_8_verilog_i  (
			     // Outputs
			     .count		(count_pop3_8),
			     .fired             (fired_pop3_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_pop3_9 ;
cancid_pop3_9_verilog   cancid_pop3_9_verilog_i  (
			     // Outputs
			     .count		(count_pop3_9),
			     .fired             (fired_pop3_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_pop3),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_rlogin.lst
//---------------------------------------------------
wire enable_rlogin ;
wire [15:0] count_rlogin_0 ;
cancid_rlogin_0_verilog   cancid_rlogin_0_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_0),
			     .fired             (fired_rlogin_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL

wire [15:0] count_rlogin_1 ;
cancid_rlogin_1_verilog   cancid_rlogin_1_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_1),
			     .fired             (fired_rlogin_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_2 ;
cancid_rlogin_2_verilog   cancid_rlogin_2_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_2),
			     .fired             (fired_rlogin_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_3 ;
cancid_rlogin_3_verilog   cancid_rlogin_3_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_3),
			     .fired             (fired_rlogin_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_4 ;
cancid_rlogin_4_verilog   cancid_rlogin_4_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_4),
			     .fired             (fired_rlogin_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_rlogin_5 ;
cancid_rlogin_5_verilog   cancid_rlogin_5_verilog_i  (
			     // Outputs
			     .count		(count_rlogin_5),
			     .fired             (fired_rlogin_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_rlogin),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_smtp.lst
//---------------------------------------------------
wire enable_smtp ;
wire [15:0] count_smtp_0 ;
cancid_smtp_0_verilog   cancid_smtp_0_verilog_i  (
			     // Outputs
			     .count		(count_smtp_0),
			     .fired             (fired_smtp_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL

wire [15:0] count_smtp_1 ;
cancid_smtp_1_verilog   cancid_smtp_1_verilog_i  (
			     // Outputs
			     .count		(count_smtp_1),
			     .fired             (fired_smtp_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_2 ;
cancid_smtp_2_verilog   cancid_smtp_2_verilog_i  (
			     // Outputs
			     .count		(count_smtp_2),
			     .fired             (fired_smtp_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_3 ;
cancid_smtp_3_verilog   cancid_smtp_3_verilog_i  (
			     // Outputs
			     .count		(count_smtp_3),
			     .fired             (fired_smtp_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_4 ;
cancid_smtp_4_verilog   cancid_smtp_4_verilog_i  (
			     // Outputs
			     .count		(count_smtp_4),
			     .fired             (fired_smtp_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_5 ;
cancid_smtp_5_verilog   cancid_smtp_5_verilog_i  (
			     // Outputs
			     .count		(count_smtp_5),
			     .fired             (fired_smtp_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_6 ;
cancid_smtp_6_verilog   cancid_smtp_6_verilog_i  (
			     // Outputs
			     .count		(count_smtp_6),
			     .fired             (fired_smtp_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_7 ;
cancid_smtp_7_verilog   cancid_smtp_7_verilog_i  (
			     // Outputs
			     .count		(count_smtp_7),
			     .fired             (fired_smtp_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_8 ;
cancid_smtp_8_verilog   cancid_smtp_8_verilog_i  (
			     // Outputs
			     .count		(count_smtp_8),
			     .fired             (fired_smtp_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_smtp_9 ;
cancid_smtp_9_verilog   cancid_smtp_9_verilog_i  (
			     // Outputs
			     .count		(count_smtp_9),
			     .fired             (fired_smtp_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_smtp),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_telnet.lst
//---------------------------------------------------
wire enable_telnet ;
wire [15:0] count_telnet_0 ;
cancid_telnet_0_verilog   cancid_telnet_0_verilog_i  (
			     // Outputs
			     .count		(count_telnet_0),
			     .fired             (fired_telnet_0),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`ifdef REGEX_OPTIONAL

wire [15:0] count_telnet_1 ;
cancid_telnet_1_verilog   cancid_telnet_1_verilog_i  (
			     // Outputs
			     .count		(count_telnet_1),
			     .fired             (fired_telnet_1),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_2 ;
cancid_telnet_2_verilog   cancid_telnet_2_verilog_i  (
			     // Outputs
			     .count		(count_telnet_2),
			     .fired             (fired_telnet_2),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_3 ;
cancid_telnet_3_verilog   cancid_telnet_3_verilog_i  (
			     // Outputs
			     .count		(count_telnet_3),
			     .fired             (fired_telnet_3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_4 ;
cancid_telnet_4_verilog   cancid_telnet_4_verilog_i  (
			     // Outputs
			     .count		(count_telnet_4),
			     .fired             (fired_telnet_4),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_5 ;
cancid_telnet_5_verilog   cancid_telnet_5_verilog_i  (
			     // Outputs
			     .count		(count_telnet_5),
			     .fired             (fired_telnet_5),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_6 ;
cancid_telnet_6_verilog   cancid_telnet_6_verilog_i  (
			     // Outputs
			     .count		(count_telnet_6),
			     .fired             (fired_telnet_6),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_7 ;
cancid_telnet_7_verilog   cancid_telnet_7_verilog_i  (
			     // Outputs
			     .count		(count_telnet_7),
			     .fired             (fired_telnet_7),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_8 ;
cancid_telnet_8_verilog   cancid_telnet_8_verilog_i  (
			     // Outputs
			     .count		(count_telnet_8),
			     .fired             (fired_telnet_8),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_telnet_9 ;
cancid_telnet_9_verilog   cancid_telnet_9_verilog_i  (
			     // Outputs
			     .count		(count_telnet_9),
			     .fired             (fired_telnet_9),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_telnet),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));

`endif //  `ifdef REGEX_OPTIONAL

//++++++++++++++++++++++++++++++++++++++++++++++++++++++

//---------------------------------------------------
//			cancid_category.lst
//---------------------------------------------------
wire enable_category = 1;

wire [15:0] count_CATEGORY_finger ;
cancid_CATEGORY_finger_verilog   cancid_CATEGORY_finger_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_finger),
			     .fired             (fired_CATEGORY_finger),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_ftp ;
cancid_CATEGORY_ftp_verilog   cancid_CATEGORY_ftp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ftp),
			     .fired             (fired_CATEGORY_ftp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));




wire [15:0] count_CATEGORY_http ;
cancid_CATEGORY_http_verilog   cancid_CATEGORY_http_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_http),
			     .fired             (fired_CATEGORY_http),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_imap ;
cancid_CATEGORY_imap_verilog   cancid_CATEGORY_imap_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_imap),
			     .fired             (fired_CATEGORY_imap),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));






wire [15:0] count_CATEGORY_netbios ;
cancid_CATEGORY_netbios_verilog   cancid_CATEGORY_netbios_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_netbios),
			     .fired             (fired_CATEGORY_netbios),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_nntp ;
cancid_CATEGORY_nntp_verilog   cancid_CATEGORY_nntp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_nntp),
			     .fired             (fired_CATEGORY_nntp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_pop3 ;
cancid_CATEGORY_pop3_verilog   cancid_CATEGORY_pop3_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_pop3),
			     .fired             (fired_CATEGORY_pop3),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_rlogin ;
cancid_CATEGORY_rlogin_verilog   cancid_CATEGORY_rlogin_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_rlogin),
			     .fired             (fired_CATEGORY_rlogin),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_smtp ;
cancid_CATEGORY_smtp_verilog   cancid_CATEGORY_smtp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_smtp),
			     .fired             (fired_CATEGORY_smtp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));




wire [15:0] count_CATEGORY_telnet ;
cancid_CATEGORY_telnet_verilog   cancid_CATEGORY_telnet_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_telnet),
			     .fired             (fired_CATEGORY_telnet),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


`ifdef REGEX_OPTIONAL


wire [15:0] count_CATEGORY_aim ;
cancid_CATEGORY_aim_verilog   cancid_CATEGORY_aim_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_aim),
			     .fired             (fired_CATEGORY_aim),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_bittorrent ;
cancid_CATEGORY_bittorrent_verilog   cancid_CATEGORY_bittorrent_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_bittorrent),
			     .fired             (fired_CATEGORY_bittorrent),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_cvs ;
cancid_CATEGORY_cvs_verilog   cancid_CATEGORY_cvs_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_cvs),
			     .fired             (fired_CATEGORY_cvs),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_dhcp ;
cancid_CATEGORY_dhcp_verilog   cancid_CATEGORY_dhcp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_dhcp),
			     .fired             (fired_CATEGORY_dhcp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_directconnect ;
cancid_CATEGORY_directconnect_verilog   cancid_CATEGORY_directconnect_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_directconnect),
			     .fired             (fired_CATEGORY_directconnect),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_dns ;
cancid_CATEGORY_dns_verilog   cancid_CATEGORY_dns_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_dns),
			     .fired             (fired_CATEGORY_dns),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_fasttrack ;
cancid_CATEGORY_fasttrack_verilog   cancid_CATEGORY_fasttrack_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_fasttrack),
			     .fired             (fired_CATEGORY_fasttrack),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_tor ;
cancid_CATEGORY_tor_verilog   cancid_CATEGORY_tor_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_tor),
			     .fired             (fired_CATEGORY_tor),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_vnc ;
cancid_CATEGORY_vnc_verilog   cancid_CATEGORY_vnc_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_vnc),
			     .fired             (fired_CATEGORY_vnc),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_worldofwarcraft ;
cancid_CATEGORY_worldofwarcraft_verilog   cancid_CATEGORY_worldofwarcraft_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_worldofwarcraft),
			     .fired             (fired_CATEGORY_worldofwarcraft),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_x11 ;
cancid_CATEGORY_x11_verilog   cancid_CATEGORY_x11_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_x11),
			     .fired             (fired_CATEGORY_x11),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_yahoo ;
cancid_CATEGORY_yahoo_verilog   cancid_CATEGORY_yahoo_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_yahoo),
			     .fired             (fired_CATEGORY_yahoo),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_freenet ;
cancid_CATEGORY_freenet_verilog   cancid_CATEGORY_freenet_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_freenet),
			     .fired             (fired_CATEGORY_freenet),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));



wire [15:0] count_CATEGORY_gnutella ;
cancid_CATEGORY_gnutella_verilog   cancid_CATEGORY_gnutella_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_gnutella),
			     .fired             (fired_CATEGORY_gnutella),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_gopher ;
cancid_CATEGORY_gopher_verilog   cancid_CATEGORY_gopher_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_gopher),
			     .fired             (fired_CATEGORY_gopher),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_irc ;
cancid_CATEGORY_irc_verilog   cancid_CATEGORY_irc_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_irc),
			     .fired             (fired_CATEGORY_irc),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_jabber ;
cancid_CATEGORY_jabber_verilog   cancid_CATEGORY_jabber_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_jabber),
			     .fired             (fired_CATEGORY_jabber),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_msn ;
cancid_CATEGORY_msn_verilog   cancid_CATEGORY_msn_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_msn),
			     .fired             (fired_CATEGORY_msn),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_napster ;
cancid_CATEGORY_napster_verilog   cancid_CATEGORY_napster_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_napster),
			     .fired             (fired_CATEGORY_napster),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_sip ;
cancid_CATEGORY_sip_verilog   cancid_CATEGORY_sip_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_sip),
			     .fired             (fired_CATEGORY_sip),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_snmp ;
cancid_CATEGORY_snmp_verilog   cancid_CATEGORY_snmp_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_snmp),
			     .fired             (fired_CATEGORY_snmp),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_socks ;
cancid_CATEGORY_socks_verilog   cancid_CATEGORY_socks_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_socks),
			     .fired             (fired_CATEGORY_socks),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_ssh ;
cancid_CATEGORY_ssh_verilog   cancid_CATEGORY_ssh_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ssh),
			     .fired             (fired_CATEGORY_ssh),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_ssl ;
cancid_CATEGORY_ssl_verilog   cancid_CATEGORY_ssl_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_ssl),
			     .fired             (fired_CATEGORY_ssl),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


wire [15:0] count_CATEGORY_subversion ;
cancid_CATEGORY_subversion_verilog   cancid_CATEGORY_subversion_verilog_i  (
			     // Outputs
			     .count		(count_CATEGORY_subversion),
			     .fired             (fired_CATEGORY_subversion),
			     // Inputs
			     .clk		(clk),
			     .rst_n		(rst_n),
			     .eop		(eop),
			     .char_in		(char_in[7:0]),
			     .enable		(enable_category),
			     .char_in_vld	(char_in_vld),
			     .load_state        (load_state),
			     .new_stream_id     (new_streamid),
			     .stream_id		(streamid[5:0]));


`endif
//++++++++++++++++++++++++++++++++++++++++++++++++++++++

