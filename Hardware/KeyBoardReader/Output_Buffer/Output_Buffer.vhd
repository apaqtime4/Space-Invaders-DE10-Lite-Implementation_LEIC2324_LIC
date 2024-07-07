LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade Output_Buffer que define a interface do módulo
entity Output_Buffer is
    port (
        CLK     : in std_logic; -- Entrada do clock principal
        reset   : in std_logic; -- Entrada do reset
        Data    : in std_logic_vector(3 downto 0); -- Entrada dos dados a serem armazenados
        Load    : in std_logic; -- Entrada bit de carregamento
        ACK     : in std_logic; -- Entrada do bit de reconhecimento
        Qout    : out std_logic_vector(3 downto 0); -- Saída dos dados armazenados
        OBfree  : out std_logic; -- Saída que indica se o buffer está livre
        Dval    : out std_logic -- Saída que indica se os dados são válidos
    );
end Output_Buffer;

-- Arquitetura do Output_Buffer
architecture Output_Buffer_arch of Output_Buffer is

    -- Declaração do componente Buffer_Control
    component Buffer_Control
        port(
            CLK : in std_logic; -- Entrada do clock principal
            ACK : in std_logic; -- Entrada do bit de reconhecimento
            Load : in std_logic; -- Entrada do bit de carregamento
            Wreg : out std_logic; -- Saída do bit de escrita no registro
            OBfree : out std_logic; -- Saída que indica se o buffer está livre
            Dval : out std_logic -- Saída que indica se os dados são válidos
        );
    end component;

    -- Declaração do componente Regis
    component Regis
        port(
            CLK : in std_logic; -- Entrada do clock
            RESET : in std_logic; -- Entrada do bit de reset
            D : in std_logic_vector(3 downto 0); -- Entrada dos dados
            EN : in std_logic; -- Entrada do bit de habilitação
            Q : out std_logic_vector(3 downto 0) -- Saída dos dados armazenados
        );
    end component;

    -- Declaração dos sinais internos (neste caso 1)
    signal S_Wreg : std_logic;

begin

    -- Instanciação do componente Regis
    URegis: Regis port map(
        CLK => S_Wreg, -- Entrada do bit de escrita no registro
        RESET => reset, -- Entrada do reset
        D => Data, -- Entrada dos dados
        EN => '1', -- Bit enable sempre ligado
        Q => Qout -- Saída dos dados armazenados
    );

    -- Instanciação do componente Buffer_Control
    UBuffer_Control: Buffer_Control port map(
        CLK => CLK, -- Entrada do clock principal
        ACK => ACK, -- Entrada do bit de reconhecimento
        Load => Load, -- Entrada do bit de carregamento
        Wreg => S_Wreg, -- Saída do bit de escrita no registro
        OBfree => OBfree, -- Saída que indica se o buffer está livre
        Dval => Dval -- Saída que indica se os dados são válidos
    );

end Output_Buffer_arch; -- Fim da arquitetura Output_Buffer_arch

-- Código feito ao som de:
-- I Can't Feel My Nuts by Adam Gibeault
