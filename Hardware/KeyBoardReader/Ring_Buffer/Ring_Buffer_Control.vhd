library IEEE;
use IEEE.std_logic_1164.all;


entity Ring_Buffer_Control is
    port(
    Reset, clk, DAV, CTS, full, empty: in std_logic;
    Wr, selPG, Wreg, DAC, incPut, incGet: out std_logic
);
end Ring_Buffer_Control;

architecture Ring_Buffer_Control_arch of Ring_Buffer_Control is 

type STATE_TYPE is (STATE_STANDINGBY, STATE_WRITINGDATA, STATE_DATAWROTE1, STATE_DATAWROTE2, STATE_DATAACCEPTED, STATE_DATAREAD, STATE_INCGET);

signal CurrentState, NextState : STATE_TYPE;

begin

-- Flip-Flop's
CurrentState <= STATE_STANDINGBY when Reset = '1' else NextState when rising_edge(clk);

-- Generate Next State
GenerateNextState:
process (CurrentState, DAV, CTS, full, empty)
    begin
        case CurrentState is
            when STATE_STANDINGBY => if (DAV = '1' and full = '0') then NextState <= STATE_WRITINGDATA;
                                        elsif (empty = '0' and CTS = '1') then NextState <= STATE_DATAREAD;
                                            else NextState <= STATE_STANDINGBY;
                                                end if;

            when STATE_WRITINGDATA => NextState <= STATE_DATAWROTE1;

            when STATE_DATAWROTE1 => NextState <= STATE_DATAWROTE2;

            when STATE_DATAWROTE2 => NextState <= STATE_DATAACCEPTED;

            when STATE_DATAACCEPTED => if (DAV = '0') then NextState <= STATE_STANDINGBY;
                                        else NextState <= STATE_DATAACCEPTED;
                                            end if;

            when STATE_DATAREAD => if (CTS = '0') then NextState <= STATE_INCGET;
                                   else NextState <= STATE_DATAREAD;
                                            end if;
            when STATE_INCGET => NextState <= STATE_STANDINGBY;
    end case;
end process;

Wr <= '1' when (CurrentState = STATE_DATAWROTE1) else '0';
selPG <= '1' when (CurrentState = STATE_WRITINGDATA or CurrentState = STATE_DATAWROTE1 or currentState = STATE_DATAWROTE2) else '0';
Wreg <= '1' when (CurrentState = STATE_DATAREAD) else '0';
DAC <= '1' when (CurrentState = STATE_DATAACCEPTED) else '0';
incPut <= '1' when (CurrentState = STATE_DATAWROTE2) else '0';
incGet <= '1' when (CurrentState = STATE_INCGET) else '0';

end Ring_Buffer_Control_arch;
