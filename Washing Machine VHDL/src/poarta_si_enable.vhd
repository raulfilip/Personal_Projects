---------------------------------------------------------------------------------------------------
--
-- Title       : poarta_si_enable
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : poarta_si_enable.vhd
-- Generated   : Sun May 22 18:22:01 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {poarta_si_enable} architecture {poarta_si_enable}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity poarta_si_enable is
	port(x,y:in std_logic;
	z:out std_logic);
end poarta_si_enable;

--}} End of automatically maintained section

architecture poarta_si_enable of poarta_si_enable is
begin
	process(x,y)
	begin			
		if (x='1'and y='0') then
			z<='1';
		else
			z<='0';
			end if;
		end process;
	 -- enter your statements here --

end poarta_si_enable;
