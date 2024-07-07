LIBRARY IEEE;
use IEEE.std_logic_1164.all;


entity Serial_Receiver_SLCDC is 
    port(
        SDX: in std_logic; -- Entrada de dado em série
        Mclk: in std_logic; -- Entrada do Clock Secundário
        SCLK: in std_logic; -- Entrada do Clock Principal
        SS: in std_logic; -- Entrada do bit de seleção
        ACCEPT: in std_logic; -- Entrada do bit do sinal de aceitação
        DXval: out std_logic; -- Saída do bit de validação de dados
        Final: out std_logic_vector(8 downto 0) -- Saída dos dados
    );
end Serial_Receiver_SLCDC;

architecture Serial_Receiver_arch of Serial_Receiver_SLCDC is

    -- Declaração dos componentes utilizados no projeto

    component counterUP 
        port(
            CE: in std_logic;
            Reset: in std_logic;
            CLK: in std_logic;
            Final: out std_logic_vector(3 downto 0)
        );
    end component;

    component Serial_Control
        port(
            clk: in std_logic;
            e_RX: in std_logic;
            accept: in std_logic;
            dFlag: in std_logic;
            pFlag: in std_logic;
            RXerror: in std_logic;
            wr: out std_logic;
            init: out std_logic;
            DXval: out std_logic
        );
    end component;

    component ShiftRegister9 
        port (
            data: in std_logic;
            clk: in std_logic;
            enableShift: in std_logic;
            D: out std_logic_vector(8 downto 0)
        );
    end component;

    component Parity_Check 
        port (
            clk: in std_logic;
            init: in std_logic;
            bit_in: in std_logic;
            parity_check: out std_logic
        );
    end component;

    component comparador_LCD
        port (
            counter_result: in std_logic_vector(3 downto 0);
            d_flag: out std_logic;
            p_flag: out std_logic
        );
    end component;

    -- Sinais internos
    signal dFLAG_s, pFLAG_s, RXerror_s, wr_s, init_s: std_logic;
    signal CounterResult: std_logic_vector(3 downto 0);

begin

    -- Instância do componente comparador_LCD
    UComparador_LCD: comparador_LCD
        port map(
            counter_result => CounterResult, 
            d_flag => dFLAG_s,
            p_flag => pFLAG_s
        );

    -- Instância do componente Serial_Control
    USerialControl: Serial_Control
        port map(
            e_RX => SS,
            accept => ACCEPT,
            clk => Mclk,
            dFlag => dFLAG_s,
            pFlag => pFLAG_s,
            RXerror => RXerror_s,
            wr => wr_s,
            init => init_s,
            DXval => DXval
        );

    -- Instância do componente Parity_Check
    UParity: Parity_Check
        port map(
            clk => SCLK,
            init => init_s,
            bit_in => SDX,
            parity_check => RXerror_s
        );

    -- Instância do componente counterUP
    UCounterSLCDC: counterUP
        port map(
            CE => '1',
            Reset => init_s,
            CLK => SCLK,
            Final => CounterResult
        );

    -- Instância do componente ShiftRegister9
    UShiftregister: ShiftRegister9
        port map(
            data => SDX,
            clk => SCLK,
            enableShift => wr_s,
            D => Final
        );

end Serial_Receiver_arch;
