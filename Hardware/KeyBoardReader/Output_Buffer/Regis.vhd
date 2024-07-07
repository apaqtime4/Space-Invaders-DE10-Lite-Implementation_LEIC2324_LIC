library IEEE;
use IEEE.std_logic_1164.all;

-- Entidade regis que define a interface do registro
ENTITY regis IS
PORT( 
    CLK : in std_logic; -- Entrada do clock principal
    RESET : in std_logic; -- Entrada do reset
    D : IN STD_LOGIC_VECTOR(3 downto 0); -- Entrada dos dados a serem armazenados
    EN : IN STD_LOGIC; -- Entrada do bit de habilitação
    Q : out std_logic_VECTOR(3 downto 0) -- Saída dos dados armazenados
);
END regis;

-- Arquitetura do regis
ARCHITECTURE logicFunction of regis is

    -- Declaração do componente FFD
    component FFD
    PORT( 
        CLK : in std_logic; -- Entrada do clock principal
        RESET : in std_logic; -- Entrada do reset
        SET : in std_logic; -- Entrada do bit set
        D : IN std_logic; -- Entrada do dado a ser armazenado
        EN : IN std_logic; -- Entrada do bit de enable
        Q : out std_logic -- Saída do dado armazenado
    );
    end component;

BEGIN
    -- Instanciação dos componentes FFD para cada bit do vetor de dados
    U0: FFD port map(
        CLK => CLK, -- Entrada do clock principal
        RESET => RESET, -- Entrada do reset
        SET => '0', -- Entrada do bit de set, fixo em 0
        D => D(0), -- Entrada do bit 0 dos dados
        EN => EN, -- Entrada do bit enable
        Q => Q(0) -- Saída do bit 0 armazenado
    );
    U1: FFD port map(
        CLK => CLK, -- Entrada do clock principal
        RESET => RESET, -- Entrada do reset
        SET => '0', -- Entrada do bitde set, fixo em 0
        D => D(1), -- Entrada do bit 1 dos dados
        EN => EN, -- Entrada do bit enable
        Q => Q(1) -- Saída do bit 1 armazenado
    );
    U2: FFD port map(
        CLK => CLK, -- Entrada do clock principal
        RESET => RESET, -- Entrada do reset
        SET => '0', -- Entrada do bitde set, fixo em 0
        D => D(2), -- Entrada do bit 2 dos dados
        EN => EN, -- Entrada do bit enable
        Q => Q(2) -- Saída do bit 2 armazenado
    );
    U3: FFD port map(
        CLK => CLK, -- Entrada do clock principal
        RESET => RESET, -- Entrada do reset
        SET => '0', -- Entrada do bitde set, fixo em 0
        D => D(3), -- Entrada do bit 3 dos dados
        EN => EN, -- Entrada do bit enable
        Q => Q(3) -- Saída do bit 3 armazenado
    );
END logicFunction;

-- Código feito ao som de:
-- The World We Knew by Frank Sinatra
