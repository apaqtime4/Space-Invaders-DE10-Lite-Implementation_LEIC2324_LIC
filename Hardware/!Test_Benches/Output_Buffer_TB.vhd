library ieee;
use ieee.std_logic_1164.all;

entity Output_Buffer_tb is
end Output_Buffer_tb;

architecture behavioral of Output_Buffer_tb is

component Output_Buffer is
    port (
        CLK     : in std_logic;
        reset   : in std_logic;
        Data    : in std_logic_vector(3 downto 0);
        Load    : in std_logic;
        ACK     : in std_logic;
        Qout    : out std_logic_vector(3 downto 0);
        OBfree  : out std_logic;
        Dval    : out std_logic
    );
end component;

-- Inputs  
    SIGNAL Reset_s : std_logic;
    SIGNAL Data_s : std_logic_vector(3 downto 0);
    SIGNAL Load_s : std_logic;
    SIGNAL Ack_s : std_logic;

-- Outputs
	SIGNAL Qout_s : std_logic_vector(3 downto 0);
    SIGNAL OBfree_s: std_logic;
	SIGNAL Dval_s: std_logic;	

-- Clock generation
    SIGNAL CLK_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;
	

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Output_Buffer PORT MAP (
        CLK    => CLK_s,
        reset  => Reset_s,
        Data   => Data_s,
        Load   => Load_s,
        ACK    => Ack_s,
        Qout   => Qout_s,
        OBfree => OBfree_s,
        Dval   => Dval_s
    );	  
	

    -- Clock process definitions
    CLK_process: PROCESS
    BEGIN
        CLK_s <= NOT CLK_s AFTER PERIOD / 2;
        WAIT FOR PERIOD / 2;
    END PROCESS;

	stim_proc: PROCESS
    BEGIN
        Reset_s <= '1';

        wait for 40 ns;
		
        Reset_s <= '0';
		
		wait for 40 ns;
		
		Data_s <= "1010";
        Load_s <= '0';
        ACK_s <= '0';
		
        wait for 40 ns;

        Load_s <= '1';

		wait for 40 ns;

		Load_s <= '0';

		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '0';
		
		wait for 40 ns;
		
		ACK_s <= '1';

        wait for 40 ns;
		
        
		
		Data_s <= "0101";
        Load_s <= '0';
        ACK_s <= '0';
		
        wait for 40 ns;

        Load_s <= '1';

		wait for 40 ns;

		Load_s <= '0';

		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '1';
		
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		wait for 40 ns;
		
		ACK_s <= '0';
		
		wait for 40 ns;
		
		
	wait;
end process;
end architecture;