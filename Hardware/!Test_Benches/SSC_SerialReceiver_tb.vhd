library ieee;
use ieee.std_logic_1164.all;

entity LCD_SerialReceiver_tb is 
end LCD_SerialReceiver_tb;

architecture behavioral of LCD_SerialReceiver_tb is
    component Serial_Receiver_SSC is 
    port(
        SDX: in std_logic;
		SCLK: in std_logic;
		Mclk : in std_logic;
		SS: in std_logic;
		ACCEPT: in std_logic;
		DXval: out std_logic;
		Final: out std_logic_vector(6 downto 0)
    );
	end component;
   
    -- UUT Signals
    constant MCLK_PERIOD : time := 20ns;
    constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

	signal SDX_tb, SCLK_tb, SS_tb, accept_tb, Reset_tb, clk_tb: std_logic;
	signal D_tb: std_logic_vector(6 downto 0);
	signal DXval_tb: std_logic;


    begin

        --Unit Under Test

        UUT: Serial_Receiver_SSC port map(
				SDX => SDX_tb, 
				SCLK => SCLK_tb, 
				SS => SS_tb, 
				accept => accept_tb, 
				Mclk => clk_tb,
				final => D_tb,
				DXval  => DXval_tb
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

			accept_tb <= '0';
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

							

			-- SS inativo
			SS_tb <= '1';
			wait for MCLK_PERIOD;
			accept_tb <= '1';
			wait for MCLK_PERIOD;
			accept_tb <= '0';

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
							

			-- SS inativo
			SS_tb <= '1';
			wait for MCLK_PERIOD;
													accept_tb <= '1';
			wait for MCLK_PERIOD;
			accept_tb <= '0';



  wait;
  end process;
	 
end behavioral;