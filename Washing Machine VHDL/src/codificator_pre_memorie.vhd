---------------------------------------------------------------------------------------------------
--
-- Title       : codificator_pre_memorie
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : codificator_pre_memorie.vhd
-- Generated   : Thu May 19 13:01:02 2022
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
--{entity {codificator_pre_memorie} architecture {codificator_pre_memorie}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity codificator_pre_memorie is 
	port(I1,I2,I3,I4,I5,enableCodificator: in std_logic;
	iesire : out std_logic_vector(3 downto 0));
end codificator_pre_memorie;

--}} End of automatically maintained section

architecture codificator_pre_memorie of codificator_pre_memorie is
begin
	
	process( I1,I2,I3,I4,I5,enableCodificator) is
	begin 
		if(enableCodificator='1') then
			if((I1='0')and (I2='0') and (I3='0') and (I4='0') and (I5='1')) then
				iesire<="0000";
			elsif((I1='0')and (I2='0') and (I3='0') and (I4='1') and (I5='0')) then
					iesire<="0001";
			elsif((I1='0')and (I2='0') and (I3='1') and (I4='0') and (I5='0')) then
					iesire<="0010";
			elsif((I1='0')and (I2='1') and (I3='0') and (I4='0') and (I5='0')) then
					iesire<="0011";
			elsif((I1='1')and (I2='0') and (I3='0') and (I4='0') and (I5='0')) then
				iesire<="0100";
			else
				iesire<="1111";
			end if;	
			end if;
			
	end process;
	 -- enter your statements here --

end codificator_pre_memorie;
