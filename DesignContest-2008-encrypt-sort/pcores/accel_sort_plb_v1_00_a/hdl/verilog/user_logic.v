//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** copyright (c) 1995-2005 xilinx, inc.  all rights reserved.            **
// **                                                                       **
// ** xilinx, inc.                                                          **
// ** xilinx is providing this design, code, or information "as is"         **
// ** as a courtesy to you, solely for use in developing programs and       **
// ** solutions for xilinx devices.  by providing this design, code,        **
// ** or information as one possible implementation of this feature,        **
// ** application or standard, xilinx is making no representation           **
// ** that this implementation is free from any claims of infringement,     **
// ** and you are responsible for obtaining any rights you may require      **
// ** for your implementation.  xilinx expressly disclaims any              **
// ** warranty whatsoever with respect to the adequacy of the               **
// ** implementation, including but not limited to any warranties or        **
// ** representations that this implementation is free from claims of       **
// ** infringement, implied warranties of merchantability and fitness       **
// ** for a particular purpose.                                             **
// **                                                                       **
// ** you may copy and modify these files for your own internal use solely  **
// ** with xilinx programmable logic devices and xilinx edk system or       **
// ** create ip modules solely for xilinx programmable logic devices and    **
// ** xilinx edk system. no rights are granted to distribute any files      **
// ** unless they are distributed in xilinx programmable logic devices.     **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// filename:          user_logic.v
// version:           1.00.a
// description:       user logic module.
// date:              mon may 02 09:49:08 2005 (by create and import peripheral wizard)
// verilog standard:  verilog-2001
//----------------------------------------------------------------------------
// naming conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "c_*"
//   user defined types:                    "*_type"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- names begin with uppercase"
//   processes:                             "*_process"
//   component instantiations:              "<entity_>i_<#|func>"
//----------------------------------------------------------------------------
`define rd_code  3'd0
`define rd_code_ack  3'd1

`define rd_len  3'd2
`define rd_len_ack  3'd3

`define wait_for_pop  3'd4

`define wait_for_result 2'b00
`define wait_for_rfifo  2'b01
`define wait_for_wr_ack 2'b11   

module user_logic
(
  // -- add user ports below this line ---------------
  // --user ports added here 
  // -- add user ports above this line ---------------

  // -- do not edit below this line ------------------
  // -- bus protocol ports, do not add to or delete 
  bus2ip_clk,                     // bus to ip clock
  bus2ip_reset,                   // bus to ip reset
  bus2ip_data,                    // bus to ip data bus for user logic
  bus2ip_be,                      // bus to ip byte enables for user logic
  bus2ip_burst,                   // bus to ip burst-mode qualifier
  bus2ip_rdce,                    // bus to ip read chip enable for user logic
  bus2ip_wrce,                    // bus to ip write chip enable for user logic
  bus2ip_rdreq,                   // bus to ip read request
  bus2ip_wrreq,                   // bus to ip write request
  ip2bus_data,                    // ip to bus data bus for user logic
  ip2bus_retry,                   // ip to bus retry response
  ip2bus_error,                   // ip to bus error response
  ip2bus_toutsup,                 // ip to bus timeout suppress
  ip2bus_addrack,                 // ip to bus address acknowledgement
  ip2bus_busy,                    // ip to bus busy response
  ip2bus_rdack,                   // ip to bus read transfer acknowledgement
  ip2bus_wrack,                   // ip to bus write transfer acknowledgement
  ip2rfifo_wrreq,                 // ip to rfifo : ip write request
  ip2rfifo_data,                  // ip to rfifo : ip write data
  rfifo2ip_wrack,                 // rfifo to ip : rfifo write acknowledge
  rfifo2ip_almostfull,            // rfifo to ip : rfifo almost full
  rfifo2ip_full,                  // rfifo to ip : rfifo full
  ip2wfifo_rdreq,                 // ip to wfifo : ip read request
  wfifo2ip_data,                  // wfifo to ip : wfifo read data
  wfifo2ip_rdack,                 // wfifo to ip : wfifo read acknowledge
  wfifo2ip_almostempty,           // wfifo to ip : wfifo almost empty
  wfifo2ip_empty                  // wfifo to ip : wfifo empty
  // -- do not edit above this line ------------------
); // user_logic

// -- add user parameters below this line ------------
// --user parameters added here
// -- add user parameters above this line ------------

// -- do not edit below this line --------------------
// -- bus protocol parameters, do not add to or delete
parameter C_DWIDTH                       = 64;
parameter C_NUM_CE                       = 4;
parameter C_RDFIFO_DWIDTH                = 64;
parameter C_WRFIFO_DWIDTH                = 64;

