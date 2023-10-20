---------------------------------------------------------------------------------------------------
--
-- Title       : multiplexor_rotatii
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : multiplexor_rotatii.vhd
-- Generated   : Sat May 14 19:50:10 2022
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
--{entity {multiplexor_rotatii} architecture {multiplexor_rotatii}}																																  ---------------------------------------------------------------------------------------------------
--
-- Title       : multiplexor
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : multiplexor.vhd
-- Generated   : Sat May  7 15:49:38 2022
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
--{entity {multiplexor} architecture {multiplexor}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity multiplexor_rotatii2 is
	port( R1,R2,R3: in std_logic;
	enable_manual1 :in std_logic;
	LED1_800,LED2_1000,LED3_1200 : OUT STD_LOGIC);
end multiplexor_rotatii2;

--}} End of automatically maintained section

architecture multiplexor_rotatii2 of multiplexor_rotatii2 is	 

signal enable,man,selectt,prestab:std_logic;

begin
 
	process(R1,R2,R3,enable_manual1) is
	
	begin 
		if 	(enable_manual1='1') then
		if 	(R1='1' and R2='0' and R3='0') then
		  
			LED1_800<='1'; 
			LED2_1000<='0';
			LED3_1200<='0';
			elsif 	(R1='0' and R2='1' and R3='0' ) then
			  	LED1_800<='0'; 
				LED2_1000<='1';
				LED3_1200<='0';
				  elsif 	(R1='0' and R2='0' and R3='1') then
				  	LED1_800<='0'; 
					LED2_1000<='0';
					LED3_1200<='1';
				  else
					  LED1_800<='0'; 
					  LED2_1000<='0';
					  LED3_1200<='0';
				  
			end if;	 
			end if;
	end process;
	 -- enter your statements here --

end multiplexor_rotatii2;

--}} End of automatically maintained section


