LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity CounterUp_tb is
end CounterUp_tb;

architecture behavioral of CounterUp_tb is

component CounterUP is
port(
            CE: in std_logic;
            Reset: in std_logic;
            CLK: in std_logic;
            Final: out std_logic_vector(3 downto 0)
    );
end component;


constant MCLK_Period : time := 20 ns;
constant MCLK_HALF_Period : time := 10 ns;

signal CE_tb : std_logic;
signal Reset_tb : std_logic;
signal CLK_tb : std_logic;
signal Final_tb : std_logic_vector(3 downto 0);

begin

--Unit Under Test 

UUT: counterUP
port map(
		CE => CE_tb,
		Reset => Reset_tb,
		CLK => CLK_tb,
		Final => Final_tb);

clk_gen : process 
begin
	clk_tb <= '0';
	wait for MCLK_HALF_Period;
	clk_tb <= '1';
	wait for MCLK_HALF_Period;
end process;

stimulus : process
begin 
	-- reset
	Reset_tb <= '1';
	CE_tb <= '0';
	wait for MCLK_Period;
	

	Reset_tb <= '0';
	CE_tb <= '1';
	-- 0000

	wait for MCLK_Period;
	-- 0001

	wait for MCLK_Period;
	-- 0010

	wait for MCLK_Period;
	-- 0011

	wait for MCLK_Period;
	-- 0100

	wait for MCLK_Period;
	-- 0101

	wait for MCLK_Period;
	-- 0110

	wait for MCLK_Period;
	-- 0111

	wait for MCLK_Period;
	-- 1000

	wait for MCLK_Period;
	-- 1001

	wait for MCLK_Period;
	-- 1010

	wait for MCLK_Period;
	-- 1011

	wait for MCLK_Period;
	-- 1100

	wait for MCLK_Period;
	-- 1101

	wait for MCLK_Period;
	-- 1110

	wait for MCLK_Period;
	-- 1111

	wait for MCLK_Period;
	-- 0000

	wait for MCLK_Period;
	-- 0001

	CE_tb <= '0';
	Reset_tb <= '1';
	
	wait for MCLK_Period;
	-- 0000

	Reset_tb <= '0';
	wait for MCLK_Period;
	-- 0000
	
	wait;
end process;
end architecture;
