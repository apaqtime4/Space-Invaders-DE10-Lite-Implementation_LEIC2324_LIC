library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade ShiftRegister7 que define a interface do registrador de deslocamento
entity ShiftRegister7 is
    Port (
        data    : in std_logic; -- Entrada do dado
        clk     : in std_logic; -- Entrada do clock
        enable  : in std_logic; -- Entrada do bit enable
        Dataout : out std_logic_vector(6 downto 0) -- Saída dos dados do shift register 
    );
end ShiftRegister7;

architecture Behavioral of ShiftRegister7 is

    -- Declaração dos sinais internos (neste caso 1)
    signal shift_reg : std_logic_vector(6 downto 0);
begin

    -- Processo do clock
    process(clk)
    begin
        -- Se o enable estiver ativo e houver uma subida no clock
        if enable = '1' and rising_edge(clk) then
            -- Desloca o conteúdo do shift register para a direita e insere o novo dado no bit mais significativo
            shift_reg <= data & shift_reg(6 downto 1);
        end if;
    end process;

    -- A saída do shift register é conectada ao sinal interno shift_reg
    Dataout <= shift_reg;

end Behavioral;

-- Código feito ao som de:
-- Expresso by Sabrina Carpenter
