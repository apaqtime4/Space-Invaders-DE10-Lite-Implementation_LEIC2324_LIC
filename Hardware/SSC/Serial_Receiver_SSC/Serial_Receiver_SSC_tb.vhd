library ieee;
use ieee.std_logic_1164.all;

entity Serial_Receiver_SSC_tb is
end Serial_Receiver_SSC_tb;

architecture behavioral of Serial_Receiver_SSC_tb is

component Serial_Receiver_SSC is
port (
		   SDX: in std_logic;
		SCLK: in std_logic;
		Mclk : in std_logic;
		SS: in std_logic;
		ACCEPT: in std_logic;
		DXval: out std_logic;
		Final: out std_logic_vector(6 downto 0)
);
end component;

-- Inputs  
    SIGNAL SDX_s : std_logic;
	SIGNAL SS_s: std_logic;
	SIGNAL ACCEPT_s: std_logic;

-- Outputs
    SIGNAL DXval_s: std_logic;
	SIGNAL Final_s: std_logic_vector(6 downto 0);
	
-- Clock generation SCLK
    SIGNAL SClk_s : std_logic := '0';
    CONSTANT SPERIOD : TIME := 10 ns;

-- Clock generation MCLK
    SIGNAL MClk_s : std_logic := '0';
    CONSTANT MPERIOD : TIME := 5 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Serial_Receiver_SSC PORT MAP (
		SCLK => SClk_s,
		MCLK => MClk_s,
		SDX => SDX_s,
		SS => SS_s,
		ACCEPT => ACCEPT_s,
		DXval => DXval_s,
		Final => Final_s
    );	  


    -- Clock process definitions
    SCLK_process: PROCESS
    BEGIN
        SCLK_s <= NOT SCLK_s AFTER SPERIOD / 2;
        WAIT FOR SPERIOD / 2;
    END PROCESS;

	 MCLK_process: PROCESS
    BEGIN
        MCLK_s <= NOT MCLK_s AFTER MPERIOD / 2;
        WAIT FOR MPERIOD / 2;
    END PROCESS;
	 
	stim_proc: PROCESS
    BEGIN
    
	 --Primeiro caso
		SDX_s <= '0';
		SS_s <= '0';
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
		SDX_s <= '1';
		SS_s <= '1';
				  
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		ACCEPT_s <= '1';
		
		wait for 40 ns;
		
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
		--Segundo caso
		
		
		SDX_s <= '0';
		SS_s <= '0';
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
		SDX_s <= '1';
		SS_s <= '1';
				  
		wait for 40 ns;
		wait for 40 ns;
		
		SDX_s <= '0';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		SDX_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		
		ACCEPT_s <= '1';
		
		wait for 40 ns;
		
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
		--Terceiro caso (teste de falha)
		
		SDX_s <= '0';
		SS_s <= '0';
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
		SDX_s <= '1';
				  
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		SDX_s <= '0';
		
		wait for 40 ns;
		wait for 40 ns;
		
		ACCEPT_s <= '1';
		
		wait for 40 ns;
		
		ACCEPT_s <= '0';
		
		wait for 40 ns;
		
	wait;
end process;
end architecture;