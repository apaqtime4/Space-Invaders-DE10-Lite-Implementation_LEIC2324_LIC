library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- para usar tipos inteiros de forma mais robusta

entity LCD_Dispatcher is
    port(
        Din: in std_logic_vector(8 downto 0);
        Dval: in std_logic; 
        clk: in std_logic; 
        WrL: out std_logic; 
        done: out std_logic;
        Dout: out std_logic_vector(8 downto 0)
    );
end LCD_Dispatcher;

architecture behavioral of LCD_Dispatcher is

    type STATE_TYPE is (STATE_WAITING,STATE_WAITING1, STATE_WAITING2, STATE_WAITING3, STATE_WAITING4, STATE_WAITING5, STATE_WAITING6, STATE_WAITING7, STATE_WAITING8, STATE_WAITING9, STATE_WAITING10, STATE_WAITING11, STATE_ENABLE, STATE_DONE);

    signal CurrentState, NextState : STATE_TYPE;

begin

CurrentState <= NextState when rising_edge (clk);

    process (CurrentState, Dval, Din)
    begin
        case CurrentState is
            when STATE_WAITING =>
                if Dval = '1' then
                    NextState <= STATE_Enable;
                else
                    NextState <= STATE_WAITING;
                end if;
                

            when STATE_ENABLE => NextState <= STATE_WAITING1;
					 
             when STATE_WAITING1 =>
                NextState <= STATE_WAITING2;
					 
				 when STATE_WAITING2 =>
                NextState <= STATE_WAITING3;
					 
				 when STATE_WAITING3 =>
                NextState <= STATE_WAITING4;
					 
		   	 when STATE_WAITING4 =>
                NextState <= STATE_WAITING5;
					 
				 when STATE_WAITING5 =>
                NextState <= STATE_WAITING6;

		   	when STATE_WAITING6 =>
                NextState <= STATE_WAITING7;
					 
					 when STATE_WAITING7 =>
                NextState <= STATE_WAITING8;
					 
					 when STATE_WAITING8 =>
                NextState <= STATE_WAITING9;
					 
					 when STATE_WAITING9 =>
                NextState <= STATE_WAITING10;

					 when STATE_WAITING10 =>
                NextState <= STATE_WAITING11;
					 
					 when STATE_WAITING11 =>
                NextState <= State_Done;
					 

            when STATE_DONE =>
                if Dval = '0' then
                    NextState <= STATE_WAITING;
                else
                    NextState <= STATE_DONE;
                end if;
        end case;
    end process;

    Dout <= Din;
    WrL <= '0' when (CurrentState = STATE_WAITING or CurrentState = STATE_DONE) else '1';
    done <= '1' when (CurrentState = STATE_DONE) else '0';

end behavioral;