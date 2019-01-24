-------------------------------------------------------------------------------
-- accel_sort_plb_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library proc_common_v1_00_b;
use proc_common_v1_00_b.all;

library ipif_common_v1_00_b;
use ipif_common_v1_00_b.all;

library plb_ipif_v1_00_e;
use plb_ipif_v1_00_e.all;

library accel_sort_plb_v1_00_a;
use accel_sort_plb_v1_00_a.all;

entity accel_sort_plb_0_wrapper is
  port (
    PLB_Clk : in std_logic;
    PLB_Rst : in std_logic;
    Sl_addrAck : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 1);
    Sl_MErr : out std_logic_vector(0 to 1);
    Sl_rdBTerm : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdDAck : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 63);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    Sl_rearbitrate : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_wrBTerm : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrDAck : out std_logic;
    PLB_abort : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_BE : in std_logic_vector(0 to 7);
    PLB_busLock : in std_logic;
    PLB_compress : in std_logic;
    PLB_guarded : in std_logic;
    PLB_lockErr : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 0);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_ordered : in std_logic;
    PLB_PAValid : in std_logic;
    PLB_pendPri : in std_logic_vector(0 to 1);
    PLB_pendReq : in std_logic;
    PLB_rdBurst : in std_logic;
    PLB_rdPrim : in std_logic;
    PLB_reqPri : in std_logic_vector(0 to 1);
    PLB_RNW : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_wrBurst : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 63);
    PLB_wrPrim : in std_logic
  );
  attribute x_core_info : STRING;
  attribute x_core_info of accel_sort_plb_0_wrapper: entity is "accel_sort_plb_v1_00_a";

end accel_sort_plb_0_wrapper;

architecture STRUCTURE of accel_sort_plb_0_wrapper is

  component accel_sort_plb is
    generic (
      C_BASEADDR : std_logic_vector;
      C_HIGHADDR : std_logic_vector;
      C_PLB_AWIDTH : INTEGER;
      C_PLB_DWIDTH : INTEGER;
      C_PLB_NUM_MASTERS : INTEGER;
      C_PLB_MID_WIDTH : INTEGER;
      C_FAMILY : STRING
    );
    port (
      PLB_Clk : in std_logic;
      PLB_Rst : in std_logic;
      Sl_addrAck : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_MErr : out std_logic_vector(0 to (C_PLB_NUM_MASTERS-1));
      Sl_rdBTerm : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdDAck : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_PLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      Sl_rearbitrate : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_wrBTerm : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrDAck : out std_logic;
      PLB_abort : in std_logic;
      PLB_ABus : in std_logic_vector(0 to (C_PLB_AWIDTH-1));
      PLB_BE : in std_logic_vector(0 to ((C_PLB_DWIDTH/8)-1));
      PLB_busLock : in std_logic;
      PLB_compress : in std_logic;
      PLB_guarded : in std_logic;
      PLB_lockErr : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_PLB_MID_WIDTH-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_ordered : in std_logic;
      PLB_PAValid : in std_logic;
      PLB_pendPri : in std_logic_vector(0 to 1);
      PLB_pendReq : in std_logic;
      PLB_rdBurst : in std_logic;
      PLB_rdPrim : in std_logic;
      PLB_reqPri : in std_logic_vector(0 to 1);
      PLB_RNW : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_wrBurst : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_PLB_DWIDTH-1));
      PLB_wrPrim : in std_logic
    );
  end component;

begin

  accel_sort_plb_0 : accel_sort_plb
    generic map (
      C_BASEADDR => X"cc800000",
      C_HIGHADDR => X"cc80ffff",
      C_PLB_AWIDTH => 32,
      C_PLB_DWIDTH => 64,
      C_PLB_NUM_MASTERS => 2,
      C_PLB_MID_WIDTH => 1,
      C_FAMILY => "virtex2p"
    )
    port map (
      PLB_Clk => PLB_Clk,
      PLB_Rst => PLB_Rst,
      Sl_addrAck => Sl_addrAck,
      Sl_MBusy => Sl_MBusy,
      Sl_MErr => Sl_MErr,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_rdComp => Sl_rdComp,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_wrComp => Sl_wrComp,
      Sl_wrDAck => Sl_wrDAck,
      PLB_abort => PLB_abort,
      PLB_ABus => PLB_ABus,
      PLB_BE => PLB_BE,
      PLB_busLock => PLB_busLock,
      PLB_compress => PLB_compress,
      PLB_guarded => PLB_guarded,
      PLB_lockErr => PLB_lockErr,
      PLB_masterID => PLB_masterID,
      PLB_MSize => PLB_MSize,
      PLB_ordered => PLB_ordered,
      PLB_PAValid => PLB_PAValid,
      PLB_pendPri => PLB_pendPri,
      PLB_pendReq => PLB_pendReq,
      PLB_rdBurst => PLB_rdBurst,
      PLB_rdPrim => PLB_rdPrim,
      PLB_reqPri => PLB_reqPri,
      PLB_RNW => PLB_RNW,
      PLB_SAValid => PLB_SAValid,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_wrBurst => PLB_wrBurst,
      PLB_wrDBus => PLB_wrDBus,
      PLB_wrPrim => PLB_wrPrim
    );

end architecture STRUCTURE;

