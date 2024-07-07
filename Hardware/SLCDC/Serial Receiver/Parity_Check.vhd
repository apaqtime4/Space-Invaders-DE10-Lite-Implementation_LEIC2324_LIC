library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade Parity_Check que verifica o bit paridade
entity Parity_Check is
    Port (
        clk : in std_logic; -- Entrada do Clock
        init : in std_logic; -- Entrada do bit enable
        bit_in : in std_logic; --
        parity_check : out std_logic
    );
end Parity_Check;

architecture Behavioral of Parity_Check is

-- Declaração de sinais
    signal bit_sum : std_logic;
begin

    process (clk, init)
    begin
        if init = '1' then
            bit_sum <= '0';
            parity_check <= '0';
        elsif rising_edge(clk) then 
            -- Acumula a soma dos bits usando operação XOR
            bit_sum <= bit_sum xor bit_in;

            -- Verifica a paridade acumulada
            if bit_sum = bit_in then
                parity_check <= '0';
            else
                parity_check <= '1';
            end if;
        end if;
    end process;

end Behavioral;