//parameter c_rdfifo_depth                 = 128;
//parameter c_wrfifo_depth                 = 128;
   
// -- do not edit above this line --------------------

// -- add user ports below this line -----------------
// --user ports added here 
// -- add user ports above this line -----------------

// -- do not edit below this line --------------------
// -- bus protocol ports, do not add to or delete
input                                     bus2ip_clk;
input                                     bus2ip_reset;
input      [0 : C_DWIDTH-1]               bus2ip_data;
input      [0 : C_DWIDTH/8-1]             bus2ip_be;
input                                     bus2ip_burst;
input      [0 : C_NUM_CE-1]               bus2ip_rdce;
input      [0 : C_NUM_CE-1]               bus2ip_wrce;
input                                     bus2ip_rdreq;
input                                     bus2ip_wrreq;
output     [0 : C_DWIDTH-1]               ip2bus_data;
output                                    ip2bus_retry;
output                                    ip2bus_error;
output                                    ip2bus_toutsup;
output                                    ip2bus_addrack;
output                                    ip2bus_busy;
output                                    ip2bus_rdack;
output                                    ip2bus_wrack;
output                                    ip2rfifo_wrreq;
output     [0 : C_RDFIFO_DWIDTH-1]        ip2rfifo_data;
input                                     rfifo2ip_wrack;
input                                     rfifo2ip_almostfull;
input                                     rfifo2ip_full;
output                                    ip2wfifo_rdreq;
input      [0 : C_WRFIFO_DWIDTH-1]        wfifo2ip_data;
input                                     wfifo2ip_rdack;
input                                     wfifo2ip_almostempty;
input                                     wfifo2ip_empty;
// -- do not edit above this line --------------------

