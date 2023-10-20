---------------------------------------------------------------------------------------------------
--
-- Title       : mux_catozi
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : mux_catozi.vhd
-- Generated   : Thu May 19 23:23:11 2022
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
--{entity {mux_catozi} architecture {mux_catozi}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_catozi is 
	port(sel2: in std_logic_vector (1 downto 0);
	timp_U1,timp_z1: in std_logic_vector(3 downto 0);
	iesire:out std_logic_vector(3 downto 0)
	);
end mux_catozi;

--}} End of automatically maintained section

architecture mux_catozi of mux_catozi is
begin
		process(sel2)
	begin			
	case sel2 is	 
		when "00" => iesire<=timp_u1;
		when "01" => iesire<=timp_z1;
		when others => iesire<="1111";
		end case;
	end process;
	 -- enter your statements here --

end mux_catozi;
