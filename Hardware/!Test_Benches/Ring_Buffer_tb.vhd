library ieee;
use ieee.std_logic_1164.all;

entity Ring_Buffer_tb is
end Ring_Buffer_tb;

architecture behavioral of Ring_Buffer_tb is

component Ring_Buffer is
    Port (
		CLK : in std_logic;
		CTS : in std_logic;
        D : in std_logic_vector(3 downto 0);
		DAV : in std_logic;
		RESET : in std_logic;
		Wreg : out std_logic;
		Q : out std_logic_vector(3 downto 0);
        DAC : out std_logic
    );
end component;

-- Inputs  
    SIGNAL CTS_s: std_logic;
    SIGNAL D_s: std_logic_vector(3 downto 0);
	SIGNAL DAV_s: std_logic;
    SIGNAL RESET_s: std_logic;

-- Outputs
	SIGNAL Wreg_s : std_logic;
    SIGNAL Q_s: std_logic_vector(3 downto 0);
	SIGNAL DAC_s: std_logic;

-- Clock generation
    SIGNAL CLK_s : std_logic := '0';
    CONSTANT PERIOD : TIME := 10 ns;


BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Ring_Buffer PORT MAP (
		CLK => CLK_s,
		CTS => CTS_s,
        D => D_s,
		DAV => DAV_s,
		RESET => RESET_s,
		Wreg => Wreg_s,
		Q => Q_s,
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
        reset_s <= '1';

        wait for 40 ns;
		
		reset_s <= '0';
        CTS_s <= '0';
        D_s <= "1010";
        CTS_s <= '0';
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        D_s <= "0101";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        D_s <= "1000";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        D_s <= "0001";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;


        D_s <= "1001";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        D_s <= "0101";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;


        D_s <= "0010";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        D_s <= "0100";
        DAV_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;

        DAV_s <= '1';
        CTS_s <= '1';
        wait for 40 ns;
        DAV_s <= '0';
        wait for 40 ns;
        wait for 40 ns;





	wait;
end process;
end architecture;