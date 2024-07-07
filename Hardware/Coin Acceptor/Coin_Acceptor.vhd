LIBRARY IEEE;
use IEEE.std_logic_1164.all; 

-- Declaração da entidade Coin_Acceptor
entity Coin_Acceptor is
    port (
        CLK            : in std_logic; -- Entrada do clock
        Insert_Coin    : in std_logic; -- "Entrada" da moeda
        accept         : in std_logic; -- Entrada do bit de aceitação da moeda
        Coin_Inserted  : out std_logic -- Saída que indica que a moeda foi inserida e aceita
    );
end Coin_Acceptor;

architecture Coin_Acceptor_arch of Coin_Acceptor is

    -- Definição dos estados possíveis
    type STATE_TYPE is (STANDING_BY, WAITING_ACCEPT, DATA_ACCEPTED);
    signal CurrentState, NextState : STATE_TYPE;

begin 

    -- Processo para atualizar o estado atual com o próximo estado no rising edge do clock
    CurrentState <=  NextState when rising_edge(CLK);

    -- Processo para determinar o próximo estado com base no estado atual e nos sinais de entrada
    
Coin_Inserted <= Insert_Coin when accept = '0' else '0' when accept = '1';


end Coin_Acceptor_arch;
