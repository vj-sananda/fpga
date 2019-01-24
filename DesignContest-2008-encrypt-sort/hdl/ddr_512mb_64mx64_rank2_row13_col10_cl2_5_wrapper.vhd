-------------------------------------------------------------------------------
-- ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library proc_common_v2_00_a;
use proc_common_v2_00_a.all;

library wrpfifo_v2_00_a;
use wrpfifo_v2_00_a.all;

library rdpfifo_v2_00_a;
use rdpfifo_v2_00_a.all;

library plb_ipif_v1_00_f;
use plb_ipif_v1_00_f.all;

library ecc_v1_00_a;
use ecc_v1_00_a.all;

library ddr_v1_11_a;
use ddr_v1_11_a.all;

library plb_ddr_v1_11_a;
use plb_ddr_v1_11_a.all;

entity ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper is
  port (
    PLB_Clk : in std_logic;
    PLB_Clk_n : in std_logic;
    Clk90_in : in std_logic;
    Clk90_in_n : in std_logic;
    DDR_Clk90_in : in std_logic;
    DDR_Clk90_in_n : in std_logic;
    PLB_Rst : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_PAValid : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_rdPrim : in std_logic;
    PLB_wrPrim : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 0);
    PLB_abort : in std_logic;
    PLB_busLock : in std_logic;
    PLB_RNW : in std_logic;
    PLB_BE : in std_logic_vector(0 to 7);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_compress : in std_logic;
    PLB_guarded : in std_logic;
    PLB_ordered : in std_logic;
    PLB_lockErr : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 63);
    PLB_wrBurst : in std_logic;
    PLB_rdBurst : in std_logic;
    PLB_pendReq : in std_logic;
    PLB_pendPri : in std_logic_vector(0 to 1);
    PLB_reqPri : in std_logic_vector(0 to 1);
    Sl_addrAck : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_rearbitrate : out std_logic;
    Sl_wrDAck : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrBTerm : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 63);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    Sl_rdDAck : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdBTerm : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 1);
    Sl_MErr : out std_logic_vector(0 to 1);
    IP2INTC_Irpt : out std_logic;
    DDR_Clk : out std_logic_vector(0 to 3);
    DDR_Clkn : out std_logic_vector(0 to 3);
    DDR_CKE : out std_logic_vector(0 to 1);
    DDR_CSn : out std_logic_vector(0 to 1);
    DDR_RASn : out std_logic;
    DDR_CASn : out std_logic;
    DDR_WEn : out std_logic;
    DDR_DM : out std_logic_vector(0 to 7);
    DDR_BankAddr : out std_logic_vector(0 to 1);
    DDR_Addr : out std_logic_vector(0 to 12);
    DDR_DM_ECC : out std_logic;
    DDR_Init_done : out std_logic;
    DDR_DQ_I : in std_logic_vector(0 to 63);
    DDR_DQ_O : out std_logic_vector(0 to 63);
    DDR_DQ_T : out std_logic_vector(0 to 63);
    DDR_DQS_I : in std_logic_vector(0 to 7);
    DDR_DQS_O : out std_logic_vector(0 to 7);
    DDR_DQS_T : out std_logic_vector(0 to 7);
    DDR_DQ_ECC_I : in std_logic_vector(0 to 6);
    DDR_DQ_ECC_O : out std_logic_vector(0 to 6);
    DDR_DQ_ECC_T : out std_logic_vector(0 to 6);
    DDR_DQS_ECC_I : in std_logic;
    DDR_DQS_ECC_O : out std_logic;
    DDR_DQS_ECC_T : out std_logic
  );
  attribute x_core_info : STRING;
  attribute x_core_info of ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper: entity is "plb_ddr_v1_11_a";

end ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper;

