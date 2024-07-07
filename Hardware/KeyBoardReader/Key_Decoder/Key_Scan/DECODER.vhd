library IEEE;
use IEEE.std_logic_1164.all;

-- Entidade DECODER. Irá funcionar de modo a ler as colunas do keyboard
entity DECODER is
    Port (
        OPin : in std_logic_vector(1 downto 0);
        OPout : out std_logic_vector(3 downto 0)
    );
end DECODER;

architecture arch_decoder of DECODER is
begin
    OPout(0) <= (not OPin(1) and not OPin(0));
    OPout(1) <= (not OPin(1) and OPin(0));
    OPout(2) <= (OPin(1) and not OPin(0));
    OPout(3) <= (OPin(1) and OPin(0));

end arch_decoder;


-- Código feito ao som de:
-- Apocalypse by Cigarettes After Sex