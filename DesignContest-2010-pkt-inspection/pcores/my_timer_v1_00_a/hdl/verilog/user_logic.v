module user_logic
(
  Bus2IP_Clk,                     // Bus to IP clock
  Bus2IP_Reset,                   // Bus to IP reset
  Bus2IP_Data,                    // Bus to IP data bus
  Bus2IP_BE,                      // Bus to IP byte enables
  Bus2IP_RdCE,                    // Bus to IP read chip enable
  Bus2IP_WrCE,                    // Bus to IP write chip enable
  IP2Bus_Data,                    // IP to Bus data bus
  IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAck,                   // IP to Bus write transfer acknowledgement
  IP2Bus_Error                    // IP to Bus error response
); // user_logic

parameter C_SLV_DWIDTH                   = 32;
parameter C_NUM_REG                      = 4;

input                                     Bus2IP_Clk;
input                                     Bus2IP_Reset;
input      [0 : C_SLV_DWIDTH-1]           Bus2IP_Data;
input      [0 : C_SLV_DWIDTH/8-1]         Bus2IP_BE;
input      [0 : C_NUM_REG-1]              Bus2IP_RdCE;
input      [0 : C_NUM_REG-1]              Bus2IP_WrCE;
output     [0 : C_SLV_DWIDTH-1]           IP2Bus_Data;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;
output                                    IP2Bus_Error;

  reg        [0 : 63]                       counter;
  reg                                       enable;
  wire       [0 : 3]                        slv_reg_write_sel;
  wire       [0 : 3]                        slv_reg_read_sel;
  reg        [0 : C_SLV_DWIDTH-1]           slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  assign
    slv_reg_write_sel = Bus2IP_WrCE[0:3],
    slv_reg_read_sel  = Bus2IP_RdCE[0:3],
    slv_write_ack     = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3],
    slv_read_ack      = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3];

  always @( posedge Bus2IP_Clk )
    begin: SLAVE_REG_WRITE_PROC

      if ( Bus2IP_Reset == 1 )
        begin
          counter <= 0;
			 enable <= 0;
        end
      else
		  counter <= slv_reg_write_sel==4'b1000 ? 0 : //addr 0 is reset
		             enable ? counter + 1 :
						 counter;
		  enable <= slv_reg_write_sel==4'b0100 ? 1 : //addr 1 is start
		            slv_reg_write_sel==4'b0010 ? 0 : //addr 2 is stop
						enable;

    end // SLAVE_REG_WRITE_PROC

  always @( slv_reg_read_sel or counter )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_sel )
        4'b1000 : slv_ip2bus_data <= counter[32:63];
        4'b0100 : slv_ip2bus_data <= counter[0:31];
        default : slv_ip2bus_data <= 0;
      endcase

    end // SLAVE_REG_READ_PROC

  assign IP2Bus_Data    = slv_ip2bus_data;
  assign IP2Bus_WrAck   = slv_write_ack;
  assign IP2Bus_RdAck   = slv_read_ack;
  assign IP2Bus_Error   = 0;

endmodule
