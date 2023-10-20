---------------------------------------------------------------------------------------------------
--
-- Title       : codificator_timpi_partiali
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : codificator_timpi_partiali.vhd
-- Generated   : Sat May 21 21:42:54 2022
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
--{entity {codificator_timpi_partiali} architecture {codificator_timpi_partiali}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity codificator_timpi_countdown is
	port(timpi_numarare: in std_logic_vector(3 downto 0);
	timpi_numarare_zecimal:out integer);
end codificator_timpi_countdown;

--}} End of automatically maintained section

architecture codificator_timpi_countdown of codificator_timpi_countdown is
begin
	process(timpi_numarare)
	begin						
	case timpi_numarare is	 
		when "0000" => timpi_numarare_zecimal<=0;
		when "0001" => timpi_numarare_zecimal<=1;
		when "0010" => timpi_numarare_zecimal<=2;
		when "0011" => timpi_numarare_zecimal<=3;
		when "0100" => timpi_numarare_zecimal<=4;
		when "0101" => timpi_numarare_zecimal<=5;
		when "0110" => timpi_numarare_zecimal<=6;
		when "0111" => timpi_numarare_zecimal<=7;
		when "1000" => timpi_numarare_zecimal<=8;
		when others => timpi_numarare_zecimal<=9;
		end case;
	end process;
	
	 -- enter your statements here --

end codificator_timpi_countdown;
