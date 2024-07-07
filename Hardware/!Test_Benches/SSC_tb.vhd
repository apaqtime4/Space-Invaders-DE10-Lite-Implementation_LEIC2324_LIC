library ieee;
use ieee.std_logic_1164.all;

entity SSC_tb is 
end SSC_tb;

architecture behavioral of SSC_tb is
    
component SSC is
	port (
		SDX : in std_logic;
		SCLK : in std_logic;
		MCLK : in std_logic;
		SCsel : in std_logic;
		set : out std_logic;
		cmd : out std_logic_vector(2 downto 0);
		data : out std_logic_vector(3 downto 0) 
	);
end component;
   
-- UUT Signals
constant MCLK_PERIOD : time := 20ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal SDX_tb, SCLK_tb, SS_tb, clk_tb, WrL_tb: std_logic;
signal CMD_tb: std_logic_vector(2 downto 0);
signal data_tb: std_logic_vector(3 downto 0);


begin

	--Unit Under Test

	UUT: SSC port map(
		SDX => SDX_tb, 
		SCLK => SCLK_tb, 
		SCsel => SS_tb, 
		Mclk => clk_tb,
		set  => WrL_tb,
		CMD => cmd_tb,
		Data => data_tb
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

					SDX_tb <= '0';
					SS_tb <= '1';
					SCLK_tb <= '0';
					Reset_tb <= '1';
					wait for MCLK_PERIOD;

					Reset_tb <= '0';
					wait for MCLK_PERIOD;

					-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 011 0000

					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 1
					SDX_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 1
					SDX_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;

					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;

									

					-- SS inativo
					SS_tb <= '1';
					wait for MCLK_PERIOD*4;

------------------------------------------------------------------


					-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 000 0010

					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 1
					SDX_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
					
					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;

					-- 0
					SDX_tb <= '0';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;
									

					-- SS inativo
					SS_tb <= '1';
					wait for MCLK_PERIOD;




          wait;
          end process;
			 
end behavioral;