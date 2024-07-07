LIBRARY IEEE;
use IEEE.std_logic_1164.all;


entity MUX_3BITS is
port(A : in STD_LOGIC_vector(2 downto 0);
	B : in std_logic_vector(2 downto 0);
	S : in std_logic;
	O : out STD_LOGIC_vector(2 downto 0)
	);
end MUX_3BITS;


architecture arq_mux of MUX_3BITS is
begin
	O(0) <= (A(0) and S) or (B(0) and not S);
	O(1) <= (A(1) and S) or (B(1) and not S);
	O(2) <= (A(2) and S) or (B(2) and not S);
	
end arq_mux;

-- Código feito ao som de:
-- Secret Flavour Gumball by Terminal