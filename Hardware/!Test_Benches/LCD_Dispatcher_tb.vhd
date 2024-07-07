library ieee;
use ieee.std_logic_1164.all;

entity LCD_Dispatcher_tb is
end LCD_Dispatcher_tb;

architecture behavioral of LCD_Dispatcher_tb is

component LCD_Dispatcher is
port (
		Din: in std_logic_vector(8 downto 0);
		Dval: in std_logic; 
		clk: in std_logic;
		Reset: in std_logic;
		WrL : out std_logic;
		done: out std_logic;
		Dout: out std_logic_vector(8 downto 0)
);
end component;

-- Inputs  
   SIGNAL Dval_s : std_logic;
	SIGNAL Reset_s : std_logic;
	SIGNAL Din_s: std_logic_vector(8 downto 0);

-- Outputs
   SIGNAL WrL_s: std_logic;
	SIGNAL Dout_s: std_logic_vector(8 downto 0);
	SIGNAL done_s: std_logic;

-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;
	

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: LCD_Dispatcher PORT MAP (
		clk => Clk_s,
		Dval => Dval_s,
        Din => Din_s,
		Reset => Reset_s,
        WrL => WrL_s,
        done => done_s,
        Dout => Dout_s
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
		
		Reset_s <= '1';
		
		wait for 40 ns;
		
		Reset_s <= '0';
		Dval_s <= '0';
		Din_s <= "010000110";
		
		wait for 40 ns;
		
		Dval_s <= '1';
		
		wait for 40 ns;
		
		Dval_s <= '0';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		
		
	wait;
end process;
end architecture;