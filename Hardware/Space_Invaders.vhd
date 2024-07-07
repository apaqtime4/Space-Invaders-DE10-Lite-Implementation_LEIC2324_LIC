LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity Space_Invaders is
port(

		CLK_Hardware : in std_logic;
		General_Reset : in std_logic;
		
		Coin_Inserter : in std_logic;
		Manut : in std_logic;

		-- Entradas e Saidas do Keyboard Reader
		Linhas : in std_logic_vector(3 downto 0);
		Colunas : out std_logic_vector(3 downto 0);

		-- Entradas e Saidas do LCD
		LCD_OUT : out std_logic_vector(8 downto 0);
		LCD_EN : out std_logic;

		-- Saídas do SSC
		HEX0 : out std_logic_vector(7 downto 0);
		HEX1 : out std_logic_vector(7 downto 0);
		HEX2 : out std_logic_vector(7 downto 0);
		HEX3 : out std_logic_vector(7 downto 0);
		HEX4 : out std_logic_vector(7 downto 0);
		HEX5 : out std_logic_vector(7 downto 0);

		Accept_Signal : out std_logic
);

end Space_Invaders;

architecture Space_Invaders_Arch of Space_Invaders is
	
	component USBport
	port(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	end component;

component KeyboardReader is
    Port (
		CLK : in std_logic;
        Linha : in std_logic_vector(3 downto 0);
		ACK : in std_logic;
		Reset : in std_logic;
		Dval : out std_logic;
		Coluna : out std_logic_vector(3 downto 0);
        Final_Data: out std_logic_vector(3 downto 0)
    );
end component;

	component SLCDC
		port (
		SDX : in std_logic;
		MCLK : in std_logic;
		SCLK : in std_logic;
		LCDsel : in std_logic;
		Enable : out std_logic;
		RS : out std_logic;
		D : out std_logic_vector(7 downto 0) 
		);
	end component;
	
	component SSC
	port (
		SDX : in std_logic;
		SCLK : in std_logic;
		MCLK : in std_logic;
		SCsel : in std_logic;
		set : out std_logic;
		cmd : out std_logic_vector(2 downto 0);
		data : out std_logic_vector(3 downto 0)  
	);
	end component;

	component scoreDisplay
	port(	
		set	: in std_logic;
		cmd	: in std_logic_vector(2 downto 0);
		data	: in std_logic_vector(3 downto 0);
		HEX0	: out std_logic_vector(7 downto 0);
		HEX1	: out std_logic_vector(7 downto 0);
		HEX2	: out std_logic_vector(7 downto 0);
		HEX3	: out std_logic_vector(7 downto 0);
		HEX4	: out std_logic_vector(7 downto 0);
		HEX5	: out std_logic_vector(7 downto 0)
	);
end component;

component Coin_acceptor is
	port (
        Insert_Coin     :   in std_logic;
		  accept 			:   in std_logic;
        Coin_Inserted   :   out std_logic

	);
end component;
	
	
		-- Entradas e Saidas do Score Controller
signal SSC_SET  : std_logic;
signal SSC_CMD  : std_logic_vector(2 downto 0);
signal SSC_DATA : std_logic_vector(3 downto 0);


signal Software_to_SCLK, Software_to_SDX, Software_to_ACK, DVAL_to_Software,Coin_acceptor_to_Software, Software_to_coin_accept : std_logic;  
signal Software_to_SS : std_logic_vector(1 downto 0);
signal Keyboard_Data_to_Software: std_logic_vector(3 downto 0);
	
begin

	Accept_Signal <= Software_to_coin_accept;
	
	NotUSBport: USBport port map(
			inputPort(0) => Keyboard_Data_to_Software(0),
			inputPort(1) => Keyboard_Data_to_Software(1),
			inputPort(2) => Keyboard_Data_to_Software(2),
			inputPort(3) => Keyboard_Data_to_Software(3),
			inputPort(4) => DVAL_to_Software,
			-- inputPort(5) => Não é nada 
			inputPort(6) => Coin_acceptor_to_Software,
			inputPort(7) => Manut,

			outputPort(0) => Software_to_SS (0),
			outputPort(1) => Software_to_SS (1),
			-- outputPort(2) => NOT A THING
			outputPort(3) => Software_to_SDX,
			outputPort(4) => Software_to_SCLK,
			-- outputPort(5) => NOTHING
		   outputPort(6) => Software_to_coin_accept,
			outputPort(7) => Software_to_ACK
		);

	UKeyboard_Reader: KeyboardReader Port Map(
		CLK 			=> CLK_Hardware,
		Linha  		=> Linhas,
		ACK        	=> Software_to_ACK,
		Reset      	=> General_Reset,
		Dval       	=> DVAL_to_Software,
		Coluna     	=> Colunas,
		Final_Data 	=> Keyboard_Data_to_Software
	);

	ULCD: SLCDC port map(
		SDX 			=> Software_to_SDX,
		Mclk => CLK_Hardware,
		SCLK 			=> Software_to_SCLK,
		LCDsel 		=> Software_to_SS(0),
		Enable 		=> LCD_En,
		RS 			=> LCD_OUT(8),
		D 				=> LCD_OUT(7 downto 0)
	);

	USSC: SSC port map(
		SDX 		=> Software_to_SDX,
		SCLK 		=> Software_to_SCLK,
		MCLK 		=> CLK_Hardware,
		SCsel 	=> Software_to_SS(1), -- (0) é 1 -- (1) é 0
		set 		=> SSC_Set,
		cmd 		=> SSC_CMD,
		data 		=> SSC_DATA
	);
	
	UCoin: Coin_Acceptor port map(
      Insert_Coin => Coin_Inserter,
		accept => Software_to_coin_accept,
      Coin_Inserted => Coin_acceptor_to_Software
	);

	UScoreDisplay: ScoreDisplay port map(
	Set  	=> SSC_Set,
	cmd	=> SSC_CMD,
	data 	=> SSC_DATA,
	HEX0 	=> HEX0,
	HEX1 	=> HEX1,
	HEX2 	=> HEX2,
	HEX3 	=> HEX3,
	HEX4 	=> HEX4,
	HEX5 	=> HEX5
	);


end Space_Invaders_Arch;

-- Código feito ao som de:
-- Symphony No. 9 by Ludwig Van Beethoven 