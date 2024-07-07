library IEEE;
use IEEE.std_logic_1164.all;

	
entity Ring_Buffer is
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
end Ring_Buffer;

architecture Ring_Buffer_arch of Ring_Buffer is 

component Ring_Buffer_Control
    Port (
		Reset, clk, DAV, CTS, full, empty: in std_logic;
		Wr, selPG, Wreg, DAC, incPut, incGet: out std_logic
    );
end component;

component MAC
    Port (
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

component RAM
generic(
		ADDRESS_WIDTH : natural := 3;
		DATA_WIDTH : natural := 4
	);
	Port (
		address : in std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
		wr: in std_logic;
		din: in std_logic_vector(DATA_WIDTH - 1 downto 0);
		dout: out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end component;

-- Input Signals
SIGNAL full_s, empty_s : std_logic;

-- Output Signals
SIGNAL Wr_s, selPG_s, incPut_s, incGet_s : std_logic;
SIGNAL address_s : std_logic_vector(2 downto 0);
	
	begin
	
	URBC : Ring_Buffer_Control port map(
		clk => CLK,
		Reset => RESET,
		CTS => CTS,
      DAV => DAV,
		full => full_s,
		empty => empty_s,
		Wreg => Wreg,
		Wr => Wr_s,
		selPG => selPG_s,
		incPut => incPut_s,
		incGet => incGet_s,
		DAC => DAC
	);
	
	UMAC : MAC port map(
		clk => CLK,
      reset => RESET,
      putget => selPG_s,
		incget => incGet_s,
		incput => incPut_s,
		full => full_s,
		empty => empty_s,
      address => address_s
	);
	
	UR : RAM port map(
		
		address => address_s,
		wr => Wr_s,
		din => D,
		dout => Q
		
	);

end Ring_Buffer_arch;

-- Código feito ao som de:
-- Maracujá by MC Gomes