//----------------------------------------------------------------------------
// implementation
//----------------------------------------------------------------------------

  // --user nets declarations added here, as needed for user logic

  // nets for user logic slave model s/w accessible register example
  reg        [0 : C_DWIDTH-1]               slv_reg0;
  reg        [0 : C_DWIDTH-1]               slv_reg1;
  reg        [0 : C_DWIDTH-1]               slv_reg2;
  reg        [0 : C_DWIDTH-1]               slv_reg3;
  wire       [0 : 3]                        slv_reg_write_select;
  wire       [0 : 3]                        slv_reg_read_select;
  reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

   reg [2:0] fifo_cntl_ns;
   reg [2:0] fifo_cntl_cs;
   
   reg 	     ip2wfifo_rdreq_cmb;
   reg 	ip2rfifo_wrreq_cmb;
   wire [0:(C_DWIDTH - 1)] ip2bus_data;
   wire 		   ip2bus_ack;
   wire 		   ip2bus_retry;
   wire 		   ip2bus_error;
   wire 		   ip2bus_toutsup;
   reg 			   ip2rfifo_wrreq;
   wire [0:(C_RDFIFO_DWIDTH - 1)] ip2rfifo_data;
   reg 				  ip2wfifo_rdreq;
   
  // --user logic implementation added here

  // ------------------------------------------------------
  // example code to read/write user logic slave model s/w accessible registers
  // 
  // note:
  // the example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // each bit of the bus2ip_wrce/bus2ip_rdce signals is configured to correspond
  // to one software accessible register by the top level template. for example,
  // if you have four 32 bit software accessible registers in the user logic, you
  // are basically operating on the following memory mapped registers:
  // 
  //    bus2ip_wrce or   memory mapped
  //       bus2ip_rdce   register
  //            "1000"   c_baseaddr + 0x0
  //            "0100"   c_baseaddr + 0x4
  //            "0010"   c_baseaddr + 0x8
  //            "0001"   c_baseaddr + 0xc
  // 
  // ------------------------------------------------------
  
  assign
    slv_reg_write_select = bus2ip_wrce[0:3],
    slv_reg_read_select  = bus2ip_rdce[0:3],
    slv_write_ack        = bus2ip_wrce[0] || bus2ip_wrce[1] || bus2ip_wrce[2] || bus2ip_wrce[3],
    slv_read_ack         = bus2ip_rdce[0] || bus2ip_rdce[1] || bus2ip_rdce[2] || bus2ip_rdce[3];

   reg [127:0] global_key;
   
   wire [2:0]  reg_select = slv_reg3[61:63];
   
  // implement slave model register(s)
  always @( posedge bus2ip_clk )
    begin: slave_reg_write_proc

      if ( bus2ip_reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
          slv_reg2 <= 0;
          slv_reg3 <= 0;
        end
      else
        case ( slv_reg_write_select )
          4'b1000 :
	    slv_reg0 <= bus2ip_data;

          4'b0100 :
	    slv_reg1 <= bus2ip_data;	    

          4'b0010 :
	    slv_reg2 <= bus2ip_data;

          4'b0001 :
	    slv_reg3 <= bus2ip_data;

          default :
	       begin
		  if ( slv_reg3[33] )//Read
		    case( reg_select)
		      3'd1: slv_reg2 <= global_key[127:96];
		      3'd2: slv_reg2 <= global_key[95:64] ;
		      3'd3: slv_reg2 <= global_key[63:32] ;
		      3'd4: slv_reg2 <= global_key[31:0]  ;	    
		    endcase // case ( slv_reg1[16:31] )	  
	       end // case: default

        endcase

    end // slave_reg_write_proc

   //Implement indirect Register addressing scheme
   always @(posedge bus2ip_clk)
     if (bus2ip_reset == 1)
       begin
	  global_key <= 0;
       end
     else
       begin
	  if ( slv_reg3[32] )//Write
	    case(reg_select)
	      3'd1: global_key[127:96] <= slv_reg2[32:63] ;
	      3'd2: global_key[95:64] <= slv_reg2[32:63] ;
	      3'd3: global_key[63:32] <= slv_reg2[32:63] ;
	      3'd4: global_key[31:0] <= slv_reg2[32:63] ;	    
	    endcase // case ( slv_reg1[16:31] )
       end
   
  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 )
    begin: slave_reg_read_proc

      case ( slv_reg_read_select )
        4'b1000 : slv_ip2bus_data <= slv_reg0;
        4'b0100 : slv_ip2bus_data <= slv_reg1;
        4'b0010 : slv_ip2bus_data <= slv_reg2;
        4'b0001 : slv_ip2bus_data <= slv_reg3;
        default : slv_ip2bus_data <= 0;
      endcase

    end // slave_reg_read_proc

  // ------------------------------------------------------------
  // example code to drive ip to bus signals
  // ------------------------------------------------------------

  assign ip2bus_data        = slv_ip2bus_data;
  assign ip2bus_wrack       = slv_write_ack;
  assign ip2bus_rdack       = slv_read_ack;
  assign ip2bus_addrack     = slv_write_ack || slv_read_ack;
  assign ip2bus_busy        = 0;
  assign ip2bus_error       = 0;
  assign ip2bus_retry       = 0;
  assign ip2bus_toutsup     = 0;

   // *************************************************************
   wire   clk = bus2ip_clk ;
   wire   reset = bus2ip_reset ;
   reg [1:0] fifo_wr_cntl_cs ,fifo_wr_cntl_ns ;

   wire      not_full = ~rfifo2ip_full & (fifo_wr_cntl_cs==`wait_for_result );	
   
   reg 	     rdy_rc,rdy_wc;
   wire      rdy = rdy_rc ;
   
   reg [C_DWIDTH-1:0] idata_wd;		
   reg [C_DWIDTH-1:0] idata_rd;	     
   
   wire [C_DWIDTH-1:0] idata = idata_rd;
   wire [C_DWIDTH-1:0] 	odata ;

   reg [C_DWIDTH-1:0]  result_rd; 
   reg [C_DWIDTH-1:0]  result_wd;  

   wire 	pop;
   wire 	push ;

   // ************** Register control begin ***************
   wire        no_compare ;
   wire        reset_index ;
   wire        zero_key ;
   
   assign      no_compare = slv_reg0[63];
   assign      reset_index = slv_reg0[62];
   assign      zero_key = slv_reg0[61];   
   
   wire [18:0] start_index ;
   assign      start_index = slv_reg1;
	  
//   assign 	global_key[127:64] = slv_reg2;
//   assign 	global_key[63:0]   = slv_reg3;   
//   assign 	global_key = 128'hb01dface0dec0ded0ba11ade0effec70 ;
 
   // ************** Register control end ***************

   always @ (/*autosense*/
	      fifo_cntl_cs or idata_rd or pop or rdy_rc
	     or wfifo2ip_data or wfifo2ip_empty or wfifo2ip_rdack)
     begin

	//default assignments
        ip2wfifo_rdreq_cmb = 1'b0;

        fifo_cntl_ns = fifo_cntl_cs;
	rdy_wc = rdy_rc ;

	idata_wd = idata_rd ;
	
	//read code and len 
        case (fifo_cntl_cs)
          `rd_code:
            if ((wfifo2ip_empty == 1'b0)) 	      
              begin
		 rdy_wc = 1'b0;
                 ip2wfifo_rdreq_cmb = 1'b1;
                 fifo_cntl_ns = `rd_code_ack;
              end

          `rd_code_ack:
            if ((wfifo2ip_rdack == 1'b1)) 
              begin
		 idata_wd = wfifo2ip_data ;
		 rdy_wc = 1'b1 ;
                 fifo_cntl_ns = `wait_for_pop;
              end

	  `wait_for_pop:
	    if ( pop == 1 )
	      begin
		 rdy_wc = 1'b0 ;
		 fifo_cntl_ns = `rd_code;
	      end
	  
          default : 
            fifo_cntl_ns = `rd_code ;
	  
        endcase
     end 
   // end always 

   // *********************************************
   //Loopback code

/* -----\/----- EXCLUDED -----\/-----
   reg 			push_rc;
   reg 			pop_rc;
   reg 			push_pending_rc ;
   
   always @(posedge clk )
     if ( bus2ip_reset == 1'b1 )
       begin
	  push_rc <= 0;
	  push_pending_rc <= 0;
	  pop_rc <= 0;
       end
     else
       begin
	  pop_rc <= 0;
	  push_rc <= 0;
	  
	  if ( rdy & ~pop_rc & ~push_pending_rc )
	    pop_rc <= 1 ;
	  
	  if ( pop )
	    push_pending_rc <= 1;

	  if ( (fifo_wr_cntl_cs == `wait_for_result) & push_pending_rc )
	    begin
	       push_pending_rc <= 0;
	       push_rc <= 1;
	    end
       end // else: !if( bus2ip_reset == 1'b1 )

   assign 		push = push_rc ;
   assign 		pop = pop_rc;
   assign 		odata = idata ;

 -----/\----- EXCLUDED -----/\----- */
   
   // *********************************************
   
   always @(/*AUTOSENSE*/
	    fifo_wr_cntl_cs or odata or push
	    or result_rd or rfifo2ip_full or rfifo2ip_wrack)
     begin
	result_wd = result_rd ;
        ip2rfifo_wrreq_cmb = 1'b0;
        fifo_wr_cntl_ns = fifo_wr_cntl_cs;
	
	case(fifo_wr_cntl_cs)
          
	  `wait_for_result:	
            if ( push == 1'b1 )
	      begin
		 result_wd = odata;
		 
		 if ( rfifo2ip_full )
		   fifo_wr_cntl_ns = `wait_for_rfifo ;
		 else
		   begin
		      fifo_wr_cntl_ns = `wait_for_wr_ack;
		      ip2rfifo_wrreq_cmb = 1'b1;
		   end
	      end

	  `wait_for_rfifo:
	    begin
	       if ( rfifo2ip_full == 1'b0)
		 begin
		    ip2rfifo_wrreq_cmb = 1'b1;	    
		    fifo_wr_cntl_ns = `wait_for_wr_ack ;
		 end
	    end
		 
	  `wait_for_wr_ack:	
	    if ( rfifo2ip_wrack == 1'b1 )
	      fifo_wr_cntl_ns = `wait_for_result;

          default : 
            fifo_wr_cntl_ns = `wait_for_result ;
	  
	endcase // case (fifo_wr_cntl_cs)
     end
   
   always @ (posedge bus2ip_clk ) // begin 
     if ((bus2ip_reset == 1'b1)) 
       begin 
          ip2wfifo_rdreq <= 1'b0;
          ip2rfifo_wrreq <= 1'b0;
          fifo_cntl_cs <= `rd_code ;
	  fifo_wr_cntl_cs <= `wait_for_result ;
	  rdy_rc <= 0;
	  
       end
     else 
       begin
	  rdy_rc <= rdy_wc ;
	  result_rd <= result_wd ;
	  idata_rd <= idata_wd ;
          ip2wfifo_rdreq <= ip2wfifo_rdreq_cmb;
          ip2rfifo_wrreq <= ip2rfifo_wrreq_cmb;
          fifo_cntl_cs <= fifo_cntl_ns;
          fifo_wr_cntl_cs <= fifo_wr_cntl_ns;	  
       end
                        
   // end always 

   assign ip2rfifo_data = result_rd ;
   
   assign {ip2bus_ack}=(slv_write_ack | slv_read_ack);
   
   accel_sort     sort_i ( 
			  // Outputs
			  .odata		(odata[C_DWIDTH-1:0]),
			  .push			(push),
			  .pop			(pop),
			  // Inputs
			  .idata		(idata[C_DWIDTH-1:0]),
			  .rdy			(rdy),
			  .not_full		(not_full),
			  .clk			(clk),
			  .reset		(reset),
			  .zero_key             (zero_key),
			  .reset_index          (reset_index),
			  .start_index		(start_index[18:0]),
			  .global_key		(global_key[127:0]),
			  .no_compare		(no_compare));      

endmodule
