LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Key_Control IS
PORT(	CLK : in std_logic;
		RESET :in std_logic;
		Kpress : in std_logic;
		Kack : in std_logic;
		Kval : out std_logic;
		Kscan : out std_logic
		);
END Key_Control;

architecture behavioral of Key_Control is


type STATE_TYPE is (STANDING_BY, READING_DATA, DATA_ACCEPTED);

signal CurrentState, NextState : STATE_TYPE;

begin 

CurrentState <= STANDING_BY when RESET = '1' else NextState when rising_edge(CLK);

GenerateNextState:
process (CurrentState, Kpress, Kack)
    begin 
        case CurrentState is 
            when STANDING_BY         => if (Kpress = '1') then 
                                                NextState <= READING_DATA;
                                            else
                                                NextState <= STANDING_BY;
                                            end if;

            when READING_DATA    => if (Kack = '1') then
                                                NextState <= DATA_ACCEPTED;
                                            else 
                                                NextState <= READING_DATA;
                                            end if;

            when DATA_ACCEPTED   => if (Kack = '0' and Kpress = '0') then
                                                NextState <= STANDING_BY;
                                            else 
                                                NextState <= DATA_ACCEPTED;
                                            end if;

        end case;
    end process;


Kscan <= '1' when (CurrentState = STANDING_BY) else '0';

Kval <= '1' when (CurrentState = READING_DATA) else '0';

end behavioral;