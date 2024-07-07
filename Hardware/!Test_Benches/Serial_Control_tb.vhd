library ieee;
use ieee.std_logic_1164.all;

entity Serial_Control_tb is
end Serial_Control_tb;

architecture behavioral of Serial_Control_tb is

component Serial_Control is
	port (
		clk, e_RX, accept, dFlag, pFlag, RXerror: in std_logic;
		wr, init, DXval: out std_logic
	);
end component;

-- Inputs  
    SIGNAL e_RX_s: std_logic;
	SIGNAL accept_s: std_logic;
	SIGNAL pFlag_s: std_logic;
	SIGNAL dFlag_s: std_logic;
	SIGNAL RXerror_s: std_logic;

-- Outputs
    SIGNAL wr_s: std_logic;
	SIGNAL init_s: std_logic;
	SIGNAL DXval_s: std_logic;
	
-- Clock generation
    SIGNAL Clk_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Serial_Control PORT MAP (
		clk => Clk_s,
		e_RX => e_RX_s,
		accept => accept_s,
		pFlag => pFlag_s,
		dFlag => dFlag_s,
		RXerror => RXerror_s,
		wr => wr_s,
		init => init_s,
		DXval => DXval_s      
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
		e_RX_s <= '1';
		accept_s <= '0';
		pFlag_s <= '0';
		dFlag_s <= '0';
		
		wait for 40 ns;

		e_RX_s <= '0';
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		dFlag_s <= '1';
		
		wait for 40 ns;
		
		e_RX_s <= '1';
		dFlag_s <= '0';
		pFlag_s <= '1';
		RXerror_s <= '0';
		
		wait for 40 ns;
		
		accept_s <= '1';
		
		wait for 40 ns;
		
		--Segundo caso
		e_RX_s <= '0';
		accept_s <= '0';
		pFlag_s <= '0';
		dFlag_s <= '0';
		
		wait for 40 ns; 
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		dFlag_s <= '1';
		
		wait for 40 ns;
		
		e_RX_s <= '1';
		dFlag_s <= '0';
		pFlag_s <= '1';
		
		wait for 40 ns;
		
		RXerror_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		wait for 40 ns;
		
	wait;
end process;
end architecture;