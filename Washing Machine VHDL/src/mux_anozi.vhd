---------------------------------------------------------------------------------------------------
--
-- Title       : mux_anozi
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : mux_anozi.vhd
-- Generated   : Thu May 19 23:13:32 2022
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
--{entity {mux_anozi} architecture {mux_anozi}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_anozi is
	port(sel1: in std_logic_vector(1 downto 0);
	anozi: out std_logic_vector(3 downto 0));
end mux_anozi;

--}} End of automatically maintained section

architecture mux_anozi of mux_anozi is
begin
	process(sel1)
	begin			
	case sel1 is	 
		when "00" => anozi<="1110";
		when "01" => anozi<="1101";
		when others => anozi<="1111";
		end case;
	end process;
	 -- enter your statements here --

end mux_anozi;
