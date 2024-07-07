library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Para usar tipos inteiros de forma mais robusta

-- Entidade Score_Dispatcher que define a interface de pontuação no hardware
entity Score_Dispatcher is
    port(
        Din: in std_logic_vector(6 downto 0);  -- Entrada dos dados
        Dval: in std_logic; -- Entrada do bit de validação de dados
        clk: in std_logic; -- Entrada do clock
        WrL: out std_logic; -- Saída do bit de escrita
        done: out std_logic; -- Saída do bit de conclusão
        Dout: out std_logic_vector(6 downto 0) -- Saída de dados
    );
end Score_Dispatcher;

architecture behavioral of Score_Dispatcher is

    -- Definição dos estados possíveis
    type STATE_TYPE is (STATE_WAITING, STATE_ENABLE, STATE_DONE);
    signal CurrentState, NextState : STATE_TYPE;

begin

    -- Transição de estado com o clock
    process(clk)
    begin
        if rising_edge(clk) then
            CurrentState <= NextState;
        end if;
    end process;

    -- Processo de controle de estado
    process (CurrentState, Dval, Din)
    begin
        case CurrentState is
            when STATE_WAITING =>
                if Dval = '1' then
                    NextState <= STATE_ENABLE;
                else
                    NextState <= STATE_WAITING;
                end if;
                     
            when STATE_ENABLE =>
                NextState <= STATE_DONE;

            when STATE_DONE =>
                if Dval = '0' then
                    NextState <= STATE_WAITING;
                else
                    NextState <= STATE_DONE;
                end if;
        end case;
    end process;

    -- Atribuições de saída
    Dout <= Din;  -- Atribui a entrada de dados para a saída de dados
    WrL <= '0' when (CurrentState = STATE_WAITING or CurrentState = STATE_DONE) else '1';  -- Define o sinal de escrita/ativação
    done <= '1' when (CurrentState = STATE_DONE) else '0';  -- Define o sinal de conclusão

end behavioral;  -- Fim da arquitetura behavioral

-- Código feito ao som de:
-- Softly by Clairo
