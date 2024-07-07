LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity MUX4_tb is

end MUX4_tb;
architecture behavioral of MUX4_tb is

component MUX4 is
port(A : in STD_LOGIC_VECTOR(3 downto 0);
    S : in std_logic_vector(1 downto 0);
    O : out STD_LOGIC
    );
end component;


constant MCLK_Period : time := 20 ns;
constant MCLK_HALF_Period : time := 10 ns;

signal A_tb : std_logic_vector(3 downto 0);
signal S_tb : std_logic_vector(1 downto 0);
signal O_tb : std_logic;

begin

--Unit Under Test 

UUT: MUX4
port map(A => A_tb,
			S => S_tb,
			O => O_tb
			);

stimulus : process
begin 

	--Primeiro caso
	A_tb <= "1010";
	S_tb <= "00";
	wait for MCLK_Period;
	
	--S = 01
	S_tb <= "01";
	wait for MCLK_Period;
	
	--S = 10
	S_tb <= "10";
	wait for MCLK_Period;
	
	--S = 11
	S_tb <= "11";
	wait for MCLK_Period;
	
	--A=0101
	--S=00
	A_tb <= "0101";
	S_tb <= "00";
	wait for MCLK_Period;
	
	--S=01
	S_tb <= "01";
	wait for MCLK_Period;
	
	--S=10
	S_tb <= "10";
	wait for MCLK_Period;
	
	--S=11
	S_tb <= "11";
	wait for MCLK_Period;
	
	wait;
end process;
end architecture;