library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade comparador_SSC que define a interface do comparador
entity comparador_SSC is
    port (
        counter_result : in std_logic_vector(3 downto 0);  -- Entrada do bit do resultado do contador
        d_flag         : out std_logic; -- Saída da flag de dados
        p_flag         : out std_logic -- Saída da flag de paridade
    );
end comparador_SSC;

architecture comparador_SSC_arch of comparador_SSC is
begin
    -- Processo sensível à mudança de counter_result
    process(counter_result)
    begin
        -- Se o valor de counter_result for "0111" (7), a d_flag vai a '1'
        if counter_result = "0111" then
            d_flag <= '1';
        -- Caso contrário, a d_flag vai a '0'
        elsif counter_result /= "0111" then
            d_flag <= '0';
        end if;

        -- Se o valor de counter_result for "1000" (8), a p_flag vai a '1'
        if counter_result = "1000" then
            p_flag <= '1';
        -- Caso contrário, a p_flag vai a '0'
        elsif counter_result /= "1000" then
            p_flag <= '0';
        end if;
    end process;
end comparador_SSC_arch;  -- Fim da arquitetura comparador_SSC_arch

-- Código feito ao som de:
-- Softly by Clairo
