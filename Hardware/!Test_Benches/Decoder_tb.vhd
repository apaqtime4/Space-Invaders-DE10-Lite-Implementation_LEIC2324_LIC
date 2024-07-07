library ieee;
use ieee.std_logic_1164.all;

entity Decoder_tb is
end Decoder_tb;

architecture behavioral of Decoder_tb is

component Decoder is
port(
		OPin : in std_logic_vector(1 downto 0);
		OPout : out std_logic_vector(3 downto 0)	
);
end component;

-- UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal OPin_tb : std_logic_vector(1 downto 0);
signal OPout_tb : std_logic_vector(3 downto 0);

begin

-- Unit Under Test
UUT: Decoder 
		port map(
			OPin => OPin_tb,
			OPout => OPout_tb);


stimulus: process 
begin
	-- start
	OPin_tb(0) <= '0';
	OPin_tb(1) <= '0';
	
	wait for MCLK_PERIOD*2;

	OPin_tb(0) <= '1';
	wait for MCLK_PERIOD*2;
	
	OPin_tb(0) <= '0';
	OPin_tb(1) <= '1';
	wait for MCLK_PERIOD*2;
	
	OPin_tb(0) <= '1';
	wait for MCLK_PERIOD*2;
	
	OPin_tb(0) <= '0';
	OPin_tb(1) <= '0';
	
	wait for MCLK_PERIOD*2;
	
	wait;
end process;

end architecture;