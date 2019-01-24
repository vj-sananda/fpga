-------------------------------------------------------------------------------
-- isocm_bram_elaborate.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity isocm_bram_elaborate is
  generic (
    C_MEMSIZE : integer;
    C_PORT_DWIDTH : integer;
    C_PORT_AWIDTH : integer;
    C_NUM_WE : integer;
    C_FAMILY : string
    );
  port (
    BRAM_Rst_A : in std_logic;
    BRAM_Clk_A : in std_logic;
    BRAM_EN_A : in std_logic;
    BRAM_WEN_A : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_A : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_A : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_A : in std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Rst_B : in std_logic;
    BRAM_Clk_B : in std_logic;
    BRAM_EN_B : in std_logic;
    BRAM_WEN_B : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_B : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_B : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_B : in std_logic_vector(0 to C_PORT_DWIDTH-1)
  );
end isocm_bram_elaborate;

architecture STRUCTURE of isocm_bram_elaborate is

  attribute WRITE_MODE_A : string;
  attribute WRITE_MODE_B : string;

  component RAMB16_S36_S36 is
    generic (
      WRITE_MODE_A : string;
      WRITE_MODE_B : string
    );
    port (
      ADDRA : in std_logic_vector(8 downto 0);
      CLKA : in std_logic;
      DIA : in std_logic_vector(31 downto 0);
      DIPA : in std_logic_vector(3 downto 0);
      DOA : out std_logic_vector(31 downto 0);
      DOPA : out std_logic_vector(3 downto 0);
      ENA : in std_logic;
      SSRA : in std_logic;
      WEA : in std_logic;
      ADDRB : in std_logic_vector(8 downto 0);
      CLKB : in std_logic;
      DIB : in std_logic_vector(31 downto 0);
      DIPB : in std_logic_vector(3 downto 0);
      DOB : out std_logic_vector(31 downto 0);
      DOPB : out std_logic_vector(3 downto 0);
      ENB : in std_logic;
      SSRB : in std_logic;
      WEB : in std_logic
    );
  end component;

  attribute WRITE_MODE_A of RAMB16_S36_S36: component is "WRITE_FIRST";
  attribute WRITE_MODE_B of RAMB16_S36_S36: component is "WRITE_FIRST";

  -- Internal signals

  signal dina : std_logic_vector(63 downto 0);
  signal dinb : std_logic_vector(63 downto 0);
  signal douta : std_logic_vector(63 downto 0);
  signal doutb : std_logic_vector(63 downto 0);
  signal net_gnd4 : std_logic_vector(3 downto 0);

begin

  -- Internal assignments

  dina(63 downto 0) <= BRAM_Dout_A(0 to 63);
  BRAM_Din_A(0 to 63) <= douta(63 downto 0);
  dinb(63 downto 0) <= BRAM_Dout_B(0 to 63);
  BRAM_Din_B(0 to 63) <= doutb(63 downto 0);
  net_gnd4(3 downto 0) <= B"0000";

  ramb16_s36_s36_0 : RAMB16_S36_S36
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(20 to 28),
      CLKA => BRAM_Clk_A,
      DIA => dina(63 downto 32),
      DIPA => net_gnd4,
      DOA => douta(63 downto 32),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(0),
      ADDRB => BRAM_Addr_B(20 to 28),
      CLKB => BRAM_Clk_B,
      DIB => dinb(63 downto 32),
      DIPB => net_gnd4,
      DOB => doutb(63 downto 32),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(0)
    );

  ramb16_s36_s36_1 : RAMB16_S36_S36
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(20 to 28),
      CLKA => BRAM_Clk_A,
      DIA => dina(31 downto 0),
      DIPA => net_gnd4,
      DOA => douta(31 downto 0),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(1),
      ADDRB => BRAM_Addr_B(20 to 28),
      CLKB => BRAM_Clk_B,
      DIB => dinb(31 downto 0),
      DIPB => net_gnd4,
      DOB => doutb(31 downto 0),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(1)
    );

end architecture STRUCTURE;

