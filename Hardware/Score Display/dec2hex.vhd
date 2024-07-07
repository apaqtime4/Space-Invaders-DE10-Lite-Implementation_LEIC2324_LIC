-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : Score Display (Space Invaders Game) 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : dec2hex.vhd
-- Author(s)   : Pedro Miguens Matutino
-- Date        : 2024/02/16
-------------------------------------------------------------------------------
-- Copyright (c) 2024 Pedro Miguens Matutino
-------------------------------------------------------------------------------
-- Description :
-- .
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dec2hex is
port(	d 		: in std_logic_vector(3 downto 0);
		clear : in std_logic;
		dOut	: out std_logic_vector(7 downto 0)
		);
end dec2hex;

architecture structural OF dec2hex IS

signal Ndout : std_logic_vector(7 downto 0);

begin

NdOut <= "11000000" when d = "0000" else
			"11111001" when d = "0001" else
			"10100100" when d = "0010" else
			"10110000" when d = "0011" else
			"10011001" when d = "0100" else
			"10010010" when d = "0101" else
			"10000010" when d = "0110" else
			"11111000" when d = "0111" else
			"10000000" when d = "1000" else
			"10011000" when d = "1001" else
			"11111100" when d = "1010" else
			"11011110" when d = "1011" else
			"11001111" when d = "1100" else
			"11100111" when d = "1101" else
			"11110011" when d = "1110" else
			"11111111";

dout <= "11111111" when clear = '1' else Ndout;
			
end structural;