library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity MAC is
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
end MAC;

architecture MAC_arch of MAC is

component CounterUp3bits
    port(
        CE: in std_logic;
        Reset: in std_logic;
        CLK: in std_logic;
        Final: out std_logic_vector(2 downto 0)
    );
end component;

component FFD
    PORT( 
        CLK : in std_logic;
        RESET : in STD_LOGIC;
        SET : in std_logic;
        D : IN STD_LOGIC;
        EN : IN STD_LOGIC;
        Q : out std_logic
    );
end component;

component MUX_3BITS
port(
        A : in STD_LOGIC_vector(2 downto 0);
        B : in std_logic_vector(2 downto 0);
        S : in std_logic;
        O : out STD_LOGIC_vector(2 downto 0)
	);
end component;

signal read_pointer_Signal, write_pointer_Signal : std_logic_vector(2 downto 0);	-- Valores dos pointers
signal Stored_putget : std_logic;													-- Store da ultima ação feita
signal equal : std_logic;
signal en : std_logic;															-- Ativa quando os pointers são iguais

begin
    
	equal <= (read_pointer_Signal(2) xnor write_pointer_Signal(2)) and (read_pointer_Signal(1) xnor write_pointer_Signal(1)) and (read_pointer_Signal(0) xnor write_pointer_Signal(0));
	en <= incput or incget;
	
    full <= Stored_putget and equal;
    empty <= not Stored_putget and equal;
	
    read_pointer_counter: COUNTERUP3bits port map(
        CE => incget,
        Reset => reset,
        CLK => clk,
        Final => read_pointer_Signal
    );

    write_pointer_counter: COUNTERUP3bits port map(
        CE => incput,
        Reset => reset,
        CLK => clk,
        Final => write_pointer_Signal
    );

    put_get: MUX_3bits port map(
        A => write_pointer_Signal,
        B => read_pointer_Signal,
        S => putget,
        O => Address
    );

    last_action_recorder: FFD port map(
        CLK =>  clk,
        reset => reset,
        set => '0',
        D => putget,
        EN => en,
        Q => Stored_putget
    );

	
end MAC_arch ; -- MAC_arch


-- Código feito a ouvir:
-- Hypnotyze by The Notorious B.I.G.