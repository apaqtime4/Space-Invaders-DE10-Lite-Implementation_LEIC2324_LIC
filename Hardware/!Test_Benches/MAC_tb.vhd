library ieee;
use ieee.std_logic_1164.all;

entity MAC_tb is
end MAC_tb;

architecture behavioral of MAC_tb is

component MAC is
port (
		clk : in std_logic;
		reset : in std_logic;
		putget : in std_logic;
		incget : in std_logic;
		incput : in std_logic;
		full : out std_logic;
		empty : out std_logic;
		address : out std_logic_vector(2 downto 0)
);
end component;

-- Inputs  
	SIGNAL reset_s : std_logic;
	SIGNAL putget_s: std_logic;
	SIGNAL incget_s: std_logic;
	SIGNAL incput_s: std_logic;	 	

-- Outputs
	SIGNAL full_s: std_logic;
	SIGNAL empty_s: std_logic;
	SIGNAL address_s: std_logic_vector(2 downto 0);

-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 40 ns;


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: MAC PORT MAP (
		clk => Clk_s,
		reset => reset_s,
		putget => putget_s,
		incget => incget_s,
		incput => incput_s,
		full => full_s,
		empty => empty_s,
		address => address_s
    );	  
	

    -- Clock process definitions
    CLK_process: PROCESS
    BEGIN
        Clk_s <= NOT Clk_s AFTER PERIOD / 2;
        WAIT FOR PERIOD / 2;
    END PROCESS;

	stim_proc: PROCESS
    BEGIN
      wait for 40 ns;
	
		reset_s <= '1';
		putget_s <= '1';
		incput_s <= '0';
		incget_s <= '0';
		
		wait for 40 ns;
		
		reset_s <= '0';
		incget_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		incget_s <= '0';
		incput_s <= '1';
		putget_s <= '0';
		
		wait for 40 ns;
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		reset_s <= '1';
		
	wait;
end process;
end architecture;