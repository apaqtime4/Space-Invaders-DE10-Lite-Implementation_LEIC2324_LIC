LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade SSC que define a interface do controlador serial
entity SSC is
    port (
        SDX : in std_logic; -- Entrada do dado em série
        SCLK : in std_logic; -- Entrada do clock principal
        MCLK : in std_logic; -- Entrada do clock secundário 
        SCsel : in std_logic; -- Entrada do bit de seleção
        set : out std_logic; -- Saída do bit de ajuste
        cmd : out std_logic_vector(2 downto 0); -- Saída dos comandos
        data : out std_logic_vector(3 downto 0) -- Saída dos dados
    );
end SSC;

architecture SSC_arch of SSC is

    -- Declaração do componente Serial_Receiver_SSC
    component Serial_Receiver_SSC 
    port(
        SDX: in std_logic; -- Entrada do dado em série
        SCLK: in std_logic; -- Entrada do clock principal
        Mclk : in std_logic; -- Entrada do clock secundário
        SS: in std_logic; -- Entrada do bit enable
        ACCEPT: in std_logic; -- Entrada do bit de aceitação
        DXval: out std_logic; -- Saída do bit de validação
        Final: out std_logic_vector(6 downto 0) -- Saída do dado final recebido
    );
    end component;

    -- Declaração do componente Score_Dispatcher
    component Score_Dispatcher 
    port(
        Din: in std_logic_vector(6 downto 0); -- Entrada dos dados
        Dval: in std_logic; -- Entrada do bit de validação
        CLK : in std_logic; -- Entrada do clock principal
        WrL: out std_logic; -- Saída do bit que permite a escrita
        done: out std_logic; -- Saída do bit de conclusão
        Dout: out std_logic_vector(6 downto 0) -- Saída dos dados processados
    );
    end component;

    -- Declaração dos sinais internos
    signal Done_s : std_logic; 
    signal DXval_s : std_logic; 
    signal Final_s : std_logic_vector(6 downto 0);

begin

    -- Instanciação do componente Serial_Receiver_SSC
    USerialReceiver : Serial_Receiver_SSC port map (
        SDX => SDX, 
        SCLK => SCLK,
        Mclk => MCLK,
        SS => SCsel, 
        ACCEPT => Done_s, 
        DXval => DXval_s, 
        Final => Final_s 
    );

    -- Instanciação do componente Score_Dispatcher
    ULCD : Score_Dispatcher port map (
        Dval => DXval_s, 
        CLK => MCLK, 
        Din => Final_s,
        Wrl => set, 
        Done => Done_s,
        Dout(6 downto 3) => data,
        Dout(2 downto 0) => cmd 
    );

end SSC_arch;

-- Código feito ao som de:
-- Too Many Nights by Metro Boomin | Future | Don Toliver