architecture STRUCTURE of ddr_512mb_64mx64_rank2_row13_col10_cl2_5_wrapper is

  component plb_ddr is
    generic (
      C_INCLUDE_BURST_CACHELN_SUPPORT : INTEGER;
      C_REG_DIMM : INTEGER;
      C_NUM_BANKS_MEM : INTEGER;
      C_NUM_CLK_PAIRS : INTEGER;
      C_FAMILY : STRING;
      C_INCLUDE_ECC_SUPPORT : INTEGER;
      C_ENABLE_ECC_REG : INTEGER;
      C_ECC_DEFAULT_ON : INTEGER;
      C_INCLUDE_ECC_INTR : INTEGER;
      C_INCLUDE_ECC_TEST : INTEGER;
      C_ECC_SEC_THRESHOLD : INTEGER;
      C_ECC_DEC_THRESHOLD : INTEGER;
      C_ECC_PEC_THRESHOLD : INTEGER;
      NUM_ECC_BITS : INTEGER;
      C_DDR_TMRD : INTEGER;
      C_DDR_TWR : INTEGER;
      C_DDR_TWTR : INTEGER;
      C_DDR_TRAS : INTEGER;
      C_DDR_TRC : INTEGER;
      C_DDR_TRFC : INTEGER;
      C_DDR_TRCD : INTEGER;
      C_DDR_TRRD : INTEGER;
      C_DDR_TREFC : INTEGER;
      C_DDR_TREFI : INTEGER;
      C_DDR_TRP : INTEGER;
      C_DDR_CAS_LAT : INTEGER;
      C_DDR_DWIDTH : INTEGER;
      C_DDR_AWIDTH : INTEGER;
      C_DDR_COL_AWIDTH : INTEGER;
      C_DDR_BANK_AWIDTH : INTEGER;
      C_MEM0_BASEADDR : std_logic_vector;
      C_MEM0_HIGHADDR : std_logic_vector;
      C_MEM1_BASEADDR : std_logic_vector;
      C_MEM1_HIGHADDR : std_logic_vector;
      C_MEM2_BASEADDR : std_logic_vector;
      C_MEM2_HIGHADDR : std_logic_vector;
      C_MEM3_BASEADDR : std_logic_vector;
      C_MEM3_HIGHADDR : std_logic_vector;
      C_ECC_BASEADDR : std_logic_vector;
      C_ECC_HIGHADDR : std_logic_vector;
      C_PLB_NUM_MASTERS : INTEGER;
      C_PLB_MID_WIDTH : INTEGER;
      C_PLB_AWIDTH : INTEGER;
      C_PLB_DWIDTH : INTEGER;
      C_PLB_CLK_PERIOD_PS : INTEGER;
      C_SIM_INIT_TIME_PS : INTEGER
    );
    port (
      PLB_Clk : in std_logic;
      PLB_Clk_n : in std_logic;
      Clk90_in : in std_logic;
      Clk90_in_n : in std_logic;
      DDR_Clk90_in : in std_logic;
      DDR_Clk90_in_n : in std_logic;
      PLB_Rst : in std_logic;
      PLB_ABus : in std_logic_vector(0 to (C_PLB_AWIDTH-1));
      PLB_PAValid : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_PLB_MID_WIDTH-1));
      PLB_abort : in std_logic;
      PLB_busLock : in std_logic;
      PLB_RNW : in std_logic;
      PLB_BE : in std_logic_vector(0 to ((C_PLB_DWIDTH/8)-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_ordered : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_wrBurst : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_pendReq : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1);
      Sl_addrAck : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_rearbitrate : out std_logic;
      Sl_wrDAck : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_PLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rdDAck : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_MErr : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      IP2INTC_Irpt : out std_logic;
      DDR_Clk : out std_logic_vector(0 to (C_NUM_CLK_PAIRS-1));
      DDR_Clkn : out std_logic_vector(0 to (C_NUM_CLK_PAIRS-1));
      DDR_CKE : out std_logic_vector(0 to (C_NUM_BANKS_MEM-1));
      DDR_CSn : out std_logic_vector(0 to (C_NUM_BANKS_MEM-1));
      DDR_RASn : out std_logic;
      DDR_CASn : out std_logic;
      DDR_WEn : out std_logic;
      DDR_DM : out std_logic_vector(0 to ((C_DDR_DWIDTH/8)-1));
      DDR_BankAddr : out std_logic_vector(0 to (C_DDR_BANK_AWIDTH-1));
      DDR_Addr : out std_logic_vector(0 to (C_DDR_AWIDTH-1));
      DDR_DM_ECC : out std_logic;
      DDR_Init_done : out std_logic;
      DDR_DQ_I : in std_logic_vector(0 to (C_DDR_DWIDTH-1));
      DDR_DQ_O : out std_logic_vector(0 to (C_DDR_DWIDTH-1));
      DDR_DQ_T : out std_logic_vector(0 to (C_DDR_DWIDTH-1));
      DDR_DQS_I : in std_logic_vector(0 to ((C_DDR_DWIDTH/8)-1));
      DDR_DQS_O : out std_logic_vector(0 to ((C_DDR_DWIDTH/8)-1));
      DDR_DQS_T : out std_logic_vector(0 to ((C_DDR_DWIDTH/8)-1));
      DDR_DQ_ECC_I : in std_logic_vector(0 to (NUM_ECC_BITS-1));
      DDR_DQ_ECC_O : out std_logic_vector(0 to (NUM_ECC_BITS-1));
      DDR_DQ_ECC_T : out std_logic_vector(0 to (NUM_ECC_BITS-1));
      DDR_DQS_ECC_I : in std_logic;
      DDR_DQS_ECC_O : out std_logic;
      DDR_DQS_ECC_T : out std_logic
    );
  end component;

