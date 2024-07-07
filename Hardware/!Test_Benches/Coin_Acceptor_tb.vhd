LIBRARY IEEE;
use IEEE.std_logic_1164.all; 

entity Coin_Acceptor_tb is
end Coin_Acceptor_tb;

architecture Coin_Acceptor_tb_arch of Coin_Acceptor_tb is

    component Coin_Acceptor is
        port (
            Insert_Coin     :   in std_logic;
			accept 			:   in std_logic;
			Coin_Inserted   :   out std_logic
        );
    end component;


    signal S_Insert_Coin   : std_logic;
	signal accept_s		   : std_logic;
    signal S_Coin_Inserted : std_logic;

begin

    uut: Coin_Acceptor port map(
        Insert_Coin     => S_Insert_Coin,
		accept			=> accept_s,
        Coin_Inserted   => S_Coin_Inserted
    );

    -- Processo de estímulo
    stim_proc: process
    begin
        --Primeiro caso

        S_Insert_Coin <= '0';

        wait for 40 ns;
        
        S_Insert_Coin <= '1';

        wait for 40 ns;
		  
		  accept_s <= '1';

		  wait for 40 ns;
		  
		  accept_s <= '0';
		  
		  wait for 40 ns;
		  
		  --Segundo caso (teste de falha)
        
        S_Insert_Coin <= '0';

        wait for 40 ns;
        
        S_Insert_Coin <= '1';

        wait for 40 ns;
        
        S_Insert_Coin <= '0';

        wait for 40 ns;
		  
		  accept_s <= '1';
		  
		  wait for 40 ns;
		  
		  accept_s <= '0';

        wait;
    end process;

end Coin_Acceptor_tb_arch ; -- Coin_Acceptor_tb_arch

