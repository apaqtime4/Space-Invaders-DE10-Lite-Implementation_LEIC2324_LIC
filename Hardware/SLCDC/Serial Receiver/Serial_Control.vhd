library ieee;
use ieee.std_logic_1164.all;

entity Serial_Control is
    port(
        clk : in std_logic; -- Entrada no clk
	e_RX : in std_logic; -- Entrada do bit enable
	accept : in std_logic; -- Entrada do bit de aceitação
 	dFlag : in std_logic; -- Entrada da flag de dados
	pFlag : in std_logic; -- Entrada da flag de paridade
	RXerror : in std_logic; -- Entrada do bit que avisa se há erro
        wr : out std_logic; -- Saída do bit de escrita
	init : out std_logic; -- Saída do bit init (enable)
	DXval: out std_logic  -- Saída do bit de validadeção de dados
    );
end Serial_Control;

architecture behavioral of Serial_Control is

    -- Definição dos estados
    type STATE_TYPE is (STATE_INIT, STATE_WRITING, STATE_ERRORCHECK, STATE_WAITINGACCEPT);

    -- Sinais para armazenar os estados atuais e próximos
    signal CurrentState, NextState: STATE_TYPE;

begin

    -- Transição de estado com flip-flop
    CurrentState <= NextState when rising_edge(clk);

    -- Geração do próximo estado
    process(CurrentState, e_RX, accept, dFlag, pFlag, RXerror)
    begin
        case CurrentState is
            when STATE_INIT =>
                if e_RX = '0' and accept = '0' then
                    NextState <= STATE_WRITING;
                else
                    NextState <= STATE_INIT;
                end if;
            
            when STATE_WRITING =>
                if dFlag = '1' then
                    NextState <= STATE_ERRORCHECK;
                elsif e_RX = '0' then
                    NextState <= STATE_WRITING;
                else
                    NextState <= STATE_INIT;
                end if;
            
            when STATE_ERRORCHECK =>
                if e_RX = '1' then
                    if pFlag = '1' then
                        if RXerror = '0' then
                            NextState <= STATE_WAITINGACCEPT;
                        else
                            NextState <= STATE_INIT;
                        end if;
                    else
                        NextState <= STATE_INIT;
                    end if;
                else
                    NextState <= STATE_ERRORCHECK;
                end if;
            
            when STATE_WAITINGACCEPT =>
                if accept = '1' then
                    NextState <= STATE_INIT;
                else
                    NextState <= STATE_WAITINGACCEPT;
                end if;
        end case;
    end process;

    -- Saídas dependendo do estado atual
    wr <= '1' when (CurrentState = STATE_WRITING) else '0';
    init <= '1' when (CurrentState = STATE_INIT) else '0';
    DXval <= '1' when (CurrentState = STATE_WAITINGACCEPT) else '0';

end behavioral;