begin

  ddr_512mb_64mx64_rank2_row13_col10_cl2_5 : plb_ddr
    generic map (
      C_INCLUDE_BURST_CACHELN_SUPPORT => 1,
      C_REG_DIMM => 0,
      C_NUM_BANKS_MEM => 2,
      C_NUM_CLK_PAIRS => 4,
      C_FAMILY => "virtex2p",
      C_INCLUDE_ECC_SUPPORT => 0,
      C_ENABLE_ECC_REG => 1,
      C_ECC_DEFAULT_ON => 1,
      C_INCLUDE_ECC_INTR => 0,
      C_INCLUDE_ECC_TEST => 0,
      C_ECC_SEC_THRESHOLD => 1,
      C_ECC_DEC_THRESHOLD => 1,
      C_ECC_PEC_THRESHOLD => 1,
      NUM_ECC_BITS => 7,
      C_DDR_TMRD => 20000,
      C_DDR_TWR => 20000,
      C_DDR_TWTR => 1,
      C_DDR_TRAS => 60000,
      C_DDR_TRC => 90000,
      C_DDR_TRFC => 100000,
      C_DDR_TRCD => 30000,
      C_DDR_TRRD => 20000,
      C_DDR_TREFC => 70300000,
      C_DDR_TREFI => 7800000,
      C_DDR_TRP => 30000,
      C_DDR_CAS_LAT => 2,
      C_DDR_DWIDTH => 64,
      C_DDR_AWIDTH => 13,
      C_DDR_COL_AWIDTH => 10,
      C_DDR_BANK_AWIDTH => 2,
      C_MEM0_BASEADDR => X"00000000",
      C_MEM0_HIGHADDR => X"0fffffff",
      C_MEM1_BASEADDR => X"10000000",
      C_MEM1_HIGHADDR => X"1fffffff",
      C_MEM2_BASEADDR => B"11111111111111111111111111111111",
      C_MEM2_HIGHADDR => B"00000000000000000000000000000000",
      C_MEM3_BASEADDR => B"11111111111111111111111111111111",
      C_MEM3_HIGHADDR => B"00000000000000000000000000000000",
      C_ECC_BASEADDR => B"11111111111111111111111111111111",
      C_ECC_HIGHADDR => B"00000000000000000000000000000000",
      C_PLB_NUM_MASTERS => 2,
      C_PLB_MID_WIDTH => 1,
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_PLB_CLK_PERIOD_PS => 10000,
      C_SIM_INIT_TIME_PS => 200000000
    )
    port map (
      PLB_Clk => PLB_Clk,
      PLB_Clk_n => PLB_Clk_n,
      Clk90_in => Clk90_in,
      Clk90_in_n => Clk90_in_n,
      DDR_Clk90_in => DDR_Clk90_in,
      DDR_Clk90_in_n => DDR_Clk90_in_n,
      PLB_Rst => PLB_Rst,
      PLB_ABus => PLB_ABus,
      PLB_PAValid => PLB_PAValid,
      PLB_SAValid => PLB_SAValid,
      PLB_rdPrim => PLB_rdPrim,
      PLB_wrPrim => PLB_wrPrim,
      PLB_masterID => PLB_masterID,
      PLB_abort => PLB_abort,
      PLB_busLock => PLB_busLock,
      PLB_RNW => PLB_RNW,
      PLB_BE => PLB_BE,
      PLB_MSize => PLB_MSize,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_ordered => PLB_ordered,
      PLB_lockErr => PLB_lockErr,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrBurst => PLB_wrBurst,
      PLB_rdBurst => PLB_rdBurst,
      PLB_pendReq => PLB_pendReq,
      PLB_pendPri => PLB_pendPri,
      PLB_reqPri => PLB_reqPri,
      Sl_addrAck => Sl_addrAck,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_wrDAck => Sl_wrDAck,
      Sl_wrComp => Sl_wrComp,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdComp => Sl_rdComp,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_MBusy => Sl_MBusy,
      Sl_MErr => Sl_MErr,
      IP2INTC_Irpt => IP2INTC_Irpt,
      DDR_Clk => DDR_Clk,
      DDR_Clkn => DDR_Clkn,
      DDR_CKE => DDR_CKE,
      DDR_CSn => DDR_CSn,
      DDR_RASn => DDR_RASn,
      DDR_CASn => DDR_CASn,
      DDR_WEn => DDR_WEn,
      DDR_DM => DDR_DM,
      DDR_BankAddr => DDR_BankAddr,
      DDR_Addr => DDR_Addr,
      DDR_DM_ECC => DDR_DM_ECC,
      DDR_Init_done => DDR_Init_done,
      DDR_DQ_I => DDR_DQ_I,
      DDR_DQ_O => DDR_DQ_O,
      DDR_DQ_T => DDR_DQ_T,
      DDR_DQS_I => DDR_DQS_I,
      DDR_DQS_O => DDR_DQS_O,
      DDR_DQS_T => DDR_DQS_T,
      DDR_DQ_ECC_I => DDR_DQ_ECC_I,
      DDR_DQ_ECC_O => DDR_DQ_ECC_O,
      DDR_DQ_ECC_T => DDR_DQ_ECC_T,
      DDR_DQS_ECC_I => DDR_DQS_ECC_I,
      DDR_DQS_ECC_O => DDR_DQS_ECC_O,
      DDR_DQS_ECC_T => DDR_DQS_ECC_T
    );

end architecture STRUCTURE;

