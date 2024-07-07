library ieee;
use ieee.std_logic_1164.all;

entity SLCDC_tb is 
end SLCDC_tb;

architecture behavioral of SLCDC_tb is
    
component SLCDC is
	port (
		SDX : in std_logic;
		MCLK : in std_logic;
		SCLK : in std_logic;
		LCDsel : in std_logic;
		Enable : out std_logic;
		RS : out std_logic;
		D : out std_logic_vector(7 downto 0) 
	);
end component;
   
-- UUT Signals
constant MCLK_PERIOD : time := 20ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal SDX_tb, SCLK_tb, SS_tb, Reset_tb, clk_tb, WrL_tb: std_logic;
signal Dout_tb: std_logic_vector(7 downto 0);
signal RS_tb: std_logic;


begin

	--Unit Under Test

      UUT: SLCDC port map(
				SDX => SDX_tb, 
				SCLK => SCLK_tb, 
				Mclk => clk_tb, 
				LCDsel => SS_tb, 
				Enable => WrL_tb,
				Rs => RS_tb, 
				D => Dout_tb
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
					
					
					-- ESCREVER 0011 0000

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

------------------------------------------------------------------

-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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

---------------------------------------------------------------------------
-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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

-----------------------------------------------------------------


-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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
					SDX_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;				

					-- SS inativo
					SS_tb <= '1';
					wait for MCLK_PERIOD;
-----------------------------------------------------------------
-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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
					
					-- 1
					SDX_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '1';
					wait for MCLK_PERIOD;
					SCLK_tb <= '0';
					wait for MCLK_PERIOD;				

					-- SS inativo
					SS_tb <= '1';
					wait for MCLK_PERIOD;

--------------------------------------------------------------------

-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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

					-- SS inativo
					SS_tb <= '1';
					wait for MCLK_PERIOD;

------------------------------------------------------------------------
-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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
					
					--0
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


------------------------------------------------------------------------
-- SS ATIVO
					SS_tb <= '0';
					wait for MCLK_PERIOD;
					
					
					-- ESCREVER 0011 0000

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