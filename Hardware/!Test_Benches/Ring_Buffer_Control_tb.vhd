library ieee;
use ieee.std_logic_1164.all;

entity Ring_Buffer_Control_tb is
end Ring_Buffer_Control_tb;

architecture behavioral of Ring_Buffer_Control_tb is

component Ring_Buffer_Control is
port (
		clk : in std_logic;
		CTS : in std_logic;
        DAV : in std_logic;
		full : in std_logic;
		empty : in std_logic;
		Wreg : out std_logic;
		Wr : out std_logic;
		selPG : out std_logic;
		incPut : out std_logic;
		incGet : out std_logic;		  
		DAC : out std_logic
);
end component;

-- Inputs  
    SIGNAL CTS_s: std_logic;
	SIGNAL DAV_s: std_logic;
	SIGNAL full_s: std_logic;
	SIGNAL empty_s: std_logic;

-- Outputs
	SIGNAL Wreg_s : std_logic;
    SIGNAL Wr_s: std_logic;
	SIGNAL selPG_s: std_logic;
	SIGNAL incPut_s: std_logic;
	SIGNAL incGet_s: std_logic;
	SIGNAL DAC_s: std_logic;

-- Clock generation
    SIGNAL CLK_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Ring_Buffer_Control PORT MAP (
		clk => CLK_s,
		CTS => CTS_s,
        DAV => DAV_s,
		full => full_s,
		empty => empty_s,
		Wreg => Wreg_s,
		Wr => Wr_s,
		selPG => selPG_s,
		incPut => incPut_s,
		incGet => incGet_s,
		DAC => DAC_s
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
		
		CTS_s <= '0';
		DAV_s <= '0';
		full_s <= '0';
		empty_s <= '0';
		
		wait for 40 ns;
		
		DAV_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;

		DAV_s <= '0';
		
		wait for 40 ns;
		
		CTS_s <= '1'; 
		
		wait for 40 ns;

		CTS_s <= '0'; 
		
		empty_s <= '1';
		
		wait for 40 ns;
		
		full_s <= '1';
		
		wait for 40 ns;
		
		full_s <= '0';		 

	wait;
end process;
end architecture;