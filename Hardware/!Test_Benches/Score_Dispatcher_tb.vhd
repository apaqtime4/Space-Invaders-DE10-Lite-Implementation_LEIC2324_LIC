library ieee;
use ieee.std_logic_1164.all;

entity Score_Dispatcher_tb is
end Score_Dispatcher_tb;

architecture behavioral of Score_Dispatcher_tb is

component Score_Dispatcher is
port (
		Din: in std_logic_vector(6 downto 0);
		Dval: in std_logic; 
		clk: in std_logic; 
		WrL: out std_logic;
		done: out std_logic;
		Dout: out std_logic_vector(6 downto 0)
);
end component;

-- Inputs  
    SIGNAL Dval_s : std_logic;
	SIGNAL Din_s: std_logic_vector(6 downto 0);

-- Outputs
	SIGNAL Wrl_s: std_logic;
	SIGNAL Dout_s: std_logic_vector(6 downto 0);
	SIGNAL done_s: std_logic;

-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 40 ns;


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Score_Dispatcher PORT MAP (
		CLK => Clk_s,
		Dval => Dval_s,
		Din => Din_s,
		Wrl => Wrl_s,
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
    
		--Primeiro caso
		
		wait for 40 ns;
		
		Dval_s <= '0';
		Din_s <= "0000000";
		
		wait for 40 ns;
		
		Dval_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;

		Dval_s <= '0';
		
		wait for 40 ns;
		--Segundo caso
		
		Dval_s <= '0';
		Din_s <= "0100110";
		
		wait for 40 ns;
		
		Dval_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		Dval_s <= '0';
		
		wait for 40 ns;
		
		--Terceiro caso
		
		Dval_s <= '0';	 
		Din_s <= "0110110";
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		Dval_s <= '1';
		
		
		Dval_s <= '0';
		
		wait for 40 ns;
		
		
	wait;
end process;
end architecture;