---------------------------------------------------------------------------------------------------
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

entity multiplexor_temperatura is
	port( T1,T2,T3,T4: in std_logic;
	TEMPERATURA: out INTEGER;
	enable_manual :in std_logic;
	LED1_MUX,LED2_MUX,LED3_MUX,LED4_MUX: OUT STD_LOGIC);
end multiplexor_temperatura;

--}} End of automatically maintained section

architecture multiplexor of multiplexor_temperatura is

begin
   
	process(T1,T2,T3,T4,enable_manual) is
	variable T30,T40,T60,T90 : integer;
	
	
	begin 

		if (enable_manual='1')then
		T30 := 30; 
		T40 := 40; 
		T60 := 60;
		T90 := 90;
		if 	(T1='1' and T2='0' and T3='0'  and T4='0') then
			TEMPERATURA<=T30;	  
			LED1_MUX<='1'; 
			LED2_MUX<='0';
			LED3_MUX<='0';
			LED4_MUX<='0';
			elsif 	(T1='0' and T2='1' and T3='0'  and T4='0') then
			  TEMPERATURA<=T40;	
			  	LED1_MUX<='0'; 
				LED2_MUX<='1';
				LED3_MUX<='0';
				LED4_MUX<='0';
				  elsif 	(T1='0' and T2='0' and T3='1'  and T4='0') then
				  TEMPERATURA<=T60;
				  	LED1_MUX<='0'; 
					LED2_MUX<='0';
					LED3_MUX<='1';
					LED4_MUX<='0';
				  	elsif 	(T1='0' and T2='0' and T3='0'  and T4='1') then
			  		TEMPERATURA<=T90;
					  	LED1_MUX<='0'; 
						LED2_MUX<='0';
						LED3_MUX<='0';
						LED4_MUX<='1'; 
							else  TEMPERATURA<=0;
						  	LED1_MUX<='0'; 
							LED2_MUX<='0';
							LED3_MUX<='0';
							LED4_MUX<='0';
				  
			end if;	
		end if ;
	end process;
	 -- enter your statements here --

end multiplexor;
