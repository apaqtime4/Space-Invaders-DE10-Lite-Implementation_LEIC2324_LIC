LIBRARY IEEE;
use IEEE.std_logic_1164.all;


entity Key_Scan is
port(	
		Kscan : in STD_LOGIC;
		Multiplexer_In : in STD_LOGIC_VECTOR(3 downto 0);
		CLK : in STD_LOGIC;
		Reset : in std_LOGIC;
		Decoder_Out : out std_logic_vector(3 downto 0);
		Kout : out STD_LOGIC_VECTOR(3 downto 0);
		Kpress : out std_logic
		);
end Key_Scan;

architecture Key_Scan_arq of Key_Scan is

component MUX4
port(A : in STD_LOGIC_VECTOR(3 downto 0);
	S : in std_logic_vector(1 downto 0);
	O : out STD_LOGIC
	);
end component;

component CounterUp
    port(
            CE: in std_logic;
            Reset: in std_logic;
            CLK: in std_logic;
            Final: out std_logic_vector(3 downto 0)
    );
end component;


component DECODER
    Port (
        OPin : in std_logic_vector(1 downto 0);
        OPout : out std_logic_vector(3 downto 0)
    );
end component;

signal K03 : std_logic_vector(3 downto 0);
signal clk_divider : std_logic;
signal OPout_S : std_logic_vector(3 downto 0);
begin


Decoder_Out <= not OPout_S;


    Multiplexer: MUX4 port map(
        A => Multiplexer_In,
        S(0) => K03(0),
        S(1) => K03(1),
        O => Kpress
    );


    UCounter: CounterUp port map(
        CE => Kscan,
        Reset => Reset,
        CLK => CLK,
        Final(3) => K03(3), --DEC_Selector(1),
    	Final(2) => K03(2), --DEC_Selector(0),
    	Final(1) => K03(1), --MUX_Selector(1),
    	Final(0) => K03(0)  --MUX_Selector(0)
    );

    Dec: Decoder port map(
        OPin(0) => K03(2),
        OPin(1) => K03(3),
        OPout => OPout_S
    );
	 

Kout <= k03;

end Key_Scan_arq;

-- Código feito ao som de:
-- Sway by Michael Bublé