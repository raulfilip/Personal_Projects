---------------------------------------------------------------------------------------------------
--
-- Title       : codificator_pre_numarare
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : codificator_pre_numarare.vhd
-- Generated   : Thu May 19 20:26:47 2022
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
--{entity {codificator_pre_numarare} architecture {codificator_pre_numarare}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity codificator_pre_numarare is 
	port(numar : in integer;
	timp_biti: out std_logic_vector(3 downto 0));
end codificator_pre_numarare;

--}} End of automatically maintained section

architecture codificator_pre_numarare of codificator_pre_numarare is
begin	
	process( numar) is
	begin 
	   case numar is
				when 0 => timp_biti<="0000" ;
				when 1 => timp_biti<="0001" ;
				when 2 => timp_biti<="0010" ;
				when 3 => timp_biti<="0011" ;
				when 4 => timp_biti<="0100" ;
				when 5 => timp_biti<="0101" ;  
				when 6 => timp_biti<="0110" ;
				when 7 => timp_biti<="0111" ;
				when 8 => timp_biti<="1000" ;

				when others => timp_biti<="1001" ;
	   end case; 
	   end process;
	 -- enter your statements here --

end codificator_pre_numarare;
