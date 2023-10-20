---------------------------------------------------------------------------------------------------
--
-- Title       : decodificator
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : decodificator.vhd
-- Generated   : Sun May  8 15:19:34 2022
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
--{entity {decodificator} architecture {decodificator}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decodificator is
	port( Intrare : in  std_logic_vector(15 downto 0);
	TimpU1,TimpZ1 : out integer;
	CS1,PResp1,TEMP3,temp4,temp6,temp9,ROT80,rot100,rot120,lc,lsr,lci,lrm,la: out std_logic;
	ipr,isp,icl,ics,ice: out integer);
end decodificator;

--}} End of automatically maintained section

architecture decodificator of decodificator is
begin
	process( INTRARE) is
	begin 
	
				--elsif Intrare= x"10B4" then TimpZ<=4; TimpU<=2 ; Temp<="11" ; Rot<="01"; presp<='0' ; Cs<='0';
				--when x"1469" => TimpZ<=5 ; TimpU<=1 ; Temp<="10" ; Rot<="10" ; presp<='0' ; Cs<='1';
				--when x"14AA" => TimpZ<=5 ; TimpU<=2 ; Temp<="00" ; Rot<="11" ; presp<='1' ; Cs<='0';
				--when x"10FC" => TimpZ<=4 ; TimpU<=3 ; Temp<="11" ; Rot<="11" ; presp<='0' ; Cs<='0';
				--when others => TimpZ<=0 ; TimpU<=0 ; Temp<="00" ; Rot<="00" ; presp<='0' ; Cs<='0'; 
				case INTRARE is
				when x"104C" => TimpZ1<=4 ; TimpU1<=1 ; Temp3<='1';Temp4<='0';Temp6<='0';Temp9<='0' ; rot80<='0';rot100<='0';rot120<='1' ; presp1<='0' ; Cs1<='0';lc<='0';lsr<='1';lci<='0';lrm<='0';la<='0';ipr<=41;isp<=41;icl<=20;ics<=20;ice<=10; 
				when x"10B4" =>  TimpZ1<=4; TimpU1<=2 ; Temp3<='0';Temp4<='0';Temp6<='1';Temp9<='0' ; rot80<='1';rot100<='0';rot120<='0' ; presp1<='0' ; Cs1<='0';lc<='1';lsr<='0';lci<='0';lrm<='0';la<='0';ipr<=42;isp<=42;icl<=20;ics<=20;ice<=10; --									
				when x"1469" => TimpZ1<=5 ; TimpU1<=1 ; Temp3<='0';Temp4<='1';Temp6<='0';Temp9<='0' ; rot80<='0';rot100<='1';rot120<='0'  ; presp1<='0' ; Cs1<='1';lc<='0';lsr<='0';lci<='1';lrm<='0';la<='0';ipr<=51;isp<=51;icl<=30;ics<=20;ice<=10;  --
				when x"14AA" =>  TimpZ1<=5 ; TimpU1<=2 ; Temp3<='0';Temp4<='1';Temp6<='0';Temp9<='0' ; rot80<='0';rot100<='1';rot120<='0'  ; presp1<='1' ; Cs1<='0';lc<='0';lsr<='0';lci<='0';lrm<='1';la<='0';ipr<=52;isp<=41;icl<=20;ics<=20;ice<=10;  --
				when x"10FC" =>  TimpZ1<=4 ; TimpU1<=3 ; Temp3<='0';Temp4<='0';Temp6<='0';Temp9<='1' ; rot80<='0';rot100<='0';rot120<='1'  ; presp1<='0' ; Cs1<='0';lc<='0';lsr<='0';lci<='0';lrm<='0';la<='1';ipr<=43;isp<=43;icl<=20;ics<=20;ice<=10; --
				when others =>  TimpZ1<=0 ; TimpU1<=0 ; Temp3<='0';Temp4<='0';Temp6<='0';Temp9<='0' ; rot80<='0';rot100<='0';rot120<='0'  ; presp1<='0' ; Cs1<='0';lc<='0';lsr<='0';lci<='0';lrm<='0';la<='0';ipr<=0;isp<=0;icl<=0;ics<=0;ice<=0;  
			end case;
			
			
	end process;
	 -- enter your statements here --

end decodificator;
