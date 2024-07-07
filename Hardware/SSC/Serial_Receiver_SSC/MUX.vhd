LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade MUX que define a interface do multiplexador
entity MUX is
    port(
        A : in std_logic;  -- Entrada A
        B : in std_logic;  -- Entrada B
        S : in std_logic;  -- Seleção
        O : out std_logic  -- Saída
    );
end MUX;

architecture arq_mux of MUX is
begin
    -- Atribuição da saída O com base na seleção S
    O <= (A and not S) or (B and S);

end arq_mux;

-- Código feito ao som de:
-- Softly by Clairo
