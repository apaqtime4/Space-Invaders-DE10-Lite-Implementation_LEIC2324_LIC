LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade MUX4. Irá funcionar de modo a interpretar as linhas do keyboard
entity MUX4 is
port(A : in STD_LOGIC_VECTOR(3 downto 0);
	S : in std_logic_vector(1 downto 0);
	O : out STD_LOGIC
	);
end MUX4;


architecture arq_mux4 of mux4 is
begin
	O <= not((not S(1) and not S(0) and A(0)) or (not S(1)  and S(0) and A(1)) or (S(1) and not S(0) and A(2)) or (S(1) and S(0) and A(3)));
	
end arq_mux4;

-- Código feito ao som de:
-- Redbone by Childish Gambino