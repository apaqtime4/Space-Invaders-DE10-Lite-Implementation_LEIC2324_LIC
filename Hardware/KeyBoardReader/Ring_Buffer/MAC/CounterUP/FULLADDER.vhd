LIBRARY IEEE;
use IEEE.std_logic_1164.all;
entity FULLADDER is
PORT ( A: in std_logic;
B: in std_logic;
Cin: in std_logic;
R: out std_logic;
Cout: out std_logic);
end FULLADDER;
architecture LOGICFULLADDER of FULLADDER is
begin
R <= A xor B xor Cin;
Cout <= (A and B) or ((A xor B) and Cin);
end LOGICFULLADDER;


-- Código feito ao som de:
-- Static by Steve Lacy