---------------------------------------------------------------------------------------------------
--
-- Title       : demultiplexor
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : demultiplexor.vhd
-- Generated   : Sat May  7 15:32:10 2022
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
--{entity {demultiplexor} architecture {demultiplexor}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demultiplexor is	 
	port(SELECTARE_MOD: in std_logic;
	PRESTABILIT, MANUAL : OUT STD_LOGIC);
end demultiplexor;

--}} End of automatically maintained section

architecture demultiplexor of demultiplexor is
begin		
	
	process (SELECTARE_MOD) is
	   variable SEL: std_logic ;
	begin	
		  SEL:='1';
	if SELECTARE_MOD ='1' then	PRESTABILIT<=SEL;
		MANUAL<='0';
	else MANUAL<=SEL;
		PRESTABILIT<='0';
	end if;
		
	end process;
	 -- enter your statements here --

end demultiplexor;
