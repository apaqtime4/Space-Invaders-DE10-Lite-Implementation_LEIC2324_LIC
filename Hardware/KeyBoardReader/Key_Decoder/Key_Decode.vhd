library IEEE;
use IEEE.std_logic_1164.all;

-- Entidade Key_Decode que define a interface do módulo
entity Key_Decode is
    Port (
        CLK : in std_logic; -- Entrada do clock principal
        Linha : in std_logic_vector(3 downto 0); -- Entrada das linhas do teclado
        Kack : in std_logic; -- Entrada do reconhecimento da tecla primida
        Reset : in std_logic; -- Entrada do reset
        Kval : out std_logic; -- Saída do sinal de tecla válida
        Coluna : out std_logic_vector(3 downto 0); -- Saída das colunas do teclado
        K03 : out std_logic_vector(3 downto 0) -- Saída do código da tecla pressionada
    );
end Key_Decode;

architecture arch_keydecode of Key_Decode is

    -- Declaração do componente Key_Scan
    component Key_Scan
        port(
            Kscan : in std_logic; -- Entrada do sinal que avisa que se pode enviar outra tecla
            Multiplexer_In : in std_logic_vector(3 downto 0); -- Entrada das linhas do teclado
            CLK : in std_logic; -- Entrada do clock
            Reset : in std_logic; -- Entrada do reset
            Decoder_Out : out std_logic_vector(3 downto 0); -- Saída do decodificador (colunas do teclado)
            Kout : out std_logic_vector(3 downto 0); -- Saída do código da tecla pressionada
            Kpress : out std_logic -- Saída do sinal de tecla pressionada
        );
    end component;

    -- Declaração do componente Key_Control
    component Key_Control
        port(
            clk : in std_logic; -- Entrada do clock
            reset : in std_logic; -- Entrada do reset
            kack : in std_logic; -- Entrada do reconhecimento da tecla primida
            kpress : in std_logic; -- Entrada do sinal de tecla pressionada
            kval : out std_logic; -- Saída do sinal de tecla válida
            kscan : out std_logic -- Saída do sinal que avisa que se pode enviar outra tecla
        );
    end component;

    -- Declaração do componente CLKDIV
    component CLKDIV
    generic(div: natural := 50000000);
        port(
            clk_in: in std_logic; -- Entrada do clock div
            clk_out: out std_logic -- Saída do clock div
        );
    end component;


    
    -- Declaração dos sinais internos
    signal s_kpress, s_kscan, CLK_Divider, not_clk_divider : std_logic;


begin

    -- Inversão do sinal do clock dividido
    not_clk_divider <= not CLK_Divider;

    -- Instanciação do componente Key_Scan
    Keyscan: Key_Scan port map(
        CLK => CLK_Divider, -- Entrada do clock dividido
        Reset => Reset, -- Entrada do sinal de reset
        Kscan => s_kscan, -- Entrada do sinal que avisa que se pode enviar outra tecla
        Multiplexer_In => Linha, -- Entrada das linhas do teclado
        Decoder_Out => Coluna, -- Saída das colunas do teclado
        Kout => K03, -- Saída do código da tecla pressionada
        Kpress => s_kpress -- Saída do sinal de tecla pressionada
    );

    -- Instanciação do componente Key_Control
    Keycontrol: Key_Control port map(
        clk => not_clk_divider, -- Entrada do clock invertido
        reset => Reset, -- Entrada do sinal de reset
        kscan => s_kscan, -- Saída do sinal de varredura do teclado
        kpress => s_kpress, -- Entrada do sinal de tecla pressionada
        kack => Kack, -- Entrada do reconhecimento da tecla primida
        kval => Kval -- Saída do sinal de tecla válida
    );

    -- Instanciação do componente CLKDIV
    Clk_div : CLKDIV generic map (500000) 
    port map(
        clk_in => CLK, -- Entrada do clock principal
        clk_out => CLK_Divider -- Saída do clock dividido
    );


end arch_keydecode;

-- Código feito ao som de:
-- Kickstart my heart by Motley Crue
