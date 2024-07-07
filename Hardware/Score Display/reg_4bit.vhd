-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : Score Display (Space Invaders Game) 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : reg_4bit.vhd
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

entity reg_4bit is
port(	clk : in std_logic;
		reset : in std_logic;
		set : in std_logic;
		d : in std_logic_vector(3 downto 0);
		en : in std_logic;
		q : out std_logic_vector(3 downto 0)
		);
end reg_4bit;

architecture reg_4bit_arch of reg_4bit is
component FFD is
port(	clk : in std_logic;
		reset : in std_logic;
		set : in std_logic;
		d : in std_logic;
		en : in std_logic;
		q : out std_logic
		);
end component;
begin

u0: FFD port map ( clk => clk, reset => reset, set => set, en => en, d => d(0), q => q(0));
u1: FFD port map ( clk => clk, reset => reset, set => set, en => en, d => d(1), q => q(1));
u2: FFD port map ( clk => clk, reset => reset, set => set, en => en, d => d(2), q => q(2));
u3: FFD port map ( clk => clk, reset => reset, set => set, en => en, d => d(3), q => q(3));

end reg_4bit_arch;