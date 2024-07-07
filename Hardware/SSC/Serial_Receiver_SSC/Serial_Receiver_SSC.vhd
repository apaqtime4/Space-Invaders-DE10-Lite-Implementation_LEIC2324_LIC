LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade Serial_Receiver_SSC que define a interface do receptor serial
entity Serial_Receiver_SSC is 
    port(
        SDX      : in std_logic; -- Entrada do dado serial
        SCLK     : in std_logic; -- Entrada do clock principal
        Mclk     : in std_logic; -- Entrada do clock secundário
        SS       : in std_logic; -- Entrada do bit enable
        ACCEPT   : in std_logic; -- Sinal do bit de aceitação
        DXval    : out std_logic; -- Saída do bit de validação
        Final    : out std_logic_vector(6 downto 0) -- Saída dos dados finais recebidos
    );
end entity Serial_Receiver_SSC;

architecture Serial_Receiver_arch of Serial_Receiver_SSC is

    -- Componente contador que conta de forma crescente
    component counterUP 
        port(
            CE     : in std_logic; -- Entrada do bit de enable
            Reset  : in std_logic; -- Entrada do reset
            CLK    : in std_logic; -- Entradado clock
            Final  : out std_logic_vector(3 downto 0) -- Saída do contador
        );
    end component;

    -- Componente de controle serial
    component Serial_Control
        port(   
            clk, e_RX, accept, dFlag, pFlag, RXerror : in std_logic;
            wr, init, DXval                          : out std_logic
        );
    end component;

    -- Componente shift regiser de deslocamento de 7 bits
    component ShiftRegister7 
        port (
            data    : in std_logic; -- Entrada do dado
            clk     : in std_logic; -- Entrada do clock
            enable  : in std_logic; -- Entrada do bit enable
            Dataout : out std_logic_vector(6 downto 0) -- Saída dos dados do registrador
        );
    end component;

    -- Componente de verificação de paridade
    component Parity_Check 
        port (
            clk          : in std_logic; -- Entrada do clock
            init         : in std_logic; -- Entrada do bit de inicialização 
            bit_in       : in std_logic; -- Entrada do bit de paridade
            parity_check : out std_logic -- Saída de verificação de paridade
        );
    end component;	 	 

    -- Componente comparador
    component comparador_SSC
        port (
            counter_result : in std_logic_vector(3 downto 0); -- Entrada do resultado do contador
            d_flag         : out std_logic;                   -- Saída da Flag de dado
            p_flag         : out std_logic                    -- Saída da Flag de paridade
        );
    end component;

    -- Declaração dos sinais internos
    signal dFLAG_s, pFLAG_s, RXerror_s, wr_s, init_s : std_logic;
    signal CounterResult : std_logic_vector(3 downto 0);

begin

    -- Instância do componente Serial_Control
    USerialControl : Serial_Control
        port map(
            e_RX   => SS,
            accept => ACCEPT,
            clk    => MCLK,
            pFlag  => pFLAG_s,
            dFlag  => dFLAG_s,
            RXerror=> RXerror_s,
            wr     => wr_s,
            init   => init_s,
            DXval  => DXval
        );			

    -- Instância do componente Parity_Check
    UParity : Parity_Check
        port map(
            clk           => SCLK,
            init          => init_s,
            bit_in        => SDX,
            parity_check  => RXerror_s
        );

    -- Instância do componente counterUP
    UCounterSLCDC: counterUP 
        port map(
            CE     => '1',
            Reset  => init_s,
            CLK    => SCLK,
            Final  => CounterResult
        );

    -- Instância do componente ShiftRegister7
    UShiftregister7 : ShiftRegister7
        port map(
            data    => SDX,
            clk     => SCLK,
            enable  => wr_s,
            Dataout => Final
        );		

    -- Instância do componente comparador_SSC
    UComparador_SSC : comparador_SSC 
        port map(
            counter_result => CounterResult, 
            d_flag         => dFLAG_s,
            p_flag         => pFLAG_s
        );

end Serial_Receiver_arch;

-- Código feito ao som de:
-- Money Trees by Kendrick Lamar
