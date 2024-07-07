library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade comparador que verificar as flags
entity comparador_LCD is
port (
    counter_result : in std_logic_vector(3 downto 0);
    d_flag : out std_logic;
    p_flag : out std_logic
) ;
end comparador_LCD;

-- o 9 é data
-- o 10 é pflag


architecture comparador_arch of comparador_LCD is



begin

process(counter_result)
begin
    if counter_result = "1001" then
        d_flag <= '1';
    elsif counter_result /= "1001" then
        d_flag <= '0';
    end if;

    if counter_result = "1010" then
        p_flag <= '1';
    elsif counter_result /= "1010" then
        p_flag <= '0';
    end if;
end process;


end comparador_arch ; -- comparador_arch