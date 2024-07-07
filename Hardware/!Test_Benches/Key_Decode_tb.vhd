library ieee;
use ieee.std_logic_1164.all;

entity Key_Decode_tb is
end Key_Decode_tb;

architecture behavioral of Key_Decode_tb is

component Key_Decode is
port(
		CLK : in std_logic;
        Linha : in std_logic_vector(3 downto 0);
		Kack : in std_logic;
		Reset : in std_logic;
		Kval : out std_logic;
		Coluna : out std_logic_vector(3 downto 0);
        K03 : out std_logic_vector(3 downto 0)
);
end component;

-- UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal kack_tb, kval_tb, clk_tb, reset_tb : std_logic;
signal linha_tb, coluna_tb, K03_tb : std_logic_vector(3 downto 0);

begin



clk_gen : process
begin
		clk_tb <= '0';
		wait for MCLK_HALF_PERIOD;
		clk_tb <= '1';
		wait for MCLK_HALF_PERIOD;
end process;




-- Unit Under Test
UUT: Key_Decode 
		port map(
		CLK => CLK_tb,
        Linha => Linha_tb,
		Kack => Kack_tb,
		Reset => Reset_tb,
		Kval => Kval_tb,
		Coluna => Coluna_tb,
        K03 => K03_tb
);
					
	
-- Vaiaveis manipulaveis:
-- clock, linha, reset, Kack.

stimulus: process 
begin
	
	kack_tb <= '0';
    reset_tb <= '1';
    linha_tb(0) <= '1';
    linha_tb(1) <= '1';
    linha_tb(2) <= '1';
    linha_tb(3) <= '1';

    WAIT for MCLK_PERIOD;
    reset_tb <= '0';
    WAIT for MCLK_PERIOD*5;

    -- verificar 5
    linha_tb(0) <= '1';
    linha_tb(1) <= '1';
    linha_tb(2) <= '0';
    linha_tb(3) <= '1';

    WAIT for MCLK_PERIOD*5;

    Kack_tb <= '1';

    wait for MCLK_PERIOD;
    kack_tb <= '0';
    wait for MCLK_PERIOD*5;
    linha_tb(0) <= '1';
    linha_tb(1) <= '1';
    linha_tb(2) <= '1';
    linha_tb(3) <= '1';
    wait for MCLK_PERIOD*5;

    kack_tb <= '1';
    wait for MCLK_PERIOD*5;


    Kack_tb <= '0';
	
	WAIT;
end process;

end architecture;