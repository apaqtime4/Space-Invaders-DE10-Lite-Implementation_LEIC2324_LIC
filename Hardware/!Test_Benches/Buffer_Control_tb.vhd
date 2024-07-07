library ieee;
use ieee.std_logic_1164.all;

entity Buffer_Control_tb is
end Buffer_Control_tb;

architecture behavioral of Buffer_Control_tb is

component Buffer_Control is
port (
		CLK : in std_logic;
        ACK : in std_logic;
        Load : in std_logic;
        Wreg : out std_logic;
        OBfree : out std_logic;
        Dval : out std_logic
);
end component;

-- Inputs  
    SIGNAL ACK_s: std_logic;
	SIGNAL Load_s: std_logic;

-- Outputs
	SIGNAL Wreg_s : std_logic;
    SIGNAL OBfree_s: std_logic;
	SIGNAL Dval_s: std_logic;	

-- Clock generation
    SIGNAL CLK_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;
	

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Buffer_Control PORT MAP (
		CLK => CLK_s,
        ACK => ACK_s,
        Load => Load_s,
        Wreg => Wreg_s,
        OBfree => OBfree_s,
        Dval => Dval_s
    );	  
	

    -- Clock process definitions
    CLK_process: PROCESS
    BEGIN
        CLK_s <= NOT CLK_s AFTER PERIOD / 2;
        WAIT FOR PERIOD / 2;
    END PROCESS;

	stim_proc: PROCESS
    BEGIN
        wait for 40 ns;
		
		Load_s <= '0';
      ACK_s <= '0';
		
		wait for 40 ns;
		
		Load_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '0';
		Load_s <= '0';
		
		wait for 40 ns;
		
		
	wait;
end process;
end architecture;