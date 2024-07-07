library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister9_tb is
end entity ShiftRegister9_tb;

ARCHITECTURE behavior OF ShiftRegister9_tb IS 

COMPONENT ShiftRegister9
PORT (
		data        : in std_logic;
        clk         : in std_logic;
        enableShift : in std_logic;
        D           : out std_logic_vector(8 downto 0)
);
END COMPONENT;

-- Inputs  
	SIGNAL data_s: std_logic;
	SIGNAL enableShift_s: std_logic;

-- Outputs
    SIGNAL D_s : std_logic_vector(8 downto 0);
	
-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 20 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ShiftRegister9 PORT MAP (
		clk => Clk_s,
		enableShift => enableShift_s,
		data => data_s,
		D => D_s      
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
		enableShift_s <= '1';
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
		wait for PERIOD;
		wait for PERIOD;
		
		enableShift_s <= '0';
		
		wait for PERIOD;

	--Segundo caso
		enableShift_s <= '1';
		wait for PERIOD;
		
		data_s <= '1';
		wait for PERIOD;
		wait for PERIOD;
		data_s <= '0';
		wait for PERIOD;
		wait for PERIOD;
		data_s <= '1';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		
		enableShift_s <= '0';
		wait for PERIOD;
		
	--Terceiro caso
		enableShift_s <= '0';
		wait for PERIOD;
		
		data_s <= '1';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		data_s <= '0';
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
		wait for PERIOD;
	
		
	wait;
end process;
end architecture;