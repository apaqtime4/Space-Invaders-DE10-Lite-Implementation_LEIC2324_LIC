library IEEE;
use IEEE.std_logic_1164.all;

-- Entidade KeyboardReader que define a interface do módulo
entity KeyboardReader is
    Port (
        CLK : in std_logic; -- Clock do hardware
        Linha : in std_logic_vector(3 downto 0); -- Linhas que saem do teclado
        ACK : in std_logic; -- Sinal de reconhecimento da tecla primida
        Reset : in std_logic; -- Sinal de reset
        Dval : out std_logic; -- Sinal de dados válidos
        Coluna : out std_logic_vector(3 downto 0); -- Colunas do teclado
        Final_Data: out std_logic_vector(3 downto 0) -- Dados finais
    );
end KeyboardReader;

architecture KeyboardReader_arch of KeyboardReader is 

    -- Declaração do componente Key_Decode
    component Key_Decode
        Port (
            CLK : in std_logic; -- Clock
            Linha : in std_logic_vector(3 downto 0); -- Linhas do teclado
            Kack : in std_logic; -- Sinal de reconhecimento da tecla primida
            Reset : in std_logic; -- Sinal de reset
            Kval : out std_logic; -- Sinal de tecla válida
            Coluna : out std_logic_vector(3 downto 0); -- Colunas do teclado
            K03 : out std_logic_vector(3 downto 0) -- Código da tecla pressionada
        );
    end component;

    -- Declaração do componente Ring_Buffer
    component Ring_Buffer
        Port (
            CLK : in std_logic; -- Clock
            CTS : in std_logic; -- Clear to Send (pronto para enviar)
            D : in std_logic_vector(3 downto 0); -- Dados de entrada
            DAV : in std_logic; -- Dados disponíveis
            RESET : in std_logic; -- Reset
            Wreg : out std_logic; -- Sinal de registro de escrita
            Q : out std_logic_vector(3 downto 0); -- Dados de saída
            DAC : out std_logic -- Dados aceitos
        );
    end component;

    -- Declaração do componente Output_Buffer
    component Output_Buffer
        Port (
            CLK : in std_logic; -- Clock
            reset : in std_logic; -- Reset
            Data : in std_logic_vector(3 downto 0); -- Dados de entrada
            Load : in std_logic; -- Sinal de carga
            ACK : in std_logic; -- Sinal de reconhecimento da tecla primida
            Qout : out std_logic_vector(3 downto 0); -- Dados de saída
            OBfree : out std_logic; -- Indicação de buffer livre
            Dval : out std_logic -- Sinal de dados válidos
        );
    end component;

    -- Declaração de sinais internos
    signal Kack, Kval : std_logic;
    signal K03 : std_logic_vector(3 downto 0);
    signal CTS_S, Wreg_S : std_logic;
    signal Ring_Buffer_Out_S : std_logic_vector(3 downto 0);

begin

    -- Instanciação do componente Key_Decode
    UKey_Decode : Key_Decode port map(
        CLK => CLK, 
        Linha => Linha,
        Kack => Kack, 
        Reset => Reset,
        Kval => Kval, 
        Coluna => Coluna,
        K03 => K03 -- 
    );

    -- Instanciação do componente Ring_Buffer
    URing_Buffer : Ring_Buffer port map(
        CLK => CLK,
        CTS => CTS_S, 
        RESET => Reset,
        D => K03, 
        DAV => Kval, 
        Wreg => Wreg_S, 
        Q => Ring_Buffer_Out_S,
        DAC => Kack 
    );

    -- Instanciação do componente Output_Buffer
    UOutput_Buffer : Output_Buffer port map(
        CLK => CLK, 
        reset => Reset,
        Data => Ring_Buffer_Out_S, 
        Load => Wreg_S, 
        ACK => ACK, 
        Qout => Final_Data,
        OBfree => CTS_S, 
        Dval => Dval 
    );

end KeyboardReader_arch;

-- Código feito ao som de:
-- Rappin' for Jesus by Brian Spinney
