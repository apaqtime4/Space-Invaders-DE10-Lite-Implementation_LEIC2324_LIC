library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade ShiftRegister9 que define a interface do componente
entity ShiftRegister9 is
    Port (
        data        : in std_logic; -- Entrada de dado serial
        clk         : in std_logic; -- Entrada do Clock 
        enableShift : in std_logic; -- Entrada do enable
        D           : out std_logic_vector(8 downto 0) -- Saída dos dados do shift register
    );
end ShiftRegister9;

architecture Behavioral of ShiftRegister9 is

    -- Sinal interno para armazenar o valor do registrador de deslocamento
    signal shift_reg : std_logic_vector(8 downto 0);

begin

    -- Processo sensível ao clock
    process(clk)
    begin
        -- Verifica a subida do clock e se o enable está ativo
        if enableShift = '1' and rising_edge(clk) then
            -- Desloca o registo à direita e insere o novo bit à esquerda
            shift_reg <= data & shift_reg(8 downto 1);
        end if;
    end process;

    -- Atribui o valor do shift register à saída D
    D <= shift_reg;

end Behavioral;
