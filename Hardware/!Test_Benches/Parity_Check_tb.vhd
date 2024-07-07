library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity parity_check_tb is
    -- Testbench não tem portas
end parity_check_tb;

architecture Behavioral of parity_check_tb is



    -- Constante para o período do clock
    constant clk_period : time := 10 ns;

    -- Componente a ser testado
    component parity_check
    Port (
        clk : in std_logic;
        init : in std_logic;
        bit_in : in std_logic;
        parity_check : out std_logic
    );
    end component;

        -- Sinais para conectar com a UUT (Unidade Sob Teste)
        signal data : std_logic;
        signal init : std_logic;
        signal clk  : std_logic;
        signal err  : std_logic;

begin

    -- Instanciando a UUT
    uut: parity_check
        Port map (
            bit_in => data,
            init => init,
            clk  => clk,
            parity_check  => err
        );

    -- Gerador de clock
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Estímulos de entrada
    stim_proc: process
    begin	
        -- Primeiro caso
        init <= '1';
        wait for clk_period;
        init <= '0';
        data <= '1';
        wait for clk_period*9;
        data <= '0';
        wait for clk_period;
        init <= '1';
        wait for clk_period;
        data <= '0';
        wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		wait for clk_period;
		data <= '1';
		wait for clk_period;
		data <= '1';
		wait for clk_period;

        -- Reiniciando a paridade
        init <= '1';
        wait for clk_period;
        init <= '0';

        -- Finaliza a simulação
        wait for 20 * clk_period;
    end process;

end Behavioral;
 