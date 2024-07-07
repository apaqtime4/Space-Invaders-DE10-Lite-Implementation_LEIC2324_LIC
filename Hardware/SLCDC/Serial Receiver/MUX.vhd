LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade MUX
entity MUX is
port(A : in STD_LOGIC;
	B : in std_logic;
	S : in std_logic;
	O : out STD_LOGIC
	);
end MUX;


architecture arq_mux of MUX is
begin
	O <= (A and not S) or (B and S);
	
end arq_mux;

-- Código feito ao som de:
-- Coconut Mall by Nitendo