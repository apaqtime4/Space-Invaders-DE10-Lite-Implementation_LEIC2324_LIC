LIBRARY IEEE;
use IEEE.std_logic_1164.all;

-- Entidade SLCDC que define a interface do componente SLCDC
entity SLCDC is
	port (
		SDX : in std_logic; -- Entrada de dados serial
		MCLK : in std_logic; -- Entrada do Clock secundário
		SCLK : in std_logic; -- Entrada do Clock Principal
		LCDsel : in std_logic; -- Seleção do LCD
		Enable : out std_logic; -- Saída do bit enable 
		RS : out std_logic; -- Saída do bit RS (bit 8 dos dados)
		D : out std_logic_vector(7 downto 0) -- Saída dos Dados (bits 7 a 0 dos dados)
	);
end SLCDC;

architecture SLCDC_arch of SLCDC is

	-- Componente Serial_Receiver_SLCDC
	component Serial_Receiver_SLCDC
	port(
		SDX: in std_logic;
		Mclk : in std_logic;
        SCLK: in std_logic;
        SS: in std_logic;
        ACCEPT: in std_logic;
        DXval: out std_logic;
        Final: out std_logic_vector(8 downto 0)
		);
	end component;

	-- Componente LCD_Dispatcher
	component LCD_Dispatcher 
	port(
		Din: in std_logic_vector(8 downto 0);
		Dval: in std_logic; 
		clk: in std_logic; 		
		WrL: out std_logic; 
		done: out std_logic;
		Dout: out std_logic_vector(8 downto 0)
		);
	end component; 

	-- Sinais internos para conectar componentes
	signal Done_s : std_logic;
	signal DXval_s : std_logic;
	signal Final_s : std_logic_vector(8 downto 0);

begin

	-- Instância do componente Serial_Receiver_SLCDC
	USerialReceiver : Serial_Receiver_SLCDC port map (
		SDX => SDX,                                
		SCLK => SCLK,                              
		Mclk => MCLK,                              
		SS => LCDsel,                            
		ACCEPT => Done_s,                         
		DXval => DXval_s,                          
		Final => Final_s                         
	);

	-- Instância do componente LCD_Dispatcher
	ULCD : LCD_Dispatcher port map (
		Dval => DXval_s,                           
		CLK => MCLK,                               
		Din => Final_s,                           
		Wrl => Enable,                             
		Done => Done_s,                            
		Dout(8) => RS,                           
		Dout(7 downto 0) => D                   
	);

end SLCDC_arch;

-- Código feito ao som de:
-- Barbie Girl by Aqua
