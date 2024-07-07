library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade Parity_Check que define a interface do verificador de paridade
entity Parity_Check is
    Port (
        clk           : in std_logic; -- Entrada do clock
        init          : in std_logic; -- Entrada do bit de inicialização
        bit_in        : in std_logic; -- Entrada do bit a ser verificado
        parity_check  : out std_logic -- Saída que indica se a paridade está correta
    );
end Parity_Check;

architecture Behavioral of Parity_Check is
    signal bit_sum : std_logic;           -- Sinal para somar os bits
begin

    process (clk, init)
    begin
        -- Inicialização dos sinais
        if init = '1' then
            bit_sum <= '0';
            parity_check <= '0';
        
        -- Verificação da subida do clock
        elsif rising_edge(clk) then 
            -- Soma o bit atual com o bit anterior usando operação XOR
            bit_sum <= bit_sum xor bit_in;
            
            -- Atualiza o sinal parity_check com base no valor de bit_sum
            if bit_sum = bit_in then
                parity_check <= '0';
            else
                parity_check <= '1';
            end if;
        end if;
    end process;

end Behavioral;

-- Código feito ao som de:
-- Expresso by Sabrina Carpenter
