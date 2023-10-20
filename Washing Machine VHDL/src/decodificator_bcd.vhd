---------------------------------------------------------------------------------------------------
--
-- Title       : decodificator_bcd
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : decodificator_bcd.vhd
-- Generated   : Thu May 19 23:39:02 2022
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
--{entity {decodificator_bcd} architecture {decodificator_bcd}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodificator_bcd is
	port(a1: in std_logic_vector (3 downto 0);
	catozi: out std_logic_vector(6 downto 0)
	);
end decodificator_bcd;

--}} End of automatically maintained section

architecture decodificator_bcd of decodificator_bcd is
begin
	  	process(a1)
	begin			
	case a1 is	 
		when "0000" => catozi<="1000000";
		when "0001" => catozi<="1111001";
		when "0010" => catozi<="0100100";
		when "0011" => catozi<="0110000";
		when "0100" => catozi<="0011001";
		when "0101" => catozi<="0010010";
		when "0110" => catozi<="0000010";
		when "0111" => catozi<="1111000";
		when "1000" => catozi<="0000000";
		when "1001" => catozi<="0010000";
		when others => catozi<="1111111";
		end case;
	end process;
	 -- enter your statements here --

end decodificator_bcd;
