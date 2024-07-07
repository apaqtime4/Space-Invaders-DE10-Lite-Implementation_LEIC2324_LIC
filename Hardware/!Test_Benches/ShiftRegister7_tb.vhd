library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister7_tb is
end entity ShiftRegister7_tb;

ARCHITECTURE behavior OF ShiftRegister7_tb IS 

COMPONENT ShiftRegister7
PORT (
		data        : in std_logic;
        clk         : in std_logic;
        enable 	  	: in std_logic;
        Dataout   	: out std_logic_vector(6 downto 0)
);
END COMPONENT;

-- Inputs  
    SIGNAL data_s: std_logic;
	SIGNAL enable_s: std_logic;

-- Outputs
    SIGNAL Dataout_s : std_logic_vector(6 downto 0);
	
-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 20 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ShiftRegister7 PORT MAP (
		clk => Clk_s,
		enable => enable_s,
		data => data_s,
		Dataout => Dataout_s      
    );	  
	

    -- Clock process definitions
    CLK_process: PROCESS
    BEGIN
        CLK_s <= NOT CLK_s AFTER PERIOD / 2;
        WAIT FOR PERIOD / 2;
    END PROCESS;
	
	stim_proc: PROCESS
    BEGIN
	--Primeiro caso
		enable_s <= '1';
		wait for 40 ns;
		
		data_s <= '0';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		data_s <= '1';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		
		enable_s <= '0';
		wait for PERIOD;		
		wait for PERIOD;
		wait for PERIOD;

		--Segundo caso

		enable_s <= '1';
		data_s <= '1';

		wait for PERIOD;
		wait for PERIOD;
		data_s <= '0';
		wait for PERIOD;
		wait for PERIOD;
		data_s <= '0';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		
		enable_s <= '0';
		wait for PERIOD;
		
		
	wait;
end process;
end architecture;