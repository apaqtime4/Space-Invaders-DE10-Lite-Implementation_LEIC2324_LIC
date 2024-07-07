library ieee;
use ieee.std_logic_1164.all;

entity Key_Scan_tb is
end Key_Scan_tb;

architecture behavioral of Key_Scan_tb is

component Key_Scan is
port(
		Kscan : in STD_LOGIC;
		Multiplexer_In : in STD_LOGIC_VECTOR(3 downto 0);
		CLK : in STD_LOGIC;
		Reset : in std_LOGIC;
		Decoder_Out : out std_logic_vector(3 downto 0);
		Kout : out STD_LOGIC_VECTOR(3 downto 0);
		Kpress : out std_logic
);
end component;

signal keyscan_tb : std_logic;
signal reset_tb : std_logic;
signal mux_tb : std_logic_vector(3 downto 0);
signal dec_tb : std_logic_vector(3 downto 0);
signal Kout_tb : std_logic_vector(3 downto 0);
signal Kpress_tb : std_logic;


-- UUT signals
SIGNAL clk_tb : std_logic := '0';
CONSTANT PERIOD : TIME := 40 ns;

begin

-- Unit Under Test
UUT: Key_Scan 
		port map(Reset => reset_tb,
					CLK => clk_tb,
					Kscan	=> keyscan_tb,
					Decoder_Out => dec_tb,
					Kout => Kout_tb,
					Kpress => Kpress_tb,
					Multiplexer_In => mux_tb);
					
-- Clock process definitions
    CLK_process: PROCESS
    BEGIN
        clk_tb <= NOT clk_tb AFTER PERIOD / 2;
        WAIT FOR PERIOD / 2;
    END PROCESS;

stimulus: process 
begin
--Primeiro caso
reset_tb <= '1';
keyscan_tb <= '1';
mux_tb(0) <= '1';
mux_tb(1) <= '1';
mux_tb(2) <= '1';
mux_tb(3) <= '1';
wait for PERIOD;

reset_tb <= '0';
mux_tb(0) <= '0';
mux_tb(1) <= '1';
mux_tb(2) <= '1';
mux_tb(3) <= '1';
wait for PERIOD;

--Terceiro caso 4 0001

mux_tb(0) <= '1';
mux_tb(1) <= '0';
mux_tb(2) <= '1';
mux_tb(3) <= '1';
wait for PERIOD*4;

--Quarto caso 5 
mux_tb(0) <= '1';
mux_tb(1) <= '0';
mux_tb(2) <= '1';
mux_tb(3) <= '1';
wait for PERIOD*5;

--Quinto caso 6
mux_tb(0) <= '1';
mux_tb(1) <= '1';
mux_tb(2) <= '0';
mux_tb(3) <= '1';
wait for PERIOD*13;

--Quinto caso 0
mux_tb(0) <= '1';
mux_tb(1) <= '1';
mux_tb(2) <= '1';
mux_tb(3) <= '0';

wait for PERIOD; --tá a verificar a tecla 3

--Quinto caso, press in next clock, mas a pressionada é a 9
mux_tb(0) <= '1';
mux_tb(1) <= '1';
mux_tb(2) <= '0';
mux_tb(3) <= '1';

wait for PERIOD * 3;

wait for PERIOD;

wait;

end process;

end architecture;