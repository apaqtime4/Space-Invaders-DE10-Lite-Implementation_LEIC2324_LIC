LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity counterUP3bits is 
    port(
        CE: in std_logic;
        Reset: in std_logic;
        CLK: in std_logic;
        Final: out std_logic_vector(2 downto 0)
    );
end entity;

architecture counterUP_arch of counterUP3bits is
    
    component regis3bits
    PORT( 
        CLK : in std_logic;
        RESET : in STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(2 downto 0);
        EN : IN STD_LOGIC;
        Q : out std_logic_VECTOR(2 downto 0)
    );
    end component;

    component Adder3bits
	port ( A: in std_logic_vector(2 downto 0);
	B: in std_logic_vector(2 downto 0);
	C0 : in std_logic;
	S: out std_logic_vector(2 downto 0);
	C3: out std_logic);
    end component;
	
    signal REGOUT, Regin:std_logic_vector(2 downto 0);

begin 

    Final<=regout;

    Uregis: regis3bits port map (
    Clk=>clk,
    RESET=>reset,
    EN=>CE,
    D=>Regin,
    Q=>REGOUT
    );

    USUM: adder3bits port map (
		A => REGOUT,	--Valor inicial
		B => "001",	--Add de 1
		C0 => '0',		--Carryin
		S => RegIN,	    --Resultado
		C3 => open		--Carry out
	);



end counterUP_arch;


-- Código feito ao som de:
-- Somewhere Only We Know by Keane