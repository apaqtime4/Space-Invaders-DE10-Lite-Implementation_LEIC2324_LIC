library ieee;
use ieee.std_logic_1164.all;

entity Key_Control_tb is
end Key_Control_tb;

architecture behavioral of Key_Control_tb is

component Key_Control is
port (
    clk : in std_logic;
    reset : in std_logic;
    kack : in std_logic;
    kpress : in std_logic;
    kval : out std_logic;
    kscan : out std_logic
);
end component;

-- UUT signals
constant MCLK_PERIOD : time := 40 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal reset_tb : std_logic;
signal clk_tb : std_logic;
signal Kack_tb : std_logic;
signal Kpress_tb : std_logic;
signal Kval_tb : std_logic;
signal Kscan_tb : std_logic;

begin

-- Unit Under Test
UUT: Key_Control 
		port map(    
			clk => clk_tb,
			reset => reset_tb,
			kack => Kack_tb,
			kpress => Kpress_tb,
			kval => Kval_tb,
			kscan => Kscan_tb
	);


clk_gen : process
begin
		clk_tb <= '0';
		wait for MCLK_HALF_PERIOD;
		clk_tb <= '1';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin
	-- start
	reset_tb <= '1';
	kack_tb <= '0';
	kpress_tb <= '0';

	wait for MCLK_PERIOD;

	reset_tb <= '0';

	wait for MCLK_PERIOD;

	kpress_tb <= '1';
	
	wait for MCLK_PERIOD*2;
	
	kack_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	kack_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	kpress_tb <= '0';

	wait for MCLK_PERIOD;
	-- end


	wait for MCLK_PERIOD;

	kpress_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	kack_tb <= '1';
	
	wait for MCLK_PERIOD;

	
	kack_tb <= '0';
	kpress_tb <= '0';	

	wait for MCLK_PERIOD;

	-- end	

	wait;
end process;

end architecture;